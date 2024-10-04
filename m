Return-Path: <stable+bounces-80976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EAA990D70
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E011C22DED
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57520A5C2;
	Fri,  4 Oct 2024 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juZEAtAI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648A20ADCD;
	Fri,  4 Oct 2024 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066396; cv=none; b=CQ3lo9pshYEtdEtB7bzXVUGAK32EzuJllOPC0ldy8fBtQAWAtsXf5dIZ8osRZJUydzyyO/CI3wOXXhwyl6/Q4XtM263OUf5t3zprZ5JGC1e6cJWSz/KusjEVmG3CQo59Dh2UCGrXzXNfciFuDrSIwuw464HLB0l601Oj6wDxOZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066396; c=relaxed/simple;
	bh=pKZoZdmY2tkfYCNOS7nlPY/aa+228cmcj4WiUxlEgdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VowcUZna905mkI1MtO9kWJ9+g87Bz6zXNeUGiEdyFu/Js1+BTKilhsOc5TflH923w7lk4n+Ol/3JmEh3o6NXPSNlnBiIYBV3dRgoeWw7oGtYt+jHe+Lb7wYSO3M3SBowgFwSn/wYP25+Xz0FoRDTK6Gsndza/ctOSpxK5o6xWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juZEAtAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F906C4CEC6;
	Fri,  4 Oct 2024 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066396;
	bh=pKZoZdmY2tkfYCNOS7nlPY/aa+228cmcj4WiUxlEgdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=juZEAtAIuDqAXEeWkM7UWp04zTEGnoQ/Rr7fRWGaq35zON3Tshcn2Aaosw1j5Pdr/
	 ljXPDzq87WLk7HJLpiQmYL0pj85ZeM92N45OfX64T1Ew9v3iz3hgjXEERdZmB32yti
	 dkfIBU6uBUMzjkIsK7BxNV5R2MijB8kXi6j5Vx2SzIybURIlqJzuJTxBm6QQq1jU7n
	 3fRoAwoJllK17bb4khOhI8fyTyzAe1xk3af8STzwVV5F5eiaNYlWRQBwdJvBsn4fN8
	 s9NvY5B3hZ8DpFSxl2b6ae5eUV32lOJEty7T0A2QJC2wewIYrtX2ZWxlizPx5Cqcds
	 ScNmv6dQRuGHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Riyan Dhiman <riyandhiman14@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	calvncce@gmail.com,
	soumya.negi97@gmail.com,
	straube.linux@gmail.com,
	linux-staging@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 50/58] staging: vme_user: added bound check to geoid
Date: Fri,  4 Oct 2024 14:24:23 -0400
Message-ID: <20241004182503.3672477-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 7c53a8a7b79b8..95730d1270af8 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1064,6 +1064,12 @@ static int __init fake_init(void)
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
index 2f5eafd509340..4566e391d913f 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2252,6 +2252,12 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


