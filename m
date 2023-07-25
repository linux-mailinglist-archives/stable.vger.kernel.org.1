Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7288C7608DC
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 06:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjGYEq3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 00:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjGYEq1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 00:46:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1351E10E5
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 21:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91CE961535
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D53CC433CC;
        Tue, 25 Jul 2023 04:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690260383;
        bh=bpLPeLn+xGD3bpb5Qfr8oWmqKwMTnOxkwkkLWH7IzSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aH7MACeJG/Xyfl8shxtsA/wM2aTBU5yIECyegW/6PCAKoivNOhyp1ZQhwrCasyG2v
         nf/vMv3tpF78M5KeYSHQ6yJ6Gx89UmialjiPuE07Hk/KjfNE7qKzHCp7bl6G/0CZro
         l6YQT5nf5DXvOp+1PIDTDUuFvTcSjnSx2HvbG7io=
Date:   Tue, 25 Jul 2023 06:46:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     stable@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH] r8169: revert 2ab19de62d67 ("r8169: remove ASPM
 restrictions now that ASPM is disabled during NAPI poll")
Message-ID: <2023072558-moisten-snore-73c7@gregkh>
References: <2023072337-dreamlike-rewrite-a12e@gregkh>
 <38cddf6d-f894-55a1-6275-87945b265e8b@gmail.com>
 <2023072453-saturate-atlas-2572@gregkh>
 <e24f1b91-efd1-5398-624f-a73c0e92d677@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e24f1b91-efd1-5398-624f-a73c0e92d677@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 24, 2023 at 09:58:39PM +0200, Heiner Kallweit wrote:
> On 24.07.2023 19:32, Greg KH wrote:
> > On Mon, Jul 24, 2023 at 05:59:07PM +0200, Heiner Kallweit wrote:
> >> There have been reports that on a number of systems this change breaks
> >> network connectivity. Therefore effectively revert it. Mainly affected
> >> seem to be systems where BIOS denies ASPM access to OS.
> >> Due to later changes we can't do a direct revert.
> >>
> >> Fixes: 2ab19de62d67 ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI poll")
> >> Cc: stable@vger.kernel.org # v6.4.y
> >> Link: https://lore.kernel.org/netdev/e47bac0d-e802-65e1-b311-6acb26d5cf10@freenet.de/T/
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217596
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> Link: https://lore.kernel.org/r/57f13ec0-b216-d5d8-363d-5b05528ec5fb@gmail.com
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >> ---
> >>  drivers/net/ethernet/realtek/r8169_main.c | 27 ++++++++++++++++++++++-
> >>  1 file changed, 26 insertions(+), 1 deletion(-)
> >>
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> The conflict notification email mentioned the following, therefore I replied
> with the backported patch. Which part is wrong or what is missing?

No hint that it was a backported patch, what the git id was, or what
branch to apply it to :(

> The patch below does not apply to the 6.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x cf2ffdea0839398cb0551762af7f5efb0a6e0fea
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072337-dreamlike-rewrite-a12e@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

The instructions above, if followed, will give the git id, and the
branch to apply it to, in the email in a form which it can be properly
deduced.

Otherwise this looks like a mis-directed patch that we don't know what
to do with :(

thanks,

greg k-h
