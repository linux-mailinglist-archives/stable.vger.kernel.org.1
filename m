Return-Path: <stable+bounces-111964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12839A24E2E
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 14:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3D81886139
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79BC1D63D8;
	Sun,  2 Feb 2025 13:19:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail2.medvecky.net (mail2.medvecky.net [85.118.132.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF68AD2F;
	Sun,  2 Feb 2025 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.118.132.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738502396; cv=none; b=jM6v6MyQPkHm/5FHcxFGmUq3/Vd5NlVXg3tkwFKBbycN9rh2s8ixhdZLdD8pgx+8hnChtMTQO36bBQa3X5X6kfVsVel8Wl+WJD0W18+z7DcWowU2ls655tWZFvuUsMEpIjYv7XM6rzgwJcKwRPx1zTB3jxyDqy08nVLUCf/3hUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738502396; c=relaxed/simple;
	bh=Tysij08OB6z+7SDaRUpJv9qwiexVTyaj0fUtUrAxXvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cw94IebemlJf/BcJiQxdtI5eHwzwBBRg40MEGiLoMlA2ZIHa4wemayFzCnA1vQtagRt3msdJaG6qx1l0BD89qlglnp6ArXdCsl/F0idVctI2/a+RceW/4Xe04AkTNvWuLaU5sftyeeKlumYk0p5CEktHFi5ojdL5zBeQtMqTjUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz; spf=pass smtp.mailfrom=assembler.cz; arc=none smtp.client-ip=85.118.132.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=assembler.cz
Message-ID: <0d647c3f-703f-47ac-9c13-3f78a3bee0f6@assembler.cz>
Date: Sun, 2 Feb 2025 14:12:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V2] USB: pci-quirks: Fix HCCPARAMS register error for LS7A
 EHCI
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Baoqi Zhang <zhangbaoqi@loongson.cn>
References: <20250202124935.480500-1-chenhuacai@loongson.cn>
Content-Language: en-US
From: ruik <r.marek@assembler.cz>
In-Reply-To: <20250202124935.480500-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: mail2.medvecky.net;
	auth=pass smtp.mailfrom=r.marek@assembler.cz
X-Spamd-Bar: /

Hi,

Dne 02. 02. 25 v 13:49 Huacai Chen napsal(a):
> +	if (pdev->vendor == PCI_VENDOR_ID_LOONGSON && pdev->device == 0x7a14)
> +		hcc_params &= ~(0xffL << 8);
> +

If it would be fixed in the future, would it make sense to check for revision ID as well?

Thanks,
Rudolf


