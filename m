Return-Path: <stable+bounces-107895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B5A04AAE
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070F31887E40
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 20:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55EC1F76C3;
	Tue,  7 Jan 2025 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BMnr8HJf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197751F7569
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736280498; cv=none; b=AN9OjCu0JOe2PnKjAlg0C44oQbSel5YqH835bQEJEt1AR5nmR+PFclkA0gS7YKGCWez5OfDnkawbZckChnkZdGauaWeE218DjB3qok/Cr1b27+4S7340fqfjsDgIEtJjqvPRLCE/KAOpuMqTiQsW3xXhC2dDLoGPrL3bqn9H6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736280498; c=relaxed/simple;
	bh=iXSbvGK/GRKHVLZGDgeu68FgJ3g7CX4QZMvsuVny4LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rh6xrdffCxwWtdGJWdNbomFO1jMb7vNE6YvEKSO7xa1iAluZdpbs7eAyxC+Fe5TU2YmD21kvrl37j3+ltmzP1qW/fLiU1KH/MO6cuC3Q53tVzd4hbT+bBp5apywpI2XrXMkClEHQqSAG2eJFBwD/udmcJOha5VQ0bFVoKGLlLgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BMnr8HJf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2167141dfa1so2658185ad.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 12:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736280494; x=1736885294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7JIcKoOn+aj6A6FGmZdKgBjeiVX3ZBuDhppF1K0+s8=;
        b=BMnr8HJf1jqrZaYD7eZY9Q2pEFXjZ8d31+ELyOgj4QfxO8LId0Pyc1QxNwR2HZgeGJ
         1aPZzMLb57M4eqIgrvT/qduiZiW0KmiHz0l82GgQ6l+KX2bHlL7Udlujk12Kt2ZAtbNA
         SAsQ8Q8V3QvqfKIuKcHkjaRm8kky+ffL4Tyhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736280494; x=1736885294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7JIcKoOn+aj6A6FGmZdKgBjeiVX3ZBuDhppF1K0+s8=;
        b=mZux3nXtlqTWK4SSfbxN+i1S+GuGzkKDcDK2EzOQmkYHReFALor3hwy/hq2Qbs8R6U
         idPI1R6OwaNKwAdOe6c6K2sh3bOhIPqb/07mNjEx+NDCIjfzU1XKExHGYQ22/e084EcD
         57NT/gbQBZ0KfgN1Ojhetehue61P77igHp8N14tNjepxlANkJKf+arjBBM7XyaGvALj4
         idSpP2yPma7n3z+AGFa7MEQDEEM+OeNnoiB5/NIfi47Aoc+jHYs26b+qqFeHCkB0r9ku
         pK4I4XuuRnAv1TefXvIL1jwHMf2oCq82ou8Ckx+HpMEsVJECXFWbqMgfQvmzOf2AXwUe
         U+oA==
X-Forwarded-Encrypted: i=1; AJvYcCXPhdLc/BXXYVnSgxBWGchzf7qf5kRE4qUN3/Pp/C3HX8hhyZmL62mtZyMQqlYiPPUKXsRLvJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8r2jnBso8tXVI9i2iGnczC5LhutBjDreiHmgWoOG2I1NqHwkW
	0auKrAVtLc9lKWZTusJoOBvGlR6kghZHzNjUCK+E2Hn5Bt7P9xK+UCB1sjeGqg==
X-Gm-Gg: ASbGncuy3o/C2gpf+y+imZt7mKHCww1Tr1lWyxm2Dp/rhCq02iJJRwJpDqhGzWubEzy
	sZsw2GoYYhlyOb2mq7mHxoexCBUD4uXL26EG8AuPNWXFntR8BJsaH4E/mRG8IRld00s+fFIJKtU
	FmMV03diFGeod2oY9smS0eOrEdRG7SwbPKi+/I+ltdEGXx4OkiR/7nkygYG2vHgtlrYZ85Z2ZRX
	Ekyti8yY9RhuBMnZbRzydr4rtTMbusDMB/vMaOhXBl1XkrhH/ArhyfRHfHA6hUK5CIr84GctXi8
X-Google-Smtp-Source: AGHT+IFYwu/b5vkXAi4S+EzyiEJNxnfulDMZqRNb7srUjlr5I3jIs0W0BPEczm+Ttsn4js6vyxWAkQ==
X-Received: by 2002:a17:903:41c6:b0:215:758c:52e8 with SMTP id d9443c01a7336-21a83c148abmr5723375ad.12.1736280494447;
        Tue, 07 Jan 2025 12:08:14 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:2961:4bbc:5703:5820])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962d47sm314263425ad.55.2025.01.07.12.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 12:08:13 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Roxana Bradescu <roxabee@google.com>,
	Julius Werner <jwerner@chromium.org>,
	bjorn.andersson@oss.qualcomm.com,
	Trilok Soni <quic_tsoni@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Scott Bauer <sbauer@quicinc.com>,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre BHB safe list
Date: Tue,  7 Jan 2025 12:06:00 -0800
Message-ID: <20250107120555.v4.3.Iab8dbfb5c9b1e143e7a29f410bce5f9525a0ba32@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20250107200715.422172-1-dianders@chromium.org>
References: <20250107200715.422172-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm has confirmed that, much like Cortex A53 and A55, KRYO
2XX/3XX/4XX silver cores are unaffected by Spectre BHB. Add them to
the safe list.


Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Cc: Scott Bauer <sbauer@quicinc.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- Re-added KRYO 2XX/3XX/4XX silver patch after Qualcomm confirmed.

Changes in v3:
- Removed KRYO 2XX/3XX/4XX silver patch.

Changes in v2:
- New

 arch/arm64/kernel/proton-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 17aa836fe46d..89405be53d8f 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -854,6 +854,9 @@ static bool is_spectre_bhb_safe(int scope)
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A510),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A520),
 		MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),
 		{},
 	};
 	static bool all_safe = true;
-- 
2.47.1.613.gc27f4b7a9f-goog


