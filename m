Return-Path: <stable+bounces-48170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A388A8FCD4F
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AB1282BCE
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156841A2FB2;
	Wed,  5 Jun 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPorn57P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C111C619A;
	Wed,  5 Jun 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589052; cv=none; b=oiOIUJgSCie7c8OpX6celaIecvq7EdeJkn1PMZOeCw6c67OJ4VH7nDvzbM7jpJs0gm5bvVLTCYcHNn8lYQwuONj5SgVPe5EU7PVdYAZUtrEW68dvwkrjYYHRkt0kFoNH0Xoht4Crr6FTTb5vj5AeuS/eqR0YRPyayrrShrmnqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589052; c=relaxed/simple;
	bh=HyWxOHBFsxYxuhl2IOENDQJf/JYMZt5KUEf88qktYTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ha1eAsabxeClyz6X3MphDcIVsV1v4PpB4YuQWhx4ifgBcxi+1yEPA44AzwBGKBiP346DJY5Pv/oQhSHsN051VkDlTdnIrog3yE9DwE5en8MFWNQ3y8EVzjVIjLAaz5Yxb3mnb86it5kc0b1uNNTxuMB6+AigTsMJWOpUoen0tMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPorn57P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F58BC4AF07;
	Wed,  5 Jun 2024 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589052;
	bh=HyWxOHBFsxYxuhl2IOENDQJf/JYMZt5KUEf88qktYTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPorn57PJ0WPzixLsQbWIWpt5PUP50V4LwzCvxEqvgGcFzXB2yRJ7Eh82wUNONPYy
	 JjDHV0m0FVYjVVCOS9cohwueMG/IP3fqGlXOWGkwJQU8kcGeMPaU6J5hPPaqOZeEUL
	 Dm3JzXhXyFm0Ra0ZruaufMGQN6uEmb0Zg7Z3V2jyRs00TE5R8fCmVGEdJjw94k9QPQ
	 +oM0E/BnmxEiTIfwY2PQAG51x+y0lzXVxaRV/DeDxDP6hSZuOg4rCqXAbVijZVIuJz
	 9vcZMzbiR9bdcTuYAeVhEFycmSFSUwbw3U2suCDIHFl45dWdy32YxoJHiFLcmqnD/A
	 CovWDSYu/jAeA==
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
Subject: [PATCH AUTOSEL 6.6 02/18] dma-mapping: benchmark: avoid needless copy_to_user if benchmark fails
Date: Wed,  5 Jun 2024 08:03:41 -0400
Message-ID: <20240605120409.2967044-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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


