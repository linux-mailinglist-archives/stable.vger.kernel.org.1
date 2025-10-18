Return-Path: <stable+bounces-187843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69333BED1CD
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FBB3A5EB5
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0488127E05A;
	Sat, 18 Oct 2025 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBvrX660"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7550155C87
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799294; cv=none; b=BQYupgwVjM91ZbwJnP5bpRJW7B1+INZy2Wae89YZqn+TW1eishH1dgBf5Tn7E+ulEfbvrThIQlh++TS885xJsIVQ008ypKlDndfqD3HbNPgPLZPIpCtWanJ9CyHoCCsIGJCKSJS1OofqvBFTKH/YVg2xh+3uEvhM12ZmfEM+r+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799294; c=relaxed/simple;
	bh=vUsOZ5FPtzf7nVfFD4BVNHPt2emZv3bNIk4SBON/DgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2+T7H6/p6ZQBAsR+0JNzFuvd60SDii4I0mMTb1tV+I/xXEQ0mJDleOG4R1MmOpxfkyHY+NcjJTm9ptZ53+BrE9X3AG4xqgkH2Ntr1bqvU+kYPg04py1vuG7bQQa/An508By6+Z0izsVAt/pbsXnd4jvdwk8/4PDSj2iTnxQu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBvrX660; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB13CC4CEF8;
	Sat, 18 Oct 2025 14:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760799294;
	bh=vUsOZ5FPtzf7nVfFD4BVNHPt2emZv3bNIk4SBON/DgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tBvrX660Z6TG0eNfkMKHgaUiQH+2A6IquDeCXBxgdrYtGz/mRwfw9MbXib3qlMhB/
	 7Pgmb7i89jGIzSuzD25eiwPJuwBs588JDn6CTah9rB3IDVcXGFoLojCp1gnxLVoTtn
	 ncPo3ofQwqbNSkXqHxF+efeUKQ2Hb/OOpE77UmRPpfaacCFcv5ZGzfYnkPwyLS+JH/
	 2djuazSm+U4XvRlYYiKJKJud5j4gIL/bXGlqxSaBmOxVSZjRQRojcQmhSSiIFLkkRL
	 cXG+PHwfB1O86yDDKIGUnCfxCl6i5ewvK/mR4FpZwFCLlc3g+wRz0QMZaJc8vjDd93
	 Zi3Gjsb4/tGJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adam Xue <zxue@semtech.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] bus: mhi: host: Do not use uninitialized 'dev' pointer in mhi_init_irq_setup()
Date: Sat, 18 Oct 2025 10:54:52 -0400
Message-ID: <20251018145452.792939-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101641-blooming-stiffness-1ee0@gregkh>
References: <2025101641-blooming-stiffness-1ee0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Xue <zxue@semtech.com>

[ Upstream commit d0856a6dff57f95cc5d2d74e50880f01697d0cc4 ]

In mhi_init_irq_setup, the device pointer used for dev_err() was not
initialized. Use the pointer from mhi_cntrl instead.

Fixes: b0fc0167f254 ("bus: mhi: core: Allow shared IRQ for event rings")
Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
Signed-off-by: Adam Xue <zxue@semtech.com>
[mani: reworded subject/description and CCed stable]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250905174118.38512-1-zxue@semtech.com
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/mhi/host/init.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 2cc48f96afdbc..2e7a1a3a546a8 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -147,7 +147,6 @@ void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
 int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 {
 	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	int i, ret;
 
 	/* Setup BHI_INTVEC IRQ */
@@ -163,7 +162,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 			continue;
 
 		if (mhi_event->irq >= mhi_cntrl->nr_irqs) {
-			dev_err(dev, "irq %d not available for event ring\n",
+			dev_err(mhi_cntrl->cntrl_dev, "irq %d not available for event ring\n",
 				mhi_event->irq);
 			ret = -EINVAL;
 			goto error_request;
@@ -174,7 +173,7 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 				  IRQF_SHARED | IRQF_NO_SUSPEND,
 				  "mhi", mhi_event);
 		if (ret) {
-			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
+			dev_err(mhi_cntrl->cntrl_dev, "Error requesting irq:%d for ev:%d\n",
 				mhi_cntrl->irq[mhi_event->irq], i);
 			goto error_request;
 		}
-- 
2.51.0


