Return-Path: <stable+bounces-140603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE21AAAA1F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECF13B909D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A07035F7DB;
	Mon,  5 May 2025 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLsi7L4r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02B35F7F1;
	Mon,  5 May 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485249; cv=none; b=foqIWeD6m1yiJtRL354lNeX7MAF/H1JuTJ/dGeFY77OGaGZKgAeFn1/NZ6h0Wu3iTUyPvkYx38RfEnbD8SnenIZGmiYOeFhjqg1ICmivY/045WuINwuu47PxYXCMfE/UEP9bgOdo3qCgS0SiVUt7v12bDsqXE1Kc+T4a6Bx9y8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485249; c=relaxed/simple;
	bh=z5aUk+dG5NqmZKV1Bu57nkbRphmoPenBEhGi2559TMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c7aXqPPiQ+2zSHnwqhN2r6zWkBfOy9kMM75P1/yzcp8LZKkOnn7vYRKsk4XSl7Oa+lKVXvb5VwTb6e4WAJb5KSIuBoToaqp7Glv0DojmXRqhIKsden0uZnR/WjubS/e+rDl9xNEIH+emw9LdeyMIt5/I9mSHap61B0n8Mm77SHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLsi7L4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343F6C4CEEE;
	Mon,  5 May 2025 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485248;
	bh=z5aUk+dG5NqmZKV1Bu57nkbRphmoPenBEhGi2559TMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLsi7L4rnu6v99iTg+sNCd8fcenGnZ2GjzD1M83bpvww0H72D5YMktN2+6d/H9wK2
	 ZzBoDiy/EWHQROfA1AChXfSc7+JfXRkatccYo2K7nWY3+DavCpNs53+4NBToo/LIk3
	 2a0vOmeiqttz/uG2X/BrIFr2KyXgLwthgfOagLXymJbD4Ln/vIFLo0NWtCw9r7c7i3
	 dPHOK5wlD9iOVTTn5/yuHoiS57jayi/jqT8kjetEXi8Z48ZQ5KSE5L++1iCGtQbL+i
	 OvzJ2ByOEBJXznlWH/ofnvSoRLGoWJDn2GvOrKUhYBNPq/gKp1hDZwsykZzP1QUp6X
	 56iNK/MIEyT0w==
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
Subject: [PATCH AUTOSEL 6.12 234/486] nvme: map uring_cmd data even if address is 0
Date: Mon,  5 May 2025 18:35:10 -0400
Message-Id: <20250505223922.2682012-234-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index a1b3c538a4bd2..d128e6cf6f1b0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -515,7 +515,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
-	if (d.addr && d.data_len) {
+	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, 0, ioucmd, vec);
-- 
2.39.5


