Return-Path: <stable+bounces-152595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC206AD802E
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 03:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1F518856B6
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 01:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D731C84C5;
	Fri, 13 Jun 2025 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="hGHoMLUZ"
X-Original-To: stable@vger.kernel.org
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478561420DD;
	Fri, 13 Jun 2025 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749777526; cv=none; b=oe7gL8JyEriNEUzM3cGzL9ajkGYJY29vMbY02iGqkTueIS3uzn3dSLaRuW/le+moSvEhqn9do/xLf/v2v3qGqfMIGE+dcHcf3E+TSk6tlHFAaTw/9ZK8c5a+zw51HZAt4xGat8SM3WzuHrMpS+fMJ83+ARPwRnCHsmXYyF+QH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749777526; c=relaxed/simple;
	bh=mzLaYBl+Y/d7BQANb7I+GDNo+dl/a7Akffi+nhcQ84s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIofHeg0p+JCWPZ9ykS4EnbVBTXkFGUmp+D6Dep1vfPCbkIiUId3iZUXH24XIR6bhvuIPctuEXe2vE6YyeSgtK7r8vUdZi2UgwKokpelHDtjtb3Q+Wpz+ewr0HdpbadxrtadNQzdsYhraHgQsPnJwmTL8vpb2k0iLvH0OZpWpb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=hGHoMLUZ; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id DABF822394;
	Fri, 13 Jun 2025 01:12:46 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id AEA6726260;
	Fri, 13 Jun 2025 01:12:37 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 021413E8B6;
	Fri, 13 Jun 2025 01:12:30 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 9E57C40078;
	Fri, 13 Jun 2025 01:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1749777149; bh=mzLaYBl+Y/d7BQANb7I+GDNo+dl/a7Akffi+nhcQ84s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hGHoMLUZOLZCVgdW8cq0dvyersBeAz3xkHIZ2Omj7r5z+HuEW/pPNfTDO8K0Wrsxy
	 PaFq534iNvtvMVkds2hnrsbyeuvgvQ1VD72sjrEnooOrYdKWIsbh3LCCSoX7Uq4NJ5
	 mQuhUKNKnd4AYL5C3TFHvzaRDPGNyi6nx0e1X6nE=
Received: from [19.191.1.9] (unknown [223.76.243.206])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id ED8D5411D6;
	Fri, 13 Jun 2025 01:12:20 +0000 (UTC)
Message-ID: <60cb6d5e-45f1-45a1-b142-22e3dfd203f9@aosc.io>
Date: Fri, 13 Jun 2025 09:12:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] drm/xe: enable driver usage on non-4KiB kernels
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Francois Dugast
 <francois.dugast@intel.com>,
 =?UTF-8?Q?Zbigniew_Kempczy=C5=84ski?= <zbigniew.kempczynski@intel.com>,
 =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
 Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Zhanjun Dong <zhanjun.dong@intel.com>, Matt Roper
 <matthew.d.roper@intel.com>, Alan Previn
 <alan.previn.teres.alexis@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Mateusz Naklicki <mateusz.naklicki@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Kexy Biscuit <kexybiscuit@aosc.io>, Shang Yatsen <429839446@qq.com>,
 Wenbin Fang <fangwenbin@vip.qq.com>, Haien Liang <27873200@qq.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, Shirong Liu <lsr1024@qq.com>,
 Haofeng Wu <s2600cw2@126.com>
References: <20250604-upstream-xe-non-4k-v2-v2-0-ce7905da7b08@aosc.io>
 <yyzxfqydczvfxddfsa4ebi7kyj5ezl2v4wbl5fopkdz6qwvjrg@fnhpcvfsp2dm>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <yyzxfqydczvfxddfsa4ebi7kyj5ezl2v4wbl5fopkdz6qwvjrg@fnhpcvfsp2dm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 9E57C40078
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[ce7905da7b08.aosc.io:server fail];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,gmail.com,ffwll.ch,kernel.org,suse.de,lists.freedesktop.org,vger.kernel.org,aosc.io,qq.com,vip.qq.com,126.com];
	FREEMAIL_ENVRCPT(0.00)[126.com,gmail.com,qq.com,vip.qq.com];
	TO_DN_SOME(0.00)[]

Hi Lucas

在 2025/6/13 08:13, Lucas De Marchi 写道:
> For some reason this patch series didn't make it to any mailing
> list... it only shows the b4-sent and stable:
> https://lore.kernel.org/intel-xe/20250604-upstream-xe-non-4k-v2-v2-0- 
> ce7905da7b08@aosc.io/
> 
> Could you resend this series?

That's strange... I have just resent the series.

Best Regards,
Mingcong Bai

