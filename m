Return-Path: <stable+bounces-114811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B1A300D2
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB693A1FD8
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B51A263883;
	Tue, 11 Feb 2025 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjXcPnZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DCD262D3B;
	Tue, 11 Feb 2025 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237553; cv=none; b=csB6MFVtXOjzHiLgpsmHZbSbZcJyllUx864Vs6GhZ7/YiALEN/li0Hb2EJo/xMxHXONW7aFBzEb4WKduTPWZqi1pqY7sIDCQGkryF/wWDYdnfxRCkesZlG5a/QswTT89gFw+zZCoru3HAVJd5ysiMUqMBMXXwxcKpNoU/xo1l1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237553; c=relaxed/simple;
	bh=yWXRVg8GbGEfxVc2POhOhGPiMA4DTp9jMMX6TH02wnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lWWzGBBn4W1cuxxLbjIg0PR3udNjSr2nWAM/me+8h+flU0ItI0ag6JxkoZnak6jK/yi/YKCyH2xK1kd1TD+61AZ/cATqju5zHyigFHvijnuBwRU/38dGJ+A7p4RqBYJvowocZpPJAsiKWJHxk19Yx4mWUzzVu7IiJNsXLTy56CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjXcPnZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711C5C4CEE5;
	Tue, 11 Feb 2025 01:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237552;
	bh=yWXRVg8GbGEfxVc2POhOhGPiMA4DTp9jMMX6TH02wnU=;
	h=From:To:Cc:Subject:Date:From;
	b=IjXcPnZow7zdalcYgcxHJy5oxmeloWco7aO4o9sN5Wl835Iysc12mwXon8ocBcv+L
	 q3v6zppXtMr2m2sHnBgwJsMUYYfJtNwOt/Bb54Hx/C711VI5zLzViwiRAKYE34HTpE
	 u7Oo8D9R7H2JYfHzifFLNUv7xBQ5Q3L9sp20RPFhBc0K+Rxo46U94wNmg0XWd5jiFn
	 R8TPSNLE8vDE9YYK/IkkXfJGS5Ka6tPdHTq2oqzFqx2WFMTGCdqNAmn1Z7s1u+YVm2
	 8S+F2nG3qhR1+O9UNNbVl4lQDpx9OSsH2oBT//fpvI4VyqIBJiFutJX8qBfENL72GA
	 Gi2w4Q0d1D8PA==
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
Subject: [PATCH AUTOSEL 5.15 1/9] nvme-fc: go straight to connecting state when initializing
Date: Mon, 10 Feb 2025 20:32:22 -0500
Message-Id: <20250211013230.4098681-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index 8dfd317509aa6..ebe8c2f147a33 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3547,8 +3547,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
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


