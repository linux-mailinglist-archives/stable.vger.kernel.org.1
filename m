Return-Path: <stable+bounces-31407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5F9889DD1
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 12:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F0EB44E12
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 11:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A04125406D;
	Mon, 25 Mar 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjcdWrGz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2A20124D;
	Sun, 24 Mar 2024 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321402; cv=none; b=AYhMEroGCPCg89HcoUMgoCVDTpLjT1dC31Y2uX1ISwMenoKOjOpkkd//T/EhLWpfnE9H/yiDfw57wU96a654ro7GwyLWrP4PQGLsgHopjlwqun8yDkkkWNLhtvsuGl5Z6orEvIXSIEMMlanWfRQeRd5DsJ4E2rXFZkl7b6Zg51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321402; c=relaxed/simple;
	bh=YmNS55wE/fW15oQTBLiltnRhThre+/zmFP9G4k8G5Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQFJDa6w+KOTOa1HeYdDA6WpPrlxRYgj11czhbDyGhtIV7Z5b70ONd7zVRmh4fBm8HS+vcYSSMOMTgTYqm8tqdzi/PpgPWyv6GsQwgu/p0nsiZFVW8UIJC9uvpILaQK1ocCyQWehgngy8dG31kODe1Ipi1VhqudlCJ+EcUtYy4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjcdWrGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8679DC433F1;
	Sun, 24 Mar 2024 23:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321402;
	bh=YmNS55wE/fW15oQTBLiltnRhThre+/zmFP9G4k8G5Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BjcdWrGzMbpRO02i3kp0QBNVJIr9VYQEc5IEuWxg5eeb+/oykg3HTAW6/E0F5ZfZo
	 0Ze89e5kWTcu8JS8XLTHPHKv9R3aXK9ZUoXhfc1ExIdB3YZlqHLi+SQJECvDZMsJZp
	 E2eCnK+QDYl7P0VHCIt+N03eI7/3Uac3Jecb6Nx7jFLe440SugUgmFAA3sOd5Sz20m
	 BT1FcOhvRSJTCSjCjK/bKo8USJJeB8LSDvz0rXTDIBdeQ+hwYVC0vjLSWyZxnbV5c/
	 yM3GzOkDSfbjNisFGRS4eh/15Lcz2PU2VrKHpZNlKdBSKFXhKGs0dWVSMmJdNmQFyN
	 cxN/++QKEVd9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 126/638] arm64: dts: qcom: sc8180x: Fix up big CPU idle state entry latency
Date: Sun, 24 Mar 2024 18:52:43 -0400
Message-ID: <20240324230116.1348576-127-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 266a3a92044b89c392b3e9cfcc328d4167c18294 ]

The entry latency was oddly low.. Turns out somebody forgot about a
second '1'! Fix it.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231230-topic-8180_more_fixes-v1-3-93b5c107ed43@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 97a75678a5169..c8001ccc2b7b1 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -289,7 +289,7 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
 			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <241>;
+				entry-latency-us = <2411>;
 				exit-latency-us = <1461>;
 				min-residency-us = <4488>;
 				local-timer-stop;
-- 
2.43.0


