Return-Path: <stable+bounces-152565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4605AD7570
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 17:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1C3188B53C
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 15:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F02298242;
	Thu, 12 Jun 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/zUKx35"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88B2980B4;
	Thu, 12 Jun 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741089; cv=none; b=CGx7WswZSlmcp+eu70ei9MgcwhOTfeG0z1LYkEtv2e7uOdujIBUuF908EXH/Q9U+FdKCn2acF8WHwSfhhEblDJqcUeVi4OX1PQHZ6HltwkC4ZzgExvZ3wEx7x6w9GYGPKBWLEiddsHLnApfB3ix1BRDvS8Q21Dtr64MzmsUmU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741089; c=relaxed/simple;
	bh=5KiAH2+HDHncQ/RBK1D4uGugtoEC8o+/psjkl+QCgG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJh5yrd4vrJJYCP2L2pL3pVr8KZp/f7s6Hn6rexfUPIMfVllMOpK9Gp90pTYJiGAB4r2TqJ7bQeqFpo0Ux4IeTip3CjU384m/L6cgvC4QKjTQL84SnSDIQTF7LKqn4UDNzhsX3jxgTOkMzmHtZqXWf5CPAFS89VRCZv3aPVRo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/zUKx35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFCBC4CEEE;
	Thu, 12 Jun 2025 15:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741088;
	bh=5KiAH2+HDHncQ/RBK1D4uGugtoEC8o+/psjkl+QCgG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e/zUKx3519LsCql7t0Y0IdI21okFM8UESHPCFX4sAWZi9xcRex90Lo1PeWl6NYP65
	 0PNLAuO1Hab2k7JyGfbOU+ti7UMqIrX4Ep8c066d7ZnqLAR7+hDRQBnvqU+Qh3vpbb
	 a0EhDlcxv5DzzaKa7yCmbL6SYK+nUYb/OkZmCPfeI5RGsmZQ/NMVuiyiUSxR1Y1Xz5
	 TW0+6qNl0tDSjbxIjQ5M6IYEZGZ9uP4PdhfzVcsXdG+54y+i3uROahYBIwNZJBd82N
	 Dyh/JFnrxV24eLut7UAQoyEYP/nKgg7sRVpXLkFunkoQpQSygBKX0CatnoTK3t05xH
	 5jLOpuKgN6XYg==
Message-ID: <49439599-bbbd-485a-b383-7b232ef5ca7e@kernel.org>
Date: Thu, 12 Jun 2025 17:11:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me, Andy Yang <andyybtc79@gmail.com>,
 Mikko Juhani Korhonen <mjkorhon@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 stable@vger.kernel.org
References: <20250612141750.2108342-2-cassel@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250612141750.2108342-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12-Jun-25 4:17 PM, Niklas Cassel wrote:
> A user has bisected a regression which causes graphical corruptions on his
> screen to commit 7627a0edef54 ("ata: ahci: Drop low power policy board
> type").
> 
> Simply reverting commit 7627a0edef54 ("ata: ahci: Drop low power policy
> board type") makes the graphical corruptions on his screen to go away.
> (Note: there are no visible messages in dmesg that indicates a problem
> with AHCI.)
> 
> The user also reports that the problem occurs regardless if there is an
> HDD or an SSD connected via AHCI, so the problem is not device related.
> 
> The devices also work fine on other motherboards, so it seems specific to
> the ASUSPRO-D840SA motherboard.
> 
> While enabling low power modes for AHCI is not supposed to affect
> completely unrelated hardware, like a graphics card, it does however
> allow the system to enter deeper PC-states, which could expose ACPI issues
> that were previously not visible (because the system never entered these
> lower power states before).
> 
> There are previous examples where enabling LPM exposed serious BIOS/ACPI
> bugs, see e.g. commit 240630e61870 ("ahci: Disable LPM on Lenovo 50 series
> laptops with a too old BIOS").
> 
> Since there hasn't been any BIOS update in years for the ASUSPRO-D840SA
> motherboard, disable LPM for this board, in order to avoid entering lower
> PC-states, which triggers graphical corruptions.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Andy Yang <andyybtc79@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220111
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v2:
> -Rework how we handle the quirk so that we also quirk future BIOS versions
>  unless a build date is explicitly added to driver_data.
> 
>  drivers/ata/ahci.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans





> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index e7c8357cbc54..c8ad8ace7496 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1410,8 +1410,15 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
>  
>  static bool ahci_broken_lpm(struct pci_dev *pdev)
>  {
> +	/*
> +	 * Platforms with LPM problems.
> +	 * If driver_data is NULL, there is no existing BIOS version with
> +	 * functioning LPM.
> +	 * If driver_data is non-NULL, then driver_data contains the DMI BIOS
> +	 * build date of the first BIOS version with functioning LPM (i.e. older
> +	 * BIOS versions have broken LPM).
> +	 */
>  	static const struct dmi_system_id sysids[] = {
> -		/* Various Lenovo 50 series have LPM issues with older BIOSen */
>  		{
>  			.matches = {
>  				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> @@ -1440,6 +1447,13 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
>  			},
>  			.driver_data = "20180409", /* 2.35 */
>  		},
> +		{
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA"),
> +			},
> +			/* 320 is broken, there is no known good version yet. */
> +		},
>  		{ }	/* terminate list */
>  	};
>  	const struct dmi_system_id *dmi = dmi_first_match(sysids);
> @@ -1449,6 +1463,9 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
>  	if (!dmi)
>  		return false;
>  
> +	if (!dmi->driver_data)
> +		return true;
> +
>  	dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
>  	snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
>  


