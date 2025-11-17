Return-Path: <stable+bounces-194892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA0C61F7B
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 01:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72EA734EEF5
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 00:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE961C54A9;
	Mon, 17 Nov 2025 00:47:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBD1A262D;
	Mon, 17 Nov 2025 00:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763340476; cv=none; b=j3wkRsNcbGwRYFqMdOxJ7deRde/oW2sFMD6+KAzVs6305fozP9wyPOJsXblWMZ1y1BL6l3p7cl38MRqf3m9o56Umu3qzO3rF45YeYAA1BT6wOzLDxFQOm4pHPeXdc3rwwsCIl95rI5PlfgbVkykGh5f+QEjFzaHlNPQV2YI2cic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763340476; c=relaxed/simple;
	bh=jWjOsLRn1GOg3oCVijnSQU1LE+QYIN/sfKTJzoq6LtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aJAFXPoM5EkZEA12Cv6J/ZDutMLoHGeCzLMoRSHRStV/NmbG/yWGs8XuOWRJ5IUzK8QrTeT8f7DRZyJIgz4pczcUpk0tE7nBQcooD4lokVdlvCnNOEDa4vkL+zTvn0mcMKq3uJVsBsOasCpHVG0cDhJwGa42c21AsRDW5MU9dQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowAA3NGWlcBpp1UECAQ--.23298S2;
	Mon, 17 Nov 2025 08:47:44 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: tglx@linutronix.de
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	make24@iscas.ac.cn,
	maz@kernel.org,
	shawn.guo@linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] irqchip: Fix error handling in qcom_mpm_init
Date: Mon, 17 Nov 2025 08:47:33 +0800
Message-Id: <20251117004733.14976-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87seed972b.ffs@tglx>
References: <87seed972b.ffs@tglx>
X-CM-TRANSID:zQCowAA3NGWlcBpp1UECAQ--.23298S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryDKw17Wr45tFW5JF13Jwb_yoW8Gr15pr
	W7Kws8Cr4kGFW0ya48XF1vya4SvFZ3tFWUGw1rt34DXa1rCa45tFWUGw4YgFy5Crna9a47
	Gry8uaykGF1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_twCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUj0D77UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Mon, Nov 17 2025 at 02:16, Thomas Gleixner wrote:
> On Sun, Nov 16 2025 at 16:16, Ma Ke wrote:
> 
> > of_find_device_by_node() increments the reference count but it's never
> > decremented, preventing proper device cleanup. Add put_device()
> > properly to ensure references released before function return.
> >
> > Found by code review.
> 
> By whom? You sent 7 patches today which touch random parts of the
> kernel:
> 
>   [PATCH] irqchip: Fix error handling in qcom_mpm_init
>   [PATCH] phy: HiSilicon: Fix error handling in hi3670_pcie_get_resources_from_pcie
>   [PATCH] ASoC: codecs: wcd937x: Fix error handling in wcd937x codec driver
>   [PATCH] ASoC: codecs: Fix error handling in pm4125 audio codec driver
>   [PATCH] powerpc/warp: Fix error handling in pika_dtm_thread
>   [PATCH] USB: Fix error handling in gadget driver
>   [PATCH] USB: ohci-nxp: Fix error handling in ohci-hcd-nxp driver
> 
> and in all of them you claim to have found them by code review.
> 
> Why do I have doubts especially when I look at your email address?
> 
> Thanks,
> 
>         tglx
Hi,

Thank you for your note. I can confirm these issues were found through
manual audit. I accumulated these findings over time and submitted 
them in a single batch during my spare time. This is a good-faith 
effort to contribute to the kernel by fixing what I found.

Best regards,
Ma Ke


