Return-Path: <stable+bounces-81977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AEC994A69
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18E11F224EF
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8C61C9B99;
	Tue,  8 Oct 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1RsXPs+J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBD178384;
	Tue,  8 Oct 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390769; cv=none; b=XoWLUGV21SWXm0TZeZZkIKz8VgSr0qh2hrcKhSALv5sf0n3jSAiJ9DDgwtmMMTCwIlApVQpVPK5O+tLbkwMiyQA6+jMx3vlfC+LnSbPaoBEwzmBW8Iqa7QrE7xFVa/piog9MMXNy7yCULnmPlod/Zk8iRGWNi8DNlX7TBU77lGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390769; c=relaxed/simple;
	bh=Xy0qiFEwnYO8WteNHxwrUzGPvpbTYDYJfDkyxI5MHLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDfWQ/40fzCn2sDqWzXBcZz+rmKJxOQXamPRHurc/X6oXoHm6v0LAo81/vCjTv5D/zWD70ScIjvJ0uaE7koNyk7N8+Wzguzz3MqgV+LCMGrDsFRTykYXblEoP8QZnXSaHdiKntHBSg2ZzVrDGuiRlcuAJ2zFHS2o81Cy6hY07NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1RsXPs+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7317C4CEC7;
	Tue,  8 Oct 2024 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390769;
	bh=Xy0qiFEwnYO8WteNHxwrUzGPvpbTYDYJfDkyxI5MHLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1RsXPs+JmdhGHyzHuhwv21yS8rvzB2wib/i6OsVZJgc2jLvdjeus9WYfuuWYGmxdj
	 SuYFn/cqn0O4ofEWeE7+W0WMIxjap82JqJ3EgRY+uD7j5ME7D+bycryZeFAYTdEWCV
	 hy+Hj17SU99A8nVG9tB4jfMYlg27X010dnZAuA4M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.10 387/482] clk: qcom: gcc-sm8450: Do not turn off PCIe GDSCs during gdsc_disable()
Date: Tue,  8 Oct 2024 14:07:30 +0200
Message-ID: <20241008115703.643300410@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

commit 889e1332310656961855c0dcedbb4dbe78e39d22 upstream.

With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
can happen during scenarios such as system suspend and breaks the resume
of PCIe controllers from suspend.

So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
during gdsc_disable() and allow the hardware to transition the GDSCs to
retention when the parent domain enters low power state during system
suspend.

Cc: stable@vger.kernel.org # 5.17
Fixes: db0c944ee92b ("clk: qcom: Add clock driver for SM8450")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20240722105733.13040-1-manivannan.sadhasivam@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/gcc-sm8450.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -2974,7 +2974,7 @@ static struct gdsc pcie_0_gdsc = {
 	.pd = {
 		.name = "pcie_0_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc pcie_1_gdsc = {
@@ -2982,7 +2982,7 @@ static struct gdsc pcie_1_gdsc = {
 	.pd = {
 		.name = "pcie_1_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc ufs_phy_gdsc = {



