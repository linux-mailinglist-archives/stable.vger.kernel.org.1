Return-Path: <stable+bounces-5890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CD880D7AA
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6BE1F21A7D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BC751C3C;
	Mon, 11 Dec 2023 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f0a0Fk1g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358F20DDE;
	Mon, 11 Dec 2023 18:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFF3C433C7;
	Mon, 11 Dec 2023 18:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319941;
	bh=xqoExGDU0jUFj2BnuTyNudTKONhvR34DwfrapDVuk0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0a0Fk1gVD50k0fATSAIDDY6jgf6tfrFxnMnqpcYROhIK/69pY897QpggFvzwHLPq
	 u1O98optsklfcyJH9Ik83qRwL0cFis8FXLoVWXW/4QEUoTjJiQIR6W1Taz/ESKVdo0
	 tHi4D3SZfotmAwBkxP5a96aZlILrUXQn4QZdP9Jo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Kunwu Chan <chentao@kylinos.cn>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 44/97] ARM: imx: Check return value of devm_kasprintf in imx_mmdc_perf_init
Date: Mon, 11 Dec 2023 19:21:47 +0100
Message-ID: <20231211182021.613517139@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
References: <20231211182019.802717483@linuxfoundation.org>
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

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 1c2b1049af3f86545fcc5fae0fc725fb64b3a09e ]

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Release the id allocated in 'mmdc_pmu_init' when 'devm_kasprintf'
return NULL

Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Fixes: e76bdfd7403a ("ARM: imx: Added perf functionality to mmdc driver")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-imx/mmdc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index b9efe9da06e0b..3d76e8c28c51d 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -502,6 +502,10 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
 	name = devm_kasprintf(&pdev->dev,
 				GFP_KERNEL, "mmdc%d", ret);
+	if (!name) {
+		ret = -ENOMEM;
+		goto pmu_release_id;
+	}
 
 	pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
 	pmu_mmdc->devtype_data = (struct fsl_mmdc_devtype_data *)of_id->data;
@@ -524,9 +528,10 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
 pmu_register_err:
 	pr_warn("MMDC Perf PMU failed (%d), disabled\n", ret);
-	ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
 	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	hrtimer_cancel(&pmu_mmdc->hrtimer);
+pmu_release_id:
+	ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
 pmu_free:
 	kfree(pmu_mmdc);
 	return ret;
-- 
2.42.0




