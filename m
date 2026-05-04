Return-Path: <stable+bounces-243299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L30MSuo+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:07:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB414BE8E7
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 597633024AA6
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2183DE45C;
	Mon,  4 May 2026 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DQmpMvtc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C775801;
	Mon,  4 May 2026 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903529; cv=none; b=tcKWxgzBBlzwuqUkGqAVawezmQCIj8v9cUSSE2eEPuMWD1VWYKjvGg5UiEZjip+C7ysQr3W7wdmC77a4gHrVDg/3zAOJyU/cnOxzIIYi+rQf5KAhwoaKG5VgPZG1tDiR+EKGKBdwOOyQieXZbYK02t9uenwf6oLeUoaQCUJRzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903529; c=relaxed/simple;
	bh=NScCOg4KpNXCOfWL/hbuALRF8hhW0FAysoeVcR4rk8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieJDur1KC8yV+GHKtC8SwJw3+HuAGJ/dDKsC5nOE6IhRqAVaQ7BZ9UKjknnbZGjlwJy/wc4Jkk81QY+yMJvVewMQj7Mxaul2qbbOdc1xemrN+AWG7b91XXdPq/hF4flq5QZ5SlSZ1lm2I6otXkMhw6ffYeblo+oYPLzB3f9f+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DQmpMvtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA084C2BCB8;
	Mon,  4 May 2026 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903529;
	bh=NScCOg4KpNXCOfWL/hbuALRF8hhW0FAysoeVcR4rk8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQmpMvtcqgn+UNW3E8B9dHhTaUAiLz6zVpjqiIB9D2F4Z27LxQhaomDPuyCpjTwSx
	 RPf/MuWpuNEqjs+/QPMOxpzkvgCKozSjZ4pBYCrP3jpbMIG8qazA507OYzX9owbKTJ
	 enEVv6qvgLBt3BsH5veKbrczn1ZZ/7uYw7rOvLQs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kairui Song <kasong@tencent.com>,
	Carsten Grohmann <mail@carstengrohmann.de>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.0 242/307] mm, swap: speed up hibernation allocation and writeout
Date: Mon,  4 May 2026 15:52:07 +0200
Message-ID: <20260504135151.939278675@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EB414BE8E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,tencent.com,carstengrohmann.de,redhat.com,kernel.org,huaweicloud.com,gmail.com,linux-foundation.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-243299-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.851];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huaweicloud.com:email,tencent.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kairui Song <kasong@tencent.com>

commit 396f57b5720024638dbb503f6a4abd988a49d815 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/swapfile.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1926,8 +1926,9 @@ out:
 /* Allocate a slot for hibernation */
 swp_entry_t swap_alloc_hibernation_slot(int type)
 {
-	struct swap_info_struct *si = swap_type_to_info(type);
-	unsigned long offset;
+	struct swap_info_struct *pcp_si, *si = swap_type_to_info(type);
+	unsigned long pcp_offset, offset = SWAP_ENTRY_INVALID;
+	struct swap_cluster_info *ci;
 	swp_entry_t entry = {0};
 
 	if (!si)
@@ -1937,11 +1938,21 @@ swp_entry_t swap_alloc_hibernation_slot(
 	if (get_swap_device_info(si)) {
 		if (si->flags & SWP_WRITEOK) {
 			/*
-			 * Grab the local lock to be compliant
-			 * with swap table allocation.
+			 * Try the local cluster first if it matches the device. If
+			 * not, try grab a new cluster and override local cluster.
 			 */
 			local_lock(&percpu_swap_cluster.lock);
-			offset = cluster_alloc_swap_entry(si, NULL);
+			pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
+			pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
+			if (pcp_si == si && pcp_offset) {
+				ci = swap_cluster_lock(si, pcp_offset);
+				if (cluster_is_usable(ci, 0))
+					offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
+				else
+					swap_cluster_unlock(ci);
+			}
+			if (!offset)
+				offset = cluster_alloc_swap_entry(si, NULL);
 			local_unlock(&percpu_swap_cluster.lock);
 			if (offset)
 				entry = swp_entry(si->type, offset);



