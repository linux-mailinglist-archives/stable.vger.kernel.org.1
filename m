Return-Path: <stable+bounces-167790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FBCB231CD
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296433A1D57
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C2E2FAC06;
	Tue, 12 Aug 2025 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vuEoSkHF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AC22EAB97;
	Tue, 12 Aug 2025 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021999; cv=none; b=cOvoV8SxAZJqUFFMK9kgCKB7THTvdWRu3rvJuun9W7JEDdGDUULkB/0kJrxgU/WbwcnUl22rOAJEiVQu/sNADgj8IukKkjocJV242C/k/uVOYARIdqniocWwYUP4WWs0AzBXLMMFjIU27qsAEBSASNBEX/lOTXmwvt8orBxmCAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021999; c=relaxed/simple;
	bh=rRH3NviaOZXznGqrDwscPqiWR45jdL+3mqlXtkKszWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aC3bPMSKiLlW8Z516MiE7wxLiZ0lOD3fkVgSZUBTUqy1iLyvxMNM1Av3nwcsabpNQCvSsV3GTP6as8Qx1wd/GoNreXTxWybnhaX+bgU6kD+rAydiwzyYkBqBMWvkjCGUPX6W9Lnr7AMWZDJ9jt/+tGRCPe1UKAkkl3j4dRsnfCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vuEoSkHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC7FC4CEF8;
	Tue, 12 Aug 2025 18:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021999;
	bh=rRH3NviaOZXznGqrDwscPqiWR45jdL+3mqlXtkKszWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vuEoSkHFD6iROu8bH32Ce9NOHj4w67Qe8x+TAqCoNQD925ZvN1ChFrJ0HTm4dgnX3
	 HO7DvZZDC2c0lgngygcJYhqzAPOI5TobC2qSG+sJS+6mE6RQ5TIT/ASf5+yso4xEdz
	 fOOgNDC2HvdDxxctlbOnAtSJY8fJaOevhmJOSh6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 025/369] arm64: dts: qcom: sc7180: Expand IMEM region
Date: Tue, 12 Aug 2025 19:25:22 +0200
Message-ID: <20250812173015.687379212@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[ Upstream commit 965e28cad4739b11f1bc58c0a9935e025938bb1f ]

We need more than what is currently described, expand the region to its
actual boundaries.

Fixes: ede638c42c82 ("arm64: dts: qcom: sc7180: Add IMEM and pil info regions")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250523-topic-ipa_mem_dts-v1-3-f7aa94fac1ab@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 249b257fc6a7..6ae5ca00c718 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3524,18 +3524,18 @@ spmi_bus: spmi@c440000 {
 			#interrupt-cells = <4>;
 		};
 
-		sram@146aa000 {
+		sram@14680000 {
 			compatible = "qcom,sc7180-imem", "syscon", "simple-mfd";
-			reg = <0 0x146aa000 0 0x2000>;
+			reg = <0 0x14680000 0 0x2e000>;
 
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			ranges = <0 0 0x146aa000 0x2000>;
+			ranges = <0 0 0x14680000 0x2e000>;
 
-			pil-reloc@94c {
+			pil-reloc@2a94c {
 				compatible = "qcom,pil-reloc-info";
-				reg = <0x94c 0xc8>;
+				reg = <0x2a94c 0xc8>;
 			};
 		};
 
-- 
2.39.5




