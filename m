Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD88379EF41
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjIMQsN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjIMQrn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 12:47:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E89213F
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 09:46:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E86C433C7;
        Wed, 13 Sep 2023 16:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694623571;
        bh=l6BQcishzv0A3XoGku22AWTGbzdmlviMgrA0d566duY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0ExiiuvdKiJtsU1VRA3hSE/VVz/13OC+F2O+OTBwxVoCMEeoDWqtBYrRPawq3bdW
         Z7CjSXtJ0yeWZlmHq+aFYeyVr3ibLdHx4y2dnB78PxHm4uhmxlAE4Voi2id383z3O/
         v60cqhd4eaunscQI0qeZAXDJmHn2lBkkFH7ueuvzGM3SF+yIYFyJba+xILIPxuYQbD
         QXlYmKVI7sTGHRz/wytZpaoBv6FVtJGpEDFstKTQsqRwmh4iFQ6ft5h03TAIEoODR9
         hKUgHIlkH7VoCvOhv69dTMS0Und09YHAEn27C+95H1Of7h74eNTnMexaYgD1eM/x7C
         jGbfhaMJoas2Q==
Date:   Wed, 13 Sep 2023 09:46:08 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@meta.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        =?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Message-ID: <ZQHnUMlm80Xzxn6n@kbusch-mbp.dhcp.thefacebook.com>
References: <20230912214733.3178956-1-kbusch@meta.com>
 <ZQGqNZD9QweQQRmF@x1-carbon>
 <ZQHTKQLKFE9Iupp0@kbusch-mbp.dhcp.thefacebook.com>
 <ZQHf8Yyw+UC9ysDR@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQHf8Yyw+UC9ysDR@x1-carbon>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 04:14:44PM +0000, Niklas Cassel wrote:
> Hello Keith,
> 
> On Wed, Sep 13, 2023 at 08:20:09AM -0700, Keith Busch wrote:
> > On Wed, Sep 13, 2023 at 12:25:29PM +0000, Niklas Cassel wrote:
> > > > +		if (ctrl->ctrl_config & NVME_CC_CRIME)
> > > > +			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
> > > > +		else
> > > > +			timeout = max(timeout, NVME_CRTO_CRWMT(crto));
> > > 
> > > I saw the original bug report.
> > > But wasn't the problem that these were compared before NVME_CC_CRIME had
> > > been written?
> > >
> > > i.e. is this max() check still needed for the bug reporter's NVMe drive,
> > > after NVME_CC_CRIME was been written and CAP has been re-read?
> > > (If so, would a quirk be better?)
> > 
> > The values reported in CRTO don't change with the CC writes. It's only
> > CAP.TO that can change, so we still can't rely on CRTO at any point in
> > the sequence for these devices.
> 
> Yes, I know that CRTO (which is the new register), doesn't change.
> It is supposed to have to values:
> CRTO.CRIMT
> CRTO.CRWMT
> 
> The hack to modify CAP.TO to be in sync with either CRTO.CRIMT or
> CRTO.CRWMT is really ugly.

This is just a sanity check to ensure the device complies with spec,
specifically this part for CAP.TO:

  this field shall be set to:
   a) the value in Controller Ready With Media Timeout (CRTO.CRWMT); or
   b) FFh if CRTO.CRWMT is greater than FFh.

If CRWMT is smaller than CAP.TO, then the device is not spec compliant.
Yeah, the driver should prefer CRTO values, but if they're clearly
unreliable, we ought to fallback to a longer wait since we can't trust
the lower value. What's the worst that can happen? We wait longer than
necessary for a device that never becomes ready? That's totally
acceptable, IMO.
 
> Considering that CRTO.CRIMT and CRTO.CRWMT are also 16-bit,
> so wider than CAP.TO, suggests that software should read these
> if available, i.e. no need to ever read CAP.TO if
> CAP.CRMS.CRWMS is 1 or if CAP.CRMS.CRIMS is 1.
> 
> CRTO.CRIMT is allowed to be 0, if CAP.CRMS.CRIMS is 0.
> CRTO.CRWMT is not allowed to be 0 if CAP.CRMS.CRWMS is 1.
> (and this bit should be set to 1 according to NVMe 2.0).

I don't see any reason why CRTO.CRWMT can't legitimately be 0. I can
conceive of an implementation ready for commands immediately after CC.EN
0->1 without a delay. In this device case, though, it's just wrong.

> Additionally, NVMe 2.0b, Figure 35, clearly states register
> CRTO as Mandatory for I/O and Admin controllers.
 
> I guess that I just can't understand how a controller can set
> bit CAP.CRMS.CRWMS to 1, without setting a value in CRTO.CRWMT.
> Is it such a silly spec violation, that they seem to have not
> bothered to read what this bit means at all.

Yep, but broken controllers are broken. They used to work in Linux
before the driver started preferring the recommended CRTO, so we gotta
fix 'em.

> Such a controller is so obviously broken that it deserves a quirk.
> 
> Although, I understand that using quirks is not always the best
> solution for end users...

If we have a way to sanity check for spec non-compliance, I would prefer
doing that generically rather than quirk specific devices. Coincidently,
I received an internal report just yesterday of a 2nd vendor with
similar breakage, so this might be a common fuck up. Let's not put users
and maintainers through the hassle if we can resolve it just once.
