Return-Path: <stable+bounces-241894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOS4IGsN8mkynQEAu9opvQ
	(envelope-from <stable+bounces-241894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:53:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 324614952E0
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF58830AE20A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDE139D6E6;
	Wed, 29 Apr 2026 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKVVMajt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903FB3FE667
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470069; cv=none; b=qlhJenB9DE0b0wtQvq4u6KdZ/jCKVQp7oYvVV/t7cqdTjlS/AMbeJILGAN+S9/WfNjWnk/epbfpkyq+RmbCDlUKQicKtc5wU0xWVI0hn2yIEistiAj2YQEiUFBDHHssYZtBVNgNHFB/yqLOek6wYlA4LvlXRdfbaIM0WxmpcDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470069; c=relaxed/simple;
	bh=qAZ16WjkXW8EaE4bAi9IdH+z9/TRRUTlzn3zZxZEVLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1NTw61yFSWtDwJ3dZF2I+zgDPorGOV2nW5SFv8I7OOIDyc9Vi4skH9vmtNP7DT4ek2aQSV7nGtM81OLQyYJtLG4DIAxRT8o1EqqUx3e02Tai8haYmBlS9gYG0iIzrnPSR9LHTcqkv3K6SZEdYfDjNp15UZc4ULM5vfpM9TrXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKVVMajt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so217881325e9.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777470059; x=1778074859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SE1WBDEAJ1UYNmcfE47F7BEz7WO16H1bRtYL6mvQ6Xs=;
        b=OKVVMajtloHYxEnX2+J+ZSCy4yTiSNRho/lGJPvJh/Aral/GUR82G4qRfUS6qEWiGs
         ifsJfjsRdH9dzbx9fYmTrOkFj4JSfsBGYBECRsIjvxatPAinhCzqLKOhejOMUBZmC3aE
         ImuD6DAwDwnB3zw2i81tDLDckD6xGCkP2vvA5NmWlXx0n+o3CJqBNrldWQD5OqWru7tl
         Fngru0z1sVT6qsR/yrqgdk3XaQwgyVJpeNzGR/38PAxqzhgc38Xs3g6i79gb8zf4L3HA
         F+vTYCdg0pFBtCkdVDH5F0ApxusQCkmMTwhv/BQ3x8HT+Dmh2nOgY2zS2d/8POYyjbUl
         uEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777470059; x=1778074859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SE1WBDEAJ1UYNmcfE47F7BEz7WO16H1bRtYL6mvQ6Xs=;
        b=abgcdA5Rc/5XYQJWkd2+hsxygTM3wMMUTcK5h7IYnmbdpSzS1kE8bzr7qHMdjjifoi
         iqHPFO64DgpSaCfuhq205GeJZqFxoGhYa44VQr30FgsNLd5tzEdcTZnyKm2abcleMpPZ
         uzNLyi6RWFM0SR4gkrW5bRCjP0I1PE4tZXkUJS/QyI+CeIY4IesIa4+3CcvnfVOfZcoh
         vs2GHiC/rsddqf6K59XOnqXyyFTSGz6SZbDdH0jxcPFinMkeRHTdFP5D05YD9VjcQ5dW
         gBXNRqpSBu7gZ4DAfT2UI4zKcI2U/331JDO5CGPB00v5JMandx31dlgLZNV+hAOmZ8zH
         XdGg==
X-Gm-Message-State: AOJu0Yz3KCeG956Gb55WKayeH9aKyx2ckogaUimACGG9QxnXXtFT1b8F
	iwuVUs9LoHFJpg35gD6lzUf99Vb+kCmcA8S76L1nMlGsjvtEpCJs4XqC
X-Gm-Gg: AeBDieuULYoFoFMZwIRTuU5PdwhGNjciMR5Fi7wtCJ4D46hE8EgKBFPI44Siy0RSg0U
	hNRsppbS34kRIaTufi0i35ChUV9YRnMy4r9/+9dVP9G6rXqjdV9MNGdDjAaJtwOHQUw5kuyedMK
	TH7s+lxJ/QgOW4+XThIxZ83IRJu6UrIkRqI4ZLsHTHGPLeHyd0JZHw0CWViVFUV0gUn+iY5BSRb
	nmU8JXLPQIXcGteywZd3ch07lDHuL2ImOYCdpNg0SdThjaGAUogyOGxwWkCsaxA3QSu+SW9MBUW
	nkkk+dIs5n9g7CO8IFvxbtmAFF/op5Daivv0qLXRJ/jLejjGQzau2ZfYJUaJk6+bsDECq8aE/hG
	/VlZTh7eTz7HfCDOjbfa/CN28XKZWf7t5nwcliGGySiL9KkM5bt5dv896aKdT0aiRck0SMhvqLM
	coXmgxalp47Dfbled31Al6NXHDLb4VHTTui3VNMBUlib5WhvOVDjjDp5SUOIC7pkY5cxX/rR8Qj
	qxcHdhr7Q==
X-Received: by 2002:a05:600c:4e4b:b0:488:be58:bb5b with SMTP id 5b1f17b1804b1-48a7b547375mr70268735e9.24.1777470059359;
        Wed, 29 Apr 2026 06:40:59 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03? ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c57b579sm56656275e9.4.2026.04.29.06.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 06:40:58 -0700 (PDT)
Message-ID: <2d81e7f6-b6e4-4e3e-bd75-315c696c003a@gmail.com>
Date: Wed, 29 Apr 2026 15:40:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/sti: remove bridge when sti_hda component_add
 fails
To: Osama Abdelkader <osama.abdelkader@gmail.com>, luca.ceresoli@bootlin.com,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20260423200622.325076-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 324614952E0
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com,foss.st.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241894-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rgallaispou@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]



On 4/23/26 22:06, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
> 
> Check the return value of devm_drm_bridge_add().
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: d28726efc637 ("drm/sti: hda: add bridge before attaching")
> Cc: stable@vger.kernel.org
> ---
Hi Osama,

Acked-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Thanks,
Best regards,
Raphaël

