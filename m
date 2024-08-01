Return-Path: <stable+bounces-65137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8C5943F0F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFB91C21A91
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A71AC438;
	Thu,  1 Aug 2024 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhM345aO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FAA1AC422;
	Thu,  1 Aug 2024 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472543; cv=none; b=U45eDIkV4vziOCinoJwkNgeTG9lmYkd0D0zOyvr1vDnyoiaPApv5H0BYV7hoVEruPBIDW2WC+rgKVvavKAAe7I0ep7+tIFK8FMjojhIdmHxxdVua12EO0/M5a9fH1nb3SM2jrwV4oJLtt4yTgvcDE+0WcG7NXDSIUVex1Td8LjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472543; c=relaxed/simple;
	bh=iT35glO44uBzpr8ozZp9u0xNHMswLi8eMbjs4xo50MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNgDE5i+erWTMpG9NzHtT78C1Nj5yZsorN5EXUqc7dnIB8feHuhIsy+D3aYHejEDpSk8KAwjeEBJkjLlXlbH3jq2hxjoneyb6HqpMd3pobQRVBnSbvU+yS+qhpeGvC+RjgTobiawpuYVEwfs+4LrNGOt+XgJRPaa2nAkdX3qg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhM345aO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F976C4AF10;
	Thu,  1 Aug 2024 00:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472543;
	bh=iT35glO44uBzpr8ozZp9u0xNHMswLi8eMbjs4xo50MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhM345aO4AyO9IpNfXyFmxNDiARoalZyQJ/VohLFSOQQdJIcdVducDNHf2n8pWlNa
	 3sjEcYRDHRnuBLzou2LNy6lCB7vKDUGyDKmXE0txZlWHPRPdM6EqytYFc9DSWauu/K
	 iF/ACJAGdDl2pFssbFSK/03bt8kA/OYCcgbKlM/mEly2TggQIQbLxslrgz/WZmlx7R
	 lDvuUKwwbFyfOuDizljlzUL7jhs6XYre67jVaxzVFeXruaT5Guv18Avrtm9QfBaauZ
	 Cb1rK/t+eDAxdurQBxb9V/LLlBJzUgDmTW1+9KQ+xq/3g1LOx05/XuU0Dbpqp+n3FV
	 iERWXGWsn8++Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 47/47] i3c: mipi-i3c-hci: Error out instead on BUG_ON() in IBI DMA setup
Date: Wed, 31 Jul 2024 20:31:37 -0400
Message-ID: <20240801003256.3937416-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index dd2dc00399600..9df01c15384a5 100644
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


