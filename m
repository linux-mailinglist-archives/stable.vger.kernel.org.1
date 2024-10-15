Return-Path: <stable+bounces-86231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DCB99ECAA
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C77D1B20D73
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3126F1E6339;
	Tue, 15 Oct 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oY4aM58z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E3E229100;
	Tue, 15 Oct 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998213; cv=none; b=L2Xv7ebimUQWql1LvjTN01KJjGxIbSnX0mr7kUQ6Y7TwJ06kGE+JZF48MoYzfzjANx+8GKbuRNFfo/LPCUzPhf4Ax7hhqH+oV6kfrazZbt10haQ3SEAQTm6Wx7NU3XsUA5t95Iq+tq6yk/2F+ajoFobESIJyDXwuc5k3xBraubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998213; c=relaxed/simple;
	bh=ucjIxcxGVTLwvQjGCakOob5ycgIjr66o3amDV5TXrdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1cpqMtqwp+tM7IvDV6VoAlUaAXTYIYwE7okyHSIq/oAcWTY0F3EB7j7nG8GEMo92J4VT0Nq1bBt/3H8Jx2BNgzVyFIOL4zM/BDL6R7zJsUOA5bChpn8x+c8rKPknPQzotdOv+KI6J9V8SHi8q090tTL3RRDE/6+dplPDag6a8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oY4aM58z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695FDC4CEC6;
	Tue, 15 Oct 2024 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728998212;
	bh=ucjIxcxGVTLwvQjGCakOob5ycgIjr66o3amDV5TXrdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oY4aM58z2TBA09YsBTr3XIyTx5MXSalV9ZLwgqVaiun3Lg4w4DTs9NE+U5zIGopf4
	 65t5tjF6y3N+Ho24Yk4hwFWf+QQ/j1vx5Cq13536gW8xgBZBqDVJlc8GubQbxKdTu+
	 JKOKm1no061XXq3Cf/Y/9+gWpRuAIQ0DZvMjIA3s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 5.10 404/518] clk: qcom: gcc-sm8250: Do not turn off PCIe GDSCs during gdsc_disable()
Date: Tue, 15 Oct 2024 14:45:08 +0200
Message-ID: <20241015123932.567520842@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

commit ade508b545c969c72cd68479f275a5dd640fd8b9 upstream.

With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
can happen during scenarios such as system suspend and breaks the resume
of PCIe controllers from suspend.

So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
during gdsc_disable() and allow the hardware to transition the GDSCs to
retention when the parent domain enters low power state during system
suspend.

Cc: stable@vger.kernel.org # 5.7
Fixes: 3e5770921a88 ("clk: qcom: gcc: Add global clock controller driver for SM8250")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20240719134238.312191-1-manivannan.sadhasivam@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/gcc-sm8250.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -3229,7 +3229,7 @@ static struct gdsc pcie_0_gdsc = {
 	.pd = {
 		.name = "pcie_0_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc pcie_1_gdsc = {
@@ -3237,7 +3237,7 @@ static struct gdsc pcie_1_gdsc = {
 	.pd = {
 		.name = "pcie_1_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc pcie_2_gdsc = {
@@ -3245,7 +3245,7 @@ static struct gdsc pcie_2_gdsc = {
 	.pd = {
 		.name = "pcie_2_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc ufs_card_gdsc = {



