Return-Path: <stable+bounces-52702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FC490CC2B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26D8284DA9
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D8B15B98C;
	Tue, 18 Jun 2024 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8wzSns3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5213E41F;
	Tue, 18 Jun 2024 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714247; cv=none; b=RUhJmLcdCqpgEhEnJSmfEbQRAkGmrf2o1EoBeM+VO54G14X4uSDb6gEWSwt6fJtF8K1Mz1XLHw2Lc9lVTqEP7oKYNm3FukUWCzZPzi5WGivBz+Vg2SMMI3W34vnsXVn71NqIziT3+jVzAZOd1i7QR/tSYirDIr8kd55ZJTeX9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714247; c=relaxed/simple;
	bh=YNwSeyUWooZMAG25GZh73ttHKehOSMr/3V06jP+H6BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4lmskpxG4k76lUKCessouunSUoZM6PPLmfzwqsgM3Krk9qI1ZfEdYpgLtLX5uKndlualGEhhXLvu296ZrVM80pZx890XdmfYVUFNhlkR0Eb+B2Hk21Cy4fcFQthbzcFBUFmBr7+07rYTiettB99kUq7Ip7jp36bVuemCs4zsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8wzSns3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E794AC32786;
	Tue, 18 Jun 2024 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714247;
	bh=YNwSeyUWooZMAG25GZh73ttHKehOSMr/3V06jP+H6BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8wzSns31YlXmj41FMd5QHwEajY48U5u5RMNqXkSRyDN/y/cmY6/HA19wLkHRmaBL
	 Ilhx1UycLO4ejfxHVX/WudX8bX/PLzjrTzZdY6taCIl1iYwZrl4FW64iaXxuGNsk5F
	 mjYwM+HvDcWGIp3l1ETZT0pS+bTK/yQF2BYGr5YQ2xaQ2OQ3NYcrPaDUypBx+Ix0Zq
	 X8WGcyCSw9HUs0QGJhR5/VmSeDHTBg+ZmBCv17W1OhB4K6fwpkAdaY3SPllkjeLA4P
	 hUEdxSCUv9UQ7DtLnPoerqjqpCN4Gvhxycmgl1ESlTe4Gq0kaEPlXSAPv50NePuIV6
	 HnW9ASwDQ772w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 30/44] nvme-fabrics: use reserved tag for reg read/write command
Date: Tue, 18 Jun 2024 08:35:11 -0400
Message-ID: <20240618123611.3301370-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Chunguang Xu <chunguang.xu@shopee.com>

[ Upstream commit 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa ]

In some scenarios, if too many commands are issued by nvme command in
the same time by user tasks, this may exhaust all tags of admin_q. If
a reset (nvme reset or IO timeout) occurs before these commands finish,
reconnect routine may fail to update nvme regs due to insufficient tags,
which will cause kernel hang forever. In order to workaround this issue,
maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
tags. This maybe safe for nvmf:

1. For the disable ctrl path,  we will not issue connect command
2. For the enable ctrl / fw activate path, since connect and reg_xx()
   are called serially.

So the reserved tags may still be enough while reg_xx() use reserved tags.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fabrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1f0ea1f32d22f..f6416f8553f03 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -180,7 +180,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -226,7 +226,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -271,7 +271,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
-- 
2.43.0


