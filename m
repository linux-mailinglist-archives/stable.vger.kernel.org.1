Return-Path: <stable+bounces-65029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32387943DB2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC1B28574A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFC51CDF9D;
	Thu,  1 Aug 2024 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA19v7zg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA91146D65;
	Thu,  1 Aug 2024 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471976; cv=none; b=pa2oa1/3bmAccJFZI4Ft2Ix6ScuVpzCYaJeZ7jJeY/9HjfRMYvVGVTzEdTgDIDiMrUErxPxsHtv2SXl3SMqM8HPXAf818uFnpSdfh/ymuM/4aP7Mlqvy5AR8IiHevDcOd7xGbaNaMkXSBNNqJqyMnmRMlcfiKcCC990ciWoNlEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471976; c=relaxed/simple;
	bh=G7oC9KzKZ3u+aZnNGCnn8qE3ProuBDlrSs5M5tCVqK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGRfpbJ5y0YUzSZGM/bwetuYdgsz90xqsoRdP5NjnVDswQsoJhhY1CTinyBp0gUmGlNOh/ol/moGCZehpFwPYLlU0HzcYmOUUv1zEXRcrdwr1r2HtqsnfMDDQ8BXdac3jooXU1y+ADWMjasUUM37WBK23yUH2w1uCvuH8H60EEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA19v7zg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E05C4AF0C;
	Thu,  1 Aug 2024 00:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471976;
	bh=G7oC9KzKZ3u+aZnNGCnn8qE3ProuBDlrSs5M5tCVqK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OA19v7zgAXVzEJ4iufs07mUxKX5BbzNwcgn0JombbHctfD52z7s6LhemaHcBm0+JP
	 fBwoVn7Fh73ya3N9KNo3cQMBzPagpPclgpxM08WA01RsQo9/gNIR3I4XYK3JNnH36k
	 U1/CuaUcoFNgxp06H41Z/F6qWUE5wi6aa/hSmZX5Twer+VjkPgfPc4Igo0MmTdYl4T
	 g+H6F10WUkif5Yli85oyzKG6KrAMUHBTFJLXFVWqxlmDsTRkYyFCTdX1fQ2bUvsoJt
	 KlIY0hUFpOP3sC6FFpsWLu5tWW9k0fg6yOpw/yzGHvrnCRjIlU5+A5j7neGW2A67AA
	 hX2r/kd0fk/IA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 83/83] i3c: mipi-i3c-hci: Error out instead on BUG_ON() in IBI DMA setup
Date: Wed, 31 Jul 2024 20:18:38 -0400
Message-ID: <20240801002107.3934037-83-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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


