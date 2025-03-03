Return-Path: <stable+bounces-120350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C2DA4E9CF
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931548C22B5
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42F124C09D;
	Tue,  4 Mar 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pN4BIftL"
X-Original-To: stable@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE824EA85
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106908; cv=pass; b=AlhQ4PA/kSA/fZHv4yUXTxartGsnfqPi27dgvZZfDGPyzK3labbbURJhqVk/pJ4kvldriKIUbW/SRvjlcYfmaicrcnBIFtiSbcXrloCpJ3steHxwarSYyvpI71OOXLq+Y/UnuH+AbY4V0Bfq3Icttl8KzXjm5bTjMospua7vxi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106908; c=relaxed/simple;
	bh=r0ACFUP8gmClzRtzoxXd/Ng22ZxFYgefb4nyAq8SEaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qlEXxNeBaC9mLRvoAp9V3PCsXxTsuymDrBSFB3cz2f37COTWzYuhB+DddqzikVDsJR8MX2yT/9P79sl6c1jFrWrUeTRyYO1l1OAeoWfDMbO6uUozGg8AT1SvWdlVmoNu9zCN54FH7PgrzFtIP6ataj2KEjgunWRx5j5rcNy7ifw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pN4BIftL; arc=none smtp.client-ip=209.85.128.42; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 3142440D1F41
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 19:48:25 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pN4BIftL
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6hRl0C4ZzG4GT
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 19:47:15 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 677AD4272D; Tue,  4 Mar 2025 19:47:08 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pN4BIftL
X-Envelope-From: <linux-kernel+bounces-541770-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pN4BIftL
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id F1BB3421D1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:11:45 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id A2EE52DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:11:45 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D957316B7FD
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615AE211A13;
	Mon,  3 Mar 2025 13:11:31 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A41210F6A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007488; cv=none; b=PnY0LUl3C9nZNvok7wlauuQqQju1ShZbSs7Vm7MuSQ4cI+i9Bg8AjQ6aEOuExYHv574CRCrFPAQaCqdBojR4nQ5E7wD04gxn7uaxZs6ZDtl49XcWK/GS765UxryCfRJkJNFapFD2n25/LVlgqiC19kqaV2xKyOXqbsT0B54+dJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007488; c=relaxed/simple;
	bh=r0ACFUP8gmClzRtzoxXd/Ng22ZxFYgefb4nyAq8SEaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z641CvWww4bhJW8lZfaZHAWqmtkSseSFfFRulOFwHHOZpbHAeZgvCYy1PnLoMoBKtK194gyBmsnOi0qFvV2Jmh3ldWQWZerzPkxR4urCzcVMteUPHsU1NklI3Ax5AZfsN4eu7QDEaA3vSCT6yHr2X6KL2QckKLtb9x4tiXqrvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pN4BIftL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43995b907cfso27797545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741007485; x=1741612285; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBkIEoZc6BXsEi/Xl/zpbl5kQzqAT2D5l+fVFL9X634=;
        b=pN4BIftLkHFRfR5AiJpuj19pHI5ut4jL33Ps2somyZnfde4kwsmxWa5EWjNccUAGsx
         Aa/vUiFbOV8VpatiTYUh6iIvB36u+gDT8D7B4CalZ9xcEcr4iBDut5N1lqsCfNCDB8Xi
         elv1Lg3eEJ9NUeVlmxFAwC7Tb1Tu9nk4GJmQb7t56JLL3/Y8EWqDzABdZ0OCDqMZn67i
         +BnauNVri/z/ZjPDFShIjaZv+2JNzM2XfKWG3u34waH04tR/tYKETBogDDYqOrLUr3e6
         xhp8k+jDkInJZbIgSm8PruesGfGGWBLDEwVJZE8ZKtaZJZxWOe459VwyTFlNbH/LdBEv
         UVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007485; x=1741612285;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBkIEoZc6BXsEi/Xl/zpbl5kQzqAT2D5l+fVFL9X634=;
        b=U1jVXd9QlT9x1gidMMalUVVJhBIXdSXPmIIpWpl8kxVVz7kZJiqpXEExVl5UXiWpg5
         3aexsi51BmUIYxaAG13R3Lu8wQOaYyuFQwD5R2UcOHm6wFqKEG52qvW0zsUypuQBlc93
         t80zK0vNVqOAuLsRIWVPSr+E/Y2uHAmvC81OorO9s0ifRGWcuHVR9nZlkO1ABIT26Y9S
         ogx/mpEAtDcZbPEaVZcjWczoeG96Mouou/b/FPLkNIThKTSiybLdP7GGNlubkaJLesxx
         sX7+h4fG+el5rCRBpV5Jo4VcdJewlOIJHUFvG6Y3Lr2+PyIJOicv1TSxUbvBY4xaDQgB
         59iA==
X-Forwarded-Encrypted: i=1; AJvYcCVOORa8azeocJHn1p0JW4BasW3/2LJHLZZ4M/G6ChqiIoka/VZAk9R2Ol6p9VRCsuJYUmGFNOd4pbUMNEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAAPZXTof8fdCtuWlqLFDZd6mqhD+A5uTlvcM6O3jhuoHsCKc
	oO/hvZ/pXxcgPg121feM7VSBVP8czpCoLc5ukr2L4GwJROrSQNLDNtv6ZkiYdrA=
X-Gm-Gg: ASbGncswNe+ynMmtU1IV6/mUxArwHC05ys/aYzIbnj/l5m2ieVlKQSxmFxS9zAoMS24
	QuBmB9aq4sWZwOmNYoBb2y4OPwxHsVa2XRV4EFFi4Pb7l0iQBGdfjsusceVA0gQW9BxgcA9k83U
	Cy262WvxcZCt2U1yVgE+v/l2ZLqEZT0aKFwTMzwAGwUZzM7zKcoPANVKpUTV+QpUGHT5Jfi/Hj8
	++eLCZMVozVos4T+q92d5FLrFX0sxyfhVU/xtyNxRuuqhqau8vInR0kc/vdZfGd8EzHrSTxEDma
	rnewmwtKOes/yXw30decpJ1tmL8RtXrB2dt+8mtrrPAowWm6FEPRU0VGl+c9RDVtPoavTTqC8Cs
	=
X-Google-Smtp-Source: AGHT+IFogfy4vTLX2D880m2Emlv1b0QxLptjPdeT4ir4OaH0lDrtdJ8Ijk5zG3y61SkNW3iZImJ9Gw==
X-Received: by 2002:a5d:5f96:0:b0:38d:e3e2:27e5 with SMTP id ffacd0b85a97d-390ec7ca98fmr10768345f8f.5.1741007484699;
        Mon, 03 Mar 2025 05:11:24 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([209.198.129.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73703caesm158307785e9.12.2025.03.03.05.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:11:24 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 03 Mar 2025 13:11:21 +0000
Subject: [PATCH] clk: samsung: gs101: fix synchronous external abort in
 samsung_clk_save()
Precedence: bulk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-clk-suspend-fix-v1-1-c2edaf66260f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHiqxWcC/x2MSQqAMAwAvyI5G+iCWvyKeJA2alCqNCiC9O8Wj
 zMw84JQYhLoqxcS3Sx8xAK6rsCvU1wIORQGo0yjrLLo9w3lkpNiwJkfdNo3obXOdGShVGeiov/
 jMOb8AUPfVtthAAAA
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1935;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=r0ACFUP8gmClzRtzoxXd/Ng22ZxFYgefb4nyAq8SEaU=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBnxap7U2WN1YaRHw7W9uRbiu+2fenuf1A5eZ5Xs
 bFL73mvclGJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ8WqewAKCRDO6LjWAjRy
 urfgD/9/FuIh/ujTyKiv8Fzda0+kpo71fe+GrwZib/NQ3obhlvSc2WG2XGPhRQqKlMOt+DkEN5R
 pkLY3fshHXDFGhS39zEkhSA7qIaltThWozUvf38use4WQqs4eriaJxl2vWe4+s2/uztjluGDzsO
 3h4ya7IYa8MwskiloUzzctUj72lrg1OatkYUBxed0T8dky1XnyAMxKJhvDO0b7pleAuVzbEaY6J
 HOpd+dJS0SoZXlir3FNdpL1Tj9AO40Bi+GtLOYFu2qoBsIpAvgfZgsWkKgudL4fatx1TyChxbIU
 WciyJusPm8nN9ZhblpHBPvx1TZBYKTqgSJH4l49LreqaSvPkll4IiVBtYdiTii3WKT/VYKpEQLm
 eS1C0DH11KnPbQGXvk9hqQk/Hvnrwy/8H0By6KghKQZ1/KmpHEIEK3SzD9iYzK6ipbaMi53ihFx
 MQ5YkGLXWljT8CAnz8WiWR+kP5Rc0ePEgX1/AH9j28xALgYmvS1oLEefx2divEis2r1ubctopys
 xXiMu4ffHKQX/TM6zqkIFpeoXMvS+S/DjCpYVPeixRCu43QIBUO2/cSWIH8ArxA8OLg3vIZyTEe
 n5W+B9NFHjIOfmXhKKZnbNo61bf2pAIkXP7TZPPB6X2Moqeo50SGuhjSusHrW7SMp9zX4j8mjvL
 eagVef8tl5/9+hg==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6hRl0C4ZzG4GT
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741711643.91675@qUxPhpigjtoMqRkmuXtV8g
X-ITU-MailScanner-SpamCheck: not spam

EARLY_WAKEUP_SW_TRIG_*_SET and EARLY_WAKEUP_SW_TRIG_*_CLEAR
registers are only writeable. Attempting to read these registers
during samsung_clk_save() causes a synchronous external abort.

Remove these 8 registers from cmu_top_clk_regs[] array so that
system suspend gets further.

Note: the code path can be exercised using the following command:
echo mem > /sys/power/state

Fixes: 2c597bb7d66a ("clk: samsung: clk-gs101: Add cmu_top, cmu_misc and cmu_apm support")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: stable@vger.kernel.org
---
Note: to hit this clock driver issue you also need the CPU hotplug
series otherwise system fails earlier offlining CPUs
Link: https://lore.kernel.org/linux-arm-kernel/20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-0-c72978f63713@linaro.org/T/
---
 drivers/clk/samsung/clk-gs101.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 86b39edba122..08b867ae3ed9 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -382,17 +382,9 @@ static const unsigned long cmu_top_clk_regs[] __initconst = {
 	EARLY_WAKEUP_DPU_DEST,
 	EARLY_WAKEUP_CSIS_DEST,
 	EARLY_WAKEUP_SW_TRIG_APM,
-	EARLY_WAKEUP_SW_TRIG_APM_SET,
-	EARLY_WAKEUP_SW_TRIG_APM_CLEAR,
 	EARLY_WAKEUP_SW_TRIG_CLUSTER0,
-	EARLY_WAKEUP_SW_TRIG_CLUSTER0_SET,
-	EARLY_WAKEUP_SW_TRIG_CLUSTER0_CLEAR,
 	EARLY_WAKEUP_SW_TRIG_DPU,
-	EARLY_WAKEUP_SW_TRIG_DPU_SET,
-	EARLY_WAKEUP_SW_TRIG_DPU_CLEAR,
 	EARLY_WAKEUP_SW_TRIG_CSIS,
-	EARLY_WAKEUP_SW_TRIG_CSIS_SET,
-	EARLY_WAKEUP_SW_TRIG_CSIS_CLEAR,
 	CLK_CON_MUX_MUX_CLKCMU_BO_BUS,
 	CLK_CON_MUX_MUX_CLKCMU_BUS0_BUS,
 	CLK_CON_MUX_MUX_CLKCMU_BUS1_BUS,

---
base-commit: 480112512bd6e770fa1902d01173731d02377705
change-id: 20250303-clk-suspend-fix-81c5d63827e3

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>



