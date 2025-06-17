Return-Path: <stable+bounces-153068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5E7ADD226
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3968317CA3C
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4E2ECD3D;
	Tue, 17 Jun 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GDXjuFyW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D42ECEB1;
	Tue, 17 Jun 2025 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174763; cv=none; b=I79Pz4GIObR36ve3cPbQDAIe3keCO5W0RyVeW6UNHQdyC45T/QPldGKcDdgPUsRbiRwsnatNVs6dGgkkwSHoFW9bqZjgaunW2WF+H6U+cA7w2DlDyFgS/mK1aDouI0bBa8+66QXX9afOIrYeCRYxyB1SHQ3UuPaY0ahRAC2tlso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174763; c=relaxed/simple;
	bh=7Sr8tbk3122XzySa+KuiqWsMvtVLkdqnrzxdltmg7YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2XoLydfpKWjlZKPL0wmV33BZ7G4/oOvChX2wA72cgRjjTkL0hIAxgspzWfsRH5+SMpX13tK3accXT0dCuI3imfzVRXMdT8cFYcy03G/q3BMxnyOe6qEQplxKU+1RuturnZfROk5vLXYDyWipnTe2lDSodbfSy+Kclb8O7ocJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GDXjuFyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5114CC4CEF1;
	Tue, 17 Jun 2025 15:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174762;
	bh=7Sr8tbk3122XzySa+KuiqWsMvtVLkdqnrzxdltmg7YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GDXjuFyWNnO918L9mTjrEvcKUYDxaEY6JUCzZKIDEzs0Q0KVbBII2gzY3IiezUomn
	 AEnPoD6H8JNiR8KqIIuFExh2qOaX2otswM7YbUvl/k01EjoLIPA4ci6rBWEcin/Ugz
	 PWwY7NgLekY5m4j1+Pw/p6kfMNn20ZNVk2ETR2eI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Weiss <luca.weiss@fairphone.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 111/356] clk: qcom: camcc-sm6350: Add *_wait_val values for GDSCs
Date: Tue, 17 Jun 2025 17:23:46 +0200
Message-ID: <20250617152342.688749862@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Weiss <luca.weiss@fairphone.com>

[ Upstream commit e7b1c13280ad866f3b935f6c658713c41db61635 ]

Compared to the msm-4.19 driver the mainline GDSC driver always sets the
bits for en_rest, en_few & clk_dis, and if those values are not set
per-GDSC in the respective driver then the default value from the GDSC
driver is used. The downstream driver only conditionally sets
clk_dis_wait_val if qcom,clk-dis-wait-val is given in devicetree.

Correct this situation by explicitly setting those values. For all GDSCs
the reset value of those bits are used.

Fixes: 80f5451d9a7c ("clk: qcom: Add camera clock controller driver for SM6350")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Taniya Das <quic_tdas@quicinc.com>
Link: https://lore.kernel.org/r/20250425-sm6350-gdsc-val-v1-1-1f252d9c5e4e@fairphone.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/camcc-sm6350.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/qcom/camcc-sm6350.c b/drivers/clk/qcom/camcc-sm6350.c
index acba9f99d960c..eca36bd3ba5c9 100644
--- a/drivers/clk/qcom/camcc-sm6350.c
+++ b/drivers/clk/qcom/camcc-sm6350.c
@@ -1694,6 +1694,9 @@ static struct clk_branch camcc_sys_tmr_clk = {
 
 static struct gdsc bps_gdsc = {
 	.gdscr = 0x6004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "bps_gdsc",
 	},
@@ -1703,6 +1706,9 @@ static struct gdsc bps_gdsc = {
 
 static struct gdsc ipe_0_gdsc = {
 	.gdscr = 0x7004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "ipe_0_gdsc",
 	},
@@ -1712,6 +1718,9 @@ static struct gdsc ipe_0_gdsc = {
 
 static struct gdsc ife_0_gdsc = {
 	.gdscr = 0x9004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "ife_0_gdsc",
 	},
@@ -1720,6 +1729,9 @@ static struct gdsc ife_0_gdsc = {
 
 static struct gdsc ife_1_gdsc = {
 	.gdscr = 0xa004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "ife_1_gdsc",
 	},
@@ -1728,6 +1740,9 @@ static struct gdsc ife_1_gdsc = {
 
 static struct gdsc ife_2_gdsc = {
 	.gdscr = 0xb004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "ife_2_gdsc",
 	},
@@ -1736,6 +1751,9 @@ static struct gdsc ife_2_gdsc = {
 
 static struct gdsc titan_top_gdsc = {
 	.gdscr = 0x14004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "titan_top_gdsc",
 	},
-- 
2.39.5




