Return-Path: <stable+bounces-243912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHLbFIwG+WkW4gIAu9opvQ
	(envelope-from <stable+bounces-243912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:50:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C704A4C3BFE
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3180930241BD
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 20:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7496E31DD97;
	Mon,  4 May 2026 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW7YusUO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20BD31985D
	for <stable@vger.kernel.org>; Mon,  4 May 2026 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927701; cv=none; b=dRp0LtH6qXIwMrrvIHsnBbSS9ARpYCEJVbShHlEH+zyuopsTjuEbHofNF2qiYtvIgJxzgFC/9NMmrU9aHRCIFuX2OgnmCQs+4bYxasymIprwb6L5j9WRTxaYVInL85kZhr/9yMNy5pRhyzvkL4B2vAdD354/DVRQVsYbhnww/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927701; c=relaxed/simple;
	bh=lHRbQRvhCefu2MS7D67kLrFGL6wNRu/ft9VmKJYEsRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvaC5kBJvjBxU9n9lt97fcb14qAPXIdWzc6cubBtrFYxvLkDmjjppnO6NrZVmhiMovtUx8PRXouifEKO4Jc5yEmhGL6RMTdeGRUiPK54E0G1LktsAXE5IEk5OjxqYFfjr01UiV5InIzSvtK7BSXpC593RfvXfbXBLNreb8tdAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW7YusUO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-444826c16ffso4368337f8f.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777927698; x=1778532498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jF8Q6RoPGmOljbJrevjIunF771/iJgvq5ngDUmVs95E=;
        b=LW7YusUOcrdFOeB1dfN2yI679/4Oz2ya60WlDz3z3axJrQ1llIgcf6HbBlZTfE7Q83
         AUEGaOuYQLtf+GzbulfPRyunCLxnKF2Xbt51xtKNHJsuCAzcuJ5ZuZGTlT2XSj5bMIvp
         IsOQPPGBgKz+qxD0eI2aSYj082dUL93qx52ixpgLL8HI8DVOrf24pk0VoCxjQN08XVKq
         jj6rwJmroSiDEakwSwOT5aeO35f+L3q7ZEub6zlzXuatFq+UTTXgH24KVXTNz1kcLNr0
         kE8EPLaiWkvPDWEQ+AaaiLzs8ZbwOtopLn11ytCw7+Dci7EUklIm79THY1Satn93B/m/
         kSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927698; x=1778532498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jF8Q6RoPGmOljbJrevjIunF771/iJgvq5ngDUmVs95E=;
        b=X8Q9R4YdJpjsUxzj0uT8wgukjguZTZ9pamqTEGGfIZs9wGJXbvHsq1eztmeuvATGeb
         Sslxuz3Tj51F/+YN3rO480SWhsLMOL1o1S8ole71tLOdTBSw6NcvjeS7FKoweE9nAH2/
         pgAsKjzXbivI2uQsechwi95e98wjVLZts/H9XUCCyDRKZ3NiyEF4CB7Bo8P3FB+gFpRv
         cIIdIW/PZH4ytwuLonbQ4+5tG/1dE3uXFmDop1a9gEMtnXnV6BZiYJ8r0XqhPUeCfrZ0
         Her1jpJNuXk7iS3C6a+X3AkeZHxJId+LIqxWijrD3248ykewQokvHiP0YyjeL2RHkgNc
         9DSg==
X-Gm-Message-State: AOJu0YzdU/7gVD/vwS7kYt4ZrkCHNovVm3XpMq76WpaMZsgLKKQ3e8mI
	EXUOm56MDnblIyDpSQWVGNik+MYuezQX0hrTMPiXpuzTKsKVXTWsEgMb
X-Gm-Gg: AeBDieucZGB9DH23EEEZdxlMhbC/6B27nlMHaXdMMNU2YdY1LI/o8J70a/wEWbP7mUd
	Y7q7Cbwdr2xRS4zhlLmYUrhY1JzcQBhQhRSkX3XnBTd7WBJNX03fgRZlWxEftawhJZ4tTbdtqZ2
	C/gYd7QTJnXyu+thukxdQqQTkkVvdlpccDZbBssd72hAdWOqceov/sx4W7cKVGL/b1BlDXfWu9C
	X0h277mPZy2frAOxnVrfecTGjTRFetVrA3T3H+0DABQr5jbbB+dx+ckz1PE7PLlgROk/NY9lF+l
	KdFZ0BLYT2/Fa5b/oyfJJtoXCJWj/soDq2fEH/4AhYX8Zvw1jFItLzqYJWXQ534OBAkysnyQS/z
	H+ffKBKfLOLgROkcdgz5NwF2Uk5b2KX2YZSE/osF2zl3TxXwbaevHsGbB0nqSWs4Kwcfm96DC7W
	fLftMGatDT0J3XiMDz59B1gTxUINcc/zag4udNJ2fBJezCQAAdvOyD2KB5+V7px5nFQYJ38iK7w
	c8v++jHQO4O40tPcEdb
X-Received: by 2002:a05:6000:2586:b0:43d:7b7b:ab76 with SMTP id ffacd0b85a97d-45003fc719dmr750576f8f.10.1777927698004;
        Mon, 04 May 2026 13:48:18 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03? ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4502865baddsm38791f8f.3.2026.05.04.13.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 13:48:17 -0700 (PDT)
Message-ID: <05dd01f4-186b-4358-b90c-36dde16036c7@gmail.com>
Date: Mon, 4 May 2026 22:47:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/exynos: remove bridge when component_add fails
To: Osama Abdelkader <osama.abdelkader@gmail.com>, luca.ceresoli@bootlin.com,
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Hoegeun Kwon <hoegeun.kwon@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
 <20260423200622.325076-2-osama.abdelkader@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20260423200622.325076-2-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C704A4C3BFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243912-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com,samsung.com,ffwll.ch,kernel.org,intel.com,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rgallaispou@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



On 4/23/26 22:06, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
> 
> Check the return value of devm_drm_bridge_add().
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: 576d72fbfb45 ("drm/exynos: mic: add a bridge at probe")
> Cc: stable@vger.kernel.org
> ---
> v3: add Fixes and Cc tags
> v2: devm_drm_bridge_add instead of drm_bridge_add + goto remove_bridge
> ---

Hi,

Reviewed-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Best regards,
Raphaël

