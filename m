Return-Path: <stable+bounces-200351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B01CAD451
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 14:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8925E307CA2A
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3836A311942;
	Mon,  8 Dec 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQdsSDS7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5132E9ED8
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200488; cv=none; b=G7gwQQzVP4EG3C6yqM7jtoo5ppjs2AwgPQZIrbcY8WcjZeO4bCmPltIVpRWGz++1hdFn2NoLI15GxnSK/VOisc9ITt9Zkq6ufjXoywJLtW9ggwDxCdFDRUuwSrXz/03B9qk/GFTQTUS+xEhCieF9NQB8SowkSrhCzfvhYBrG0w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200488; c=relaxed/simple;
	bh=ZvUsiZtvhhNdLAfSWiOEhbkDZkzZTRSe61KoteKi8Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O71GHMcRSg0Oh5UolghkYKuwE4M7a5udDNhioMTcEz+RYmJ7/5pF9GX7cPidVK5j0qVR3OoDcJn4yWuvxD0IEW2kh44HxsM3kXkWMy68O6tFTn/n9g03ifDO7LdkWTKEdpWi/THrTH48zJlB6bBrFR5pE5HvypnBVi7wXX7ZMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQdsSDS7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7ba55660769so3743106b3a.1
        for <stable@vger.kernel.org>; Mon, 08 Dec 2025 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765200485; x=1765805285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbHHkduGncpuPtot795Xe6V8uWxMjY6W8fGIG+hxDeg=;
        b=GQdsSDS7x+qbAyZ1oLp2/vuQG2rzfXNmK5l+7sCecDd4AB7q60xWIcayC2cIQlGHZ9
         rNaLVfqaLiwUuELyixSX9aF96MkS1hZMriJPLESp/Vrcle48Bbezo0Pn97NREUPdlIJc
         3HPIG0EwIki1L4nu2me0O5usBG+zdkjNE/QFchyQD9w/PBrgIf7PDTQ54opn5lOusYeS
         i23kVyQFErSqC1DczjXhvtQScTOSHapQXBX2aP0XqEzSGKVDnkgWCdXSv4FWX2x9nWVi
         eVN5uRMfpNHyaHtvauzborYQYo45g12QQtYDfSZawJ6gs+sW1WoOP7Cwu/HrvXloojOg
         uSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765200485; x=1765805285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbHHkduGncpuPtot795Xe6V8uWxMjY6W8fGIG+hxDeg=;
        b=axe1M0My0APTJyo/PToF/PT4xXz6ZEQrw36HDzaO7e/tiYfY4xu8Oq47BRgyjSygZR
         KqpuI8v0R5d9LoaW/X7ynFrmp8YUA6ABbMYZGsGEbCmsDfGn6ID/9t8oxqQK7+NSdonB
         DPKRJiCb2ZIjB9mupfckI1ANAIRTAnZylnCdQc2pThM3dXFWL/YrBSnnPSzXxcc5p7IU
         bUzvVftWf95y/LrGTb7c9YJT5Gtm5UVVnA0H36uX6EVOUtBPJ5JapoAjdM4d+msw9kas
         JK+ObUGAJ/LKd1VJdZxh7Y69f0a9MPj7AKrOTGpBormhJazhFdjkGrdztr/Hp+j26+wQ
         HvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDnbLoc6IdNUnvVfciLK2xPRJWvkNCcXwTNJnzxL/UXZQHFeXcuX63tg3kFP7IXGvKS6xmo5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4rOLOaPDysoXEUkmv+J5PDk3FT/zCsWMR4NjylE0YftCZWWu6
	Eb4peZvFwfJ7GclPVuKG986lBkX6vu/bOi9MJop4fSYwC2EQs6r4114l
X-Gm-Gg: ASbGncvj33Mfxy7T6L0xadpVrUmMpFX+XNb7zdPScHTDcJE/z5dfY/wcFkY58ipr/T9
	U+HoC/ICWkxGVIjvpeiKaGzTRm6Lq919IpUR6kG2Jmwt3xPIfRccYUUwjFwOkB0uQaJlTUIxz+8
	aBiqK9pPsaPyOdbzhYnq+9yqGr7qzFL0dWvmSMj4BzV7eagBfIoChBfAGLFNaIwd4UODUXDp50/
	4gUXd1y92RCgx8nnEsuTxhE/nDq2ukvVpjjBEo4npWEP8GC0aesUzcyUQnxAd6YbggZQzPIHfwI
	mYmj7mDQPxuca4Sehu/MAJaXSomrXsqsCgNMm3epoSSo0R6gyXXHQpJVMH1fmzg3y93tNaqBv1b
	VPhcN4ybu/boCO9nyZSWsKQtYCm3hOn+sRJk9YjMBafO5krtFzGQ6tDOhCzzMO8U+kCPnxHARAw
	RKW2BDR/w=
X-Google-Smtp-Source: AGHT+IEJink5dffLsMfjiF2kZmo0I3LJowM/dJuNuWV+1SloCdfrgSufG4LI0yl6V1FTUBYmf5D2Fg==
X-Received: by 2002:a05:7022:2226:b0:11b:e21e:5653 with SMTP id a92af1059eb24-11e03262c31mr5354387c88.19.1765200484612;
        Mon, 08 Dec 2025 05:28:04 -0800 (PST)
Received: from [0.0.0.0] ([2605:52c0:1:b17:84f1:a0ff:fe39:857a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm58067184c88.6.2025.12.08.05.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 05:28:04 -0800 (PST)
Message-ID: <19627811-c325-4ef3-8982-59fcd9ecbdfb@gmail.com>
Date: Mon, 8 Dec 2025 21:27:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: add quirk for Wodposit WPBSNM8-256GTP to
 disable secondary temp thresholds
To: Ilikara Zheng <ilikara@aosc.io>, linux-kernel@vger.kernel.org
Cc: Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
 stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <20251208132340.1317531-1-ilikara@aosc.io>
Content-Language: en-US
From: RigoLigo <rigoligo03@gmail.com>
In-Reply-To: <20251208132340.1317531-1-ilikara@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On 2025-12-08 21:23, Ilikara Zheng wrote:
> Secondary temperature thresholds (temp2_{min,max}) were not reported
> properly on this NVMe SSD. This resulted in an error while attempting to
> read these values with sensors(1):
> 
>    ERROR: Can't get value of subfeature temp2_min: I/O error
>    ERROR: Can't get value of subfeature temp2_max: I/O error
> 
> Add the device to the nvme_id_table with the
> NVME_QUIRK_NO_SECONDARY_TEMP_THRESH flag to suppress access to all non-
> composite temperature thresholds.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilikara Zheng <ilikara@aosc.io>
> ---
>   drivers/nvme/host/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e5ca8301bb8b..31049f33f27d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3997,6 +3997,8 @@ static const struct pci_device_id nvme_id_table[] = {
>   		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
>   	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
>   		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> +	{ PCI_DEVICE(0x1fa0, 0x2283),   /* Wodposit WPBSNM8-256GTP */
> +		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
>   	{ PCI_DEVICE(0x025e, 0xf1ac),   /* SOLIDIGM  P44 pro SSDPFKKW020X7  */
>   		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
>   	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */

I have tested this patch on a CTCISZ 3B6000M-NUC with an exact same SSD 
and this has resolved the error with sensor(1).

Tested-by: Wu Haotian <rigoligo03@gmail.com>

