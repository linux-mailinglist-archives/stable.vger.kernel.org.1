Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE26742288
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 10:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjF2IpU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjF2Ioa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 04:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D526D30F1
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 01:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65C4761502
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 08:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E527C433C9;
        Thu, 29 Jun 2023 08:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688028214;
        bh=1T7s2ZlorAEL0e5E5qBlSn3AXS4qK2ztbuGXqHOKEqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFoyM9yELEBey2u8ug0XBEcmhy/d7dFborxGplWnPAqG1FZPkoWpWX2vygRWKaJaf
         0+uzdegvGmrG7DDkX2cLEjKJxiQhmqHEDhA3budc9tw+qm87A/V/FRTY8Jyv9IsSmN
         dMVvv83xsKRiGM1LHpw1EnGlfPwqSzSr0bYJwX1U=
Date:   Thu, 29 Jun 2023 10:43:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Luiz Capitulino <luizcap@amazon.com>, sashal@kernel.org,
        stable@vger.kernel.org
Subject: Re: Possible build time regression affecting stable kernels
Message-ID: <2023062955-wing-front-553b@gregkh>
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <2023060156-precision-prorate-ce46@gregkh>
 <20259cf7-d50d-4eca-482b-3a89cc94df7b@amazon.com>
 <2023060148-levers-freight-5b11@gregkh>
 <CAHC9VhQ6W4hq3B122BxcrD6h6_-Q1AguFYYLjAbB6ALCbmzDoQ@mail.gmail.com>
 <2023060102-chatter-happening-f7a5@gregkh>
 <CAHC9VhRuc5jSK7xODqtBvhUmunov+PVVQyLb8oDP8k0pLq_P-g@mail.gmail.com>
 <2023062846-outback-posting-dfbd@gregkh>
 <CAHC9VhQfWNxP80PRHMM44fkMx8fnuPJ2VyR-mA1WMLwsAevRuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQfWNxP80PRHMM44fkMx8fnuPJ2VyR-mA1WMLwsAevRuA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 28, 2023 at 07:33:27PM -0400, Paul Moore wrote:
> > So, can I get a directory list or file list of what we should be
> > ignoring for the AUTOSEL and "Fixes: only" tools to be ignoring?
> 
> I've been trying to ensure that the files/directories entries in
> MAINTAINERS are current, so that is probably as good a place as any to
> pull that info.  Do the stable tools use that info already?  In other
> words, if we update the entries in MAINTAINERS should we also notify
> you guys, or will you get it automatically?

We do not use (or at least I don't, I can't speak for Sasha here, but
odds are we should unify this now), the MAINTAINERS file for this, but
rather a list like you provided below, thanks.

> Regardless, here is a list:
> 
> * Audit
> include/asm-generic/audit_*.h
> include/linux/audit.h
> include/linux/audit_arch.h
> include/uapi/linux/audit.h
> kernel/audit*
> lib/*audit.c
> 
> * LSM layer
> security/
> (NOTE: the individual sub-dirs under security/ belong to the
> individual LSMs, not the LSM layer)

So security/*.c would cover this, not below that, right?

> * SELinux
> include/trace/events/avc.h
> include/uapi/linux/selinux_netlink.h
> scripts/selinux/
> security/selinux/

Looks good, thanks for this.

greg k-h
