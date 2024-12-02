Return-Path: <stable+bounces-95957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E9C9DFDFB
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D0A162BA1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242B11FC0FA;
	Mon,  2 Dec 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="H5a/i0IW"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3E1FBEA3
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133610; cv=none; b=VlIDyGHc/aQuFT332KLFKkjT943Jm3ZUFQOa2jf3Q4okD/1HsRvc5PJ1QrTOEifmrO94yJDXs7Je8vN/5cdZawQOU/Fmw6E11AhSOmEFeVJQB+VpOdphaIJpxpsYuLop+QA5GuPwN66IupOkLNGN5qQFKrstBbNPcKhC1tQZH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133610; c=relaxed/simple;
	bh=O7IqFk4A4clI95UGcAox4qWgJZMewlfbe4OgVIdru2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oiBxx2W7vVkBFfWxumQCwNiQEG4g0NcfYQXwngKPwmgw45ib3Jz/7CEVmnJSMI7HchO247FjsSV2E8HfH5/zLt4uZ0PglQgXaARTgyQIBM4mlPmbg2j/kAacNmo2VRIlC4OdOVV/fGMiIW2pGsX3HSBtlpp2CD3oagVnjMn8bXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=H5a/i0IW; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 19167A03FB;
	Mon,  2 Dec 2024 10:59:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:in-reply-to:message-id:mime-version:references:reply-to
	:subject:subject:to:to; s=mail; bh=9EMUJHMnC2+smf92gibFwpIfKifsy
	armijUY2tDA8NQ=; b=H5a/i0IWrXCV/d5E/OKK2NWRNzI/nE8aYOrvLV6UfcIjv
	FQVjUOaOGnwIMOOTEwPCBKs1sqr5+z2UtdC1t8rkCk+z/E7C4ilKrNxfJpjXVzYd
	vK+YEc4w3XMejgT1YZoIdd2+f1YJW9vSlJjZuuyv9n+0ZbRsSF86gXqWD9duUjFL
	vsTZDqR4NE2ZQI3JwzbtjN5AF3oPp+kFwS2Ha7+nxR8xis2514wQDzHVFbkapW7d
	vqfkhKrQx+Btz1PkpCR2Qeavja6GizjUARjQfS8AwDR8QEHbE2XGEjUnTyH362tJ
	fsPaAaK8K9PW6HYV/Z3MPUHwFzQjUF6RPx4y0Vqsa6T+nKmE7VNFLtNSxWYEHUo1
	RhSKhogJbvCqSLS6W9eQVY79BMby2DpR2k1KNTthlK3jtH2sC4mvxCys0jZrAafQ
	JBGzqZ1slqInMP21ESwG9ZAwe3UNCK/tDkX9bcUgg/89oA6xl/YjsYvfAJZAmxWA
	BwqLcDyQO+EoDQPL7DfSi+O9z56Db0ID+/3wbEy5zt5zzDBnSNUZc1S+oxBBsFrL
	BSIrMBNe0XK4r3GJUTxx43pz5+QSlNGxtvM9iqBSQBkf8VoWmwIqwVTUGJIkqFiV
	J4qOh9pNDDs6BtdHnkXTkTWrRI3e1D4TrRypNw2Gdt3GnyecpDUpmUt4fu9BRE=
Message-ID: <cc6e8462-8f9d-495c-900b-fb79a745172f@prolan.hu>
Date: Mon, 2 Dec 2024 10:59:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 3/3] net: fec: make PPS channel configurable
To: Sasha Levin <sashal@kernel.org>, <stable@vger.kernel.org>
References: <20241125092936-8008bf13218ad74b@stable.kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241125092936-8008bf13218ad74b@stable.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637263

Hi,

On 2024. 11. 25. 16:20, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Found matching upstream commit: 566c2d83887f0570056833102adc5b88e681b0c7
> 
> WARNING: Author mismatch between patch and found commit:
> Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
> Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> 
> Status in newer kernel trees:
> 6.12.y | Not found
> 6.11.y | Not found
> 6.6.y | Not found
> 
> Note: The patch differs from the upstream commit:
> ---
> --- -	2024-11-25 09:25:02.822819093 -0500
> +++ /tmp/tmp.NUygUEJTBz	2024-11-25 09:25:02.816734590 -0500
> @@ -10,12 +10,15 @@
>   Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>   Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
>   Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> +
> +(cherry picked from commit 566c2d83887f0570056833102adc5b88e681b0c7)
> +Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

Was I wrong to sign-off the cherry pick? Should I resubmit without it? 
Or will you re-pick it from upstream instead?

Bence


