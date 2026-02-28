Return-Path: <stable+bounces-221006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OInTJPxHo2l//AQAu9opvQ
	(envelope-from <stable+bounces-221006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0272E1C7845
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89AC93447428
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924574BC035;
	Sat, 28 Feb 2026 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVfiiXY9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E34BC02D;
	Sat, 28 Feb 2026 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301350; cv=none; b=gBJgv7FPC40lqArLlRhyThu5YRu7nBnyS4uQOC0DIozGPdZr1C7ZkRMKvsaSkObctsyvxCyzT6K0OETwqY0qmB1KD+5F9TNVk8DUd5WwJ2owPIsQfeikHfuHYxkfnKnKSX+y8klL1k4To8BAITQ1RM9afkWJpqunsw6Dva3BG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301350; c=relaxed/simple;
	bh=c3A55tmRUKNtJtG/xnSgd+ZJdr/KmsWNCeJ7nVrLmXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJDQio5cK9A9ssDgFLYSd04zH+kUY8ZPZ77TU6WR3dYVCG4gEqnRV4PHbJh7LRArRpxY5WSDmIYzL03vA2mcwwCw1IspIlWuQoyWS0WjZ3OSmqj9v99mDFmGle7huESmLRJzS98fyGQ1hB+ttzfwAkuiVvJfyWHE1fuh0wThzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVfiiXY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBFAC19424;
	Sat, 28 Feb 2026 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301350;
	bh=c3A55tmRUKNtJtG/xnSgd+ZJdr/KmsWNCeJ7nVrLmXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVfiiXY9iYgRjDrQPS46/PbZshU5UnDo9VmKJb5i0/66hO7A0YWtbJWLamaZF3ofN
	 pGvwvZ5b8qiQSNgmbVDd/h3LNO6rBK4GekKaij5Pal8okKmVbrToQxBOQP4Uczo+aT
	 b2x8I1EIwQyXJMXRLVkc7LfYe0HFEMgLsJLdfTGOm2FEa7wN8xDbphDwMn3C6+4j3s
	 +rtdqh41b3nRkWLXFLGlWDCzFN1JmRlhwo6gBEOGW74bkjyD+aZ1Rnxnf8dHvCsj/W
	 h8AZLSvWCK2iRK1CZL5/KPXFwHXwRC4lYbLn7evvJx0dX6VAAoYJdNs4E9nLrXTdih
	 KjUUnuDgEDKkA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Bingbu Cao <bingbu.cao@intel.com>,
	stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 537/752] media: staging/ipu7: Fix the loop bound in l2 table alloc
Date: Sat, 28 Feb 2026 12:44:08 -0500
Message-ID: <20260228174750.1542406-537-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221006-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0272E1C7845
X-Rspamd-Action: no action

From: Bingbu Cao <bingbu.cao@intel.com>

[ Upstream commit 98cc19a353abc8b48b7d58fd7a455e09e7c3aba3 ]

This patch fixes the incorrect loop bound in alloc_l2_pt(). When
initializing L2 page table entries, the loop was incorrectly using
ISP_L1PT_PTES instead of ISP_L2PT_PTES though the ISP_L1PT_PTES is
equal to ISP_L2PT_PTES.

Fixes: 71d81c25683a ("media: staging/ipu7: add IPU7 DMA APIs and MMU mapping")
Cc: stable@vger.kernel.org
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/ipu7/ipu7-mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu7/ipu7-mmu.c b/drivers/staging/media/ipu7/ipu7-mmu.c
index ded1986eb8ba3..ea35cce4830ad 100644
--- a/drivers/staging/media/ipu7/ipu7-mmu.c
+++ b/drivers/staging/media/ipu7/ipu7-mmu.c
@@ -231,7 +231,7 @@ static u32 *alloc_l2_pt(struct ipu7_mmu_info *mmu_info)
 
 	dev_dbg(mmu_info->dev, "alloc_l2: get_zeroed_page() = %p\n", pt);
 
-	for (i = 0; i < ISP_L1PT_PTES; i++)
+	for (i = 0; i < ISP_L2PT_PTES; i++)
 		pt[i] = mmu_info->dummy_page_pteval;
 
 	return pt;
-- 
2.51.0


