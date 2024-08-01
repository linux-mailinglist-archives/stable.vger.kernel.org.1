Return-Path: <stable+bounces-64946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6187943CE4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E5A1F2286C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A9D2101B7;
	Thu,  1 Aug 2024 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7G/NV8H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF132101B2;
	Thu,  1 Aug 2024 00:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471515; cv=none; b=hxF+RrpbXCzGUpyF9mFok0DMyglPjLRh6HPblQI8zGEjoRue5eErnqXUwuzi4O3vcFj84aBw37RkvTWuKiJsxKzwiQiyzeE5ukoQ/020A0gDDBwiRM1EQ6l34XPYh7Zu39LXtLiE5ZKZAg0yN/21Sx5DvZjNCombX5QLTl2mle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471515; c=relaxed/simple;
	bh=ufngkK1NW5FJJk3y562A9XzeMfpxXgZhI0+V1MKWuaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJYnHSjKhHMMc0oXg/za0Sw0YK3QePSS3TYVBXWdN9vYA9zmo7K22cRXK5kBdE2h+prHmzY51MPL2D/Pdsgin4HyeJ0iHL7fscnoFw7Cz4CCvuBJDaQAasX2WCwErcCGqM5T4u6XHJDWDGaspYgulSRITaaZ00xCrrU3Nq9meno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7G/NV8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4C2C32786;
	Thu,  1 Aug 2024 00:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471514;
	bh=ufngkK1NW5FJJk3y562A9XzeMfpxXgZhI0+V1MKWuaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7G/NV8H0m6pohW4k5M+xOvZY6yUw57KaGchVXGP82P9+mxy0xi+mHoQQBcJfJcCt
	 rUu0AD4mupo8/kB5XTohgVU4vVjn4ZMC/1xkNY7SKZteerqwebNaLpHzRno0wZDe1K
	 tcMQqgDsPCCL7BZKmSLXMoD0Wt7qZGOgC9f7qvQ7YwSqr2CpbHX0/2b0nhMcqxbl6c
	 MXifeW0UlhrIxQ1fuBLaui0p6QYfHp4BeyuWih5ibMKIAub95K9SzCbjpbOB2cMWUh
	 7v/03cMSSexo8StIKOYHeaJFkT6Ugn6KoaYzuvG8XtnUjVubsW7aTReCm7iJwEWt0J
	 4NBAx5Mf3Z7CA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 121/121] i3c: mipi-i3c-hci: Error out instead on BUG_ON() in IBI DMA setup
Date: Wed, 31 Jul 2024 20:00:59 -0400
Message-ID: <20240801000834.3930818-121-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 4e01a95cc4d0a..1a96bf5a0bf87 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -294,7 +294,10 @@ static int hci_dma_init(struct i3c_hci *hci)
 
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


