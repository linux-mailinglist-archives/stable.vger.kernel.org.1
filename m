Return-Path: <stable+bounces-114828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70469A30102
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABF13A2791
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D1726AEF4;
	Tue, 11 Feb 2025 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRf3DAq5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C202126AEED;
	Tue, 11 Feb 2025 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237587; cv=none; b=GHIUG1HCIDK5fU74DYIghYahRWdE7ZpthdKI8M5yTu2un8TZqo15Iujqd4yOmFuJ6kc8kVKpbpEKAvJSDlGaBQ1fvqLDODDaB+S4UiUqPH/A8aPvDzhNZuKHv8eg86nW0F6hDnB3ev5JPkd2S7HYwRP8fNJzr3sL9P0gnpx+GOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237587; c=relaxed/simple;
	bh=EsV3B9F5AWzE3L9ceW3hP97e8ozRHkUwY5GAy6Wjt5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VSbAT7c1nvcNgXL7ALvHN7QupbpY710Ll3VMna6Z2HuU+BQ/mDifpVuDSf53iTbCTOvoSyAw+COKzrtaN0za3U2SnTn8oeiiJUg77PpBqdOiqXq9eR9CNsmcmMb9ByLJpd8D2uoXoKZPPu56Hq2AoEQFa70PPVTkG7c0UBAHOc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRf3DAq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8947FC4CED1;
	Tue, 11 Feb 2025 01:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237587;
	bh=EsV3B9F5AWzE3L9ceW3hP97e8ozRHkUwY5GAy6Wjt5o=;
	h=From:To:Cc:Subject:Date:From;
	b=WRf3DAq5wx22fx7QNpin3tIyw6V9aFVyHOW0WTeSywuEtf6xhWH7WLfXuaInZf9Pi
	 6ZcY7IWL9DrJKwqWLS/JRpO+P89sDH72CnqLJNAV1eZ5bWHZ570WsBHHxOb0gwXbvG
	 qUNZKNoydvcvgUiolxej9xntZ0ATfEYZBgdO7ij9Uq/uKsR91NKqYGBaRdaMZaxaR7
	 VNu7rRnIt8zzggI8lZj4HH2YDslNAPAlbTP0Br8/r9LajMtylI/+oY0yUwn2Npd6bm
	 XnrQT8rreBb1TILQqhO4//mFBOdKLZidFs4I1sxAPTuEPWJhYidQcxZmzChmB9ehLA
	 AYCisfwStrOAQ==
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
Subject: [PATCH AUTOSEL 5.4 1/6] nvme-fc: go straight to connecting state when initializing
Date: Mon, 10 Feb 2025 20:33:00 -0500
Message-Id: <20250211013305.4099014-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
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
index 0d2c22cf12a08..f3c0bff714eba 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3164,8 +3164,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
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


