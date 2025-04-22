Return-Path: <stable+bounces-134919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E9FA95B31
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7CB169562
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A0224418F;
	Tue, 22 Apr 2025 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je8tMoBI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A132417F2;
	Tue, 22 Apr 2025 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288189; cv=none; b=Vrqyb0FoEhQRsg33cXOTauZbsB4JbJSRYyR/8LSLATtM7yxw57rYDdfsH2ldhYlFQrgXaVtsG62uxiHuL8ZbzIu/9SJUuYLfXWTzdwQie98hsONCIStRXj8H8whS+exk4zjW1bFu8EBmOkgt3bDT9qt4scBycvO4h1IbCuLqjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288189; c=relaxed/simple;
	bh=QrzVhPOEckdeVgfj7BTtvLJJYq7mpUIxJUdJU3sToRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HssHf+t16patYianl/vub9A1JADPdxJ0J4VlpeVHatI2nCqDKbatmQ4fb5JoJMCTKg1U32gRBNefUo7KrttzuzU6oGB9lxvcOQe9jNB/yioJPf71lB9BDO32QF9rmSXutljJ9zGCP/xW+nsS9/aEP1E1/QqNOct4d9SFebjZptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je8tMoBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5775AC4CEEC;
	Tue, 22 Apr 2025 02:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288188;
	bh=QrzVhPOEckdeVgfj7BTtvLJJYq7mpUIxJUdJU3sToRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Je8tMoBIRld8+lQq3a0fPculqIjuVEAi4l0l0OSaDEcxAWA7oLvQk76RDoO475SGW
	 h9GorU6lbiTeH32lULxhnLr88x4YwCbuQLtrWFIjbqMh5rCkDvA5nYPb5QQasCZI68
	 zWawcqfVcBC5axU0OfWOh+0ZQQJRyhlfUsQNyhrUXyd9/iPWglbg67fgpvHxDmyz/y
	 TYKscvfl+bQYyaPt7pCDpRde46IGlcyzEmPvTWKqqV5M5SU6mgqbi10E4sz2nk6eZD
	 zrM87+gyHHxJMgFoL+TgBgyiCMZJsfeo5upVKIb6wJmk+NO0QSoyTlO57CkRh9CApk
	 44e5xWjKBtBQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 21/30] nvmet: pci-epf: cleanup link state management
Date: Mon, 21 Apr 2025 22:15:41 -0400
Message-Id: <20250422021550.1940809-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit ad91308d3bdeb9d90ef4a400f379ce461f0fb6a7 ]

Since the link_up boolean field of struct nvmet_pci_epf_ctrl is always
set to true when nvmet_pci_epf_start_ctrl() is called, assign true to
this field in nvmet_pci_epf_start_ctrl(). Conversely, since this field
is set to false when nvmet_pci_epf_stop_ctrl() is called, set this field
to false directly inside that function.

While at it, also add information messages to notify the user of the PCI
link state changes to help troubleshoot any link stability issues
without needing to enable debug messages.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 99563648c318f..094826f81b283 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2084,11 +2084,18 @@ static int nvmet_pci_epf_create_ctrl(struct nvmet_pci_epf *nvme_epf,
 
 static void nvmet_pci_epf_start_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 {
+
+	dev_info(ctrl->dev, "PCI link up\n");
+	ctrl->link_up = true;
+
 	schedule_delayed_work(&ctrl->poll_cc, NVMET_PCI_EPF_CC_POLL_INTERVAL);
 }
 
 static void nvmet_pci_epf_stop_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 {
+	dev_info(ctrl->dev, "PCI link down\n");
+	ctrl->link_up = false;
+
 	cancel_delayed_work_sync(&ctrl->poll_cc);
 
 	nvmet_pci_epf_disable_ctrl(ctrl);
@@ -2314,10 +2321,8 @@ static int nvmet_pci_epf_epc_init(struct pci_epf *epf)
 	if (ret)
 		goto out_clear_bar;
 
-	if (!epc_features->linkup_notifier) {
-		ctrl->link_up = true;
+	if (!epc_features->linkup_notifier)
 		nvmet_pci_epf_start_ctrl(&nvme_epf->ctrl);
-	}
 
 	return 0;
 
@@ -2333,7 +2338,6 @@ static void nvmet_pci_epf_epc_deinit(struct pci_epf *epf)
 	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
 	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
 
-	ctrl->link_up = false;
 	nvmet_pci_epf_destroy_ctrl(ctrl);
 
 	nvmet_pci_epf_deinit_dma(nvme_epf);
@@ -2345,7 +2349,6 @@ static int nvmet_pci_epf_link_up(struct pci_epf *epf)
 	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
 	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
 
-	ctrl->link_up = true;
 	nvmet_pci_epf_start_ctrl(ctrl);
 
 	return 0;
@@ -2356,7 +2359,6 @@ static int nvmet_pci_epf_link_down(struct pci_epf *epf)
 	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
 	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
 
-	ctrl->link_up = false;
 	nvmet_pci_epf_stop_ctrl(ctrl);
 
 	return 0;
-- 
2.39.5


