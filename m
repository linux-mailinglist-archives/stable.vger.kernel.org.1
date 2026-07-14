Return-Path: <stable+bounces-274216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5vtINcsmVmqW0AAAu9opvQ
	(envelope-from <stable+bounces-274216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 14:08:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9BC7544AE
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 14:08:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.it header.s=amazoncorp2 header.b=S25TugjO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274216-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274216-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB562309CCF3
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002AB38F651;
	Tue, 14 Jul 2026 12:02:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823C37A83B;
	Tue, 14 Jul 2026 12:02:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030577; cv=none; b=uIoyUo+QweLPMMFEr8Npjs7IU2Q7NSSbQYA1rNBOWdmXUDrteHnlYer8VYLjs2VvmitPlWNTByKdq3Gd7w6EfhZnsm12n34U8vIdIpYAj5KKfRdoO+LNiD4GdddUkcJIoppepcJlxphqBIo/k0ttu/ByEiPQOkb3/RdRZQSOYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030577; c=relaxed/simple;
	bh=ROrMdPdO6onErXT9M+OlhhdYLJOoqWpGS0WOQwDjFBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HazZakktlupnyaL94v49bmcspKzk5/wOp3k4N04v35mIOee+RMxVFvxzKxiqS65coTYe1SWimPhEiafe5nla+bNbHMGKahd4J9rEyw+F9V2CHWnUZh6wU+nbK/sVQIEn5Ip7YPiC37HZliwqs70oYnouRw/uB00MRDsiNcQMkxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it; spf=pass smtp.mailfrom=amazon.it; dkim=pass (2048-bit key) header.d=amazon.it header.i=@amazon.it header.b=S25TugjO; arc=none smtp.client-ip=52.26.1.71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1784030576; x=1815566576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xg7sx8Fcwnz35cM6X5s89ftjr56njrrKRxrcpCwNiT8=;
  b=S25TugjOgABs8xxtDueQjYFK8MMWr7GZ8FNGFf1Ljhg9JBNvAeXxPprV
   O4Bsu8ggFsGfsBIJrewQrNqS07g45zegrvVlYZJjVncR5dp7xjv+V3ylN
   E9M1xAcL1ANTV7qpJomsUXRbO8sbK1nxkupgYk4bpGgtKEuPrJUjdaYU7
   ty01/vGZZ+oOMuuiAwDF5Ob4R2DrHZgZEu5VGmvqWgw4Cf8Y+uegOowaX
   285DDdkQXArAlVPzPvr5sEYJWu+D5tX/Y+6L3WTs8z0/sGlM7PMlQtfYS
   8SbnwhKnQop+rZoxmjXXC4buSQh7zrQZj5pfgy6jKb4xylppws3AQ9Q4C
   w==;
X-CSE-ConnectionGUID: BBEVK6/MRkyicl38cs1lxQ==
X-CSE-MsgGUID: 4tRkKufeQB+DvyJnPm7R1g==
X-IronPort-AV: E=Sophos;i="6.25,163,1779148800"; 
   d="scan'208";a="23659306"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:02:52 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:17218]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.175:2525] with esmtp (Farcaster)
 id ac228d5a-c9a9-439a-935a-e5fef6abf6b4; Tue, 14 Jul 2026 12:02:52 +0000 (UTC)
X-Farcaster-Flow-ID: ac228d5a-c9a9-439a-935a-e5fef6abf6b4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 12:02:52 +0000
Received: from cdd-al23.dub2.corp.amazon.com (10.253.66.177) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 12:02:48 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <hannes@cmpxchg.org>, <willy@infradead.org>
CC: <abuehaze@amazon.com>, <akpm@linux-foundation.org>, <alisaidi@amazon.com>,
	<blakgeof@amazon.com>, <brauner@kernel.org>, <dgc@kernel.org>,
	<dipietro.salvatore@gmail.com>, <dipiets@amazon.it>, <djwong@kernel.org>,
	<hch@infradead.org>, <jackmanb@google.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-xfs@vger.kernel.org>, <mhocko@suse.com>, <ritesh.list@gmail.com>,
	<stable@vger.kernel.org>, <surenb@google.com>, <vbabka@kernel.org>,
	<vbabka@suse.cz>, <ziy@nvidia.com>
Subject: Re: [PATCH v3] mm/page_alloc: avoid direct compaction for costly __GFP_NORETRY allocations
Date: Tue, 14 Jul 2026 12:02:04 +0000
Message-ID: <20260714120204.542300-1-dipiets@amazon.it>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <alEz4Chf7Ibyg-ZG@casper.infradead.org>
References: <alEz4Chf7Ibyg-ZG@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[amazon.it:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.it,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.it:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amazon.com,linux-foundation.org,kernel.org,gmail.com,amazon.it,infradead.org,google.com,vger.kernel.org,kvack.org,suse.com,suse.cz,nvidia.com];
	TAGGED_FROM(0.00)[bounces-274216-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:willy@infradead.org,m:abuehaze@amazon.com,m:akpm@linux-foundation.org,m:alisaidi@amazon.com,m:blakgeof@amazon.com,m:brauner@kernel.org,m:dgc@kernel.org,m:dipietro.salvatore@gmail.com,m:dipiets@amazon.it,m:djwong@kernel.org,m:hch@infradead.org,m:jackmanb@google.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-xfs@vger.kernel.org,m:mhocko@suse.com,m:ritesh.list@gmail.com,m:stable@vger.kernel.org,m:surenb@google.com,m:vbabka@kernel.org,m:vbabka@suse.cz,m:ziy@nvidia.com,m:dipietrosalvatore@gmail.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dipiets@amazon.it,stable@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amazon.it:from_mime,amazon.it:dkim,amazon.it:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipiets@amazon.it,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.it:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A9BC7544AE


Hi Johannes, Matthew,

Thank you both for the alternative proposals. I've tested both
approaches on the same test environment used for v3.

Results (4 runs each):

  Config                   Avg TPS      % vs Baseline
  --------------------------------------------------------
  baseline (no patch)       70,735       -
  Johannes' approach       156,908      +121.8%
  Matthew's approach        70,145       -0.8% (within noise)


Johannes' approach (clearing __GFP_DIRECT_RECLAIM early in the
slowpath for costly __GFP_NORETRY) delivers the same ~2.2x speedup
as v3, as expected - it prevents the entire direct reclaim and
compaction machinery from running for these opportunistic allocations.

Matthew's filemap.c approach does not help in this workload.  The
reason is that the first allocation attempt at max order still carries
__GFP_DIRECT_RECLAIM and enters the slowpath with direct compaction
enabled.  The __GFP_DIRECT_RECLAIM clearing only takes effect for 
subsequent lower-order attempts in the fallback loop, but the costly 
compaction has already executed on the first try.

Let me know if you have any other variant you want me to test, 
or if I should prepare a v4 based on Johannes' suggestion.

This is what I tested for Johannes' approach:


diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a63733dac659..6e960c969e67 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4733,10 +4733,10 @@ static inline struct page *
 __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 					struct alloc_context *ac)
 {
-	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
-	bool can_compact = can_direct_reclaim && gfp_compaction_allowed(gfp_mask);
-	bool nofail = gfp_mask & __GFP_NOFAIL;
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
+	bool can_direct_reclaim;
+	bool can_compact;
+	bool nofail;
 	struct page *page = NULL;
 	unsigned int alloc_flags;
 	unsigned long did_some_progress;
@@ -4751,6 +4751,20 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	bool can_retry_reserves = true;
 	unsigned long alloc_start_time = jiffies;
 
+	/*
+	 * Costly __GFP_NORETRY allocations are opportunistic: the caller
+	 * can fall back to smaller orders.  Don't stall on direct reclaim
+	 * or compaction; clearing __GFP_DIRECT_RECLAIM makes the entire
+	 * slowpath treat this as a non-blocking request.  kswapd will wake
+	 * kcompactd as needed for background defragmentation.
+	 */
+	if (costly_order && (gfp_mask & __GFP_NORETRY))
+		gfp_mask &= ~__GFP_DIRECT_RECLAIM;
+
+	can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
+	can_compact = can_direct_reclaim && gfp_compaction_allowed(gfp_mask);
+	nofail = gfp_mask & __GFP_NOFAIL;
+
 	if (unlikely(nofail)) {
 		/*
 		 * Also we don't support __GFP_NOFAIL without __GFP_DIRECT_RECLAIM,


Thanks,
Salvatore





AMAZON DEVELOPMENT CENTER ITALY SRL, viale Monte Grappa 3/5, 20124 Milano, Italia, Registro delle Imprese di Milano Monza Brianza Lodi REA n. 2504859, Capitale Sociale: 10.000 EUR i.v., Cod. Fisc. e P.IVA 10100050961, Societa con Socio Unico




