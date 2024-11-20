Return-Path: <stable+bounces-94096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E519D33F1
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 08:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC20AB2333B
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 07:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E783A15533F;
	Wed, 20 Nov 2024 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="EBDDeOLX"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144D1662F1;
	Wed, 20 Nov 2024 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086149; cv=none; b=KCON0ib/nUwz883/bMflRax7jB0Y732dy9O9RJOHIw5nRvJqnV5WhCPcMTB9dK3DLJUUvw8ogu4GwDneAvMSJXtYdXRlPlfV90XQzjOjvb9eNE3OURpJ4V+6YBXJmT0q7LUB21nNaAr9rGYXJzEGF9KXEloXMFneG9MVd8MTTnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086149; c=relaxed/simple;
	bh=p6j4fO9kqZpC1/2B/+caYj1VwLD2k++uOfBQkCfzKSI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mQvaAFJ+96YFsIC0Bxc+Ia5z2XV8H+0XaMY8irxDQTS4Mmv6wvng2SYsximjU/aA1Mn3wqzjbxTlrXaWWWBGa3HD0wEzn+0RVtBzjHOT29e7iYrHKt9GIQxClE16SlJ8vBZiyn/xVwLZMR1WHLEdTIQfMD5qRbuGdnQ93g4G7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=EBDDeOLX; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 08B952621F;
	Wed, 20 Nov 2024 07:02:18 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 954323E8A5;
	Wed, 20 Nov 2024 08:02:09 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id C8E9340085;
	Wed, 20 Nov 2024 07:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1732086128; bh=p6j4fO9kqZpC1/2B/+caYj1VwLD2k++uOfBQkCfzKSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EBDDeOLXr/bmvUlrNr/TEVbb/rgjjWvMIFhICj9WDU25MGjAuglPdruQyO43D79wl
	 D5bPZG4N9NX4bvM4k8rBc5iFsFh3lbpDItP6Q19ms/T+dGOdxvSLfpajf1soxEOgM8
	 Nx6ePsF9XsIc9P58eiSkNF6PLOIMz+eHny2UHGYg=
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 89064414F1;
	Wed, 20 Nov 2024 07:02:07 +0000 (UTC)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Nov 2024 15:02:07 +0800
From: Mingcong Bai <jeffbai@aosc.io>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Huacai
 Chen <chenhuacai@kernel.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Poll jack events for LS7A HD-Audio
In-Reply-To: <20241115150653.2819100-1-chenhuacai@loongson.cn>
References: <20241115150653.2819100-1-chenhuacai@loongson.cn>
Message-ID: <c47281ea4b3f68cb8c3b0f3582e62fab@aosc.io>
X-Sender: jeffbai@aosc.io
Organization: Anthon Open Source Community
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[chenhuacai.loongson.cn:server fail,stable.vger.kernel.org:server fail];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C8E9340085

Hi Huacai,

在 2024-11-15 23:06，Huacai Chen 写道：
> LS7A HD-Audio disable interrupts and use polling mode due to hardware
> drawbacks. As a result, unsolicited jack events are also unusable. If
> we want to support headphone hotplug, we need to also poll jack events.
> 
> Here we use 1500ms as the poll interval if no module parameter specify
> it.

A little late since Takashi Iwai already queued this patch, but for the 
sake of the record, I have tested this patch and found that it resolved 
the issue where hot-plugged (plugged in after boot) headphones were not 
detected on the following boards:

- Loongson XA61200
- Loongson XA612A0
- Loongson Loongson-3A5000-HV-7A2000-1w-V0.1-EVB
- ASUS XC-LS3A6M

Hooray.

But I would also like to note that this issue was only reproducible on 
Loongson (or Loongson-drived, in the case of that ASUS board) firmware. 
However, with the XA61200 board, when using Byosoft's firmware 
(https://github.com/loongson/Firmware/blob/main/6000Series/PC/XA61200/Byosoft_3A6000_7A2000_CRB_R0103.bin), 
audio jack hot-plugging works with or without this patch. So I do 
suspect that there are still a firmware issue at play.

Bottom line - this patch should have fixed audio jack hot-plugging for 
most users.

Best Regards,
Mingcong Bai

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  sound/pci/hda/hda_intel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index b4540c5cd2a6..5060d5428caf 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1867,6 +1867,8 @@ static int azx_first_init(struct azx *chip)
>  		bus->polling_mode = 1;
>  		bus->not_use_interrupts = 1;
>  		bus->access_sdnctl_in_dword = 1;
> +		if (!chip->jackpoll_interval)
> +			chip->jackpoll_interval = msecs_to_jiffies(1500);
>  	}
> 
>  	err = pcim_iomap_regions(pci, 1 << 0, "ICH HD audio");

