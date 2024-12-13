Return-Path: <stable+bounces-103985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDB49F08D8
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 10:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAB22835F7
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FFD1CF5EA;
	Fri, 13 Dec 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHrR5Frw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6731B4145
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083785; cv=none; b=UsQlpKQqj3c7ZXoVG6EAP+aXMWeTQKNacro1sS9WTl4fgVNfiYVoVly/55x8JwrNTU4Ffw9yCpEPDDYEPRqxS3rnH/cPZdbZNchbxQv7nLeorcSGnwq2BQKb14bOz6xcHN7NeJaukcuW/z8uBcPvk7IyugTiW4ritEiI+huqeeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083785; c=relaxed/simple;
	bh=wsHLBdhL/YuObC++wXJTgBih1Ze+nqAIErHGGB8oKks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZZkOFz2oCIOE3OSgcBf2oBBRAek0zwfeG1brBI4mgtHd1mpFljjWCT96CxSZZhYsSInrWXqZeqUhhsfeTyDBCogaEhAE3Jyf9d/TU0uSVxAzIF5u6hwUFm9Jtd4l3a8L7NOszXERPIJTRuWIONb+8bXCE2aMmq/Nrv/jlMUUzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RHrR5Frw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43618283dedso14591405e9.3
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 01:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734083782; x=1734688582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9gYBr7le6CudpIb2B0d8mAxQug4zJXIf9a2dPZSils=;
        b=RHrR5FrwMpFZGZyVavtFEtGVn3WpjXlqh/M5QDnnn4Y3ugOmhNRWnV/ZI5EwIkd5Tp
         NEGt+w+4FIDlIJuIceah3L0ciE6yerFUqleRkztjVawvrwDSHZ5/iFTfeQ2uk0M8hCJn
         9lJ+3RFi+NW/iWpszR3kcCuto++SffwPeB7HzU8XBUd12Rrn8XdTIx3WUuAl8zbJHKmT
         4Kqqt/zWeNgr7MaI0s++DIzdLKtmMJR7m+j32NMvo27ksDruMXnubaoHTd7icNpUCoGz
         uISugR/uAJUIo3PvMLIkD191OAIMgCT7z2ME9hbj35V2iWr1rid1hrkmpnqqxoutqXnr
         XSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734083782; x=1734688582;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9gYBr7le6CudpIb2B0d8mAxQug4zJXIf9a2dPZSils=;
        b=aHpCPC9ibVyyAHdXqtxKDk+1pCV/mZJPxowiotpMq8/ah208Jq7Up1j3xicXdVZ2xt
         2yYgss7+axt8QXlP+JIKb23e970rl1sIaDrv2E7apMbND7aSATyvaLq7xKjHFijwncNn
         kSm4koNEXTG9cHZsKg6nMZ8kaUQNbNOaaj+xT4C717fQLFRwEXa35JpV5yMqqlZAGP+X
         h+nWARd/vtys6iuvDTSIqRxtM2qhQqpqaRnMSnDxxvnfRrLMHdy8GuBudPSR5pUdTNi6
         xycZBFOh6/rL6Ydqg5yeRdDSnwfSUH9opsE/zcDtoSfZFPnDbhwbu0V7UEhrePkiQ3OJ
         zKnw==
X-Forwarded-Encrypted: i=1; AJvYcCUuQn8LnWTJ96scdH3NQ+JSQbxm1LO7qWoLVSB3qjax808nPKlfXcw/Hj6MNagANoPfpCKHcZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsf+AurVIftZo4yCUZ237YLYa99q+1QMa2EJo8kgpGA//Uqkrk
	TIYN/+rdQoqExvdJiv/be9zfQGT1YLxCmhccfhacD5sr7O+noUpR/z4LvO/sejDpEoLN2osVeVf
	ZNYA=
X-Gm-Gg: ASbGncsmM6ytQ8j+8WzzFtWtzSnfEZmI4jUEmzlatYvNodwpxQ60wrwevSKWYQZsPnL
	Txyo9Cu0K96KNIJey6ouROu+pR+BNK+YNVwKr0rDWoOH74LQK2068NpFJyo8JZfa3Moh+e1Uv8W
	GBd9EAN9DyfCAjdEA8OQip5j8Rxc/mU6Q3Mu2qyXMVHioUJV49uS9wDKmKrShytEk8OyEwrCr9d
	xxDHZ/WLqajhWUavmYqLuUPvJv4JguULZDMn72Z3T0bG5yewkgkKHm1QbXsf6lm2UarAqQOKSQl
	+w==
X-Google-Smtp-Source: AGHT+IGgkNpBc05ccOXtavEiu9PB3goLoKJdoKutPLdyxpIQ28Umt6u9qU6JdmkJwtWwOvchkFmAvw==
X-Received: by 2002:a05:600c:4ed4:b0:435:d22:9c9e with SMTP id 5b1f17b1804b1-4362aa5313dmr13933525e9.19.1734083782469;
        Fri, 13 Dec 2024 01:56:22 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706c77sm43616845e9.34.2024.12.13.01.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 01:56:22 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>
Cc: Chris Morgan <macromorgan@hotmail.com>, 
 David Airlie <airlied@gmail.com>, Hironori KIKUCHI <kikuchan98@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
In-Reply-To: <20241124224812.150263-1-marex@denx.de>
References: <20241124224812.150263-1-marex@denx.de>
Subject: Re: [PATCH] drm/panel: st7701: Add prepare_prev_first flag to
 drm_panel
Message-Id: <173408378171.189325.1503369050092401336.b4-ty@linaro.org>
Date: Fri, 13 Dec 2024 10:56:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Sun, 24 Nov 2024 23:48:07 +0100, Marek Vasut wrote:
> The DSI host must be enabled for the panel to be initialized in
> prepare(). Set the prepare_prev_first flag to guarantee this.
> This fixes the panel operation on NXP i.MX8MP SoC / Samsung DSIM
> DSI host.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: st7701: Add prepare_prev_first flag to drm_panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/406dd4c7984a457567ca652455d5efad81983f02

-- 
Neil


