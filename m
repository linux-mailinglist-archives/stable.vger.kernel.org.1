Return-Path: <stable+bounces-104166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A028C9F1B97
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 01:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E4C57A03D6
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 00:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E1F80C02;
	Sat, 14 Dec 2024 00:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dnexty68"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5846762E0
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137600; cv=none; b=oPl0Zy/NN8qQngqa74eSI66S+qeBsygHysbO0qLABkEIZ3GQCcGUmXGu9/0Kn3CARRTfyCjsyamRIKyVOr5Y3ys3IgQCV7VlHzbYv/8DOAoJV5siXBP4V7SBgBUUpZ9yZX7vmQWXblxw2E0Jh04tgwg2eXfsTB6mE2skzgDycvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137600; c=relaxed/simple;
	bh=wtOPnKbsorF7XJRH1GXzXj2KmpV4JSzbTQjjrqjiA1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7AlJk7m/Mj+ff4q5lgC0zmOhFAmh5KjjUSEzKc5tDK8HNwdLdYBfMhsureDNaDXM2sryY8rR3e0d/2uktUXXgOxZ19FLt6dO7pjdYXqPx+0yRE81AhzJYtxCIuJ7WA5lHyPDw289TdjJH8r2LwLFt/tcWEBHu52tTkRPoyIThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dnexty68; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee51c5f000so1586682a91.0
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 16:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734137598; x=1734742398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrdqv5su9sKfrkNYXwk3VMWny97c1fSpv0cdthxhYIM=;
        b=dnexty68MmZaR2XUnmm8HfrxZKDViRGTfHbMiwe8Du5vrjkrHxU2BiyoSs4MR2U1LT
         eK6VvUTg30WllBGRgxU4qJfL1G4jyZq1W/2+daHbUWuztmkSoe0xgMrOExMZwLA6WGIJ
         CCHPcvCsY7eVFf6q/M++P0NBfDvhlzS9kRSTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137598; x=1734742398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrdqv5su9sKfrkNYXwk3VMWny97c1fSpv0cdthxhYIM=;
        b=eM7H6M3A28WGWNgC9kYHn6s3ZXc44fcnFxRHEb2UTtfqgZZ+o9EEqzfoVqIgXXkMpW
         nUpsCNdWkvalQAlEJRO1gvO3EyWvg4gA0MeWhQGivigAlOARAtflA/UuB0wY1IcCqs+B
         rzfBU7y6TDjbKmuutcqqZkRWO6E7nYbSYFoN66leMgBRD/XEUPbX/yx8Nkqk61QdrVP8
         JUGLq92PlnV5Ys5TEgaOXcD3S6yprC001YInGOAACoQuSUr+9Vp169lLnwAwKMAfbBd0
         zhBf76Kud3dUhoMwqY5f3bLiDvu0dHnLsXBmkuZ5DhNSqQLujQNliH1Lkib3mapNmYqB
         boIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHej6GqRc5+/2Z5HqfQeepbRxldc1Hmoz3+tpngQn/jjzF+HbKv3aKeymtDm5LzUUXcCbCEEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXkW7Cfkqq5HQmG5cYESAkhiGWvjtcmW7Rt3TCOSdABaGq/dG4
	LkKEXvnyYlk4tvQaDX/0BTiQMnOJIekXWbTlOej8Dpw+1ik5K/jZpWeQOe7A6A==
X-Gm-Gg: ASbGncuLT+hqZYA5V2nsHnMAq6neXHcQVOYJN6BqlabeWA3zi9iAzHlo+uqgN0XvcCO
	f8Bt89dDq3HhTk/PcWcO/KPC2b3Dcfr0PfhmybVIC4ooTNe+R/6FHfKHO24Tzr4ZfOsmQZmDo+X
	393t+0nyOIDVjkPpQrruvjrH853LfdckQAExDHH0hJKEyqNrGKCOdm7AVQ0X7F8EpSOJ9o7owLR
	A16wu6lwEPbJDYumTWSzUHwuiK//252Sy/4FE024JbN8X2GTh+NUbWkK9an7tdAtdTi4KFbhUvm
X-Google-Smtp-Source: AGHT+IHOcPfHNBrkQn6M2DPoYqrW9wGOVpvFmhjU4MB0966dHygCTCiPIakP//mkJvwDEs162n4ynA==
X-Received: by 2002:a17:90b:4b81:b0:2ee:b66d:6576 with SMTP id 98e67ed59e1d1-2f2901b3256mr7290054a91.30.1734137598295;
        Fri, 13 Dec 2024 16:53:18 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ae86:44a5:253c:f9bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm3788270a91.41.2024.12.13.16.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 16:53:17 -0800 (PST)
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
Date: Fri, 13 Dec 2024 16:52:06 -0800
Message-ID: <20241213165201.v2.5.I18e0288742871393228249a768e5d56ea65d93dc@changeid>
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

Add a definition for the Qualcomm Kryo 300-series Gold cores.

Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 488f8e751349..c8058f91a5bd 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -119,6 +119,7 @@
 #define QCOM_CPU_PART_KRYO		0x200
 #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
 #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
+#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
 #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
 #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
 #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
@@ -195,6 +196,7 @@
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 #define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
 #define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
+#define MIDR_QCOM_KRYO_3XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_GOLD)
 #define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
 #define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
 #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
-- 
2.47.1.613.gc27f4b7a9f-goog


