Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F6F742BB6
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjF2SH4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjF2SHz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3CA1BD6
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB2F2615D1
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99CFC433C8;
        Thu, 29 Jun 2023 18:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688062071;
        bh=JWzxliodFFtqsyjT991ra8WMh+2MUB6v/5XwPT+OUXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0TjO64JeZS7hVasW4frRKGkcj/tlBeraP/HbGLjLSmusVwNnYZ7SdIaaE1dbugHRo
         0xkdlEkCYAxw4QGOWXQpIW0lDmWHWzQ4hI3xPxxIeONAvK4WivpHA1Gdj7M2ipb1pQ
         eU6CkghqbFOQIv7QJU3xiknMxrvz9fOAwzDFBhK4=
Date:   Thu, 29 Jun 2023 20:07:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     pabeni@redhat.com, cpaasch@apple.com, kuba@kernel.org,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mptcp: fix possible divide by zero in
 recvmsg()" failed to apply to 5.10-stable tree
Message-ID: <2023062938-tidbit-sampling-3bde@gregkh>
References: <2023062349-nerd-rupture-49ab@gregkh>
 <062b7104-b536-2b09-acae-3f99d57368dd@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <062b7104-b536-2b09-acae-3f99d57368dd@tessares.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 29, 2023 at 08:00:29PM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 23/06/2023 11:30, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.10-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 0ad529d9fd2bfa3fc619552a8d2fb2f2ef0bce2e
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062349-nerd-rupture-49ab@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
> 
> Thank you for the notification.
> 
> I think we can drop this patch for v5.10. The infrastructure in the code
> is not there (mptcp_disconnect()) and the risk is very low: we only saw
> the issue recently, maybe only visible in newer versions due to other
> features.
> 
> So no need to do anything here for v5.10.

Great, thanks for letting us know.

greg k-h
