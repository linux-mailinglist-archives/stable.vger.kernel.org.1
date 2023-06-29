Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE2742A42
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 18:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjF2QHc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 12:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjF2QHa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 12:07:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7E41FD2
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 09:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09706157B
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 16:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889C3C433C0;
        Thu, 29 Jun 2023 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688054848;
        bh=m0B4NXa1LCIZ/nj2T82ikQC2cC2ycFK6Db3ynJMcbK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRviszAAwtFLQ76IqSjYNS17oiPV/YX/bSY4TKbh8nQ8yAELgxMyfSTTI/wy9FGss
         hp5aNJF52LcMzP/uxhpA+e/iDlESAUATrate3jY0R9cSk33AMY+3IDBJPy66PnIEmX
         G2ICjMfB0eVUcFd65S4zYIjHIkr556mhyTXVnWJs=
Date:   Thu, 29 Jun 2023 18:07:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Luiz Capitulino <luizcap@amazon.com>, sashal@kernel.org,
        stable@vger.kernel.org
Subject: Re: Possible build time regression affecting stable kernels
Message-ID: <2023062943-cognitive-basin-2261@gregkh>
References: <2023060156-precision-prorate-ce46@gregkh>
 <20259cf7-d50d-4eca-482b-3a89cc94df7b@amazon.com>
 <2023060148-levers-freight-5b11@gregkh>
 <CAHC9VhQ6W4hq3B122BxcrD6h6_-Q1AguFYYLjAbB6ALCbmzDoQ@mail.gmail.com>
 <2023060102-chatter-happening-f7a5@gregkh>
 <CAHC9VhRuc5jSK7xODqtBvhUmunov+PVVQyLb8oDP8k0pLq_P-g@mail.gmail.com>
 <2023062846-outback-posting-dfbd@gregkh>
 <CAHC9VhQfWNxP80PRHMM44fkMx8fnuPJ2VyR-mA1WMLwsAevRuA@mail.gmail.com>
 <2023062955-wing-front-553b@gregkh>
 <CAHC9VhQ5Mx_BMuTCyMFKeTWkgZsoXxAipzx6YQhrrhNu61_awA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ5Mx_BMuTCyMFKeTWkgZsoXxAipzx6YQhrrhNu61_awA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 29, 2023 at 11:55:12AM -0400, Paul Moore wrote:
> On Thu, Jun 29, 2023 at 4:43 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Jun 28, 2023 at 07:33:27PM -0400, Paul Moore wrote:
> > > > So, can I get a directory list or file list of what we should be
> > > > ignoring for the AUTOSEL and "Fixes: only" tools to be ignoring?
> > >
> > > I've been trying to ensure that the files/directories entries in
> > > MAINTAINERS are current, so that is probably as good a place as any to
> > > pull that info.  Do the stable tools use that info already?  In other
> > > words, if we update the entries in MAINTAINERS should we also notify
> > > you guys, or will you get it automatically?
> >
> > We do not use (or at least I don't, I can't speak for Sasha here, but
> > odds are we should unify this now), the MAINTAINERS file for this, but
> > rather a list like you provided below, thanks.
> 
> Fair enough, if we ever have any significant restructuring I'll try to
> remember to update the stable folks.  Although I'm guessing such a
> change would likely end up being self-reporting anyway.
> 
> > > Regardless, here is a list:
> > >
> > > * Audit
> > > include/asm-generic/audit_*.h
> > > include/linux/audit.h
> > > include/linux/audit_arch.h
> > > include/uapi/linux/audit.h
> > > kernel/audit*
> > > lib/*audit.c
> > >
> > > * LSM layer
> > > security/
> > > (NOTE: the individual sub-dirs under security/ belong to the
> > > individual LSMs, not the LSM layer)
> >
> > So security/*.c would cover this, not below that, right?
> 
> Yes, that should work.
> 
> > > * SELinux
> > > include/trace/events/avc.h
> > > include/uapi/linux/selinux_netlink.h
> > > scripts/selinux/
> > > security/selinux/
> >
> > Looks good, thanks for this.
> 
> Thanks for maintaining the exception list.

Cool, it's maintained here:
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list

if it's ever needed to be updated in the future.

thanks,

greg k-h
