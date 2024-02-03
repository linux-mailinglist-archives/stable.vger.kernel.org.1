Return-Path: <stable+bounces-18614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C284836B
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B94282D29
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF2728DC4;
	Sat,  3 Feb 2024 04:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yoC0QSXA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15F17541;
	Sat,  3 Feb 2024 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933928; cv=none; b=by3AZYQ7GHz+jROfOjMjDNEjEZNZJr9XYlbhQ/RbDTRCB8h6SBF6bSMbGzzpzS+iuuCueq1rLPeYrFRN4gl4jc4XTyrH2jqk7HTc3KIJxlEcoRd4uRT2Rw3bOLSLa7QzARuP0YZt5N07VzMO0TwVf1Xfat1hXGpI7iJgVFY+Awg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933928; c=relaxed/simple;
	bh=fhsSiXb4GDcRfq9JPEmIE5Q3OdpEX/Rb7ViId2bUqqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VR5V4KYMviMTwRZ+Re/0jk8nNNIoWcFuDSa4/BdY2RgB/Xhh2KwpxLkrrvGNtP4Vq6nGl2S6nQMvnU5XsjhB4/iA4bVBWhbOjZ3iw6y8Y7GpoeDj3a6oRoM4dkegqAD2Rw+7cRRF+T/peeRUNMAtu3lA1nEq5Jvn5j5qt6lBXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yoC0QSXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF0CC433C7;
	Sat,  3 Feb 2024 04:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933928;
	bh=fhsSiXb4GDcRfq9JPEmIE5Q3OdpEX/Rb7ViId2bUqqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yoC0QSXAKNZBgIsstRBFfaWR2e4QC6AhIC73Z7DMBgZjo3gACkRYm5Znu4LqWjn30
	 T9wBagsp2hJQBFhXmClN6tlhwi844XbHIfsKmsyAy+Ph938+3hixTtpmwaJ9i191dM
	 H4pQzcCfWLNp7grRqcc5kG0GPER2jgI6yylQ07jI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fei Shao <fshao@chromium.org>,
	Yu-Che Cheng <giver@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 261/353] spmi: mediatek: Fix UAF on device remove
Date: Fri,  2 Feb 2024 20:06:19 -0800
Message-ID: <20240203035412.003228706@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu-Che Cheng <giver@chromium.org>

[ Upstream commit e821d50ab5b956ed0effa49faaf29912fd4106d9 ]

The pmif driver data that contains the clocks is allocated along with
spmi_controller.
On device remove, spmi_controller will be freed first, and then devres
, including the clocks, will be cleanup.
This leads to UAF because putting the clocks will access the clocks in
the pmif driver data, which is already freed along with spmi_controller.

This can be reproduced by enabling DEBUG_TEST_DRIVER_REMOVE and
building the kernel with KASAN.

Fix the UAF issue by using unmanaged clk_bulk_get() and putting the
clocks before freeing spmi_controller.

Reported-by: Fei Shao <fshao@chromium.org>
Signed-off-by: Yu-Che Cheng <giver@chromium.org>
Link: https://lore.kernel.org/r/20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid
Tested-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20231206231733.4031901-3-sboyd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spmi/spmi-mtk-pmif.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index 54c35f5535cb..1261f381cae6 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -475,7 +475,7 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	for (i = 0; i < arb->nclks; i++)
 		arb->clks[i].id = pmif_clock_names[i];
 
-	err = devm_clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
+	err = clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to get clocks: %d\n", err);
 		goto err_put_ctrl;
@@ -484,7 +484,7 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	err = clk_bulk_prepare_enable(arb->nclks, arb->clks);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to enable clocks: %d\n", err);
-		goto err_put_ctrl;
+		goto err_put_clks;
 	}
 
 	ctrl->cmd = pmif_arb_cmd;
@@ -510,6 +510,8 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 
 err_domain_remove:
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
+err_put_clks:
+	clk_bulk_put(arb->nclks, arb->clks);
 err_put_ctrl:
 	spmi_controller_put(ctrl);
 	return err;
@@ -521,6 +523,7 @@ static void mtk_spmi_remove(struct platform_device *pdev)
 	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
 
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
+	clk_bulk_put(arb->nclks, arb->clks);
 	spmi_controller_remove(ctrl);
 	spmi_controller_put(ctrl);
 }
-- 
2.43.0




