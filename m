Return-Path: <stable+bounces-14957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EF9838359
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FBC1C29B3E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E556168F;
	Tue, 23 Jan 2024 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AGb0Q23y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F1861673;
	Tue, 23 Jan 2024 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974942; cv=none; b=rW7DvoXuTiWro7qLe2Bifmebe92Kq2uhsbNDNLbuPujxCW7d21gL/dbzdSBfdU0ObgKY854epSJhvyeP3R8XRim5rA1f5MvP3JjNN0bCN6H0e9tTRtokrr07bmBY+nFL6xnZIsbAuwOVLlT9x8KqQWv5QizBOE5xV+4PElGIToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974942; c=relaxed/simple;
	bh=tmzyn4fPMzw/RbEnmLBGbWlAZ/I3BfbtEk0aAqrJipk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRH1BHcXrwSHjsvx4SrWVaIZgKpHCcIB6SBA2T5nOjTEBTLNb0kD+terbmOK5YBsCUA8DtMg7kYBKx7mywet9YNZbc2NBtlAytKSeXziwsYBrcwjCpaL4dm2CVGrARxya6yD1WtnblbrdjNDlfUtbmg0JsfjAsOudhXk3X6+DVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AGb0Q23y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC364C43399;
	Tue, 23 Jan 2024 01:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974941;
	bh=tmzyn4fPMzw/RbEnmLBGbWlAZ/I3BfbtEk0aAqrJipk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGb0Q23yLE08gy350aj8VE49NXNCNPglNVp3yOUzW6Bxh+Er+QB2fbxvsZ3gt8zch
	 cSSpCUfEupWr9PuCUGugzG58ZCNMacktY5QhkpX4nHsf5YMMFOKAX16KM178W7APhI
	 j7kalUCFhnjvLmmmroqOBpsqPz9TCa0TCcxgFsxQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 130/583] arm64: dts: qcom: sc7280: Fix up GPU SIDs
Date: Mon, 22 Jan 2024 15:53:01 -0800
Message-ID: <20240122235816.111631467@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 94085049fdad7a36fe14dd55e72e712fe55d6bca ]

GPU_SMMU SID 1 is meant for Adreno LPAC (Low Priority Async Compute).
On platforms that support it (in firmware), it is necessary to
describe that link, or Adreno register access will hang the board.

The current settings are functionally identical, *but* due to what is
likely hardcoded security policies, the secure firmware rejects them,
resulting in the board hanging. To avoid that, alter the settings such
that SID 0 and 1 are described separately.

Fixes: 96c471970b7b ("arm64: dts: qcom: sc7280: Add gpu support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230926-topic-a643-v2-2-06fa3d899c0a@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 95c35892fb85..4903d17c4207 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2558,7 +2558,8 @@ gpu: gpu@3d00000 {
 				    "cx_mem",
 				    "cx_dbgc";
 			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
-			iommus = <&adreno_smmu 0 0x401>;
+			iommus = <&adreno_smmu 0 0x400>,
+				 <&adreno_smmu 1 0x400>;
 			operating-points-v2 = <&gpu_opp_table>;
 			qcom,gmu = <&gmu>;
 			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
-- 
2.43.0




