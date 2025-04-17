Return-Path: <stable+bounces-134480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B15A92B51
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 21:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD44F1B66A3C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16A225742F;
	Thu, 17 Apr 2025 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mSrYUHoK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E783256C97;
	Thu, 17 Apr 2025 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916252; cv=none; b=l9TEyTD4xLbKEhzOqF3QnEtg0J5m1Yjt72zYP1NDlnx0QZPpUQRa9Ibw1ZXuTdo8EwVTP4BbVB6FhMeVxmyLUUaszYVh/fGj6dOmZML+4bgQllnr6zN2u5H19+iEa6haqD7rLQBrl8Rsp102XF0uXqz1Q/TGL/pY1ykFboBM96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916252; c=relaxed/simple;
	bh=mBMTEnBEqmRf8OcfFpm8g2B0MSoFjKtTkgWOJW2N6kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upTKvlNg+xsoVqspGR0LjPgbOL0t+V8NVM6sgehh1plWJdXQbrSYcfiR0I6sNVpLXAjRbbJFFzWMmytqn+1asKxJUGhX9MDu/PWv3pQ9kuOGHijlNM4KANK3qGJHQPSRwuK9DGsMN10OqPsj5JYUHjmb1oSpnsjRhnw1E54sgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mSrYUHoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD73C4CEE4;
	Thu, 17 Apr 2025 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744916252;
	bh=mBMTEnBEqmRf8OcfFpm8g2B0MSoFjKtTkgWOJW2N6kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSrYUHoKF4x8owVzOPs4f5nADZf/qEuhnBctnMX1CYmpHJJrZG2yKbiFSbtCiZDqK
	 +MBOAmH+hg6YRBAdHNW/n+ejS9e7kJMo9n0Jwx0yCMA5cjAnMLnoF1nTzH4A7UAMWT
	 nVOz8aJngSERdzMOpOzM6M4dejV3BYqC1CxRzBqM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.12 380/393] arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected() lists
Date: Thu, 17 Apr 2025 19:53:09 +0200
Message-ID: <20250417175122.887080855@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

commit a5951389e58d2e816eed3dbec5877de9327fd881 upstream.

When comparing to the ARM list [1], it appears that several ARM cores
were missing from the lists in spectre_bhb_loop_affected(). Add them.

NOTE: for some of these cores it may not matter since other ways of
clearing the BHB may be used (like the CLRBHB instruction or ECBHB),
but it still seems good to have all the info from ARM's whitepaper
included.

[1] https://developer.arm.com/Arm%20Security%20Center/Spectre-BHB

Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: James Morse <james.morse@arm.com>
Link: https://lore.kernel.org/r/20250107120555.v4.5.I4a9a527e03f663040721c5401c41de587d015c82@changeid
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/proton-pack.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -876,6 +876,14 @@ static u8 spectre_bhb_loop_affected(void
 {
 	u8 k = 0;
 
+	static const struct midr_range spectre_bhb_k132_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+	};
+	static const struct midr_range spectre_bhb_k38_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+	};
 	static const struct midr_range spectre_bhb_k32_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
@@ -889,6 +897,7 @@ static u8 spectre_bhb_loop_affected(void
 	};
 	static const struct midr_range spectre_bhb_k24_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76AE),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
 		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
@@ -904,7 +913,11 @@ static u8 spectre_bhb_loop_affected(void
 		{},
 	};
 
-	if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
+	if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k132_list))
+		k = 132;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k38_list))
+		k = 38;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
 		k = 32;
 	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
 		k = 24;



