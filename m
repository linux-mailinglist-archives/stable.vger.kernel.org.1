Return-Path: <stable+bounces-224673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKGVMuBMsWlCtAIAu9opvQ
	(envelope-from <stable+bounces-224673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:07:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C089262BCD
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF79B3171B3D
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BBC3D666A;
	Wed, 11 Mar 2026 11:04:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F33D669A;
	Wed, 11 Mar 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227051; cv=none; b=ukfosW+rthN8f9UDXTL2CsEV75lxh0bK6qkg7bpW6ikD4YW05Uxw0s4uU8jLj6p4UHCgDhZNJ99b6FfZxw4w5nHoyX8wdToLhbtFgQDR/Sn1wL3AKMjZQy92SZw13eoCYVDPtpkw59Fwzn7syJvC7yVJkzLSFyZCzaM42JVnTrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227051; c=relaxed/simple;
	bh=dUS30z5mwiHKFQ3rO9Ro70hyG3QRgNKWXiRNvl5lVB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvLoTTnysTcHnzPBmMOFsva+AdumGcMsYNReOIxZX2X7J3pJNA6HdgS0ISoVp8wdN2+iKUveox0nt9AUlZX2TEeEtz3+4mns3MVkpoAYrNOqu6HuXQtcnO3Dr8VtYVkkBkRMdwyqnBqpZ7aS/k7S4jkoejWGGVGuaclP7EfexJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A2D24329A;
	Wed, 11 Mar 2026 11:03:58 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: akpm@linux-foundation.org
Cc: alexghiti@kernel.org,
	kernel-team@meta.com,
	akinobu.mita@gmail.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	gourry@gourry.net,
	apopple@nvidia.com,
	byungchul@sk.com,
	joshua.hahnjy@gmail.com,
	matthew.brost@intel.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] mm: Fix demotion gfp by preserving initial gfp reclaim policy
Date: Wed, 11 Mar 2026 12:02:43 +0100
Message-ID: <20260311110314.237315-5-alex@ghiti.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311110314.237315-1-alex@ghiti.fr>
References: <20260311110314.237315-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeeludffffethfejfefhfeeukeevffehjedtieelgfekjedtueegfeduhfeifefgudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedviedvtdemuddtugemtgdtledvmeegtddtmeemheemfegriegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdeivddtmedutdgumegttdelvdemgedttdemmeehmeefrgeivgdphhgvlhhopegrlhgvgihghhhithhiqdhfvgguohhrrgdqrffhgefokeeivdfrrdhthhgvfhgrtggvsghoohhkrdgtohhmpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpqhhiugepleetvdffvdegfedvleetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvdelpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrlhgvgihghhhithhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghom
 hdprhgtphhtthhopegrkhhinhhosghumhhithgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhm
X-GND-State: clean
X-Rspamd-Queue-Id: 2C089262BCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224673-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ghiti.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,meta.com,gmail.com,oracle.com,google.com,suse.com,cmpxchg.org,bytedance.com,linux.dev,gourry.net,nvidia.com,sk.com,intel.com,linux.alibaba.com,kvack.org,vger.kernel.org,ghiti.fr];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ghiti.fr:mid,ghiti.fr:email]
X-Rspamd-Action: no action

When the src folio is a hugetlb page, htlb_modify_alloc_mask() will
unconditionally enable reclaim. But we have to preserve initial gfp
flags which, in the case of demotion, prevent direct reclaim.

Reported-by: Gregory Price <gourry@gourry.net>
Closes: https://lore.kernel.org/linux-mm/aXkfBF5bdnTZ7t7e@gourry-fedora-PF4VCD3F/
Fixes: 19fc7bed252c ("mm/migrate: introduce a standard migration target allocation function")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/migrate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ee533a4d38db..d44a34d37007 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2169,13 +2169,13 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
 struct folio *alloc_migration_target(struct folio *src, unsigned long private)
 {
 	struct migration_target_control *mtc;
-	gfp_t gfp_mask;
+	gfp_t gfp_mask, gfp_entry;
 	unsigned int order = 0;
 	int nid;
 	enum zone_type zidx;
 
 	mtc = (struct migration_target_control *)private;
-	gfp_mask = mtc->gfp_mask;
+	gfp_mask = gfp_entry = mtc->gfp_mask;
 	nid = mtc->nid;
 	if (nid == NUMA_NO_NODE)
 		nid = folio_nid(src);
@@ -2184,6 +2184,8 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
 		struct hstate *h = folio_hstate(src);
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
+		gfp_mask = (gfp_mask & ~__GFP_RECLAIM) | (gfp_entry & __GFP_RECLAIM);
+
 		return alloc_hugetlb_folio_nodemask(h, nid,
 						mtc->nmask, gfp_mask,
 						htlb_allow_alloc_fallback(mtc->reason));
-- 
2.53.0


