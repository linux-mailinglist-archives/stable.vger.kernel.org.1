Return-Path: <stable+bounces-14996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E81838453
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD01BB2AA0A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AB762A17;
	Tue, 23 Jan 2024 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AfAZHUTq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D362A0E;
	Tue, 23 Jan 2024 01:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974982; cv=none; b=qT1onfZKUN7oFKh0rzzQc9v8jD8G4DgCtZodiZp2Fwlvwzd09fAyUux4N9rYMu0vP/bPfdm7HNbywcCTzYyMIAoOnyRIh6uWNvy3HAgFpodMcLKkNhk8XijQyd+M3SlY+XnW/RpQM+jd3w1thFs5R3I8gd98jecMx2Hq14i4CrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974982; c=relaxed/simple;
	bh=1USQWhog3FzJ9o9Z7jdOwAg1PUsfHAAGIaDQMuSReug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkrYL1baQC3kgmbW0fwyND1tIyUtmWdjpRMUs0Nmc1h7rUjwyPIBVGjigPqXsDdFlBpK8WGc1KFod1Fpc1BsULsUSOZ3fYyJJgkecqk4c1QoIbodLw0y4rtyMhQkhyQqGp3uVqV0qn0kyB/L38umMQsrS7aTE684jL6+wrTVITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AfAZHUTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8560C43390;
	Tue, 23 Jan 2024 01:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974981;
	bh=1USQWhog3FzJ9o9Z7jdOwAg1PUsfHAAGIaDQMuSReug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AfAZHUTqBpjhvyhKtWRL1L/GxV4VAdefpe2lOaVHFW8qp1o7s5NLLpeVyWVWNrbLS
	 ekwT/bIcDPYyGMlftQdrlIm5x1iffKV5rF4IM3QdhRAnPYqVF4hsLz5PG9FpfniVDO
	 P3l9m5hCuhubdQ8eTLmCT3ygmMKDv6IJt8UsFWcQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 179/583] soc: qcom: llcc: Fix LLCC_TRP_ATTR2_CFGn offset
Date: Mon, 22 Jan 2024 15:53:50 -0800
Message-ID: <20240122235817.491025365@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 110cb8d861cc1a040cdab495b22ac436c49d1454 ]

According to documentation, it has increments of 4, not 8.

Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
Reported-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Reviewed-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20231012160509.184891-1-abel.vesa@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/llcc-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 309c12f2d3bb..e877aace1155 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -46,7 +46,7 @@
 #define LLCC_TRP_STATUSn(n)           (4 + n * SZ_4K)
 #define LLCC_TRP_ATTR0_CFGn(n)        (0x21000 + SZ_8 * n)
 #define LLCC_TRP_ATTR1_CFGn(n)        (0x21004 + SZ_8 * n)
-#define LLCC_TRP_ATTR2_CFGn(n)        (0x21100 + SZ_8 * n)
+#define LLCC_TRP_ATTR2_CFGn(n)        (0x21100 + SZ_4 * n)
 
 #define LLCC_TRP_SCID_DIS_CAP_ALLOC   0x21f00
 #define LLCC_TRP_PCB_ACT              0x21f04
-- 
2.43.0




