Return-Path: <stable+bounces-142007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BEFAADB6B
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740B49A4874
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529C02033A;
	Wed,  7 May 2025 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjmklosG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52276222568
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609693; cv=none; b=aa/NJDdeDLJ20TzTQKu5OySg5Mv7+63WzEvLAkzImUG9sToJzKCKtu/Ubtlj3/m8KqP+evCxf417P6CcIULmlNc1xDAF5TeyguDN4HvBDT51HmxAesFXRBoO/8+PVqde7oJ6ww3EbMJ8V5CEU6C32CSBtHZindbBAbb3oo7t5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609693; c=relaxed/simple;
	bh=Zuk4ngv1wcV3NMC95okNfizOZQtgYbFjGF2v7oWA7MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GiGB67mS9bXi3MAOKGatugmELgtg7LN0gCxAZcjz9vGaa0Qfv41742YpeKz6tCzzckYRhKfW7P6lP0qDYVaQCCLf25bWMpppCCCUUx3WiBDn14MXxCGX97wBh+ynDT0Xq3x/13G6QcEqH6FrazeTWC3rt5MF4qoYIMFXQ5LQxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FjmklosG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c2688e2bbso441555f8f.1
        for <stable@vger.kernel.org>; Wed, 07 May 2025 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746609688; x=1747214488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+y8jPOzO/Gnjm1gvhE1qivFemvUWxShS+OkhHR4ZTcI=;
        b=FjmklosGXNCndGj2Ube/jmC6+zs6C31CEDfF6sWwRVPN1zxhieEW5W7Wr1uanoQQTa
         sLdUl7AbtV53/eE7eKArkQjeyHJmQIs6Q5sOCabusg5y1+RHxfK0cDUpfYq9o0WDjfXw
         APd6WAnXdjwtv2IEgNevtGEmOBEbv8IsXl6IWn2U+PIXNgAY3Fk/TzvAfa4PQrxZnYFJ
         i7MClMBXF2HZhl7ybTQnCFoMYAI3Giu5Z5P75qw0dnwGyqr2jEhL/3ydq8HJByhzNY6J
         xxopq9DLaYu5h6Tfwhswr/2czJgGNJ9H4BLMCENWajmCJFRvPohk2SEeiJ1+2oFYgwdK
         AePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746609688; x=1747214488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+y8jPOzO/Gnjm1gvhE1qivFemvUWxShS+OkhHR4ZTcI=;
        b=GrtiA29QZNeDOrsPWYR8kX3nAuRpXD0ay9LaZ+bTWE8M4ypW4zIjrMiAviiJt1gp/s
         MYWLt0otZZ9JDjEi6tTxIczeWkhAJZEepPAXEngfCT/TzuQjwqrN/sG1sEmyjeAhHoam
         iTSEi7xMJqdNPGI8FnjPGq7ByE1MhhInwIRlS2Z0nTtsKMcC4UYPGg0c6/0E5AjcwmDh
         s8ZDio+KYEgcEuZuUoW3b4X3as0ixsxA4WIUoEb3mX8NfaGCCyd4uIT9Jk2OqPviHQ4O
         iLwAWRDpoYAR2V0QnoejVcOKJT//POL1d0J8cXEXC/tVueMZm8t7bR+9eaQ2xgC/wZPb
         52+A==
X-Forwarded-Encrypted: i=1; AJvYcCXByOjC0IQYjgfZeePoQVCPr58kWPz9BFcKxpa5W2RSS1CjnqwEJ/BLarkk/2GIH7cMyLTGCIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qGwYJQCPmepek9cPHPBtLhdy3vxTn46X6t+y1oQMkwWWeeCB
	lTgOIwJ/a5+KnBl79PteBLcVr4alBAp9X0ZoXMhAGOUIW83MLYvBiQOOsPIKSQE=
X-Gm-Gg: ASbGncuQEk+iQHRHlDTH7p2dm4I6THo56gwO5vVu8UI/ytnJivmeqGQ/Y4uEUTEd5AO
	mBo5Yr1+Mktg9o5W6SlyC1B/2egwERj2tPG+t/GIpuIM2Qmzvpdm9psq+V91QnmqW0vCOd2pUpW
	ld0ouYpIjOrtcMYjpt8tX9rjCzbUgFEceGS1byvIJun7FUOgv0YvYntkXXDdubO91W8y8WT8dMO
	BHjVQLGQgHmA5edf/V+wBmfCWdK73vlQza0mf41AyBOppZYqYnJuaBYkUpExnPomVQ99nkNvzmj
	uZ/cmFThdc6x0y93Y8xybwrWrXn8j9H+v1gTfeAQS7vjaMBm7g==
X-Google-Smtp-Source: AGHT+IGj/1ahHnSJ4e2xPVwr+AuBbHJ0wuhNIZomcjtqGtlqcAu1lDRaE0pf4RUZq68YnrfTUyA8AA==
X-Received: by 2002:a5d:47c5:0:b0:3a0:7d47:8d7e with SMTP id ffacd0b85a97d-3a0b4a363a9mr745845f8f.8.1746609688581;
        Wed, 07 May 2025 02:21:28 -0700 (PDT)
Received: from kuoka.. ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b5764733sm1633431f8f.22.2025.05.07.02.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 02:21:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	stable@vger.kernel.org
Subject: [PATCH] bus: firewall: Fix missing static inline annotations for stubs
Date: Wed,  7 May 2025 11:21:22 +0200
Message-ID: <20250507092121.95121-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=Zuk4ngv1wcV3NMC95okNfizOZQtgYbFjGF2v7oWA7MU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoGyYROrndXK6jXz7UdfFDTRPGKx2tUXBG8hAo+
 NjoRR0HvAyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaBsmEQAKCRDBN2bmhouD
 1yXTEACTo9Eb1/KCCY3Jd9m8bNUsYfG6kBXHtTAAFI8wXEESF8U4GhmrAvx81vwof2w0YREvtxb
 ISMF0pjB6RnocBfCP85nQ746kCG8w4rVNu7MT0UDe2Jz018fFc7e0HVZvZYTA6jt8gJBKwCmqd/
 OgFPMAwzCMmhAN0BMMRhei5JK5WBibxnRVJcAEQUEStj9wP5hwWVvHLNHyVpQvZfaC/8dWZBQtn
 zmtaN+U9IM6vKJGcwlagZLSUw66zRwLh2m+JGoab8bZzlOQ14Obp0WgsNouRNXtU9sKOglP/YrK
 Me7qo1tycDwv/7E4OHa3sRgrA68d2lbHXQc4FGvocItlGvWTu/gKzaXMeN7j0BXnWRU1GukWcOQ
 l5QHEjIyw1Vub0gO20KmikggPtrV01IS1/6oWur1TIG6J1cQDwQrWO3sOTlviVTRx7y/vrfwuuN
 w54+Az1E3GuM7qxNAvOY+CEG5RIzkNT/aVfRMbCZt4GBPLFctNStFxyP1qSRnD/nA+4AT9Nqy9Z
 D+nsGkQaCaMla6U9FWlPBqK6HaD1qzIz3Wd/OF8PYatfVDMZSP1QMZGFmYK2BV1r7DZV431BQET
 XmFwOSmhvwY44mJFyA9kdRO+00I/Vd3zISVSx8V6tEaHfIjeqV0ByI9r73KKQY17jhlYWNl1C6W qg3wA9+J6hsAWEg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Stubs in the header file for !CONFIG_STM32_FIREWALL case should be both
static and inline, because they do not come with earlier declaration and
should be inlined in every unit including the header.

Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: <stable@vger.kernel.org>
Fixes: 5c9668cfc6d7 ("firewall: introduce stm32_firewall framework")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/linux/bus/stm32_firewall_device.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/bus/stm32_firewall_device.h b/include/linux/bus/stm32_firewall_device.h
index 5178b72bc920..eaa7a3f54450 100644
--- a/include/linux/bus/stm32_firewall_device.h
+++ b/include/linux/bus/stm32_firewall_device.h
@@ -114,27 +114,30 @@ void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 su
 
 #else /* CONFIG_STM32_FIREWALL */
 
-int stm32_firewall_get_firewall(struct device_node *np, struct stm32_firewall *firewall,
-				unsigned int nb_firewall)
+static inline int stm32_firewall_get_firewall(struct device_node *np,
+					      struct stm32_firewall *firewall,
+					      unsigned int nb_firewall)
 {
 	return -ENODEV;
 }
 
-int stm32_firewall_grant_access(struct stm32_firewall *firewall)
+static inline int stm32_firewall_grant_access(struct stm32_firewall *firewall)
 {
 	return -ENODEV;
 }
 
-void stm32_firewall_release_access(struct stm32_firewall *firewall)
+static inline void stm32_firewall_release_access(struct stm32_firewall *firewall)
 {
 }
 
-int stm32_firewall_grant_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id)
+static inline int stm32_firewall_grant_access_by_id(struct stm32_firewall *firewall,
+						    u32 subsystem_id)
 {
 	return -ENODEV;
 }
 
-void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id)
+static inline void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall,
+						       u32 subsystem_id)
 {
 }
 
-- 
2.45.2


