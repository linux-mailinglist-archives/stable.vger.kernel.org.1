Return-Path: <stable+bounces-48129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA9E8FCCC0
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26491F22A1E
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DA3195FEF;
	Wed,  5 Jun 2024 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzDezxIt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC07195FE4;
	Wed,  5 Jun 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588944; cv=none; b=ESvfdkhPxLxC6Jh5H5R9MOZBNB/mCAt9/JdNH4CAd0MWcjjE/bvIkH1UsgdnQBMNKRrYTnTbeB966V15OAxrIMrbX+gcnDzDQB0S9JxpHwN3AJOIh25MqIREjF5jhhszItNRPh6pTrLpRlU2GvMMV+8WqedW0wIsEM5XpGSgsZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588944; c=relaxed/simple;
	bh=HyWxOHBFsxYxuhl2IOENDQJf/JYMZt5KUEf88qktYTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZsch/1q1DR8L0LDwlEpesjGsyMLw0CK71bpwaRmumaskwAUpNwZtjXipX0AqKSi2J8h3AJfnSxPix7p2AA8FMu3uVUOknwAJbU3neMnYTQ1Gx19JJ+bBcfdJmA3BfgMxbARbUnhihGZneW2hifJajKeCNUEZSUjR0A1Qyp4HkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzDezxIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EBBC32786;
	Wed,  5 Jun 2024 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588944;
	bh=HyWxOHBFsxYxuhl2IOENDQJf/JYMZt5KUEf88qktYTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzDezxItsI+ktI6JycRMmKIqqXZrXWVegMJk0QoLEGryY0IoxhIjxPx40QPSzjIWr
	 SSf57IiDX+BdbY2SybnvEjD1rWEWyeGQwZ6YllmC5UZZ52KGG7GvG68GguGa0D6i1q
	 sT1irotU9wOTklOaKhCBcOS+yoUPXffElY8cHVK2alE+LThHjVyb33nD9heQvKiJBp
	 mzVqwTwtwX43NsWg34Towiyka4w6kwKZ1f5uNXJdq/4to5yQVLcWIqPFnm5QfG3HSX
	 sakM3ZsyY1K5iVWZEMn9kWduPFIzm+CVzbk3jsmD/2DPAr9uTkSYmrGsSHAx2U2vsM
	 EwOsx+ftlSqTw==
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
Subject: [PATCH AUTOSEL 6.9 02/23] dma-mapping: benchmark: avoid needless copy_to_user if benchmark fails
Date: Wed,  5 Jun 2024 08:01:45 -0400
Message-ID: <20240605120220.2966127-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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


