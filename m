Return-Path: <stable+bounces-270420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F0FrCrpXRmq3RAsAu9opvQ
	(envelope-from <stable+bounces-270420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 14:21:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7188C6F77C4
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 14:21:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=DLkLz76Q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270420-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270420-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1738C321541F
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484D947DD70;
	Thu,  2 Jul 2026 12:06:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFDB48BD44
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 12:06:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993974; cv=none; b=CZB3nXRGmwxP+xyrJ1MYIrAymwljQQ/0XBLtB4HjC8V4klCp1kSFNqubjUweRT13EladaKxZse4nuMkQLr/spPlhpzAU7nakZdb7zyN/ZnClToR/HYtJYoBrAAZfYePRQfZI/1eebwT6dxwmmGvjwKmmw1JoHc2VCTc+i+cHR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993974; c=relaxed/simple;
	bh=wL6EI+19wHEEY+WMTOkkSKEWQTxQHKe051Ieglp4iaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t74DPJlLtzDlHO2kFyR5bLSKGA0kYAyQh5fcAT1ZAsJ/JY7SKtG+9kxij8245CQUJMMqubQUlfXlGhmbDTJazevv5Ne0DX3aEh+d2D7IJgYu14+s8B2EDt1I6JSh+K7O6ECn6VYMoWkEyC0VZIs+QT8kDXb1xZyZvC5Bs1pBZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DLkLz76Q; arc=none smtp.client-ip=91.218.175.181
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782993970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ot8Pbi2ksMCb71ohLRuXFssEPjkwMgegS5vpVomHt3o=;
	b=DLkLz76Qy07SpkjgRlbk1XaeIGakKBaKar/d744vhL1M11MSRoNs+e6pFM8xMn9zFtWVdB
	PRU49ACRUjA28JcsX8rOKJFgUaWDJ8yIsWUXEAxhNxykVp/NyRa9eQEs3hXDK/bXhaKh0L
	6ZeP6QkAAViQ/7rHWF5Wb5s7qyzOYQk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jiri Bohac <jbohac@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Diana Craciun <diana.craciun@nxp.com>,
	Jason Yan <yanaijie@huawei.com>,
	Scott Wood <oss@buserror.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/kaslr_booke: Fix reserved region overlap checks
Date: Thu,  2 Jul 2026 14:05:50 +0200
Message-ID: <20260702120551.3046-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=thorsten.blum@linux.dev; h=from:subject; bh=wL6EI+19wHEEY+WMTOkkSKEWQTxQHKe051Ieglp4iaI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFluIfIbpxwsLWjZ+Hfl5JmbThsJJulfuz7zjVTrXaWZt /bPDzjG11HKwiDGxSArpsjyYNaPGb6lNZWbTCJ2wsxhZQIZwsDFKQATmbSYkeHj9oAEvc5lkyzE 47wXfbv4zqZrm7SauY1F9cFHzdvmPzNg+F/xPUWXL0uird1pYuyuo7VP3zgrBd/XL+9/4drA7WU twwsA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270420-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:jbohac@suse.cz,m:akpm@linux-foundation.org,m:diana.craciun@nxp.com,m:yanaijie@huawei.com,m:oss@buserror.net,m:thorsten.blum@linux.dev,m:stable@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,suse.cz,linux-foundation.org,nxp.com,huawei.com,buserror.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7188C6F77C4

FDT reserved region addresses can be 64-bit, but regions_overlap() takes
32-bit arguments, which could truncate values before comparing them and
cause KASLR to incorrectly detect or miss overlaps. Make
regions_overlap() work with 64-bit values instead.

Also clamp reservation sizes before computing their end addresses to
prevent the addition from overflowing.

Fixes: 6a38ea1d7b94 ("powerpc/fsl_booke/32: randomize the kernel image offset")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/mm/nohash/kaslr_booke.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 5e4897daaaea..3e5e67c76bda 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -91,7 +91,7 @@ static __init u64 get_kaslr_seed(void *fdt)
 	return ret;
 }
 
-static __init bool regions_overlap(u32 s1, u32 e1, u32 s2, u32 e2)
+static __init bool regions_overlap(u64 s1, u64 e1, u64 s2, u64 e2)
 {
 	return e1 >= s2 && e2 >= s1;
 }
@@ -100,13 +100,15 @@ static __init bool overlaps_reserved_region(const void *fdt, u32 start,
 					    u32 end)
 {
 	int subnode, len, i;
-	u64 base, size;
+	u64 base, size, rsv_end;
 
 	/* check for overlap with /memreserve/ entries */
 	for (i = 0; i < fdt_num_mem_rsv(fdt); i++) {
 		if (fdt_get_mem_rsv(fdt, i, &base, &size) < 0)
 			continue;
-		if (regions_overlap(start, end, base, base + size))
+
+		rsv_end = base + min(size, U64_MAX - base);
+		if (regions_overlap(start, end, base, rsv_end))
 			return true;
 	}
 
@@ -118,7 +120,6 @@ static __init bool overlaps_reserved_region(const void *fdt, u32 start,
 	     subnode >= 0;
 	     subnode = fdt_next_subnode(fdt, subnode)) {
 		const fdt32_t *reg;
-		u64 rsv_end;
 
 		len = 0;
 		reg = fdt_getprop(fdt, subnode, "reg", &len);
@@ -141,8 +142,7 @@ static __init bool overlaps_reserved_region(const void *fdt, u32 start,
 			if (base >= regions.pa_end)
 				continue;
 
-			rsv_end = min(base + size, (u64)U32_MAX);
-
+			rsv_end = base + min(size, U64_MAX - base);
 			if (regions_overlap(start, end, base, rsv_end))
 				return true;
 		}

