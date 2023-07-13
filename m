Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7313C752581
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjGMOuL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 13 Jul 2023 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGMOuK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 13 Jul 2023 10:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5568E270B
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 07:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AAA461542
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 14:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF51C433C7;
        Thu, 13 Jul 2023 14:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689259769;
        bh=gNzRnvp7dpfaFyOH+Dfs0Pt/L1HXuYhOOR+SdyoBl0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ma2NbpNVf4RyvhqBeKqPBOFsrWI0ZAVd7CU9+63uoFYnIWGXTQRhVWng9wUJ2wT7R
         qRC3GfEfBrr9+mnMbmmBHROX1GlJvp2dnudr49dvK7LrQLudAO6kDsGHOqT6BhMhIZ
         Q71VkeJDnL7qhQBFdxECJBj+vWHSle/Ay/Ky/0rU=
Date:   Thu, 13 Jul 2023 16:49:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        stable@vger.kernel.org, agruenba@redhat.com
Subject: Re: [PATCH v6.5-rc1 1/2] fs: dlm: introduce DLM_PLOCK_FL_NO_REPLY
 flag
Message-ID: <2023071318-traffic-impeding-dc64@gregkh>
References: <20230713144029.3342637-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713144029.3342637-1-aahringo@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 13, 2023 at 10:40:28AM -0400, Alexander Aring wrote:
> This patch introduces a new flag DLM_PLOCK_FL_NO_REPLY in case an dlm
> plock operation should not send a reply back. Currently this is kind of
> being handled in DLM_PLOCK_FL_CLOSE, but DLM_PLOCK_FL_CLOSE has more
> meanings that it will remove all waiters for a specific nodeid/owner
> values in by doing a unlock operation. In case of an error in dlm user
> space software e.g. dlm_controld we get an reply with an error back.
> This cannot be matched because there is no op to match in recv_list. We
> filter now on DLM_PLOCK_FL_NO_REPLY in case we had an error back as
> reply. In newer dlm_controld version it will never send a result back
> when DLM_PLOCK_FL_NO_REPLY is set. This filter is a workaround to handle
> older dlm_controld versions.
> 
> Fixes: 901025d2f319 ("dlm: make plock operation killable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

Why is adding a new uapi a stable patch?

> ---
>  fs/dlm/plock.c                 | 23 +++++++++++++++++++----
>  include/uapi/linux/dlm_plock.h |  1 +
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> index 70a4752ed913..7fe9f4b922d3 100644
> --- a/fs/dlm/plock.c
> +++ b/fs/dlm/plock.c
> @@ -96,7 +96,7 @@ static void do_unlock_close(const struct dlm_plock_info *info)
>  	op->info.end		= OFFSET_MAX;
>  	op->info.owner		= info->owner;
>  
> -	op->info.flags |= DLM_PLOCK_FL_CLOSE;
> +	op->info.flags |= (DLM_PLOCK_FL_CLOSE | DLM_PLOCK_FL_NO_REPLY);
>  	send_op(op);
>  }
>  
> @@ -293,7 +293,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
>  		op->info.owner	= (__u64)(long) fl->fl_owner;
>  
>  	if (fl->fl_flags & FL_CLOSE) {
> -		op->info.flags |= DLM_PLOCK_FL_CLOSE;
> +		op->info.flags |= (DLM_PLOCK_FL_CLOSE | DLM_PLOCK_FL_NO_REPLY);
>  		send_op(op);
>  		rv = 0;
>  		goto out;
> @@ -392,7 +392,7 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
>  	spin_lock(&ops_lock);
>  	if (!list_empty(&send_list)) {
>  		op = list_first_entry(&send_list, struct plock_op, list);
> -		if (op->info.flags & DLM_PLOCK_FL_CLOSE)
> +		if (op->info.flags & DLM_PLOCK_FL_NO_REPLY)
>  			list_del(&op->list);
>  		else
>  			list_move_tail(&op->list, &recv_list);
> @@ -407,7 +407,7 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
>  	   that were generated by the vfs cleaning up for a close
>  	   (the process did not make an unlock call). */
>  
> -	if (op->info.flags & DLM_PLOCK_FL_CLOSE)
> +	if (op->info.flags & DLM_PLOCK_FL_NO_REPLY)
>  		dlm_release_plock_op(op);
>  
>  	if (copy_to_user(u, &info, sizeof(info)))
> @@ -433,6 +433,21 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
>  	if (check_version(&info))
>  		return -EINVAL;
>  
> +	/* Some old dlm user space software will send replies back,
> +	 * even if DLM_PLOCK_FL_NO_REPLY is set (because the flag is
> +	 * new) e.g. if a error occur. We can't match them in recv_list
> +	 * because they were never be part of it. We filter it here,
> +	 * new dlm user space software will filter it in user space.
> +	 *
> +	 * In future this handling can be removed.
> +	 */
> +	if (info.flags & DLM_PLOCK_FL_NO_REPLY) {
> +		pr_info("Received unexpected reply from op %d, "
> +			"please update DLM user space software!\n",
> +			info.optype);

Never allow userspace to spam the kernel log.  And this is not going to
work, you need to handle the error and at most, report this to userspace
once.

Also, don't wrap your strings, checkpatch should have told you this.

thanks,

greg k-h
