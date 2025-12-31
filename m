Return-Path: <stable+bounces-204396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B1BCECA1E
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 23:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4190830056F5
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 22:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4F316EB42;
	Wed, 31 Dec 2025 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWvBV5iJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC42AE99
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767220341; cv=none; b=UV+M8/d9NLRkTeVHo1PKPgmLmR2iBbvPN4za3NyFSLkqF4y/jmg1Tgi2FhidTJm+svHdbQO5SlWXQELMVD9KQl79jqt8cxJ9EaTu/Twwcy8zt+ELUZ6MeEqXF6t7IEDyRPxC48CAadqp2fufOjE1IVZsVyVzMqwMWvTtNPmcxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767220341; c=relaxed/simple;
	bh=YsUwQXQJpglrxdKbf9sCAxWwe4KWESyj7ApL5r5p1QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doLjSCnQyCx4YIATvV5tWdTcgWqu1bQ/GBZQuhCRK3xmswMsaWvnMIa6k5s9xhN5nzoyg0xHrMxDXbvmTO1aVjXGyyoufrzztBXmEkTDtHq8iVLfWNzVbGbYRm8DSrUIBzZ3ReYmJzWyexpB3I7mZjlOOzeArIH/435on/5a2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWvBV5iJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471A8C113D0;
	Wed, 31 Dec 2025 22:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767220340;
	bh=YsUwQXQJpglrxdKbf9sCAxWwe4KWESyj7ApL5r5p1QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWvBV5iJpUVl1D2LwqA0NrMBU0tJS32PU7eCVeZJqxjVNbdU+wdD6EUCDe2d5dAMR
	 NxKaYRVaO1Z6nbd1AadSpggGoZrdd2AhsiRCDKDimSUfsQ6qKFos4rRmlwA2ZyKfdx
	 AAGIOYPaVx3bYUeiBZDr34b3/mQI4WRaGS0msFf1xRwCc/E3hroc7Q87PzYOflo6UL
	 GzauFVW01B4BPTXpIUYZIp4gIe4cAWicRlrIAd7HSYyHgv68dC0fN6cIPZbKOu3uTl
	 ZwhCtelJTwMo+9oFKiqBkNBwouAPSM2hKj8LJLp+ICKGe3DsZufsdbmWXbO7NPYXkw
	 rL1PmGE6SeTxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joshua Rogers <linux@joshua.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] svcrdma: bound check rq_pages index in inline path
Date: Wed, 31 Dec 2025 17:32:17 -0500
Message-ID: <20251231223217.3548253-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122918-oversight-jolliness-46c2@gregkh>
References: <2025122918-oversight-jolliness-46c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Rogers <linux@joshua.hu>

[ Upstream commit d1bea0ce35b6095544ee82bb54156fc62c067e58 ]

svc_rdma_copy_inline_range indexed rqstp->rq_pages[rc_curpage] without
verifying rc_curpage stays within the allocated page array. Add guards
before the first use and after advancing to a new page.

Fixes: d7cc73972661 ("svcrdma: support multiple Read chunks per RPC")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ adapted rc_curpage and rq_maxpages fields to ri_pageno and RPCSVC_MAXPAGES constant ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index e460e25a1d6d..249a17c7e82b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -815,6 +815,9 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
 	for (page_no = 0; page_no < numpages; page_no++) {
 		unsigned int page_len;
 
+		if (info->ri_pageno >= RPCSVC_MAXPAGES)
+			return -EINVAL;
+
 		page_len = min_t(unsigned int, remaining,
 				 PAGE_SIZE - info->ri_pageoff);
 
-- 
2.51.0


