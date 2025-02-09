Return-Path: <stable+bounces-114451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDF8A2DED1
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 16:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311AC1885644
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEACA1AF0BA;
	Sun,  9 Feb 2025 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="BDAut/I+"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639A54738;
	Sun,  9 Feb 2025 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739115266; cv=none; b=Wj0Ar5a0Cz9ZgYBasqIpcdBrLacuifEi0JEB//tbMLhMO2BztTkDrxq6Jr4kr9DceS849fk6kL7iFEUDxc/p8wQURu1P2JvoyC1gfPFMaynwS1pSRxLuUVcxok6r0SGxgbrZW0BbgTL2CkvP5zWN9oEyqN08iRAyWM31tU3PpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739115266; c=relaxed/simple;
	bh=WmsqJqDfGBjTiEEMO2Bvl+sBwNM3htxGNeXAIexYEn0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=T0LcYzkJh2gF/uAVIbsGQtPJ6O/V+zJEfaDShiTvUQjFxkiyu+NheCbQMZLOs5WIjg/pTwDkKXQ6OplD7VPugSnGjLhpOK+SAwDI7wF15DPLehiNF+/ON3dWIq9LurYzYaSWQFFHZm4tKUsIpCjuC+472N+xjw86PCbIhvPSbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=BDAut/I+; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.155])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id B7D55200C0;
	Sun,  9 Feb 2025 15:34:15 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id 5C105203CD;
	Sun,  9 Feb 2025 15:34:08 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 51EB840098;
	Sun,  9 Feb 2025 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1739115246; bh=WmsqJqDfGBjTiEEMO2Bvl+sBwNM3htxGNeXAIexYEn0=;
	h=Date:To:Cc:From:Subject:From;
	b=BDAut/I+aCsNzhQ9PXFaBVV8EUDUkumpeVgfixKehispIutQVQWuDhaXz1D7r+6SC
	 2Ts89KRgOp6zIamaEjYmayCvwh79X77bcChAMnnUgSpqllcwrKeUAu/3lMif7Ps2mq
	 qUPKL7gmaSx9LqB5WnCQEtj0UjTTpI2vPDqX+s/Q=
Received: from [172.29.0.1] (unknown [203.175.14.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id C6E1E41423;
	Sun,  9 Feb 2025 15:33:59 +0000 (UTC)
Message-ID: <13267282-2b5d-4a9d-aa0e-bbf650ea2221@aosc.io>
Date: Sun, 9 Feb 2025 23:33:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tom Chung <chiahsuan.chung@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, harico@yurier.net,
 Kexy Biscuit <kexybiscuit@aosc.io>
From: Mingcong Bai <jeffbai@aosc.io>
Subject: Please Apply: Revert "drm/amd/display: Fix green screen issue after
 suspend"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 51EB840098
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MID_RHS_MATCH_FROM(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[harico.yurier.net:server fail,jeffbai.aosc.io:server fail];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,yurier.net,aosc.io];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

The display on Lenovo Xiaoxin Pro 13 2019 (Lenovo XiaoXinPro-13API 2019) 
briefly shows a garbled screen upon wakeup from S3 with kernel v6.13.2, 
but not with v6.14-rc1. I have bisected to 
04d6273faed083e619fc39a738ab0372b6a4db20 ("Revert "drm/amd/display: Fix 
green screen issue after suspend"") as the fix to this issue.

However, it is quite strange that the title indicated a revert to the 
fix for the exact issue I was experiencing - despite the commit claiming 
that the maintainers "cannot see the issue" any more. It seems that I'm 
running into some sort of unexpected issue that is outside of AMD's test 
case.

In any case, this commit fixes the issue on the device I have tested and 
applies cleanly on 6.13. I would therefore like to request for this 
commit to be backported to 6.13 (and maybe other branches, but I think 
the maintainers may have a better idea on this).

Reported-By: Yang Wu <harico@yurier.net>
Tested-by: Yang Wu <harico@yurier.net>
Suggested-by: Mingcong Bai <jeffbai@aosc.io>

