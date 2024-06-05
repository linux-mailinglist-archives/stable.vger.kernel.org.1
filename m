Return-Path: <stable+bounces-48188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C917D8FCDF1
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE023B28C71
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F83DABFF;
	Wed,  5 Jun 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB+c+id8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9D1CA2FA;
	Wed,  5 Jun 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589099; cv=none; b=p2Tlid0QjLjHZ6dAvu0PilZ6vehv9tyEo5nglj9czVHesBidlLoNIrkvrB6yXh7jq3JKxH/HyZUj61BtOb9qTLhq2P1atqzLsiWk4mOMHnfCrvi0+HgM4zhykdehghzu758Vds1lgUHl1XhpBM6/fnrQ45fF9jg7eRp0JeCVl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589099; c=relaxed/simple;
	bh=B3cXj5QRC/Hj3s+cHzQMtqKF+PdRub88qOcV1NmK5CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMdQ3E+ObyCcxUG+NBsfdby06uA6O1sa0dRkLPD3zzTPt5iDDh+bzNDuMGSgAoJmxjKzgW+SO0ahwOLLSvBOYNhseyJ5ubtfQiFIrsvfzIR7g1aLAx9tu4WBAzH/TMJAz7+aOLC4m/ii8JXM7clSK0Z8E6Cnuu1NblXQswwdGPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB+c+id8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78409C3277B;
	Wed,  5 Jun 2024 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589098;
	bh=B3cXj5QRC/Hj3s+cHzQMtqKF+PdRub88qOcV1NmK5CY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gB+c+id8lHu3GzymWcwwp9wqJh9P2Jgq96y4UWnk0lEYDfwu6iB8jZmdspwg9hhz+
	 CxjREY5J9qvDpLWohcvyKoJiUySRLb1XuYIZ5i+yuOhSSrLWzy+qfhD+cUt9fNL3N1
	 N+kle2fhLhgETwbZPSJM8atN9bmvBhQXA1q8weiv38s9Of1jwyIUPWZz0Uqtt7H5Tm
	 2aeN5yVrt+iuDo2WUbyh7PUhz13RRWLNB5nerIAywchwzKpmY2D27C36fj4O+mxD4q
	 sIAnAW0ms64vJZnPHHuWE6DTd927nEGoN/PuIuiO1+ifq1Dmld7wNBdGfGHE5WO+Qc
	 6NHI6b7X9SxjA==
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
Subject: [PATCH AUTOSEL 6.1 02/14] dma-mapping: benchmark: avoid needless copy_to_user if benchmark fails
Date: Wed,  5 Jun 2024 08:04:35 -0400
Message-ID: <20240605120455.2967445-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120455.2967445-1-sashal@kernel.org>
References: <20240605120455.2967445-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
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
index 0520a8f4fb1df..30ebfbf756847 100644
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


