Return-Path: <stable+bounces-73595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A45996D8C1
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 14:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC7F1C21752
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F9519924E;
	Thu,  5 Sep 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lz6IrJRs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF61E489
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539884; cv=none; b=hFdByWBU6DON62rMviwxPvZmbk8xTA+d1XqjRZB6vW/eveyOQKo/i+pB2w7zb+PfutXXaPDAwm6mysR5FAoFV3GlQDk9Os7DP/mjNcwU8c5XHK2dNhwADfENiHgF7jwwZH1fW19Engw3qBuxOwowTQcmOfCfFKElPvkYRejdVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539884; c=relaxed/simple;
	bh=gAIJ3PhajTs243EZcebvGSoGjro9qiQ/Ws0W81/D/fc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=II05vxLcQMS070VPe2Ew5dHnmlzixM5HGPyNcb0fgKZMOEA86Dotl9nUOgxAYoRRcXMRWEEDCrBwW6sWWSLBh0K4B1YgnoQ8iLY26f3aqo3l2TLW0w5qgjHFZMme0dyqkBLUCUaOGOfgTBOX22jAdg8Unw+V+9X81wTRShX1tvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lz6IrJRs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso7455625e9.1
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725539881; x=1726144681; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fs5UBLOJNpf28XhTrSsd4UdpoAhSIXUZY6dh5f6f8w=;
        b=lz6IrJRsimt1R5mDYhhnLLMIO53OagJWLH+CjPdQEbWiRQow20Dc/QflSAuk70LGE8
         KZsoMyprP8kAUldh6Nf1ad9yq38vg4JaIeba1ykzb8n1PbCPm1BDJ0s1LEbzVrsDsG9s
         O6yVR3ojs4XTOpITC5ULU/Ry3CDoMOBfOjV6mk8CtxRzmmY3mnA1mrAucWDI/x74XUrq
         B7FwLRvylDAkE866WvBFXJ3Wx4Cp4FRSmudug5f9yyGJHxgGWqXzntKnbQYy92UowM23
         F7BJW+cJcbRk4lzYc2V0xbH8+AM6yJyqKAuVUlmW7qdHVt2YtcA5GWnH952OBETo/JcM
         CxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539881; x=1726144681;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fs5UBLOJNpf28XhTrSsd4UdpoAhSIXUZY6dh5f6f8w=;
        b=pRDVLHTmF6u/7XsJPqZZXXFUi6+lMX6K3AppRS1Wu11fJ6F9GB4hlOEnTTlGrap59k
         SCVYuKedy7DoI5dbL1xzq7YmxJHmKuXnUz2AR8z1JTVGK3IFI0+Xezix5793sn6hm9KM
         gu6/xwJaSm/tNWJxUjwBxE9ad2803WQr4XjODiIhTMTHe66Wtp7IYIpjPIUKHK53Xlto
         AwCZoqmijxZJjnVK8BqDhTZr6WqPVJIPL60QT1SEHAjc/UWIaQhnTOPeKLh2aBnk+9J2
         F1Wd5HhhQ2Pw17p6yTtVM4Htl0Ehcj3rSlYAJkHWrZyHGu0IVeLYM3YWpDqBufyh/3yv
         t/zg==
X-Forwarded-Encrypted: i=1; AJvYcCWtjhr1erJq/EcEG5mZ70oSLR8l/aOdMMFX5bNQOzkBBtToaamK/aDsZHBC47PQ8P9MEzSCe94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFKHQ/99IrFZjW9eK6pcrCNyAtHBAP5pP9ANQW/2dccdn0Xd9
	yxgX4ZUHoNxBXUW+awP0liacMC8ztfCR5D2ZvXB/5NJEuLOEQjhfzYnpqZ1jVLs=
X-Google-Smtp-Source: AGHT+IGzhcg/wy7VI0taY5toO76pCtxvIT0nMt9rIoFCFrX0MaSFl5c96yqpLUhXxfmWrltlNd85FQ==
X-Received: by 2002:a05:600c:1994:b0:426:5269:982c with SMTP id 5b1f17b1804b1-42c9a38b28bmr20532705e9.28.1725539881113;
        Thu, 05 Sep 2024 05:38:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c17fed40csm185938965e9.0.2024.09.05.05.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:38:00 -0700 (PDT)
Date: Thu, 5 Sep 2024 15:37:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Hillf Danton <hdanton@sina.com>,
	stable@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2 4.19.y] ALSA: usb-audio: sanity checks for pipes
Message-ID: <be8708fe-fa9c-4b41-bbbf-50a75d0fb3c8@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Backporting the sanity checks on pipes seems like a good idea.  These
are basically the same as Takashi Iwai's patches upstream.  The
difference is that upstream added two sanity checks to code that
doesn't exist in 4.19.

I had talked about backporting fcc2cc1f3561 ("USB: move
snd_usb_pipe_sanity_check into the USB core") but that's just a
refactor and not a bug fix.

Hillf Danton (1):
  ALSA: usb-audio: Fix gpf in snd_usb_pipe_sanity_check

Takashi Iwai (1):
  ALSA: usb-audio: Sanity checks for each pipe and EP types

 sound/usb/helper.c | 17 +++++++++++++++++
 sound/usb/helper.h |  1 +
 sound/usb/quirks.c | 14 +++++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

-- 
2.45.2


