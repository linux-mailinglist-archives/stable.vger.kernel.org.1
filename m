Return-Path: <stable+bounces-80843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC0B990BC0
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F036F1C22164
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A661E9099;
	Fri,  4 Oct 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaykCRr4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BBE1E908D;
	Fri,  4 Oct 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066030; cv=none; b=WV33tin5O/JiWy7gqnO9/xe4lrP+MspfFC1bjN0nyhRlHCagrBzIdgb0wp7706tdt9aSpO4TBROiW3XdyfpOdOPsg8bmpXvf/eDRGCJEWF7QVl+X3ywH/+rAeas+cNaWsc4Mi1l6v9pj6VzAhyXjaVGuwNQEcx6TdUlH4fB0KlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066030; c=relaxed/simple;
	bh=I43N8VamydTRQfZg02WHwUJugou2zgn+e1JtOSyuupA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+WQLcYwTuCQ5l5NyTVcdJNj04LRqulmu1ZzcifSfT1DFMw02vL/6JThiRHbCDUAiiwuTdlXlb4Q1EapJ80nphNcoXda/edJJRfXuc/WdBcDYNqqaq5fpMoOAe2rVCmNEgbkzFhy5xXGUkOrgo5ecYwCHwoYHK55Vx60AwJgdgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaykCRr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEF3C4CECC;
	Fri,  4 Oct 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066030;
	bh=I43N8VamydTRQfZg02WHwUJugou2zgn+e1JtOSyuupA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kaykCRr4Byjr0FUxLfYf1OhCckZ08VlLOif6wVi28/XaOmNqitoKLifB7+d4PecB9
	 B0tK0imD3BbuCw5Rjn6PJEtjePyrkiv9xgz+eanK1X9o62cC37x9fB/St66uUkh67e
	 AYZgHVV+qDub8brSzElBovGPVY6iVTEf0ggiRGopnWBLTgfUfG1PcCmkmPYWjvGIXk
	 66H0jiMf4vDKXUvrNBNCGk9hnc2D2GxkfBoHXvlefi+FLkY8avLTdL62v3bwox3+IX
	 SmSJg/PJZwSvqjRDU1IbFYGPMQs2WLe8qPPrDqqGPk83nnf5+dmaaUmeZbMMd+5yz4
	 i47tcqxZAUD4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Riyan Dhiman <riyandhiman14@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	calvncce@gmail.com,
	straube.linux@gmail.com,
	soumya.negi97@gmail.com,
	linux-staging@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 63/76] staging: vme_user: added bound check to geoid
Date: Fri,  4 Oct 2024 14:17:20 -0400
Message-ID: <20241004181828.3669209-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Riyan Dhiman <riyandhiman14@gmail.com>

[ Upstream commit a8a8b54350229f59c8ba6496fb5689a1632a59be ]

The geoid is a module parameter that allows users to hardcode the slot number.
A bound check for geoid was added in the probe function because only values
between 0 and less than VME_MAX_SLOT are valid.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/20240827125604.42771-2-riyandhiman14@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/vme_user/vme_fake.c   | 6 ++++++
 drivers/staging/vme_user/vme_tsi148.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 7f84d1c86f291..c4fb2b65154c7 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1059,6 +1059,12 @@ static int __init fake_init(void)
 	struct vme_slave_resource *slave_image;
 	struct vme_lm_resource *lm;
 
+	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+		pr_err("VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* We need a fake parent device */
 	vme_root = root_device_register("vme");
 	if (IS_ERR(vme_root))
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 2ec9c29044041..e40ca4870d704 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2253,6 +2253,12 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct vme_dma_resource *dma_ctrlr;
 	struct vme_lm_resource *lm;
 
+	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+		dev_err(&pdev->dev, "VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* If we want to support more than one of each bridge, we need to
 	 * dynamically generate this so we get one per device
 	 */
-- 
2.43.0


