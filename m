Return-Path: <stable+bounces-119457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A84CA43636
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 08:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD351899304
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239E618B484;
	Tue, 25 Feb 2025 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="yeBdoqTK"
X-Original-To: stable@vger.kernel.org
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB5B2571CD;
	Tue, 25 Feb 2025 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468868; cv=none; b=dCZk1EgSEjIGTOIuDHeKpel/xPD9BO6Tfnfx6t1hspo0+XyL8ZBEfM1nTYtaTFf+jF87/QfVrZDeRh/uVKueu+t5SF5BHQPHJ3wlSztwnCQkp+EoHtUlxb+r9RGQKvQm9mjhFREjtuuKyaRXhsKhB0wGcf4aaMv23fXiotppDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468868; c=relaxed/simple;
	bh=+JalhccGD3dfKX7N9TtFSk3UBg6wqIoop1+xyjVxPsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXjYp2QnYS2+sAPd+OH67aravKD7pTebmmLIFln4kv2N2fUThm/IbxxIpHG+0RL0evB3kairLNYY6grm+QrCXuLUYJhTWBq5yDKBFzinn+2PMrwzdiMCLqyH+gJgaw6pLKuSuemlS0T8nZKQ/067zZGqJEbR3Rl8BXue0zDgeO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=yeBdoqTK; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 75B8F20099;
	Tue, 25 Feb 2025 07:28:54 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.155])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id D91BC200C2;
	Tue, 25 Feb 2025 07:28:45 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 09D753E917;
	Tue, 25 Feb 2025 07:28:38 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 26F6A40078;
	Tue, 25 Feb 2025 07:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1740468516; bh=+JalhccGD3dfKX7N9TtFSk3UBg6wqIoop1+xyjVxPsc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yeBdoqTKWCxFwETv4ogWkB7Q50+lbpJs7iCgHkzukBIH2zdOJLp8/uIy6PiPGQ26d
	 lL+Oum+a/dnd67OEHIQyhMfoQurMEOkot1KfpGT/ES4uaYJiH8UtreGZ4R0PaAJ5Kt
	 dMrge6+74qs+MG43sHeEvQktU9wGb5+3T0SLiduM=
Received: from [172.29.0.1] (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 028F243C7E;
	Tue, 25 Feb 2025 07:28:28 +0000 (UTC)
Message-ID: <7db41baa-c435-4478-baef-d3d658b050b4@aosc.io>
Date: Tue, 25 Feb 2025 15:28:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/xe/regs: remove a duplicate definition for
 RING_CTL_SIZE(size)
To: linux-kernel@vger.kernel.org
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, stable@vger.kernel.org,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matt Roper <matthew.d.roper@intel.com>,
 Ashutosh Dixit <ashutosh.dixit@intel.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 Ilia Levi <ilia.levi@intel.com>, Gustavo Sousa <gustavo.sousa@intel.com>,
 =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20250225071832.864133-1-jeffbai@aosc.io>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <20250225071832.864133-1-jeffbai@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 26F6A40078
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[jeffbai.aosc.io:server fail,stable.vger.kernel.org:server fail];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[aosc.io,vger.kernel.org,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi all,

在 2025/2/25 15:18, Mingcong Bai 写道:
> Commit b79e8fd954c4 ("drm/xe: Remove dependency on intel_engine_regs.h")
> introduced an internal set of engine registers, however, as part of this
> change, it has also introduced two duplicate `define' lines for
> `RING_CTL_SIZE(size)'. This commit was introduced to the tree in v6.8-rc1.
> 
> While this is harmless as the definitions did not change, so no compiler
> warning was observed.
> 
> Drop this line anyway for the sake of correctness.
> 
> Cc: <stable@vger.kernel.org> # v6.8-rc1+
> Fixes: b79e8fd954c4 ("drm/xe: Remove dependency on intel_engine_regs.h")
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
>   drivers/gpu/drm/xe/regs/xe_engine_regs.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/regs/xe_engine_regs.h b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
> index d86219dedde2a..b732c89816dff 100644
> --- a/drivers/gpu/drm/xe/regs/xe_engine_regs.h
> +++ b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
> @@ -53,7 +53,6 @@
>   
>   #define RING_CTL(base)				XE_REG((base) + 0x3c)
>   #define   RING_CTL_SIZE(size)			((size) - PAGE_SIZE) /* in bytes -> pages */
> -#define   RING_CTL_SIZE(size)			((size) - PAGE_SIZE) /* in bytes -> pages */
>   
>   #define RING_START_UDW(base)			XE_REG((base) + 0x48)
>   

Sorry about the series header, this was meant to be a single patch. I'm 
re-sending a copy now.

Best Regards,
Mingcong Bai

