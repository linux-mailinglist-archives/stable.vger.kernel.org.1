Return-Path: <stable+bounces-244832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH7lKQpT/mntpAAAu9opvQ
	(envelope-from <stable+bounces-244832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:18:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF454FBD72
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E73B30277DF
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 21:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1AC379993;
	Fri,  8 May 2026 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkMCowwb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267C35E95A
	for <stable@vger.kernel.org>; Fri,  8 May 2026 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275079; cv=none; b=GK1QodalhMRMU6/OjmVUW0g4JC2tuS3SIWTXSjG5IEJoleNV1M9/l1obRt8GAVy8YVN81piT6sGXpw87oIgMPx1aPNSoXzprHhDqAWYZB/P3v1k8Vk+rO2B2xEC97tDbxE7w//cTKhQD5QVRlhaM1Gt7+JNXhDGyom8LkGkqwsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275079; c=relaxed/simple;
	bh=RiMJDoehrv66r4+JfmD2QEkkUhEsWuBIHlDfMw43XXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnhB9VyLvZMs4/TON3V+S6WoTsIMBafqoWOfvR2ZVMvJ+xTj88g84W4gNzRyAoUydU3VttLWzCfG/BvgWAC4i5Zp6cK2G/bYFw26VQ2Ul7+jeitrVEKRdedkyCqdQKH0cXVPi+Arh1Mq76RXllfKeBgzIY8u3nQf2HZHPljNIA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkMCowwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB397C2BCB0;
	Fri,  8 May 2026 21:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778275079;
	bh=RiMJDoehrv66r4+JfmD2QEkkUhEsWuBIHlDfMw43XXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkMCowwbMZye+iDzEpZwQGGfXmrkXr3KnORk6CM7aa+8VRv41QBAsWWLpsGxnK8lj
	 5ptkTNs2r3+cqClDY0kZWCzHWJGgDqrCRZgUBkym+aUebHDiQLwSzTNcMOQ2Kcrn/b
	 HGhHUY27JvFcefRcpj1CfnfO7jdKYxJQaLa8lSUkYeH8NVmV+XKQ+Yc8sg/cuBnMHE
	 NK0FZpjTeEbHWDL2mv1/ysyRx0pQOlxliWXYohIwsjQT9SWSURsCidM0OMk4nJ9dAc
	 PQEDVoegZoQ3ewbWo/lPPkstOztNV0JpArPv85DTve42PEOa0uvtIzV+Oa5tSA06Vs
	 UKgcn+smiJbFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kairui Song <kasong@tencent.com>,
	Carsten Grohmann <mail@carstengrohmann.de>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm, swap: speed up hibernation allocation and writeout
Date: Fri,  8 May 2026 17:17:56 -0400
Message-ID: <20260508211756.1960595-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050440-judgingly-glandular-5a54@gregkh>
References: <2026050440-judgingly-glandular-5a54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BF454FBD72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244832-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[tencent.com,carstengrohmann.de,redhat.com,kernel.org,huaweicloud.com,gmail.com,linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.266];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:email,tencent.com:email]
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

[ Upstream commit 396f57b5720024638dbb503f6a4abd988a49d815 ]

Since commit 0ff67f990bd4 ("mm, swap: remove swap slot cache"),
hibernation has been using the swap slot slow allocation path for
simplification, which turns out might cause regression for some devices
because the allocator now rotates clusters too often, leading to slower
allocation and more random distribution of data.

Fast allocation is not complex, so implement hibernation support as well.

Test result with Samsung SSD 830 Series (SATA II, 3.0 Gbps) shows the
performance is several times better [1]:
6.19:               324 seconds
After this series:  35 seconds

Link: https://lkml.kernel.org/r/20260216-hibernate-perf-v4-1-1ba9f0bf1ec9@tencent.com
Link: https://lore.kernel.org/linux-mm/8b4bdcfa-ce3f-4e23-839f-31367df7c18f@gmx.de/ [1]
Signed-off-by: Kairui Song <kasong@tencent.com>
Fixes: 0ff67f990bd4 ("mm, swap: remove swap slot cache")
Reported-by: Carsten Grohmann <mail@carstengrohmann.de>
Closes: https://lore.kernel.org/linux-mm/20260206121151.dea3633d1f0ded7bbf49c22e@linux-foundation.org/
Cc: Baoquan He <bhe@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chris Li <chrisl@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adjusted helper signatures ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/swapfile.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 89746abc47373..ca0298a840cdd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2014,8 +2014,9 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 
 swp_entry_t get_swap_page_of_type(int type)
 {
-	struct swap_info_struct *si = swap_type_to_info(type);
-	unsigned long offset;
+	struct swap_info_struct *pcp_si, *si = swap_type_to_info(type);
+	unsigned long pcp_offset, offset = SWAP_ENTRY_INVALID;
+	struct swap_cluster_info *ci;
 	swp_entry_t entry = {0};
 
 	if (!si)
@@ -2025,11 +2026,21 @@ swp_entry_t get_swap_page_of_type(int type)
 	if (get_swap_device_info(si)) {
 		if (si->flags & SWP_WRITEOK) {
 			/*
-			 * Grab the local lock to be complaint
-			 * with swap table allocation.
+			 * Try the local cluster first if it matches the device. If
+			 * not, try grab a new cluster and override local cluster.
 			 */
 			local_lock(&percpu_swap_cluster.lock);
-			offset = cluster_alloc_swap_entry(si, 0, 1);
+			pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
+			pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
+			if (pcp_si == si && pcp_offset) {
+				ci = swap_cluster_lock(si, pcp_offset);
+				if (cluster_is_usable(ci, 0))
+					offset = alloc_swap_scan_cluster(si, ci, pcp_offset, 0, 1);
+				else
+					swap_cluster_unlock(ci);
+			}
+			if (!offset)
+				offset = cluster_alloc_swap_entry(si, 0, 1);
 			local_unlock(&percpu_swap_cluster.lock);
 			if (offset)
 				entry = swp_entry(si->type, offset);
-- 
2.53.0


