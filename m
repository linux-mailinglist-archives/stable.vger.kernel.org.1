Return-Path: <stable+bounces-53825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E953A90E8F0
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962C31F218C6
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383491386C9;
	Wed, 19 Jun 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SRxN1qgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFC580BFF;
	Wed, 19 Jun 2024 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795120; cv=none; b=BrfXEyzC1cVcwYuv/9sGSlFUPc1h5c6drUR2mKeQPbsqENvQnUaRNNxXa9jYJ8/aIQ3nXOloS746PIHSCpq1HUaYX63K4MKjeFTo9fHV2ODSPC9u6MG/fTwfVKBAVlaGNN5/hWpzK/oFGOW0keH4ejBNyQRuou+r33OOM5cmRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795120; c=relaxed/simple;
	bh=l7ToMDCtV3ZqsLxvf9mUdcHH4ylWiymL+hAWVPLUklo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM+YjGlSpX1hpbT2015DlK8bw6EFOYs1GJKVfW/4ErbjHN96qVTsu7v82KTHQpBA2iQYHFYka33MPWrmPxxwngm33vD4AKWFkLVeUebEhygor9QDA3T6q8l8+O03sU/1Xf8cVpTyhhx4ZkJjZvRQvIwk8QrVa0ZAG9CipaAieRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SRxN1qgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0518FC4AF4D;
	Wed, 19 Jun 2024 11:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718795119;
	bh=l7ToMDCtV3ZqsLxvf9mUdcHH4ylWiymL+hAWVPLUklo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRxN1qggvNdHJjrVNRbB6tHSpvfyFhwMO35kDmVwnp0mw1Z+TngxsVMSLFYJM762j
	 jo7eWx7eRXaC2W8yo/ql9KSvzh1nBXYvNqonYHKlmLUt22kI7jX10hS2EYbBmjVrWQ
	 5TgpoWMkMBoVwDtpEVP16P/cQZPd9hOeR3d4iMrA=
Date: Wed, 19 Jun 2024 13:05:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pablo =?iso-8859-1?Q?Ca=F1o?= <pablocpascual@gmail.com>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14AHP9
Message-ID: <2024061903-agile-satisfy-d722@gregkh>
References: <20240619105932.29124-1-pablocpascual@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619105932.29124-1-pablocpascual@gmail.com>

On Wed, Jun 19, 2024 at 12:59:32PM +0200, Pablo Caño wrote:
> Lenovo Yoga Pro 7 14AHP9 (PCI SSID 17aa:3891) seems requiring a similar workaround like Yoga 9 model and Yoga 7 Pro 14APH8 for the bass speaker.
> 
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index aa76d1c88589..f9223fedf8e9 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10525,6 +10525,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x3881, "YB9 dual power mode2 YC", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x3882, "Lenovo Yoga Pro 7 14APH8", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
> +	SND_PCI_QUIRK(0x17aa, 0x3891, "Lenovo Yoga Pro 7 14AHP9", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
>  	SND_PCI_QUIRK(0x17aa, 0x3884, "Y780 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C),
> -- 
> 2.45.2
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

