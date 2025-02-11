Return-Path: <stable+bounces-114766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46CAA3005B
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E45D3A48DF
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747EC1EEA4A;
	Tue, 11 Feb 2025 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNzBR9Oe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406E1EE7D3;
	Tue, 11 Feb 2025 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237450; cv=none; b=DIp/9enBARrDMEvbtVFQU7DC8xwVmDCAFE6nbKIAy61vh1kMGuTSBzYD4uxa+1EfW8vMrmWyeM4NXGejTnEVSi4MpwZunZVzNRfbp6dAYOxvRRbIEVeCgmmnRlXnpAJYXlL4/LhK1W2+2C6sGEmtfyBn3HkJKJje236A/XGBmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237450; c=relaxed/simple;
	bh=WFxr/y9LJF0Ox1+qtFw5ab55rZwBdjgkMAZy8r9P928=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LgLVrD6au90vKy1KIE5I4f2iyY1cfcfqDAU8okBWt42F29tTYyTnYfgGuEqskYGtoTHL3+ZaT7QrrQlLjR3RCV1mS+roVFjSCPBFEHu+bDjmXcbUM3I4Kbdv+rSWyyHbTAluo6cwKt0yxCM0scUh2FcSTz4ZUz0Aqg/R1JYJxzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNzBR9Oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D411AC4CEEA;
	Tue, 11 Feb 2025 01:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237450;
	bh=WFxr/y9LJF0Ox1+qtFw5ab55rZwBdjgkMAZy8r9P928=;
	h=From:To:Cc:Subject:Date:From;
	b=NNzBR9OeQe5ULtl/VZPzX1YbxNjoUYTkFSXsu8zbXmWKkC29MIHfZbqycK85bqvCO
	 xFZo62pevqWIon+aPSVTOJAQdP2vwK4CNMKCDywcduJTuaYmuWxLiubcdIpSZeDt0q
	 aqI+BS884eeJZKijy/iTKK4i4kxui5xn4ugKIzKseZ8ahuUbqYfkTXS2kzizOiyTeO
	 PCHjzkRwfds4AjYAnae3AMnIHS6asuJKlpGYZdHb+dXtk74wIwie9E8QPOw4m92yAk
	 MaLl9k7tYcDf7onx8JID0inteBwfv2c6i3AeSnziTi4fY/q7oKgkhElo6837ovNMIB
	 JCv+nfxDWoy/g==
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
Subject: [PATCH AUTOSEL 6.12 01/19] nvme-fc: go straight to connecting state when initializing
Date: Mon, 10 Feb 2025 20:30:29 -0500
Message-Id: <20250211013047.4096767-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
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
index b81af7919e94c..d45ab530ff9b7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3579,8 +3579,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
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


