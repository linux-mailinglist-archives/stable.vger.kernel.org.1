Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFDB7C4A83
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344315AbjJKGZr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 02:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344778AbjJKGZp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 02:25:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C6D93
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 23:25:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E34AC433C7;
        Wed, 11 Oct 2023 06:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697005536;
        bh=OLoihqIcIPqtoTLdpjp9mZwnCQ0ViV7zmpSst0C4UxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0H94P6GnYqmxDqxCpCCwjhVUpXOvSGX4bg3MGU8WHpARsJZX0QNTpBRBIfcEOIFV
         mxeX2i9QPw7Ak2gwYn1eayAww76psWhbZxyi/6FXaI04BzjXCc+3LeJ3CFVBY4T1sM
         Vl4sUeElyJPoAecBxz+Mivx/wR9SitQAR/2goljA=
Date:   Wed, 11 Oct 2023 08:25:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        gfs2@lists.linux.dev, christophe.jaillet@wanadoo.fr,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND 8/8] dlm: slow down filling up processing queue
Message-ID: <2023101129-stabilize-tree-5959@gregkh>
References: <20231010220448.2978176-1-aahringo@redhat.com>
 <20231010220448.2978176-8-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010220448.2978176-8-aahringo@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 06:04:48PM -0400, Alexander Aring wrote:
> If there is a burst of message the receive worker will filling up the
> processing queue but where are too slow to process dlm messages. This
> patch will slow down the receiver worker to keep the buffer on the
> socket layer to tell the sender to backoff. This is done by a threshold
> to get the next buffers from the socket after all messages were
> processed done by a flush_workqueue(). This however only occurs when we
> have a message burst when we e.g. create 1 million locks. If we put more
> and more new messages to process in the processqueue we will soon run out
> of memory.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/lowcomms.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index f7bc22e74db2..67f8dd8a05ef 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -63,6 +63,7 @@
>  #include "config.h"
>  
>  #define DLM_SHUTDOWN_WAIT_TIMEOUT msecs_to_jiffies(5000)
> +#define DLM_MAX_PROCESS_BUFFERS 24
>  #define NEEDED_RMEM (4*1024*1024)
>  
>  struct connection {
> @@ -194,6 +195,7 @@ static const struct dlm_proto_ops *dlm_proto_ops;
>  #define DLM_IO_END 1
>  #define DLM_IO_EOF 2
>  #define DLM_IO_RESCHED 3
> +#define DLM_IO_FLUSH 4
>  
>  static void process_recv_sockets(struct work_struct *work);
>  static void process_send_sockets(struct work_struct *work);
> @@ -202,6 +204,7 @@ static void process_dlm_messages(struct work_struct *work);
>  static DECLARE_WORK(process_work, process_dlm_messages);
>  static DEFINE_SPINLOCK(processqueue_lock);
>  static bool process_dlm_messages_pending;
> +static atomic_t processqueue_count;
>  static LIST_HEAD(processqueue);
>  
>  bool dlm_lowcomms_is_running(void)
> @@ -874,6 +877,7 @@ static void process_dlm_messages(struct work_struct *work)
>  	}
>  
>  	list_del(&pentry->list);
> +	atomic_dec(&processqueue_count);
>  	spin_unlock(&processqueue_lock);
>  
>  	for (;;) {
> @@ -891,6 +895,7 @@ static void process_dlm_messages(struct work_struct *work)
>  		}
>  
>  		list_del(&pentry->list);
> +		atomic_dec(&processqueue_count);
>  		spin_unlock(&processqueue_lock);
>  	}
>  }
> @@ -962,6 +967,7 @@ static int receive_from_sock(struct connection *con, int buflen)
>  		con->rx_leftover);
>  
>  	spin_lock(&processqueue_lock);
> +	ret = atomic_inc_return(&processqueue_count);
>  	list_add_tail(&pentry->list, &processqueue);
>  	if (!process_dlm_messages_pending) {
>  		process_dlm_messages_pending = true;
> @@ -969,6 +975,9 @@ static int receive_from_sock(struct connection *con, int buflen)
>  	}
>  	spin_unlock(&processqueue_lock);
>  
> +	if (ret > DLM_MAX_PROCESS_BUFFERS)
> +		return DLM_IO_FLUSH;
> +
>  	return DLM_IO_SUCCESS;
>  }
>  
> @@ -1503,6 +1512,9 @@ static void process_recv_sockets(struct work_struct *work)
>  		wake_up(&con->shutdown_wait);
>  		/* CF_RECV_PENDING cleared */
>  		break;
> +	case DLM_IO_FLUSH:
> +		flush_workqueue(process_workqueue);
> +		fallthrough;
>  	case DLM_IO_RESCHED:
>  		cond_resched();
>  		queue_work(io_workqueue, &con->rwork);
> -- 
> 2.39.3
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
