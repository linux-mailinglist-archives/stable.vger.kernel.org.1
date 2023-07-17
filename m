Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC67756DFD
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 22:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjGQUMo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 16:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGQUMn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 16:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84994A6
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 13:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 219236123A
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 20:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3E6C433C8;
        Mon, 17 Jul 2023 20:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689624761;
        bh=PgUJ/kj6+r6scn/MLqY9Og1CPXO4zQlWcVYJBDBVfIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bl0qdT+7OD4QzoWqGtQoomA9GplH+rF40tg1Q0OoxVwrRVfZ7tRIzCqwJrLq8/sRW
         qpeyMV4N64zmWPhORyFn7ss7TsqFRdCcCNSpyIx3sI8IC0MunCVjYuzZMxlA4kpfVk
         FWjLOz6Mz87X5Ph70g1ncvnKB8Ek5DOE/necrbVg=
Date:   Mon, 17 Jul 2023 22:12:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     andres@anarazel.de, asml.silence@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: Use io_schedule* in cqring
 wait" failed to apply to 6.1-stable tree
Message-ID: <2023071722-quirk-uncouple-9542@gregkh>
References: <2023071620-litigate-debunk-939a@gregkh>
 <0cfb74bb-c203-39a1-eab7-abeeae724b68@kernel.dk>
 <222ae139-33a6-a522-0deb-dcdf044edd19@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <222ae139-33a6-a522-0deb-dcdf044edd19@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 17, 2023 at 10:39:51AM -0600, Jens Axboe wrote:
> On 7/16/23 12:13 PM, Jens Axboe wrote:
> > On 7/16/23 2:41 AM, gregkh@linuxfoundation.org wrote:
> >>
> >> The patch below does not apply to the 6.1-stable tree.
> >> If someone wants it applied there, or to any other stable or longterm
> >> tree, then please email the backport, including the original git commit
> >> id to <stable@vger.kernel.org>.
> >>
> >> To reproduce the conflict and resubmit, you may use the following commands:
> >>
> >> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> >> git checkout FETCH_HEAD
> >> git cherry-pick -x 8a796565cec3601071cbbd27d6304e202019d014
> >> # <resolve conflicts, build, test, etc.>
> >> git commit -s
> >> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071620-litigate-debunk-939a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > 
> > Here's one for 6.1-stable.
> 
> And here's a corrected one for 6.1.

All now queued up, thanks.

greg k-h
