Return-Path: <stable+bounces-191774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15870C2301D
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 03:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37913B35B4
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 02:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450A7284890;
	Fri, 31 Oct 2025 02:28:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816DD27FB1B
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 02:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877714; cv=none; b=GqwDiZcR1Qu9flpHebxKH7CSYcPXmoTe11qTYcu3ohD8wxMHrAvUk+fMMkqyo/xx++nuHj3z+6p4x7yf5IN0gLuolFeqgYq1Z5iY8nOckMV4hz1HvNYUN7QGi6bQrua3DmW3hEJQ4WGzxFIY9tIdE087TqaSDHOzvNG2FZF9liM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877714; c=relaxed/simple;
	bh=saSevqQqF0NKsGN4g+J82OxGRpjZfSGnHrYhDSzT1Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ck0ATdPGa+l5PRQTikr7At86iNME7cLjIRUcFWi1fPp/NNz4Zd6m1jkIds9L58QoXrR+XmTcmj+EXtbJ3jtfxcI6eUJ7AMfqOmm8KlV6fHuoD12/i5cs/9Zk/ELYj2FfqdEnjzm26cgnfhyCuX4tNddCPTITVWmwc4oENuJiEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=permerror (bad message/signature format); arc=none smtp.client-ip=95.215.58.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alexey@web.codeaurora.org, Minnekhanov@web.codeaurora.org
Date: Fri, 31 Oct 2025 05:27:43 +0300
Subject: [PATCH 1/3] dt-bindings: clock: mmcc-sdm660: Add missing MDSS
 reset
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-sdm660-mdss-reset-v1-1-14cb4e6836f2@postmarketos.org>
References: <20251031-sdm660-mdss-reset-v1-0-14cb4e6836f2@postmarketos.org>
In-Reply-To: <20251031-sdm660-mdss-reset-v1-0-14cb4e6836f2@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>
X-Migadu-Flow: FLOW_OUT

From: Alexey Minnekhanov <alexeymin@postmarketos.org>

Add definition for display subsystem reset control.

Cc: <stable@vger.kernel.org> # 6.17
Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
---
 include/dt-bindings/clock/qcom,mmcc-sdm660.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,mmcc-sdm660.h b/include/dt-bindings/clock/qcom,mmcc-sdm660.h
index f9dbc21cb5c7..ee2a89dae72d 100644
--- a/include/dt-bindings/clock/qcom,mmcc-sdm660.h
+++ b/include/dt-bindings/clock/qcom,mmcc-sdm660.h
@@ -157,6 +157,7 @@
 #define BIMC_SMMU_GDSC							7
 
 #define CAMSS_MICRO_BCR				 0
+#define MDSS_BCR				1
 
 #endif
 

-- 
2.51.0


