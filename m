Return-Path: <stable+bounces-114820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCA3A300EB
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8981887415
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370481E98FF;
	Tue, 11 Feb 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keMhmnCc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8821E98F3;
	Tue, 11 Feb 2025 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237571; cv=none; b=PvkYyK54RIehQQ3bDAZ0qwasegwmttPEqK2J4EYJYL24lNqLkMs+Zpha7BjKJ8cX75UfAjlWhTlUuLdQPKXVedQkIZCEFv1ywh4Z0H6OwivBCha35ZjAKOd0jr9NcgYlVmLNOinODcEA1cHy86duH6YiIxZfZMcrO6RLuwvrAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237571; c=relaxed/simple;
	bh=vBCEJhkvhL8m42FZn4nwtaID0zY/K448LpVIKyP3ksw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a7Os0KVkXM25qRZIkfUf+ZoMcgByOLAaFKS7sitSd5IL11Vk4Ch900q+UZXpOeeW8umjkFxrO5+MKABZMBcK8goftSNvF4326KNsWK0Oph7J2384YxeOtxP+6mamCLFVSbmNsC8NH1kO5ZiU9m9hYVxfkwKGL3876nCcWJP59WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keMhmnCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FD2C4CED1;
	Tue, 11 Feb 2025 01:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237571;
	bh=vBCEJhkvhL8m42FZn4nwtaID0zY/K448LpVIKyP3ksw=;
	h=From:To:Cc:Subject:Date:From;
	b=keMhmnCcaLb9RHzcWFPVWGRqu+d7iofi+cYSn4nj8Hq+duxm+zW2t68RKJg4aCrXk
	 1DS7VkwTMW0MD+kOjzObBWBzHDO8NZno5UhFz7KiJuzDNvXG4k1L6xEns4yZja5Awn
	 zRyBpuTktl0IkgOV4DHloBLRqVThDHxFioS2cXBkZETbcsf/QjmMcD8dbVS+eQlGsS
	 UxUkzNF++uP/By120JIGAfY+tWZk+M5EtHPvp5zsQdFCvDk225knjSF3ya2HVxjyf1
	 9I7OauV4HbwQPh0yrHH3ZdoDFfZMIgAGs8VHnNLEdySdq+UeZTUNebufY/lZfH6sun
	 qRKY+x3BULm5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 1/8] nvme-fc: go straight to connecting state when initializing
Date: Mon, 10 Feb 2025 20:32:41 -0500
Message-Id: <20250211013248.4098848-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit d3d380eded7ee5fc2fc53b3b0e72365ded025c4a ]

The initial controller initialization mimiks the reconnect loop
behavior by switching from NEW to RESETTING and then to CONNECTING.

The transition from NEW to CONNECTING is a valid transition, so there is
no point entering the RESETTING state. TCP and RDMA also transition
directly to CONNECTING state.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8e05239073ef2..f49e98c2e31db 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3536,8 +3536,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
 		goto fail_ctrl;
-- 
2.39.5


