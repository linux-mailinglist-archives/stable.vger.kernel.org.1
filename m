Return-Path: <stable+bounces-65090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D820943E43
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550C11C21ABC
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C581D776B;
	Thu,  1 Aug 2024 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5I8DXe0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0E1D7767;
	Thu,  1 Aug 2024 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472296; cv=none; b=ei52HBfmQrotc1DpqVA1Jvfxzrumb5ZtehIMWVKFM7YxKLPOOfikzfeMYm73gnr5JmJc4NQxfjbD40gYSD+AsqDRvtr0Ok9E+iujZEKYFckX6/KQ1cth0A69ijG4CRw/7ufYlxX5u8UEsjmbvkknPZkP42pzARds0c5OeJ+OJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472296; c=relaxed/simple;
	bh=G7oC9KzKZ3u+aZnNGCnn8qE3ProuBDlrSs5M5tCVqK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiGzMtq0X9GlIHRfYLw63JW0oonJSQEHcSMb+vQ8sENBGHbzup12IRWAEMHpuNrOkXcb6TAbuk1lBDLB5TuGgZ2TSs2hQgL3Upoq//rYpkPHDyVWQdNlHMfCy81oQNHXHFSYAAV5bDr2JASGDYRFK+r3i70EDoMOf7zb3KSumI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5I8DXe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9EEC4AF0C;
	Thu,  1 Aug 2024 00:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472296;
	bh=G7oC9KzKZ3u+aZnNGCnn8qE3ProuBDlrSs5M5tCVqK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5I8DXe0FlcalJ4cnUuM5J391vOtL4tmPQ8wEtL+nK4x4NZKWsVTpdRtM80q1sHdS
	 fhnglx1zlNB693+GqoOmHjVsVBeCMqME1IdR1S8oR2PGxBl85my5yV48Btb+bM1rI0
	 UYPfE5Uq0fVbvqLIIYCRaREpBGjFSG3X8+qDs7wCy3bQ/Klj431dd8Ie/yF9Vf5kbw
	 sT5qZQtRpjT37e5m/tXFJHQRRIG0sgdf0rkPUITBJJhdiW5lZ0UBHUBAGxUDS4/mMM
	 9JtL9SJzNiR+7wobNY7+UNApFtQcsM1MC825SpFJpRifJISZNK/o54Csu0rRnVIazJ
	 tfuTCEa2j+N/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	gustavoars@kernel.org,
	kees@kernel.org,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 61/61] i3c: mipi-i3c-hci: Error out instead on BUG_ON() in IBI DMA setup
Date: Wed, 31 Jul 2024 20:26:19 -0400
Message-ID: <20240801002803.3935985-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit 8a2be2f1db268ec735419e53ef04ca039fc027dc ]

Definitely condition dma_get_cache_alignment * defined value > 256
during driver initialization is not reason to BUG_ON(). Turn that to
graceful error out with -EINVAL.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20240628131559.502822-3-jarkko.nikula@linux.intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/mipi-i3c-hci/dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index 71b5dbe45c45c..a4b56d59a5a13 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -291,7 +291,10 @@ static int hci_dma_init(struct i3c_hci *hci)
 
 		rh->ibi_chunk_sz = dma_get_cache_alignment();
 		rh->ibi_chunk_sz *= IBI_CHUNK_CACHELINES;
-		BUG_ON(rh->ibi_chunk_sz > 256);
+		if (rh->ibi_chunk_sz > 256) {
+			ret = -EINVAL;
+			goto err_out;
+		}
 
 		ibi_status_ring_sz = rh->ibi_status_sz * rh->ibi_status_entries;
 		ibi_data_ring_sz = rh->ibi_chunk_sz * rh->ibi_chunks_total;
-- 
2.43.0


