Return-Path: <stable+bounces-107893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95025A04AA7
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0A97A1E64
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 20:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3A71F755B;
	Tue,  7 Jan 2025 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ROePip+n"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE261F7085
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736280493; cv=none; b=abfxmAplB79FJwZjaEc5z0pHTJKjicGRcNkmKcAtH0ma6+wLOXcMgJ3YpqevhTZWm67WK3Uz8F94W9JR3LdanAa0WzgMtZAYoTH9XDksDXGAdyg0CNkOTkC9OR0OJ1KS1tiRkcxDEJcZ5hdqFFEbOcY22GkmxquvjoqWb3GO8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736280493; c=relaxed/simple;
	bh=4/CkRjq9kcUokUjRmbo9S34/t4UeumZJsbesld2STWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOejfC1p15nxjx6ICJ+lVH65mQiMLyXhOJvtLBiS8TZLleriXDt3CAevBo1lZ6k0blypX+DnNdXLzizNQD6W04TiIyWYqXjomWERiwWJc0cI8eJpIXgOuO8IHGJ+eKvregmuIrzARxWZCdjErySsxkarMq5yki7IHc+e6ITPXcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ROePip+n; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216728b1836so215819055ad.0
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 12:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736280490; x=1736885290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KrxwWdw54K0Yj+RKR+q5UWCVF10MxJgob7ZMKnFuvw=;
        b=ROePip+nHNwLAIrpFg+8tCzs0mL0XCNKxdWTETBa5ccyD7IC50fw45pgflCDLr4oME
         IwUbRt3pUa/4FcO43ZfuqO7RJ4/+mJQP9EM0Afy2WPPBQ9oBuF+6eV+fkPtH2UrQFNmU
         0en5z+fIWWEAP4RSqaMqWD0catzTAQyc8rxnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736280490; x=1736885290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KrxwWdw54K0Yj+RKR+q5UWCVF10MxJgob7ZMKnFuvw=;
        b=thoT8oN51BMDQ0W7zMqOclmQKiLA941meBji92/2RLeUnyF4sH+KsQ2TvbLcU+ofoP
         XMsDwELnqnYyyB9E2VkHbXBw53z2eDk08TcNDVj+NJMJTMuSD5bWLaP7bCxhcVfDsXjP
         QtbB4z0U351ayQwISqnHcjWQ5flLkLQRVuE02DcdDGA5wKp5mcCKVe8nDGZMMjGX+Kk8
         8awHUH1S9+xPaLpBzBpOJ6PwRc7jaxgvWxWOX0KPmuxZOSU+a7cC4UPRm2hT/0SSmPYR
         dghHBNOjYhI7YE+JEuAcskXk0G0MjQ9wOyqfaLoD1Hc21k65hIt6SCf9Yd/PEIB0k2RA
         UJdg==
X-Forwarded-Encrypted: i=1; AJvYcCWHDsGkk5dLAxQAxIrhu/cG+LazRuPWpYpPMJ/ryU1iHuHQ2KVB9ncgPHOyfybOn/1/0R6cOGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cCDRuqyWALcy+u0ZNxN+SZYpqgG/GkMIVw3qoL7XO4tsVbpd
	GkLSPTp7oiBojiEGaT+4viN5G8vu14PsQtMhAJdvjWFda46sLdLfPVz0NaywqA==
X-Gm-Gg: ASbGncvqlgW0ZGefmkaUvJcyIPidKZZo9VF2qos+DwXJhKQ9R1Z1hOQET2e5KTqCm9J
	q5YPn9ftXpHnRagEoaxAkWGe76BjuFSqEg/lVGLY+oe1/SuCjyewY3BJ0RQYrzFo9pz7Ul0YgHr
	F4fgc4cJn6Wqp7poKAtlB4WJq8IuQ5IhClEbyToPgIVHIkebkrqG1l/Qw3qJiiZBZ+dGvmu29lV
	aKolwmiENE+7MAP0dBRpfyL7t6bs1VCwJ8AQzKk64cshs0NtGMg9HOakZFvsxT7axqK0SapTqJm
X-Google-Smtp-Source: AGHT+IGlYlv+o4b4M4lfyay2yfIQhWPrIig5AxGmXyZ7/rDfeJh96vHrE9iSzFs341VZqJN1Vu/LmA==
X-Received: by 2002:a17:902:d48b:b0:216:2bd7:1c2f with SMTP id d9443c01a7336-21a83f5510emr4528055ad.18.1736280489913;
        Tue, 07 Jan 2025 12:08:09 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:2961:4bbc:5703:5820])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962d47sm314263425ad.55.2025.01.07.12.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 12:08:09 -0800 (PST)
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
Subject: [PATCH v4 1/5] arm64: errata: Add QCOM_KRYO_4XX_GOLD to the spectre_bhb_k24_list
Date: Tue,  7 Jan 2025 12:05:58 -0800
Message-ID: <20250107120555.v4.1.Ie4ef54abe02e7eb0eee50f830575719bf23bda48@changeid>
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

Qualcomm Kryo 400-series Gold cores have a derivative of an ARM Cortex
A76 in them. Since A76 needs Spectre mitigation via looping then the
Kyro 400-series Gold cores also need Spectre mitigation via looping.

Qualcomm has confirmed that the proper "k" value for Kryo 400-series
Gold cores is 24.

Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Cc: Scott Bauer <sbauer@quicinc.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- Re-added QCOM_KRYO_4XX_GOLD k24 patch after Qualcomm confirmed.

Changes in v3:
- Removed QCOM_KRYO_4XX_GOLD k24 patch.

Changes in v2:
- Slight change to wording and notes of KRYO_4XX_GOLD patch

 arch/arm64/kernel/proton-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index da53722f95d4..e149efadff20 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -866,6 +866,7 @@ u8 spectre_bhb_loop_affected(int scope)
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+			MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
 			{},
 		};
 		static const struct midr_range spectre_bhb_k11_list[] = {
-- 
2.47.1.613.gc27f4b7a9f-goog


