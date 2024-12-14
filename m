Return-Path: <stable+bounces-104163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9541B9F1B89
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 01:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BED47A0571
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 00:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F641B59A;
	Sat, 14 Dec 2024 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMpYUjip"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E22816415
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137593; cv=none; b=S51fR7aYmMHyPv9sGpTCaoI3gs6/GDvlMtD1bYU8c0HvPbwfTah+4cNeBZyJiqDrOy8r+zFbGvtn9xrbsCe+URRDCf5j3mU8MtcgZj5xSuOyr3VuJboRZh+enqGwgOxKTfJwWhtmAzK9dLhAIvXNXDYeckTO4lYuaoPkG9h3KUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137593; c=relaxed/simple;
	bh=XJYoVV8JvXnn2NiRA98wpV2UEbpgwE4/KHVxl3uEyMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPsDje0CF1FpeEHZnAiPrVYc/MZrbDYIA+nWI9mZL+n7eXn+0qeShIoUA16nKM2BElKCMFdq8+HW4Rm/oqhsfEn0qG6nDVVNux+8yq8BsHryhXr6u7Qa35oCYEfz7pC6mb7BQvXnxK4lF9+wOrVpr5/LSpvfzU87mPKOnIQGk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YMpYUjip; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso1619811a91.2
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 16:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734137591; x=1734742391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lb40kxSySziI3vHFr8SIoDrNL6+Q2SvOcQax38nrL70=;
        b=YMpYUjipeqgd3d+86PYmi/8aaRdHXrJB+kDlh/kGvDKOI/oPhe4BawB4oowi4YjciO
         Mwn1u117Ukt3WScrLoOAJgIMDqV1UhKg+GNTWqkR+KvpHpY8NqHfWycYGfAm20Z9ggmu
         ECbKxBttSkpIpTheg8qAdzhT7MQGmSNqwD5lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137591; x=1734742391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lb40kxSySziI3vHFr8SIoDrNL6+Q2SvOcQax38nrL70=;
        b=YcUZKeSaDvX3FrUmpyc1/2g9pTj30ZyUTCCidjKw2sviRCUlVgjzRJap16YgIBGRnn
         6gnI0Rvelw2nQvy8RXtygVIHY5vug89O7dvNZ9Wg5QqwViJQDJprbd0c1P8NC8mCPZMt
         1bxHzTXE06IHe+qkPoPgvuv1QzoVlOFb1yI0B0t5+RchOlBjL5TCprUoWvqrj27ghqqU
         4xk7lEzJHjUUUz+z/3l3fwVfCFMGFXm5zGau9Fpv3b6bk3lpl7uLkErrNwf0IJ8zgCUP
         Tjc+D5ESwQGEqw7BMjqJQo+w47uryKpKCi3DIHrT4mcr9kDXNgsb7ipFWmfzbcqyp5sx
         vrvg==
X-Forwarded-Encrypted: i=1; AJvYcCVElwEzPNpn/8djjSaUXuZQl+zjIPoYEPZ700qnd1LyHPZW37AAcCL2NKSC9ChR6dR1eSFBPNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5Mn8pnJ4nL4snydIp2ugLydN+ZZHUMuFChM8C4pxg+IFkx/H
	m48h0fMd/rMep8ojCirvmmAnPsSkjK2GL0cG7N3M1TvTilA54GZF+iNAm/levQ==
X-Gm-Gg: ASbGncvgqqonqMOMtdiWzmnkkhbFvpuTvQcCXHnXz9LWAY5kv8a+XdP8FNd8C2mPIEk
	eFeKOHiOFomE0yXBG34mFXiBsZM8vXnXa8+lVtoJr2vIr3KQxYoASirqs1HHRRcBfmNcpCJMkY9
	9WgEudI/FHDESu8ZpDcjppXlrjHOBKR+YRUQR1FTJedaVNgcESyJ5g+O3tKf7d9OC5XYpf11G1o
	I8V2bYzlhczATJRoFGFn/KH9Bs+hKIifKFcRUi/BsC+viC/6A6mxQhOhWQtD7zcLmDvusgk3nbv
X-Google-Smtp-Source: AGHT+IHA02wdX7gbQpc2VM52GOd1+IrxDgEcszoQJP7VGIrV4tHzcaG0wjdjW5xSAzMH6mwnDjKcmA==
X-Received: by 2002:a17:90a:d450:b0:2ee:f687:6ad3 with SMTP id 98e67ed59e1d1-2f290d96c48mr6152633a91.28.1734137590982;
        Fri, 13 Dec 2024 16:53:10 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ae86:44a5:253c:f9bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm3788270a91.41.2024.12.13.16.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 16:53:10 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Julius Werner <jwerner@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	Roxana Bradescu <roxabee@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	bjorn.andersson@oss.qualcomm.com,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre safe list
Date: Fri, 13 Dec 2024 16:52:03 -0800
Message-ID: <20241213165201.v2.2.Iab8dbfb5c9b1e143e7a29f410bce5f9525a0ba32@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241214005248.198803-1-dianders@chromium.org>
References: <20241214005248.198803-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 2XX cores appear to be based on ARM Cortex A53. The 3XX and 4XX
cores appear to be based on ARM Cortex A55. Both of those cores appear
to be "safe" from a Spectre point of view. While it would be nice to
get confirmation from Qualcomm, it seems hard to believe that they
made big enough changes to these cores to affect the Spectre BHB
vulnerability status. Add them to the safe list.


Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- New

 arch/arm64/kernel/proton-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 39c5573c7527..012485b75019 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -851,6 +851,9 @@ static const struct midr_range spectre_bhb_safe_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_SILVER),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),
 	{},
 };
 
-- 
2.47.1.613.gc27f4b7a9f-goog


