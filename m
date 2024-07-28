Return-Path: <stable+bounces-62242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6404993E764
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941181C2100A
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253118785C;
	Sun, 28 Jul 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWEm41Qh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0B768FC;
	Sun, 28 Jul 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181874; cv=none; b=I/Hy4ZUe+BcRde9Z5xVM7DDwgKYcBJjOXrKDBD82luqfriLtxKb/sUeWLJ63aYYv9nnRT2jF0KXuXHzd+maSGp7o9qmAUoVtS5lGUMfcfG7DKaU5dqtDxCbrnEsgXv4HzxZQZGdXngU2QcyVqN6zsRP7vVg1h4JwN9QvuL58i5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181874; c=relaxed/simple;
	bh=MCl2thOrMpSD7UbCXdQ7fzx+9mC48PAXCPYzgWxy9SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABeWkbJ/wXzDnsoUc6WhmBQdGu8wPujkdAbWA/nsyQgG/NtEGl9HhRpUtqdSMnLeu4CUKU6iVFx4Ajpd63vMAUbC/dgqDsLNbK8pE4ZNeyWW8R2hdrGm+339k1/ZneMOXgCzTIw07UqEYUUoxSEyosZSKp+88u7J0BdpljG8mxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWEm41Qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4BFC4AF0A;
	Sun, 28 Jul 2024 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181874;
	bh=MCl2thOrMpSD7UbCXdQ7fzx+9mC48PAXCPYzgWxy9SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QWEm41QhEIH8VU44X3dDMvmGaHXgJQ9yNJ9nseqSB8pEayoWKq101qdSh0I5jd60o
	 RbYDMAgAmMTSYHMSpOFV18lJejyTKGLua0OXoG0KknG+zyaXd74lkhwWZd0PEPIK4e
	 7/od9bvz+sa4plpe3/npsjKGc0AeaIL4U2PCCrEpsJXG1/GT6FS0coQg9pnFEl73Qe
	 hO9ErXpNNK1HpDECdAV3rHVGtLa3pr3CUv6upDzLkrIZ6sjT+N2ZJUs38n1p234qxH
	 VYfdByRh0AioABvzEnolLWqsw940OnjiKtAIcUjkiFja3qZmxwSxJ/M5Ir3nQDXq3q
	 cGe3oUixftVAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 4/5] s390/sclp: Prevent release of buffer in I/O
Date: Sun, 28 Jul 2024 11:50:59 -0400
Message-ID: <20240728155103.2050728-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728155103.2050728-1-sashal@kernel.org>
References: <20240728155103.2050728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: Peter Oberparleiter <oberpar@linux.ibm.com>

[ Upstream commit bf365071ea92b9579d5a272679b74052a5643e35 ]

When a task waiting for completion of a Store Data operation is
interrupted, an attempt is made to halt this operation. If this attempt
fails due to a hardware or firmware problem, there is a chance that the
SCLP facility might store data into buffers referenced by the original
operation at a later time.

Handle this situation by not releasing the referenced data buffers if
the halt attempt fails. For current use cases, this might result in a
leak of few pages of memory in case of a rare hardware/firmware
malfunction.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/char/sclp_sd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_sd.c b/drivers/s390/char/sclp_sd.c
index 1e244f78f1929..64581433c3349 100644
--- a/drivers/s390/char/sclp_sd.c
+++ b/drivers/s390/char/sclp_sd.c
@@ -319,8 +319,14 @@ static int sclp_sd_store_data(struct sclp_sd_data *result, u8 di)
 			  &esize);
 	if (rc) {
 		/* Cancel running request if interrupted */
-		if (rc == -ERESTARTSYS)
-			sclp_sd_sync(page, SD_EQ_HALT, di, 0, 0, NULL, NULL);
+		if (rc == -ERESTARTSYS) {
+			if (sclp_sd_sync(page, SD_EQ_HALT, di, 0, 0, NULL, NULL)) {
+				pr_warn("Could not stop Store Data request - leaking at least %zu bytes\n",
+					(size_t)dsize * PAGE_SIZE);
+				data = NULL;
+				asce = 0;
+			}
+		}
 		vfree(data);
 		goto out;
 	}
-- 
2.43.0


