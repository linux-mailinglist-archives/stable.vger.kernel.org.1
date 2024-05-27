Return-Path: <stable+bounces-46284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A38CFB0F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 10:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A9E1F2101E
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB203B298;
	Mon, 27 May 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNWqk8Ao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7473A1B6;
	Mon, 27 May 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797532; cv=none; b=e1qCQzjzfWpMfnkmvI4g/V1azD2u5low6T2mkiJM77CaQz28ugu9Vv3t/l0lG5wWZ6GeJHfnJS5FnJbJsu3dc+RhU8zP8XvE/xt7b6sFIj5z31+v8Cx/cymO4d/q2ZfjiG4vPZYxwrIurCx6AMvf0ziIK+0XGQXdIHN3mzmwnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797532; c=relaxed/simple;
	bh=MqOHYe0UGiIBXGRX/xNVtnaxON/WQbzQCnxadJ9yroM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdKg186nrSgeVAJ5nvJoAt0/CA6NsBbQ9bSGjSlnZRooTTygHG3xekIQElbZ4ZPqlADCmcLRarfyz+3Bso4/YmHNR1EEJTA/bjBu/WeG36ZiStlFjDa6VLb8/xNekvNxfaTOcTHs+pYfZfHOdKTtftnqdtiQfJ09zAPv/thejGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNWqk8Ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5D8C2BBFC;
	Mon, 27 May 2024 08:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716797532;
	bh=MqOHYe0UGiIBXGRX/xNVtnaxON/WQbzQCnxadJ9yroM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNWqk8AoTGJdM7ibgXHK1clorLzQaKEqIWJZspmiYYIHgU7JRgN9rdtSA+2wHnnmW
	 pvRuaeGG/3wZC85ZCx3MuZQuFY5Pt+MGx6QjGk98+oxVoAXkG41U3Iflj0xdEIbkRi
	 10PpC4x3Ry/E60/irFzEC1TBhi4I2TXpkD4rVAGP8d/Ii31EKeqlDhv3R9W5yNRTLd
	 rvR9e5DxaMqibnLdGjXGC8n0JZsCfTaYx1HYCHB/M1a/8WRMPdnDk9FRRIQRV+Vjsc
	 85pheeUQkNmUr849fVbXKKRXJGVf8AsEpCx9pf9rLcKUuaNciAwB0rxd4p6yKtV/oi
	 oZ19Zbckia9Hw==
Date: Mon, 27 May 2024 10:12:08 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jason Nader <dev@kayoway.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] ata: ahci: Do not apply Intel PCS quirk on Intel
 Alder Lake
Message-ID: <ZlRAWMJTTAy6Yg0V@ryzen.lan>
References: <20240513135302.1869084-1-dev@kayoway.com>
 <20240521133624.1103100-1-dev@kayoway.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521133624.1103100-1-dev@kayoway.com>

On Tue, May 21, 2024 at 10:36:24PM +0900, Jason Nader wrote:
> Commit b8b8b4e0c052 ("ata: ahci: Add Intel Alder Lake-P AHCI controller
> to low power chipsets list") added Intel Alder Lake to the ahci_pci_tbl.
> 
> Because of the way that the Intel PCS quirk was implemented, having
> an explicit entry in the ahci_pci_tbl caused the Intel PCS quirk to
> be applied. (The quirk was not being applied if there was no explict
> entry.)
> 
> Thus, entries that were added to the ahci_pci_tbl also got the Intel
> PCS quirk applied.
> 
> The quirk was cleaned up in commit 7edbb6059274 ("ahci: clean up
> intel_pcs_quirk"), such that it is clear which entries that actually
> applies the Intel PCS quirk.
> 
> Newer Intel AHCI controllers do not need the Intel PCS quirk,
> and applying it when not needed actually breaks some platforms.
> 
> Do not apply the Intel PCS quirk for Intel Alder Lake.
> This is in line with how things worked before commit b8b8b4e0c052 ("ata:
> ahci: Add Intel Alder Lake-P AHCI controller to low power chipsets list"),
> such that certain platforms using Intel Alder Lake will work once again.
> 
> Cc: stable@vger.kernel.org # 6.7
> Fixes: b8b8b4e0c052 ("ata: ahci: Add Intel Alder Lake-P AHCI controller to low power chipsets list")
> Signed-off-by: Jason Nader <dev@kayoway.com>
> ---
>  drivers/ata/ahci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 6548f10e61d9..07d66d2c5f0d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -429,7 +429,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_pcs_quirk }, /* Comet Lake PCH RAID */
>  	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
>  	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_pcs_quirk }, /* Elkhart Lake AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x7ae2), board_ahci_pcs_quirk }, /* Alder Lake-P AHCI */
>  
>  	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>  	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> -- 
> 2.45.1
> 

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.10-fixes

