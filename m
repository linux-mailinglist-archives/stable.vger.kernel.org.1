Return-Path: <stable+bounces-118369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEBBA3CEB5
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 02:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339B51897BAD
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 01:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849D2192B82;
	Thu, 20 Feb 2025 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MMESd3X2"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19015624D
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014941; cv=none; b=asalqheIXv23Cic7LuI8+BVHMED9k2ddA8KruHjXPZaMph7WKsajBWRcUtb6R6MwTF7tewvnQJO2SD2KtUvAO3+sDmSrNMOZTxYQ/3bn4wzjR0rCDGuIM67/QIxgiJsScS0jKlHjpsYvaJHxy89XlV6J4gvzpRO6JrQSRrlHir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014941; c=relaxed/simple;
	bh=LJdxENxZpd6woHMrpY+JCXncfXl+eonrCnkoYGj7Hes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LI0L0auGclcH+xamx8x9kQkpCgHUoS6tnFY5yq5cXk7M6j/HN9H4s77syu96lGfbuWhEOvJyrhqWNOqjA+Ef6NjO4hW/Rc0YP4vqJQ8qRk5o37Y7rSd0GpsQ9SViv3qNVE0hyZmJ6a3J8BMWYa3RpPyQeODl0moU/ihlreGwi3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MMESd3X2; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25782504-2d3c-4666-b72d-343371fe037c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740014927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqvqbehjGrCNe1roBGtpI6CdjxU06tpCNUUgl7lLOFI=;
	b=MMESd3X2iQtkaGVQRwL3xhqstdJuuAjyumoxl6XNw7VGJk7xkwNcaEtaXZK+0UsfydBE1+
	Yx3XyQjS5f50oUCs6UwuGBWAmmqY1ceR3a6B8FZ9RNRRwiyBfvxqBJgxoLykA/6Q0UCEp6
	A3k7AJIPZQHC/shqdMvbQutshltteto=
Date: Thu, 20 Feb 2025 09:28:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net V3] net: stmmac: dwmac-loongson: Add fix_soc_reset()
 callback
To: Qunqin Zhao <zhaoqunqin@loongson.cn>, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Cc: chenhuacai@kernel.org, fancer.lancer@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20250219020701.15139-1-zhaoqunqin@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250219020701.15139-1-zhaoqunqin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2/19/25 10:07 AM, Qunqin Zhao 写道:
> Loongson's DWMAC device may take nearly two seconds to complete DMA reset,
> however, the default waiting time for reset is 200 milliseconds.
> Therefore, the following error message may appear:
>
> [14.427169] dwmac-loongson-pci 0000:00:03.2: Failed to reset the dma
>
> Fixes: 803fc61df261 ("net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Acked-by: Yanteng Si <si.yanteng@linux.dev>


Thanks,

Yanteng

> ---
> v3: Added "Cc: stable@vger.kernel.org" tag.
>      Added error message to commit message.
>
> v2: Added comments. Changed callback name to loongson_dwmac_fix_reset.
>
>   .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

