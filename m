Return-Path: <stable+bounces-140042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4738EAAA459
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C153ACB3A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612228C015;
	Mon,  5 May 2025 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvWj18zU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445BD28C018;
	Mon,  5 May 2025 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483966; cv=none; b=fcn8HXtUbVjgO+xDrcj21DSRcKHbdqCcZF7EYWB5fkYKlhQvu25dltHc0Adf31nXnufnMR95j4JQn+yeQrdbY231/zn61tlqyf0cdKzQz2Que+xI0ymkFVxjd0M2VKoI/dKzZwjYqnUw6ESiYCiij+uQIygiF92BfpiHucG2UR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483966; c=relaxed/simple;
	bh=G+46tQlxluCP6eWe/CdD8mmIezTjRDbXVZi4O5UPoPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INykNzsH1lafglpYM5Gaq0As/KpC1UkYYKAponIuh4s6brFeqhjvepeQr1GitRbXovD46dOypQ2dLd2B8qWaPYhbK+/2keC/I7usAbjy4+Q5mE6QzLt82FpTbMoaljCLEaxN53j1PJ51cA2mR+gTzFXj0jFGvSpOcn7ztQjP2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvWj18zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC929C4CEEF;
	Mon,  5 May 2025 22:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483965;
	bh=G+46tQlxluCP6eWe/CdD8mmIezTjRDbXVZi4O5UPoPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvWj18zUAJYf3ApV3bp5Ecr4At8c/66hQNsZnAR8/7mJ1iT5k7QjAyfAndECCkLNW
	 7HhjEHO+C0iM95IIcXg53tVfPqDD9TcYJy8RRT8yn4Ins+92vThJ+IfSuVL0TfW/v/
	 HZDx+UYGF1SOFHsDnvahDaI524mTp/TwJzphpx+HPEX4LtG5nyNeel13JYTJhVuAzu
	 TYVPzuZjRgmBddPeDVDNy13Og2zCbha3uxCnwvAocoom5LwvNSXfp6US0T0K1i4yUl
	 X8z8z/qJqg+M+z9qv47dFcsdEf5tnqisfD1tlzoXjudFKAlDF3gcmRvb1N+kJf4u6z
	 8ABH01B8GOkWg==
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
Subject: [PATCH AUTOSEL 6.14 295/642] nvme: map uring_cmd data even if address is 0
Date: Mon,  5 May 2025 18:08:31 -0400
Message-Id: <20250505221419.2672473-295-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index fed6b29098ad3..11509ffd28fb5 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -514,7 +514,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
-	if (d.addr && d.data_len) {
+	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, ioucmd, vec);
-- 
2.39.5


