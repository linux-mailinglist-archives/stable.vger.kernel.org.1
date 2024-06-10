Return-Path: <stable+bounces-50094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78066902405
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 16:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216F81F22482
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BE512F397;
	Mon, 10 Jun 2024 14:26:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A86484E1F;
	Mon, 10 Jun 2024 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029586; cv=none; b=qJpXmw9u981mEMr6L4XAMuFr+JiaYN8oX4D01+sYHzVHSW0QvXFqsDWqdnyELUwUvAQdpw9HkOzPFopC9JWhX27TJEI+UcrFbd/wOZRuRa7UTHhV4fWTyCN3VNuBKYKksVGW66AjDhLBwCeuD0RtHJbi6p9NWO+m1U1vfx0rTaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029586; c=relaxed/simple;
	bh=K8PVPwbdAax7eDEaEiYoUJQ+9eRdRMPvizcBIqVICXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByrFpownKVO4jyxisPRX4UIo8D3z/WD2wBIzpcBjisYSVruHM0tlCEarRCuR51w8mcQhioJLMd5w+q86x3aUu7mdlGCRbsaoXuaqiQKwqSbv3scLAEdKpHP02PWFLCDkqv69VSRCvC2z8LNaGmw5Ue79fw0dI2RfSWhq1S8qhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id AF3A872C8F5;
	Mon, 10 Jun 2024 17:20:44 +0300 (MSK)
Received: from pony.office.basealt.ru (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id A88F436D0184;
	Mon, 10 Jun 2024 17:20:44 +0300 (MSK)
Received: by pony.office.basealt.ru (Postfix, from userid 500)
	id 6F33D360B51C; Mon, 10 Jun 2024 17:20:44 +0300 (MSK)
Date: Mon, 10 Jun 2024 17:20:44 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Gora <dan.gora@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Leonid Krivoshein <klark.devel@gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: btrtl: Add missing MODULE_FIRMWARE
 declarations
Message-ID: <lpcccmoa34ifxregretv3cim3cfajonkcwbm3d6j5d4ekyweya@k2cswpafqdw7>
References: <20230504212843.18519-1-dan.gora@gmail.com>
 <20230509195119.9655-1-dan.gora@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509195119.9655-1-dan.gora@gmail.com>

Greg, Sasha,

Please add this patch to 6.1.x branch. Mainline commit
bb23f07cb63975968bbabe314486e2b087234fc5

This will fix Bluetooth support (visibility of devices) and manifested
errors during boot:

  bluetooth hci0: Direct firmware load for rtl_bt/rtl8822cu_fw.bin failed with error -2
  Bluetooth: hci0: RTL: firmware file rtl_bt/rtl8822cu_fw.bin not found

Downstream bug report: https://bugzilla.altlinux.org/50471

Thanks,

On Tue, May 09, 2023 at 12:51:19PM -0700, Dan Gora wrote:
> Add missing MODULE_FIRMWARE declarations for firmware referenced in
> btrtl.c.
> 
> Signed-off-by: Dan Gora <dan.gora@gmail.com>
> ---
>  drivers/bluetooth/btrtl.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 2915c82d719d..d978e7cea873 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1367,14 +1367,30 @@ MODULE_FIRMWARE("rtl_bt/rtl8723cs_vf_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8723cs_vf_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8723cs_xx_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8723cs_xx_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8723d_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8723d_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8761a_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8761b_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8761b_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8761bu_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8761bu_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8821a_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8821a_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8821c_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8821c_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8821cs_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8821cs_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8822b_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8822b_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8822cs_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8822cs_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8822cu_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8822cu_config.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8851bu_fw.bin");
> +MODULE_FIRMWARE("rtl_bt/rtl8851bu_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852au_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852bs_fw.bin");
> @@ -1383,5 +1399,3 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
>  MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8851bu_fw.bin");
> -MODULE_FIRMWARE("rtl_bt/rtl8851bu_config.bin");
> -- 
> 2.35.1.102.g2b9c120970
> 

