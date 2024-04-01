Return-Path: <stable+bounces-34846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA4894125
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005171C21097
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C074481BF;
	Mon,  1 Apr 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="elDVaHfX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F3481B3;
	Mon,  1 Apr 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989494; cv=none; b=rOXYEVbCiWlMY/aGQsBx1C7FuVV+OMxYpKLohCE7PjHVcW08EyBJZeNCZ7DjwBCrF9hzfozdSRx6qjg559WszapvRh808q2DBCHl/2KBwLDVWgm+1iUaXdj7idO79XwuHYTuMhB3j7FKbNeMqT2YUkDm/X0et94yNFE2dlrBLQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989494; c=relaxed/simple;
	bh=0O+6KWEmbo9g1Fe3j1+aV86ByxohDXwN2m3/1yKi1jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyK4lwcSJz5EQqurj9Re9XmQjwkxeEWO8dkfXW4mCs1Tg0NEOgqwaHv0S3cH5L+Z+7kP2eDDqpzQshwmPO99PfpoPiRuz/y3IK9NlwANvdoqW5QlfS+rHhqbyRV2OqZwfmnp512g/Qtg3vfxQfxzdkSymcCqREiO8B/SWliD5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=elDVaHfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AE9C433F1;
	Mon,  1 Apr 2024 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989493;
	bh=0O+6KWEmbo9g1Fe3j1+aV86ByxohDXwN2m3/1yKi1jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=elDVaHfXAIAsnlMwvYRsJ27lUcpOYIPxcG1xYSkZUYps8K1AfeoKUSBRmoSvSaqWL
	 yM6bjT8BB0mMofeUYmtQXdXi0HOQr/zJc6xX729GF3e0Qo86QngPS0eZqswvl/cg+V
	 Y4RH0mS+NngSVSsTICZyHOEDMLSpRoAwIlEu19as=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabor Juhos <j4g8y7@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 066/396] clk: qcom: gcc-ipq5018: fix terminating of frequency table arrays
Date: Mon,  1 Apr 2024 17:41:55 +0200
Message-ID: <20240401152549.891306173@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

From: Gabor Juhos <j4g8y7@gmail.com>

[ Upstream commit 90ad946fff70f312b8d23226afc38c13ddd88c4b ]

The frequency table arrays are supposed to be terminated with an
empty element. Add such entry to the end of the arrays where it
is missing in order to avoid possible out-of-bound access when
the table is traversed by functions like qcom_find_freq() or
qcom_find_freq_floor().

Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240229-freq-table-terminator-v1-1-074334f0905c@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-ipq5018.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index cc2331d729fb6..3136ba1c2a59c 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -856,6 +856,7 @@ static struct clk_rcg2 lpass_sway_clk_src = {
 
 static const struct freq_tbl ftbl_pcie0_aux_clk_src[] = {
 	F(2000000, P_XO, 12, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 pcie0_aux_clk_src = {
@@ -1098,6 +1099,7 @@ static const struct freq_tbl ftbl_qpic_io_macro_clk_src[] = {
 	F(100000000, P_GPLL0, 8, 0, 0),
 	F(200000000, P_GPLL0, 4, 0, 0),
 	F(320000000, P_GPLL0, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 qpic_io_macro_clk_src = {
@@ -1193,6 +1195,7 @@ static struct clk_rcg2 ubi0_axi_clk_src = {
 static const struct freq_tbl ftbl_ubi0_core_clk_src[] = {
 	F(850000000, P_UBI32_PLL, 1, 0, 0),
 	F(1000000000, P_UBI32_PLL, 1, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ubi0_core_clk_src = {
-- 
2.43.0




