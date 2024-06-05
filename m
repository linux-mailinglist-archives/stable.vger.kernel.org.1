Return-Path: <stable+bounces-48152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80758FCD05
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0278E1C21408
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA981C2259;
	Wed,  5 Jun 2024 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/xdRNHa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C567F1C2252;
	Wed,  5 Jun 2024 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589003; cv=none; b=O63HGR6N55Ak6+LV1NrFOTqxikcP7WnzBQ+UMTa3BqPNyI8XiDNwI9XFbg+lNtH09IyBIAsaV+iIsr7Bi8cEiU0G0HAgd7TZj2A8dcEcXA25ydkSny+1tLhzMnOrcv05ixbkFyA128n/v2Wn6sgL9c2v2fe5WuoLms2Or7dUHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589003; c=relaxed/simple;
	bh=HyWxOHBFsxYxuhl2IOENDQJf/JYMZt5KUEf88qktYTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4D9/bhnt3iMJKNDuNIFMLMGfgMjs2Qh2odRHimI9xbvRawhdmwGiFvezaXVzXF6swwh7+nTC/4DINoP12c0LIeXzyJScKOixCZPc/WRJEhLnvwdQH1F7YkYUslk9Hc7GKNGqhyx5yZSEC1I9BxtYn16DLBQnWJ2W7NsRkySMoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/xdRNHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F838C32786;
	Wed,  5 Jun 2024 12:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589003;
	bh=HyWxOHBFsxYxuhl2IOENDQJf/JYMZt5KUEf88qktYTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/xdRNHaajEvJxU+vkVqmdw341dHC2nnhruq6ugC5b9fxmAtxmWS+a8uiBrQgWLIw
	 2Oee/3xKTGOFURR61AujBvyFG9Ps+rT0tV2icXet7+PAIbWHaWxxQ6myEQuiP9kL2k
	 MiA3HOhV3aZhvLlxEisM6nVWww5Ee1YX1Ag8uwjpjYKZneQfjQH9GGoCb+S6EsWrn3
	 I6Eagep4qKpjA1+QHXL9ir7pfpV10Okf2MUWTfAmPlm4OQQczWhmBQxdjBpOOusHxI
	 mZngpzU0R+TXDOJ9X+ujeAilTvNMA0z3Ga3ypmEgYa76RyS3F9c1T4u44z4JHyJS5d
	 QNu93ss9Gm/nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Barry Song <21cnbao@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	chenxiang66@hisilicon.com,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 02/18] dma-mapping: benchmark: avoid needless copy_to_user if benchmark fails
Date: Wed,  5 Jun 2024 08:02:52 -0400
Message-ID: <20240605120319.2966627-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120319.2966627-1-sashal@kernel.org>
References: <20240605120319.2966627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit f7c9ccaadffd13066353332c13d7e9bf73b8f92d ]

If do_map_benchmark() has failed, there is nothing useful to copy back
to userspace.

Suggested-by: Barry Song <21cnbao@gmail.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/map_benchmark.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 02205ab53b7e9..28ca165cb62c1 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -252,6 +252,9 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 		 * dma_mask changed by benchmark
 		 */
 		dma_set_mask(map->dev, old_dma_mask);
+
+		if (ret)
+			return ret;
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0


