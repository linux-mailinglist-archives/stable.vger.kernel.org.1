Return-Path: <stable+bounces-114800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E39CA300B4
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC8F163596
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2039220C473;
	Tue, 11 Feb 2025 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNZD6mVg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2B121772B;
	Tue, 11 Feb 2025 01:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237529; cv=none; b=OQlMHam50M7ekZYPnpkXZF9t8ObremwGwPche5AZyWzlxoX3YpnCdNOhvj4ALsbUmeLdnLwe8Is4wz7AbsPMNyYCmhnsP5L2awyEiFWL64qtD8N3wTbiVql2P9wuVUv0OyZmh3Uzaecb7Y9wpL3LCCTgAl1g/P30b/+KaenKM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237529; c=relaxed/simple;
	bh=joTmstJh5P/C7qhbFmS7I5l3jHWOY12qVNch68QcO68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kmrwzZ3cyodk6SyUE8+32ZqANXiO8EmCMjTUMmZpklrh3nVseQPeR4Jg+j93yLjIjkVhNv+4yWpMGAkVHdMGqDdo6fvqEo0unn0owWVClc7I6WKLRJuLOTExCtJ9u32vWyRdSJf3tQ89Tr4tDMJIBJOwvi7tp4boJ+0Ij8YORR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNZD6mVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B13C4CEDF;
	Tue, 11 Feb 2025 01:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237529;
	bh=joTmstJh5P/C7qhbFmS7I5l3jHWOY12qVNch68QcO68=;
	h=From:To:Cc:Subject:Date:From;
	b=HNZD6mVghzZRbzRyw+WEDY90zSvrilRTQiHt4DdPDcgg6gKsRL8W70UaPAhLZaW/8
	 gSgvmUpdiOgER9rjNXyFlvO8R0po4HlupGTShTowYksDMR6WV1f7TpK5qct7dvi2PV
	 G4gyEXsWvd0/s3Cy6zB/qajfzmlIDZ0MGBiuBNZF91cMj3YiuDOk4Ml0baBu2u+3H1
	 rBdE6tw1GhGsFzVaaQhlQCKSZrMEkkPKT7pI/eBpw0whrMmi8x79oqfqwvMwehUJA4
	 M00dO9PfNA/KXSVm2R48MdLddniXVhnkQfRj3LGu58W+TodFyeXVnC77kZR9Rss7+3
	 BtkaXGC9rlk5g==
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
Subject: [PATCH AUTOSEL 6.1 01/11] nvme-fc: go straight to connecting state when initializing
Date: Mon, 10 Feb 2025 20:31:56 -0500
Message-Id: <20250211013206.4098522-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
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
index 3dbf926fd99fd..2b0f15de77111 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3525,8 +3525,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
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


