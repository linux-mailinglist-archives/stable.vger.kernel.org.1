Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF8F7349CC
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjFSBvu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 21:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFSBvt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 21:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C5DE42
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 18:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687139461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=juZChD7AeGuoIhBQHb19M6VO8+L15OVX04eqmBo6al4=;
        b=JEyEp34J3N2CsE4gPNWz8VcbWR5clU0n2S2e/9siQSr369npMJyzr3AQRdKY+2cujvbgtr
        6LtdMMh1dXwgjt5S7xrt642Qn6Uz2RO0Z2V3OLKD3aurW/ptU3R/dXerV1hhRIjMaLAWE/
        JNOOkqXDE8doT2Yt4lV1Vhu/xWyxa4w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-2VLEOqZ5PF2iiGds8b3jhA-1; Sun, 18 Jun 2023 21:50:58 -0400
X-MC-Unique: 2VLEOqZ5PF2iiGds8b3jhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06DDB185A78B;
        Mon, 19 Jun 2023 01:50:58 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE63C2166B26;
        Mon, 19 Jun 2023 01:50:53 +0000 (UTC)
Date:   Mon, 19 Jun 2023 09:50:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     gregkh@linuxfoundation.org
Cc:     axboe@kernel.dk, jaeshin@redhat.com, longman@redhat.com,
        tj@kernel.org, yosryahmed@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] blk-cgroup: Flush stats before releasing
 blkcg_gq" failed to apply to 6.3-stable tree
Message-ID: <ZI+0d98BX0knu+PT@ovpn-8-18.pek2.redhat.com>
References: <2023061747-drum-devourer-6205@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061747-drum-devourer-6205@gregkh>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jun 17, 2023 at 10:18:47AM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.3-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
> git checkout FETCH_HEAD
> git cherry-pick -x 20cb1c2fb7568a6054c55defe044311397e01ddb
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061747-drum-devourer-6205@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..
> 
> Possible dependencies:

I will port it to 6.3.y and post it later.

Thanks,
Ming

