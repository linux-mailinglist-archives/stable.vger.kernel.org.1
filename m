Return-Path: <stable+bounces-204397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9530CECA3C
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 23:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62073007687
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 22:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C070A30AAD0;
	Wed, 31 Dec 2025 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExW7TUFD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A7E1A239A
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221066; cv=none; b=lXe9NkWVo0jFwO5xYK8Upo0qcFsuEt+Rxkm547+4Krs+hHHlIdHudMlVjVN5d6JE6EEshebAsr6WCthcxe+HLEcomQnvZszniLb6UuYhSjjF+Lzl1UwBU4D4BwIQa5/MTRQF88t1Utv6vyweFQz3Sjg1Iqo0bFPrf2CSAYBRZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221066; c=relaxed/simple;
	bh=0j5x1dlzfQTwh4fDE3TsPzSfQ4FuEK+wMJl+aOxqDXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+j4ETqsCZ8/cJAwzqBdc158yFFmsIxX199NJkzyb7T9iR4L8CRaHtCiKXeDNlBR2Sw2XfFF3RJchH6scuKuctcfV+tTrA64tlCK/zAdUJj0hTjtJYFyGS+Lcj23dWlpxk/qBOVh4egBDxCYwfJfyMmNoTy9AyvYKU5LpsQ+u4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExW7TUFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5B6C113D0;
	Wed, 31 Dec 2025 22:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767221066;
	bh=0j5x1dlzfQTwh4fDE3TsPzSfQ4FuEK+wMJl+aOxqDXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExW7TUFDBiX/V7eUe8eautpIPMtmSn5HQTSmAHqgslDNhG85+DRxoH3e4bASeB7wG
	 0d/xfd/pNZ43P97eH/WvtzSJO6pKZ6o8G1BX/plwpvC6SKu15DTOcV2nLAG0ZCeOH3
	 oOoTWecKAoqjQb1+78Yx9EjO4p4F9Nujyfsk9cZ4P0qh62zPmG7rpZnC8po7OAkpqn
	 TBiahyCTw3NBmbzLoLA7dIVFJwLFELCrGNpy7sAcf1jfkZL1mEDikf9PA2OcdGoTyy
	 4uioFojPIROkfO2Ev+DiFhkUrv51Bl0HX7oE+qieE/wmDFmZcj5bJgw4J8bn1dpSKv
	 Lailrz7ukOxyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joshua Rogers <linux@joshua.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] svcrdma: bound check rq_pages index in inline path
Date: Wed, 31 Dec 2025 17:44:24 -0500
Message-ID: <20251231224424.3631279-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122934-smartness-abrasive-06be@gregkh>
References: <2025122934-smartness-abrasive-06be@gregkh>
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
index 50bf62f85166..bfa137ad7710 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -789,6 +789,9 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
 	for (page_no = 0; page_no < numpages; page_no++) {
 		unsigned int page_len;
 
+		if (info->ri_pageno >= RPCSVC_MAXPAGES)
+			return -EINVAL;
+
 		page_len = min_t(unsigned int, remaining,
 				 PAGE_SIZE - info->ri_pageoff);
 
-- 
2.51.0


