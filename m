Return-Path: <stable+bounces-94056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7649D2E0A
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 19:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93041F2303F
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 18:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCAE1D9A50;
	Tue, 19 Nov 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yErh/Cv/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB81D04A5
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041221; cv=none; b=GigXFdc0RSCD8UzKAAFBCy7HsbLmkYZ5p/zREhUtRBq1/OQfzllgMlhnWMAtn96VIpZTgNc+tboNq7azTZ4SZMSctiO6dDXhk6CC7sdZJ6A8SR9anrlgrYAVPV/irLG7tPvdtFlpW5frpn8dv/9+PEj/8Nr9/TTJrcH/TUnQYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041221; c=relaxed/simple;
	bh=4+hwar7hksX4/M0z4NFaljX6f1cD5Yplk+PiSWSgQRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JK3whU4FqR+ghR/SP5P3E3coRguw1tk7fGMiT6yKuH2ZLnmyExiJt0zInLgEcna0jQlE9NmHQnWo5sQQaK1NrF9jiUmzCqUyeX4n+Hgymn+XaYilO4pIbpoluWy6S6hU8tjI+aA6MC6DJ7Wqsc9lYmAxHjQvDai6/XPKG9KPWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yErh/Cv/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso5617275e9.1
        for <stable@vger.kernel.org>; Tue, 19 Nov 2024 10:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732041217; x=1732646017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efvOEpCd95WeO/48w+qj0oP+ZGNtmRm4St0msFrAtIM=;
        b=yErh/Cv/ya3qYr2Y5tYS7qxG4jIHygLgHxiw8YAbfjCsjDETCP73xoY+CQBWKGcCOd
         w4ivfjOSegE96NwINW+USurpQfDC5d/iTPOH5e6gNr1sursUwwEVwfkUX7Mm0Z528/Eb
         JD7Kgda4cdeyzW0C2nQTG+xlLaSt0uyHb0C9zpTi9YGPm3ZYmuHqy5xy0RfQu5jBZO7G
         OXn3YWSxScS85hj8clG29NqAOcRu+RS0wy8ML6NQF/Jr2iKZY7kNvx534o48c531oEpk
         jAJem7SpTU2YoTmWtKqXH53K2u4alX/8LNJXNBDOQ0ndrUws0zsBsjGT8oqPXZ1pcerb
         vD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041217; x=1732646017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efvOEpCd95WeO/48w+qj0oP+ZGNtmRm4St0msFrAtIM=;
        b=sDS5j75Brt1RjgbX43GZVss+o7BIBO0y4odNwvjwpM0g2jUxzllOXE+uCaVq98ddAt
         u9uSGmH0yew8v7Ww6+bVX1Ez2otOf/0pFiCyQeWOjZkyZchyD/znJO5vrLGFZvMo7KKk
         g9FGuDIVO33fmJD/FlJ+E7NiW/FMLOwxY8Uh2f2eHiqL7Tc4fHjEN/hfg7kVzaIiVtqM
         rPqmozD405YahAKEpL+YxmY/8ZVJfd9U5PE+cUmwEJeC882fhZHvMZKrkCkYslZ5WJMW
         nv4k5kAIY7sgeWt0/HkRyUz+nN6Rb8AT8ueAH2axyhhPNOd59H5pWPRpNMUcKpanFJ3e
         c7OA==
X-Forwarded-Encrypted: i=1; AJvYcCWbTMmzn69uzorvRdp/t+Dk0Ty1GF69FNWooHZCrgu00LZkMYdEz8DlLKvfKMhfANrDJ3gz4U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeqlKh/1mXlOOO5CqKq5I068DdAqVAsNXn4uautZDaH9el5snC
	WpgmUgRB/HDjg0F7AUVHbIf9BEYtG/NFvttgWs12t/mN/50z0KklHaic1V8xwXE=
X-Gm-Gg: ASbGncttDHP5BA72MU0vHiiDsKkPGW16p6I+m/859EMN4A2mpEv09IkjeVCPk+g8rKE
	XdFglduhdZtLij3+9kzaHGknx9Q4UeZMobC3mFqyuJ5LEdUHe1jvd08DKhdmUlhLfkKW+TVErGz
	x+4+Q2RtjxMdI319tDLQWAQ7pSImD4iX1c7PsWMkusbNUVPLlxOexMQcv+pzlmXGHBmnzaoXffP
	SwdNoWcbk/xUpHQeUtR/qhjA/KHeQuMXhSjqFcgcU1lcTlArJSKvs4CnMU/9KxhqA==
X-Google-Smtp-Source: AGHT+IFYWxyynk2sfdjI6zEKI1/p2FFiirdli/9bZ7gZYwreNjnXC2OHtYTc93Faqf94ePMZ80JLtQ==
X-Received: by 2002:a05:600c:354b:b0:42c:aeee:80b with SMTP id 5b1f17b1804b1-432df797e02mr64688085e9.8.1732041216817;
        Tue, 19 Nov 2024 10:33:36 -0800 (PST)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1fb7asm201566805e9.42.2024.11.19.10.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 10:33:36 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 19 Nov 2024 19:33:17 +0100
Subject: [PATCH 1/6] firmware: qcom: scm: Fix missing read barrier in
 qcom_scm_is_available()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-1-7056127007a7@linaro.org>
References: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
In-Reply-To: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Mukesh Ojha <quic_mojha@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Kuldeep Singh <quic_kuldsing@quicinc.com>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>, 
 Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2415;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4+hwar7hksX4/M0z4NFaljX6f1cD5Yplk+PiSWSgQRo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnPNn4YvyTrrVQ2ijl7+Oi6n0F0Aq4/byHzwRun
 llOJtQbA6iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZzzZ+AAKCRDBN2bmhouD
 19hFD/9GIIDYhi+PrS+qUWDkluN3W+XZL198CX0iOUIm2HEDywnOVrTgfaMPFnWwYRCEO/n08n2
 q0AKqTk/zoo+bcOlJZjnZy/NOQipv5J0GHotUw+25guqkMKDU2GO4lnRFsAKEAqR0HLbs0q2gBu
 LVDWihY+APlv7sjgEWQ7RSqquGfD6mT9F6J0K3qD+YcYuQugc/Y+NwLD8rY1deJZioF1RW6gpGp
 QbpkG2YsuXfgnFd1GlPPoROT5PUVedFD9mhHi/8g1utecHPrtwRgn3cS+8xDo9ja35dc7aKOh2A
 ioecBL5mZ46S7QO/87ZAAcHjVPGky0tPd/4nFTitR67IG6a/VK5U/2AWGkWbb1uQRiKiu5vOZwM
 mollWngi5XhnlO6KtGlLAya9wbCz8QHdbEUN4ayzmIZr0ALukN/nehmy8BvsNhnlBZj+DBQb+8d
 eIoyj+clcIUX51TmffduPT/aSqbHHWsUn2W28aTqWBcokWVHdwp2XDy0BJ1FGqXBwaF1vDwuYFP
 L0q0PSxLSYr/e3dhuSb1HlINCEnRlSB/mgSwuJKoLytApfy06k8v8DGcGPv24w6u1JT061bK15g
 E/CGUjSnDbIeDlnRZZNCziLJGmfl7zhAGFhLc0H6+y6s4j2YsF3z9FOyc5PSG6u16TSvXDboOB7
 I2OdHxy22EUGNNg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 2e4955167ec5 ("firmware: qcom: scm: Fix __scm and waitq
completion variable initialization") introduced a write barrier in probe
function to store global '__scm' variable.  It also claimed that it
added a read barrier, because as we all known barriers are paired (see
memory-barriers.txt: "Note that write barriers should normally be paired
with read or address-dependency barriers"), however it did not really
add it.

The offending commit used READ_ONCE() to access '__scm' global which is
not a barrier.

The barrier is needed so the store to '__scm' will be properly visible.
This is most likely not fatal in current driver design, because missing
read barrier would mean qcom_scm_is_available() callers will access old
value, NULL.  Driver does not support unbinding and does not correctly
handle probe failures, thus there is no risk of stale or old pointer in
'__scm' variable.

However for code correctness, readability and to be sure that we did not
mess up something in this tricky topic of SMP barriers, add a read
barrier for accessing '__scm'.  Change also comment from useless/obvious
what does barrier do, to what is expected: which other parts of the code
are involved here.

Fixes: 2e4955167ec5 ("firmware: qcom: scm: Fix __scm and waitq completion variable initialization")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 72bf87ddcd969834609cda2aa915b67505e93943..246d672e8f7f0e2a326a03a5af40cd434a665e67 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1867,7 +1867,8 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
  */
 bool qcom_scm_is_available(void)
 {
-	return !!READ_ONCE(__scm);
+	/* Paired with smp_store_release() in qcom_scm_probe */
+	return !!smp_load_acquire(&__scm);
 }
 EXPORT_SYMBOL_GPL(qcom_scm_is_available);
 
@@ -2024,7 +2025,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Let all above stores be available after this */
+	/* Paired with smp_load_acquire() in qcom_scm_is_available(). */
 	smp_store_release(&__scm, scm);
 
 	irq = platform_get_irq_optional(pdev, 0);

-- 
2.43.0


