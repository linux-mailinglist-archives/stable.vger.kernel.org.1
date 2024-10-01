Return-Path: <stable+bounces-78502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2969898BE80
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9B41C2172F
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299B01C8FD6;
	Tue,  1 Oct 2024 13:51:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037041C7B85;
	Tue,  1 Oct 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790695; cv=none; b=oR0PEgSmn+wSycMFod3GyXZaYX9+QQtW2YkCssMr7ZT3P2WnopM6puPoFZIQjDehGBPiozXwhcpgyVPfCkSPTKG89p1QJnNTp/rIIfuFJROim931nnprhbXwoa8IUXN2lg1m0WHvvNaAJJXJG1u/vSuWStmYLIvR/yl2AeYq18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790695; c=relaxed/simple;
	bh=2fo/+5TzW8Lnvu8C8hpVTe4rIXImdrGxixvdBsg4FDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2ThD88O86/F9r5Xtqkm3BmB7Z/YFmwLHUNZjw7T6SXlVZrDLWGzFkfp1OQnJU+Tk8trVfEMEby630NfyzjjcHKdvw4N1eTceWyQQK8OuNSNw0fmxqwmtBxXE+1tsouwJjumg6j1kTGqXqZKjXF1sR0iPfgx0LujkOzphH9oeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9BD2FC0003;
	Tue,  1 Oct 2024 13:51:27 +0000 (UTC)
Message-ID: <3c2ff70d-a580-4bba-b6e2-1b66b0a98c5d@ghiti.fr>
Date: Tue, 1 Oct 2024 15:51:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: efi: Set NX compat flag in PE/COFF header
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Heinrich,

On 29/09/2024 16:02, Heinrich Schuchardt wrote:
> The IMAGE_DLLCHARACTERISTICS_NX_COMPAT informs the firmware that the
> EFI binary does not rely on pages that are both executable and
> writable.
>
> The flag is used by some distro versions of GRUB to decide if the EFI
> binary may be executed.
>
> As the Linux kernel neither has RWX sections nor needs RWX pages for
> relocation we should set the flag.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   arch/riscv/kernel/efi-header.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
> index 515b2dfbca75..c5f17c2710b5 100644
> --- a/arch/riscv/kernel/efi-header.S
> +++ b/arch/riscv/kernel/efi-header.S
> @@ -64,7 +64,7 @@ extra_header_fields:
>   	.long	efi_header_end - _start			// SizeOfHeaders
>   	.long	0					// CheckSum
>   	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION		// Subsystem
> -	.short	0					// DllCharacteristics
> +	.short	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	// DllCharacteristics
>   	.quad	0					// SizeOfStackReserve
>   	.quad	0					// SizeOfStackCommit
>   	.quad	0					// SizeOfHeapReserve


I don't understand if this fixes something or not: what could go wrong 
if we don't do this?

Thanks,

Alex


