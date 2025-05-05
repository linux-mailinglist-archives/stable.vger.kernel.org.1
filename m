Return-Path: <stable+bounces-141397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87538AAB341
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3E73A83AD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC04219A97;
	Tue,  6 May 2025 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRnxKyNU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A538B4D8;
	Mon,  5 May 2025 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486076; cv=none; b=eDHXnFI1mI0h/BDFkCkW3GlmMcHNiMRR2Nyj2T+xkPrUm5JEAx47OMn0lluXN80HiBEfWYUVSUSoeUemvCg12n2py/YIg9efxeCsSfVF9WAsBrv8DFCIOk7fi9xuqAzvg//lHTxFbwRWyxDTl2VPdE2DncYj+a68aXS3gJUu0eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486076; c=relaxed/simple;
	bh=VUG9QuunpnT/Cw2Hq0jcFjdmziSDloJ7N9vAzyTbyfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rdL6xjIKlZgrEekDcNnRImWKjmQKwunNJarayQQwfB4Gl/yBKNLerDg5qCAZ2YJHN4cIuvRzi5e7mRbJqI/ergF90g85fExT/VF+D3vVqSpd36hbdidsfoNhlP8hGRiMrl2KEjSyRp+kUCFVRsbTyXhYi423ORcvFLiZ3tekPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRnxKyNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D643AC4CEE4;
	Mon,  5 May 2025 23:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486076;
	bh=VUG9QuunpnT/Cw2Hq0jcFjdmziSDloJ7N9vAzyTbyfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RRnxKyNU70XYMjMWZ1En+Ih5ZMax72PM/nH0fvRx2JOsrbZu38k+MWrPF6phe0lFb
	 UjhdljU9g8duVKAl49NF8RBMifiZOmzBX5OTYiShQQxMD7oUKmPdwxHfNd1fHuZ30R
	 8v8c1Dmpp6483d0UNFNUPsAnRAUau0p4CIam3g/mhux2fpcin44rSM9gnkklkRpZlO
	 fUHpA11R3AHWlXCFDi6Qprf2LfQ3CU1ced+jVvUeft6qUYlwJkD+r+Q3fXt7QavcIR
	 bJdhj6l6IQb7P64csHP9pGCi7Nux8QfjD2HwK3DjI3ZAbGE0x1uVHBs/a8mZDRtosV
	 XGNJ5sew8m4TQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 142/294] nvme: map uring_cmd data even if address is 0
Date: Mon,  5 May 2025 18:54:02 -0400
Message-Id: <20250505225634.2688578-142-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Xinyu Zhang <xizhang@purestorage.com>

[ Upstream commit 99fde895ff56ac2241e7b7b4566731d72f2fdaa7 ]

When using kernel registered bvec fixed buffers, the "address" is
actually the offset into the bvec rather than userspace address.
Therefore it can be 0.

We can skip checking whether the address is NULL before mapping
uring_cmd data. Bad userspace address will be handled properly later when
the user buffer is imported.

With this patch, we will be able to use the kernel registered bvec fixed
buffers in io_uring NVMe passthru with ublk zero-copy support.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Link: https://lore.kernel.org/r/20250227223916.143006-4-kbusch@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 4ce31f9f06947..83908f2dd07fe 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -618,7 +618,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
-	if (d.addr && d.data_len) {
+	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, 0, &meta, ioucmd, vec);
-- 
2.39.5


