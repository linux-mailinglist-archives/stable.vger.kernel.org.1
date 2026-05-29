Return-Path: <stable+bounces-256643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNRzF0alGWptyAgAu9opvQ
	(envelope-from <stable+bounces-256643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:40:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A0E603BF9
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C93C53076422
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD393A961A;
	Fri, 29 May 2026 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="frmzm4Bw"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3502E14ABE;
	Fri, 29 May 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065238; cv=none; b=tXu1VE4lsin6SMqZF9OO/5Bsf//4ojVOGD/HlLbdsUa8nNtQiycUA/By8BHhUo3WGwCTjccn07B14JZp3KHrb/ZHRtEdFwImyE+Pap9qbGue/d3Wl9FPMR5S8hfP99ufl/ImLCQRy8+8RAJ8VOAU0bIyWSL3OXAq5qWIO+Ew8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065238; c=relaxed/simple;
	bh=DxQIY9aVNXnbe+nacPZDzEqdF/6n6FZ2z0Z159xjSJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P65Z42UXS4iJANJAuuTmBjW/o84sVXBBEA1UmPbvEUFmI4bop3mHkplTkdLS1wbLGFFqdjlLCo2G8VmnEupdCdPy2NAwR/csunkRrxZy8tHB5xUZcsNWIYsIRK70gcTVImVACEDJH5HDp7LqdLMpTHGR/eShP7Z5D7qTo73p3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=frmzm4Bw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F4BF1FC7;
	Fri, 29 May 2026 07:33:50 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF6B03F905;
	Fri, 29 May 2026 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780065235; bh=DxQIY9aVNXnbe+nacPZDzEqdF/6n6FZ2z0Z159xjSJk=;
	h=From:To:Cc:Subject:Date:From;
	b=frmzm4Bw0NKUCKg7cScfgm4wYmILy10DV6QqLlMXsaJp5zwedFU4kHAze4ZyreWSn
	 7qevaKhEkRLfLeEvA/Pu5o224lb3z/IdD12EyF9fX8reA+k+NVfOoML+tzwW645ugf
	 Kr+A0g++p6Yy/rHfK1clZfFRGv67X8sEJWu2VDjc=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] perf/arm-cmn: Fix DVM node events
Date: Fri, 29 May 2026 15:33:45 +0100
Message-ID: <1af20ba3fb35cc507e0d74408675b50340feca39.1780065225.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	TAGGED_FROM(0.00)[bounces-256643-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arm.com:email,arm.com:mid,arm.com:dkim]
X-Rspamd-Queue-Id: 78A0E603BF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The new DVM node events added in CMN-700 also apply to CMN S3; fix
the model encoding so that we can expose the aliases and handle
occupancy filtering on newer CMNs too.

Cc: <stable@vger.kernel.org>
Fixes: 0dc2f4963f7e ("perf/arm-cmn: Support CMN S3")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index f5305c8fdca4..6e5cc4086a9e 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -197,13 +197,14 @@
 enum cmn_model {
 	CMN600 = 1,
 	CMN650 = 2,
-	CMN700 = 4,
-	CI700 = 8,
+	CI700 = 4,
+	CMN700 = 8,
 	CMNS3 = 16,
 	/* ...and then we can use bitmap tricks for commonality */
 	CMN_ANY = -1,
 	NOT_CMN600 = -2,
-	CMN_650ON = CMN650 | CMN700 | CMNS3,
+	CMN_700ON = ~(CMN700 - 1),
+	CMN_650ON = CMN_700ON | CMN650,
 };
 
 /* Actual part numbers and revision IDs defined by the hardware */
@@ -919,14 +920,14 @@ static struct attribute *arm_cmn_event_attrs[] = {
 	CMN_EVENT_DVM(NOT_CMN600, txsnp_stall,		0x0a),
 	CMN_EVENT_DVM(NOT_CMN600, trkfull,		0x0b),
 	CMN_EVENT_DVM_OCC(NOT_CMN600, trk_occupancy,	0x0c),
-	CMN_EVENT_DVM_OCC(CMN700, trk_occupancy_cxha,	0x0d),
-	CMN_EVENT_DVM_OCC(CMN700, trk_occupancy_pdn,	0x0e),
-	CMN_EVENT_DVM(CMN700, trk_alloc,		0x0f),
-	CMN_EVENT_DVM(CMN700, trk_cxha_alloc,		0x10),
-	CMN_EVENT_DVM(CMN700, trk_pdn_alloc,		0x11),
-	CMN_EVENT_DVM(CMN700, txsnp_stall_limit,	0x12),
-	CMN_EVENT_DVM(CMN700, rxsnp_stall_starv,	0x13),
-	CMN_EVENT_DVM(CMN700, txsnp_sync_stall_op,	0x14),
+	CMN_EVENT_DVM_OCC(CMN_700ON, trk_occupancy_cxha, 0x0d),
+	CMN_EVENT_DVM_OCC(CMN_700ON, trk_occupancy_pdn,	0x0e),
+	CMN_EVENT_DVM(CMN_700ON, trk_alloc,		0x0f),
+	CMN_EVENT_DVM(CMN_700ON, trk_cxha_alloc,	0x10),
+	CMN_EVENT_DVM(CMN_700ON, trk_pdn_alloc,		0x11),
+	CMN_EVENT_DVM(CMN_700ON, txsnp_stall_limit,	0x12),
+	CMN_EVENT_DVM(CMN_700ON, rxsnp_stall_starv,	0x13),
+	CMN_EVENT_DVM(CMN_700ON, txsnp_sync_stall_op,	0x14),
 
 	CMN_EVENT_HNF(CMN_ANY, cache_miss,		0x01),
 	CMN_EVENT_HNF(CMN_ANY, slc_sf_cache_access,	0x02),
-- 
2.54.0.dirty


