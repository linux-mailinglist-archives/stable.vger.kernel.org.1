Return-Path: <stable+bounces-55164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035A99161AD
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EE8B21B25
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047D5148836;
	Tue, 25 Jun 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX8WRsVh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42871487EF;
	Tue, 25 Jun 2024 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305527; cv=none; b=KFngzeUEbrdhCpA2UpofXPQ5a+XhWK+jE8ZvALaZhJAQZ7Zh5E13Tw0Qm19wXX2VmDuTeyd/4pMv5sjpVWWmJVToBfUVL06I6ozWIamTKFF3/RNukiqo5QLl+GscPkcIEwlOpRJbvvKimhnUfOgcm4WrL74UO8hoai+WVgcMtF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305527; c=relaxed/simple;
	bh=4pe60kbKwrC7TGbA702p6mSSM0WZeEPXA2cJPlqiBy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLCgYR09IGlK1fZaxzWvuojXENZUhCefbt4u1HTdxNW38tVesxDTNKuCqZ0UEWz+P9Hc8PRQ0WOjSiA6dvNwy92tGrRiYMNRrNQESnftR6pDZnG00X/HV5tFNYGe61CCSMBxi5ECkeqR/cM4rOg9gW9hWLjW8rnJ5uD0K/CUjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX8WRsVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E638BC32781;
	Tue, 25 Jun 2024 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719305527;
	bh=4pe60kbKwrC7TGbA702p6mSSM0WZeEPXA2cJPlqiBy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OX8WRsVhci9jQbvXFHSbvGlv3mJIhsSBJvYsoMBm6z5QxQW8eiePKH1rTrnmV5C7K
	 Dl+TA2ei98RusxmsYRVQFGd2Z1B1YC5Ywv8A0UGzPMzgjfRiPj9lALo0GWOaUuxxeX
	 5j2iE/SihoZQBvT3lZhnDkF8OvWCNQ7YFDk2n/uO0Ch8ml2wu7l+cvnDoWcs8D2fL5
	 mZGUxFa3qo3cv6944qyrlS79hqNHmNL4AqCD8w1AV0KF0TtX2SL4tvP5lugXcMngiF
	 iQ8Oj7IvrAxMAPJgtaWFQy1RMYQGRj/oDxqcrTF43G//UTiemwvpzIBv66EH/ahYTK
	 suquxkZiYAaVw==
Date: Tue, 25 Jun 2024 10:52:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, lp610mh@gmail.com, stable@vger.kernel.org,
	Tkd-Alex <alex.tkd.alex@gmail.com>
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for all Crucial
 BX SSD1 models
Message-ID: <ZnqFM9oulPGKqytO@ryzen.lan>
References: <20240624132729.3001688-2-cassel@kernel.org>
 <82e310a4-5668-4edf-b3a8-2c7898a7c4cb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e310a4-5668-4edf-b3a8-2c7898a7c4cb@kernel.org>

On Tue, Jun 25, 2024 at 06:47:32AM +0900, Damien Le Moal wrote:
> On 2024/06/24 22:27, Niklas Cassel wrote:
> > We got another report that CT1000BX500SSD1 does not work with LPM.
> > 
> > If you look in libata-core.c, we have six different Crucial devices that
> > are marked with ATA_HORKAGE_NOLPM. This model would have been the seventh.
> > (This quirk is used on Crucial models starting with both CT* and
> > Crucial_CT*)
> > 
> > It is obvious that this vendor does not have a great history of supporting
> > LPM properly, therefore, add the ATA_HORKAGE_NOLPM quirk for all Crucial
> > BX SSD1 models.
> > 
> > Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> > Cc: stable@vger.kernel.org
> > Reported-by: Tkd-Alex <alex.tkd.alex@gmail.com>
> 
> We need a real full name here, not a user name... So if Alex is not willing to
> send his full name, please remove this.

I disagree.

The Signed-off-by tag needs a real name, but if you take a dig through the
git log, you will see that the Reported-by tag is not always a real name.

E.g. the benevolent dictator for life used a non-real name for Reported-by
here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6022f210461fef67e6e676fd8544ca02d1bcfa7a

Anyway, now when we have a real name, I will send a V2.


Kind regards,
Niklas

