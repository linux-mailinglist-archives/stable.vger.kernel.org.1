Return-Path: <stable+bounces-178027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A61DB47974
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 09:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3AD189623C
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 07:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F4A1F790F;
	Sun,  7 Sep 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rJlUB+Re"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B061E51F1
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757231690; cv=none; b=SSSwfcSrhNgcTj+JoxwOvYHult7I79a0Hm495cPbKm3wzv7baTlR1wzN4j8A+HRvnZhbC43lav86vHOFN7cVnVpz6raut47NkSG9Z2jT5rCrGOwMwmY6YDzYSScvUrUwvST6nsltZrF0EsgHpFWwknn2boAEf0eUdRDz4M8yKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757231690; c=relaxed/simple;
	bh=Va0+6dNLR/iRYAwBSZO0MreU3UI8JvLpAlkvIvHZB3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAmO4JtiX9guZ17BA7nF4MzM01eWK6hF9oJbZ/oOS6IthjxOQ5dRzL+zGoiBc2yWqiHsif3QIwJNy9XwwVJ+UKWURWUtMOxWesZg329vlhqpMGXBG5TgFnywXJRXtf+N+wSCWaWq26D3gfkAR4XlKjwux1D6BPuVqJbK716Gdsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rJlUB+Re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051B9C4CEF0;
	Sun,  7 Sep 2025 07:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757231689;
	bh=Va0+6dNLR/iRYAwBSZO0MreU3UI8JvLpAlkvIvHZB3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJlUB+Redq9A6gSe4iBsWB816wkO5wlbbKdwCEXkxOSd+cXQZolkaj1PhgrjjA3A4
	 Gup/feXKv515DrKUxMh0ed9e13nxHLwf9dh1zoN0RstwlSfGxziiVMwOl3pY1bnN4y
	 kUk/Ejsbf5wFjXO2gVCIPcHnwOb2wRft62se27fI=
Date: Sun, 7 Sep 2025 09:54:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Chris Chiu <chris.chiu@canonical.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 6.6.y] ALSA: hda/realtek - Add new HP ZBook laptop with
 micmute led fixup
Message-ID: <2025090758-chasing-cassette-aa76@gregkh>
References: <2025052415-fang-botanist-0180@gregkh>
 <20250905211700.3421432-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905211700.3421432-1-sashal@kernel.org>

On Fri, Sep 05, 2025 at 05:17:00PM -0400, Sasha Levin wrote:
> From: Chris Chiu <chris.chiu@canonical.com>
> 
> [ Upstream commit f709b78aecab519dbcefa9a6603b94ad18c553e3 ]
> 
> New HP ZBook with Realtek HDA codec ALC3247 needs the quirk
> ALC236_FIXUP_HP_GPIO_LED to fix the micmute LED.
> 
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> Cc: <stable@vger.kernel.org>
> Link: https://patch.msgid.link/20250520132101.120685-1-chris.chiu@canonical.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> [ Adjust context ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index d4bc80780a1f9..b47820105ead4 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10249,6 +10249,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8e1d, "HP ZBook X Gli 16 G12", ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
>  	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
>  	SND_PCI_QUIRK(0x1043, 0x1054, "ASUS G614FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
> -- 
> 2.50.1
> 
> 

This, and the other alsa patch for 6.6, conflicted as you only
backported these on a "clean" tree.  I've fixed it up by hand, but I
don't know if you have a way to determine that these are in a "series"
or not.

thanks,

greg k-h

