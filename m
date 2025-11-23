Return-Path: <stable+bounces-196626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1302AC7E7DB
	for <lists+stable@lfdr.de>; Sun, 23 Nov 2025 22:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DBFC4E13D0
	for <lists+stable@lfdr.de>; Sun, 23 Nov 2025 21:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5963C26E708;
	Sun, 23 Nov 2025 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTQjUcgp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3AB26CE11;
	Sun, 23 Nov 2025 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763934373; cv=none; b=A661rV6g7mF3AUTEfQrgZ2DwgP0Wkin7x+idDGh8mMJsRG+R0K4nYomoP/zLL1qi/UPZ3G7qbsCNPqYt5f/boElQ5Kq8QULG912ittM78EHyvLTIi16BNaG/CMFBwZh0O2b/94zOyyYCf8FoAGBtLCg3X+QZyiBtqimp18dU1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763934373; c=relaxed/simple;
	bh=erfZkZ5UG+aglPHXCSoaPTJtbm5oOoBqRQdNgSjH3p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thGxuU2lDa6Ym7xgiax2uBcjRt/fVNa9VUv1K8ym01hFtwjRa/WhKwtQ0xGoifkM7ReOVQn8E3urpC+x0dJb2UHzrQvZdZWAdolTZMvRxrB+yvW/L9hncO837Ytbr1CzQHtJw3/IX1J3VljHexS3UXtiON5O7cpDRaHsVWMOqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTQjUcgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CEFC113D0;
	Sun, 23 Nov 2025 21:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763934371;
	bh=erfZkZ5UG+aglPHXCSoaPTJtbm5oOoBqRQdNgSjH3p8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OTQjUcgpGsoo/tI+Ste3IPNsPwquTF15b/vz+oJg/31YH7tWfXd+mdvv4fMX2SESS
	 iJY3xT1A5n+x3tOKzQNyab83B9yhLuBapLwi3ymRbZ+8IBUwgbZNfmVlOV5WME3Uj9
	 a652dLeB0DCMPFO0SyFNB879qeQd6avgu7IyIQdEmGc0X+U9vNMTEb7lwZAdN+68Z2
	 LJ7fqHwI1prtLQj+HCfaOCsdYX1jlf1p9R4FSIto2kYJO3IPMrjW79/33h7f6y9CfG
	 tpnynnzmemGLEEEcaMGXxAqwpL1iGGqpmm8czNrrwItU9AVDZwh4m07ArO4z0JvAoW
	 7KZfc+w9k/AiA==
Message-ID: <9d0aa1ef-a356-4ce0-8ea4-321d07c25ad2@kernel.org>
Date: Sun, 23 Nov 2025 22:46:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: apple-spmi-nvmem: wrap regmap calls to satisfy CFI
To: Jens Reidel <adrian@mainlining.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Srinivas Kandagatla <srini@kernel.org>,
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Clayton Craft <craftyguy@postmarketos.org>,
 stable@vger.kernel.org
References: <20251118-apple-spmi-nvmem-cfi-v1-1-75b9ced0a2c2@mainlining.org>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20251118-apple-spmi-nvmem-cfi-v1-1-75b9ced0a2c2@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.11.25 03:35, Jens Reidel wrote:
> The Apple SPMI NVMEM driver previously cast regmap_bulk_read/write to
> void * when assigning them to nvmem_config's reg_read/reg_write
> function pointers.
> 
> This cast breaks the expected function signature of nvmem_reg_read_t
> and nvmem_reg_write_t. With CFI enabled, indirect calls through
> these pointers fail:
> 
>    CFI failure at nvmem_reg_write+0x194/0x1e4 (target: regmap_bulk_write+0x0/0x2c8; expected type: 0x83a189c3)
>    ...
>    Call trace:
>     nvmem_reg_write+0x194/0x1e4 (P)
>     __nvmem_cell_entry_write+0x298/0x2e8
>     nvmem_cell_write+0x24/0x34
>     macsmc_reboot_probe+0x1dc/0x454 [macsmc_reboot]
>    ...
> 
> Introduce thin wrapper functions with the correct nvmem function
> pointer types to satisfy the CFI checks.
> 
> Fixes: fe91c24a551c ("nvmem: Add apple-spmi-nvmem driver")
> Signed-off-by: Jens Reidel <adrian@mainlining.org>
> Reported-by: Clayton Craft <craftyguy@postmarketos.org>
> Tested-by: Clayton Craft <craftyguy@postmarketos.org>
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Sven Peter <sven@kernel.org>


Thanks,


Sven


