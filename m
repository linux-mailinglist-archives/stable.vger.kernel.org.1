Return-Path: <stable+bounces-48202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C48FCDA1
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4354D1F28DCC
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E71ABCA7;
	Wed,  5 Jun 2024 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/4w+0Wk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DBD19599E;
	Wed,  5 Jun 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589133; cv=none; b=hX/HflbD02DDDT4or5B2ouNrCTiq0yzQKXiIJpYmhM69zOh7l8rjEvllN/HyDyIAmV6p4WPXTyIQVC7HSKv/C4kJQDb6/Xv6JLAMzC+gX+bx/FR3PsOGe0W17nRsoBo/yvhGUAQHyPfeHF64QDplLpS3uHYscuK/DbBxPDRZQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589133; c=relaxed/simple;
	bh=+XnIWAAgCcPltNF7UZ57tChLepn3YL0mHPeD8aZhqto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFiOphjlFhqztcqad1GC82MLG3IxYutzEeFuKfNCcfdmCjBi5oDipq1/HzBfbWXd0vb+pXHbGoJU/bBWgNUqiG7BudBVAhgt8ujBKQElPGtA9CqqFUiXq15+8eXmRGeZ2YZBjpQ/F+c9FIcSuPG7uSdyjF1S64QYPsk71LYXwc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/4w+0Wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E716C3277B;
	Wed,  5 Jun 2024 12:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589132;
	bh=+XnIWAAgCcPltNF7UZ57tChLepn3YL0mHPeD8aZhqto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/4w+0WkXTZeG3A/r2HYosyFZYYrcUnY+62U4xg9hkzWi/c5cQj3AX4MjXDciT1zH
	 cL7h+Fv5im+KTmJ0EZzwYcFtdjrcDafZVI8BzIIZu2gb27c63rzJK1OWphzNjrV9YE
	 uFeDFvTQ+00p49px1X99SjErH9PSX+KohiWHx+T8i7fzNN3yWs6BGgW/4Zd2236ugU
	 l7L6ugko2eLARPB8p5/J7YSnxc5yXr4HWa/8YflfxgIR3a3x8RPBAMD+qU/4vRKdIG
	 DXqHTAqhVhAoQQk6Dqk3ltS2PQ+ZSMcYCkzBr89Eutl0DItv4o1aC8j5OFXXwxmwym
	 De2CXWl9RVRIQ==
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
Subject: [PATCH AUTOSEL 5.15 02/12] dma-mapping: benchmark: avoid needless copy_to_user if benchmark fails
Date: Wed,  5 Jun 2024 08:05:12 -0400
Message-ID: <20240605120528.2967750-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120528.2967750-1-sashal@kernel.org>
References: <20240605120528.2967750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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
index 9b9af1bd6be31..8d6d802576928 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -275,6 +275,9 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
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


