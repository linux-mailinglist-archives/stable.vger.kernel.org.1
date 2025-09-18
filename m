Return-Path: <stable+bounces-180437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F28B8194C
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 21:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E88C188724D
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3632FB623;
	Wed, 17 Sep 2025 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="nk20iw8P"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB1C72614;
	Wed, 17 Sep 2025 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136965; cv=none; b=nWcDZQhF5iZVdBsFDvQzDDS0jiW3FweaBIvkFBSWJEs2kYVcMgN7+jQrOir918y6U2Ykp7ouCP/4ti4YV7JyZl9dqqPaFXnSdqvjSZyDUBEh9cE2yOVrIpMu5gK6IUkurPxVVH/78Sn48l0Pcm/IWl15e+8k6UfYX5YpmjZJnyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136965; c=relaxed/simple;
	bh=PTQ+yvZSmhRRLSQsvEgLokeRTMIuUULbYjYZ/CokF3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oc3+NVII9Kp0SOVqS8TlxwgifgwIqDedi30Tk3OPeWJyo0UVaK+ABPGqNtqRuTmB2PTIgV09qgcvnVzt0BHkoHt29uGjHz9jj79FO+Opp6Mzy5npxPwKXPubTM+CaMrgKuSG2olct5WdH2CGanCBw3G4+FEFds9XoEhaXPiGy0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=nk20iw8P; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [178.69.115.167])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6C10F40762F6;
	Wed, 17 Sep 2025 19:22:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6C10F40762F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758136957;
	bh=P6p6r29lD45A+/uq5js84nAQQ/c7J4cIgLWM44tq/Q4=;
	h=From:To:Cc:Subject:Date:From;
	b=nk20iw8P8nmSk6+19NBk99b8ul2al2ffH15RS/sUpQ4YPiZANEQnSUBvSGBrPWfwU
	 xNNoiUn8w+MuublYB1h5z3S0KRfAM/8EiiSXF2k26KGulmd+Bk1SHnzaycLfSwQh7l
	 KyRmWARaiOJh9+JpS3Q7FsZ4hUgRK7s+KHl6gZqI=
From: Matvey Kovalev <matvey.kovalev@ispras.ru>
To: matvey.kovalev@ispras.ru,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath11k: fix NULL derefence in ath11k_qmi_m3_load()
Date: Wed, 17 Sep 2025 22:20:01 +0300
Message-ID: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ab->fw.m3_data points to data, then fw pointer remains null.
Further, if m3_mem is not allocated, then fw is dereferenced to be
passed to ath11k_err function.

Replace fw->size by m3_len.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7db88b962f06 ("wifi: ath11k: add firmware-2.bin support")
Cc: stable@vger.kernel.org
Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 378ac96b861b7..1a42b4abe7168 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2557,7 +2557,7 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
 					   GFP_KERNEL);
 	if (!m3_mem->vaddr) {
 		ath11k_err(ab, "failed to allocate memory for M3 with size %zu\n",
-			   fw->size);
+			   m3_len);
 		ret = -ENOMEM;
 		goto out;
 	}
-- 
2.43.0.windows.1


