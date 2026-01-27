Return-Path: <stable+bounces-211825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P9JC23JeGmNtQEAu9opvQ
	(envelope-from <stable+bounces-211825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:19:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DB19581A
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24B63306EB73
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F19229ACFD;
	Tue, 27 Jan 2026 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="tvbi/vGM"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508E29BDBD;
	Tue, 27 Jan 2026 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523431; cv=none; b=NH3ihna2XRAOOz+gIkvSlScU4LxspkZCiOLF02dfF0/EBYOCJxsYWUq0joYtB9i/YglLAJWzQSZTbgjPD0ZspjL8ytEO7BhShDB8ae3JLWVwhW7cPkUbqXkmR/ON11sp7AQuBU737yA/inilVilBYmbq9I3QMHgfHwCmcUMlBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523431; c=relaxed/simple;
	bh=ZcXLInvO6iuPrZ8BTtnhaWFQll85GRjtKMuyVP5HAl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKIoEhm9El6eS5ccC1y1VmytKOS5Sds7n/NJ13MMKKVjLJdbQHuLUHGPUceUNuhA+q9xXhY5ggdEfT7CV3h12JF7KXGkNknWPFBeizOnAZ84ZVpTzwWMFSOlZzlw+obBiLTk+OPndChOrmj91e3FRluIBabXS9Gq0m2/gs20dBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=tvbi/vGM; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 770C020224;
	Tue, 27 Jan 2026 14:17:02 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 643543E878;
	Tue, 27 Jan 2026 14:16:54 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id EC79C40095;
	Tue, 27 Jan 2026 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1769523411; bh=ZcXLInvO6iuPrZ8BTtnhaWFQll85GRjtKMuyVP5HAl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tvbi/vGMkblog79v+C1n6VFvErfs3VVoSCDLpgQdUVtM7nbYxZLSxpMVF2MQkw0FP
	 bHF1Uwhlmhx9t9g5SPECWDahZHE7U+hY4IoBdcoYk08kvH1Tb8NX4c/xxezBEbKzjO
	 5qUB4gD9fO4Xvrvnuy9wP8LFNoaawn5L31lkcPHc=
Received: from [198.18.0.1] (unknown [203.175.14.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 653DB40601;
	Tue, 27 Jan 2026 14:16:43 +0000 (UTC)
Message-ID: <f94fbe61-11b9-4fbc-a2a1-57a10547655a@aosc.io>
Date: Tue, 27 Jan 2026 22:16:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loongarch: retrieve CPU package ID from PPTT when
 available
To: Rong Bao <rong.bao@csmantle.top>, Huacai Chen <chenhuacai@kernel.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, stable@vger.kernel.org,
 WANG Xuerui <kernel@xen0n.name>, Yuli Wang <wangyuli@uniontech.com>,
 Yanteng Si <si.yanteng@linux.dev>, Masahiro Yamada <masahiroy@kernel.org>,
 Hongliang Wang <wanghongliang@loongson.cn>,
 Thierry Reding <treding@nvidia.com>,
 Tianyang Zhang <zhangtianyang@loongson.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <78c75769.AU0AAIwo2ewAAAAAAAAAA-ma1psAAYKJPtkAAAAAADNVAQBpc5ot@mailjet.com>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <78c75769.AU0AAIwo2ewAAAAAAAAAA-ma1psAAYKJPtkAAAAAADNVAQBpc5ot@mailjet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[aosc.io:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-211825-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[aosc.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[aosc.io:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,csmantle.top:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffbai@aosc.io,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A3DB19581A
X-Rspamd-Action: no action

Hi Rong,

在 2026/1/23 23:56, Rong Bao 写道:
> Currently, the LoongArch CPU topology initialization code calculates
> each core's package ID by dividing its physical ID by
> loongson_sysconf.cores_per_package. This relies on the assumption that
> cores_per_package counts in the same domain as physical IDs.
> 
> On Loongson 3B6000 (XB612B0V_1.2), cores_per_package matches the visible
> core count -- 24 in this case. However, the physical IDs range from 0 to
> 31 in a noncontiguous fashion:
> 
>          $ cat /proc/cpuinfo | grep -i -F 'global_id'
>          global_id               : 0
>          global_id               : 1
>          global_id               : 4
>          global_id               : 5
>          global_id               : 6
>          global_id               : 7
>          global_id               : 8
>          global_id               : 9
>          global_id               : 10
>          global_id               : 11
>          global_id               : 14
>          global_id               : 15
>          global_id               : 16
>          global_id               : 17
>          global_id               : 20
>          global_id               : 21
>          global_id               : 22
>          global_id               : 23
>          global_id               : 26
>          global_id               : 27
>          global_id               : 28
>          global_id               : 29
>          global_id               : 30
>          global_id               : 31
> 
> Retrieve the exact package ID from ACPI PPTT when available, in the same
> style as retrieving the core ID and thread ID in parse_acpi_topology().
> Use this information in loongson_init_secondary() when PPTT readout is
> successful. The original division logic is kept as a fallback.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Rong Bao <rong.bao@csmantle.top>

Tested good on the following single-socket systems:

- Loongson XA61200_V1.1 (Loongson 3A6000-HV)
- Loongson AC612A0_V1.1 (Loongson 3C6000/S)
- Loongson N2K20Z0 (Loongson 2K2000, "Cloud Laptop")
- IPASON NL38-N11 (Loongson 3A6000, laptop)

... the following dual-socket systems:

- Loongson TD622E0 (Loongson 3C6000/D × 2)

... and of course, the offending platform:

- Loongson XB612B0_V1.2 (Loongson 3B6000, 12 cores)

I should note however, I found that the patch caused lscpu(1) to report 
incorrect processor topology on Loongson TD622E0:

   Thread(s) per core:        2
   Core(s) per socket:        64
   Socket(s):                 1

Whereas it should have been:

   Thread(s) per core:        2
   Core(s) per socket:        32
   Socket(s):                 2

Which, of course, due to the nature of this patch, was caused by 
incorrect PPTT data included in the firmware (this was fixed earlier 
today); NUMA topology reporting was not affected.

If this patch results in incorrect processor topology reports, similarly 
to what I ran into above, you should consult your system vendor for a 
firmware fix (or some sort of quirk should be shipped with distros - or 
the upstream somehow?).

With that,

Tested-by: Mingcong Bai <jeffbai@aosc.io>
Tested-by: Xi Ruoyao <xry111@xry111.site>

Best Regards,
Mingcong Bai

