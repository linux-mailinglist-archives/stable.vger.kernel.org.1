Return-Path: <stable+bounces-141528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 992D6AAB747
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BA51C25D3B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7431F2EEBC6;
	Tue,  6 May 2025 00:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcTZsKUi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F342EEBD1;
	Mon,  5 May 2025 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486603; cv=none; b=mh4eRtl/Y5Kglus5BAkLpuQXUVOtTENxWORyOVFkATAMzOy0QfjvgguKlel57QIzcIvcjaezBFn3hn3lv1kU6t1H+035XPdIVfaecPrvDCSfnucx85pMnNyEANvoHMzMzaK1jqfZcrnojBpTqEPlb3+JBrlUOZoMBjU5YTabuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486603; c=relaxed/simple;
	bh=/A2lNNDhMc5Fco9orW1zjWE7iSjabScTNUs6YZMsbcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TlADusUeF8tcWpQEnB+qWl9ZdtVoSms9mWNO/NT2C6Yd4Jyew4Vzi3rRPgRq4MJd2CWetZ7sf51/N2/X3nx66TZ0BtK5cYxA3+GqG2eFqhKefKYaeT6ye9c7hmx776IyNmw9puEcNQ+6bcNeGeZkmEeccc3rNnMmCyIHagBa+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcTZsKUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C799C4CEEE;
	Mon,  5 May 2025 23:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486602;
	bh=/A2lNNDhMc5Fco9orW1zjWE7iSjabScTNUs6YZMsbcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YcTZsKUiEAJ2VcHMcG+Igda5Mg/8P47PCr6DZhaBgjvYlDDfGi95984Wcr5/g6N9i
	 D3UABN5gQ0kyTwAJ3m1rva5ZLHMFig7savcRjqhpr5yqCCwgYNnKwf/UZYNNE3WPBe
	 yXfuT/ChfLrCq9Q4Z0KbvwYtjP1qpVruLZa3E+bG01onSo02OhPcQNjk50yeaGGvoP
	 zL2iHkftp8zm3y+wSVUtMLD2ebyWLHCoWSdtnipvLbSdNEe8rsPLb/G+HRIfInrWQF
	 TuaOlJPe+StLT5c/eZ/wfaLHIF3jFeL16dxfFcWKtX3aba/jlgaSPHVzjhjEgSQktY
	 Q3RZ66RsrXysg==
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
Subject: [PATCH AUTOSEL 6.1 112/212] nvme: map uring_cmd data even if address is 0
Date: Mon,  5 May 2025 19:04:44 -0400
Message-Id: <20250505230624.2692522-112-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index acf73a91e87e7..0d84acbdbf6b0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -541,7 +541,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
-	if (d.addr && d.data_len) {
+	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, 0, &meta, ioucmd, vec);
-- 
2.39.5


