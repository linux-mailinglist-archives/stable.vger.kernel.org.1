Return-Path: <stable+bounces-20355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CF7857CA5
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 13:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC21D1C22F6A
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EF312881C;
	Fri, 16 Feb 2024 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NALNiGxt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9E78B66;
	Fri, 16 Feb 2024 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086827; cv=none; b=Ls1EQi5yjtbmZdCqHvSugD6lpCSbIszXwaBeZUzarvP0pVdsVdLJ+hHDlQOf0abssUoQ1VtYVGs1wm0XtF/HtvhPxtFQSZGKRpEd0IsBcQtHDKcHIPYUVbcjqGlePTTKFXxTH/+VwLPqejC9Duonx5n0QcmnsclpenuTWNLgQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086827; c=relaxed/simple;
	bh=HaKdZfSG22E2FVRd9BdX5eYZM5R1eXCBvV0m5VvAyjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWon8gSCOE09V7+9n5XcY62HYg12bJjnrkSRyuzfi0zyvxHPbjlckpYOmjKu22gDoGNW0d9CiSqgcV9W2opInAJWeWOcP9jHEXIxRdz25GKAzDneyiR+bnh5IElLcm5UBpFKacn4PaK96yKBnCELE2Ozfo5CNiY2kHJTY0+r11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NALNiGxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D40C433C7;
	Fri, 16 Feb 2024 12:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086826;
	bh=HaKdZfSG22E2FVRd9BdX5eYZM5R1eXCBvV0m5VvAyjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NALNiGxtkmJu7aNTBydFJY1gCjgA4G3VnycsTKjtuDTr8JNdZo+ee1fql8BqnuvBR
	 tOuKCoylbo4B+xrBTSJ9IbYOdsxHURA3U9BOU4G62GN5TvaT9/N6461R2V3q3M1/SX
	 oLY9iguRc8VRoFG8o+AQGNdYZb6cT0Q5GHKW7QUPIZIydLJp97UMuvoFT+2Ca0nFo+
	 rM0hKWdy/c2TUMWgxyVyjJxAPyFx+QIza90LhOGYvnZJ8R6F8AY4iExpM7l1BaQK6K
	 7xn2/7ieVuZxb0tOUndH8zp00HOXPyD6t7CnIdMJEzAo3VhgpFKByFziBzI9FFQ+rp
	 0U8EaMUQmISyQ==
Date: Fri, 16 Feb 2024 13:33:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Do not call
 ata_dev_power_set_standby() twice
Message-ID: <Zc9WJcBRrf5kr/pi@x1-carbon>
References: <20240216112008.1112538-1-cassel@kernel.org>
 <c2054321-401d-4b16-9c20-20ea11929f49@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2054321-401d-4b16-9c20-20ea11929f49@kernel.org>

On Fri, Feb 16, 2024 at 09:16:23PM +0900, Damien Le Moal wrote:
> On 2/16/24 20:20, Niklas Cassel wrote:
> > From: Damien Le Moal <dlemoal@kernel.org>
> > 
> > For regular system shutdown, ata_dev_power_set_standby() will be
> > executed twice: once the scsi device is removed and another when
> > ata_pci_shutdown_one() executes and EH completes unloading the devices.
> > 
> > Make the second call to ata_dev_power_set_standby() do nothing by using
> > ata_dev_power_is_active() and return if the device is already in
> > standby.
> > 
> > Fixes: 2da4c5e24e86 ("ata: libata-core: Improve ata_dev_power_set_active()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > This fix was originally part of patch that contained both a fix and
> > a revert in a single patch:
> > https://lore.kernel.org/linux-ide/20240111115123.1258422-3-dlemoal@kernel.org/
> > 
> > This patch contains the only the fix (as it is valid even without the
> > revert), without the revert.
> > 
> > Updated the Fixes tag to point to a more appropriate commit, since we
> > no longer revert any code.
> > 
> >  drivers/ata/libata-core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index d9f80f4f70f5..af2334bc806d 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -85,6 +85,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
> >  static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
> >  static void ata_dev_xfermask(struct ata_device *dev);
> >  static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
> > +static bool ata_dev_power_is_active(struct ata_device *dev);
> 
> I forgot what I did originally but didn't I move the code of
> ata_dev_power_is_active() before ata_dev_power_set_standby() to avoid this
> forward declaration ?
> 
> With that, the code is a little odd as ata_dev_power_is_active() is defined
> between ata_dev_power_set_standby() and ata_dev_power_set_active() but both
> functions use it...

Yes, you moved the function instead of forward declaring it.

But then there was a discussion of why ATA_TFLAG_ISADDR is set in
ata_dev_power_is_active():
https://lore.kernel.org/linux-ide/d63a7b93-d1a3-726e-355c-b4a4608626f4@gmail.com/

And you said that you were going to look in to it:
https://lore.kernel.org/linux-ide/0563322c-4093-4e7d-bb48-61712238494e@kernel.org/

Since this fix does not strictly require any changes to
ata_dev_power_is_active(), and since we already have a bunch of
forward declared functions, I think that forward declaring it is a
good way to avoid this actual fix from falling through the cracks.


Kind regards,
Niklas

