Return-Path: <stable+bounces-224672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFBEN51MsWlCtAIAu9opvQ
	(envelope-from <stable+bounces-224672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:06:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3809E262B98
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4851F31201E8
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27E73D7D7E;
	Wed, 11 Mar 2026 11:04:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E05E3C0607;
	Wed, 11 Mar 2026 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227044; cv=none; b=Wso8MDqFWa8REIs/f6G/UE4oaOCvIEbe/TLftqhilmOncM9rof2iaJ7BlPs5uRpoI8rdFRdvU6lNdJd8s2UF/S35WEfp9ureoUnNVzzXLBeAobMyegX4a/7e7GJK0S70P4gsXNXT5EaVQ84fTWAnb4xooaErO3UGX87qOtb96MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227044; c=relaxed/simple;
	bh=DiS/za7Xcx9BgyGTN/XlBOt/05ajBcBSWxbepSobKo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8rDeszfTyhXnqVtGtzVAD397hgQQxn0QPhbbdcegDFbUeIlOOgQt0ZdakmadhkqHbtKwE1Jd9Q9+WywUycGPxgJN9jth3ewUrdgxbw3qdKEdl3Oz0SA92ZtKIlEK2lqBRWfG8fW+J6fS9mkkR4SXQAk8M03fnHLvc1HhK9+ohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B34EA4333F;
	Wed, 11 Mar 2026 11:03:53 +0000 (UTC)
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
	Bing Jiao <bingjiao@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] mm: Fix demotion gfp by clearing GFP_RECLAIM after setting GFP_TRANSHUGE
Date: Wed, 11 Mar 2026 12:02:42 +0100
Message-ID: <20260311110314.237315-4-alex@ghiti.fr>
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
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepledufffftefhjeefhfefueekveffheejtdeilefgkeejtdeugeefudfhieefgfdunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdeivddtmedutdgumegttdelvdemgedttdemmeehmeefrgeivgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedviedvtdemuddtugemtgdtledvmeegtddtmeemheemfegriegvpdhhvghloheprghlvgigghhhihhtihdqfhgvughorhgrqdfrhfegofekiedvrfdrthhhvghfrggtvggsohhokhdrtghomhdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhqihgupeeufeeggfetgeeffeefhfdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeeftddprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghlvgigghhhihhtiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepk
 hgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhrtghpthhtoheprghkihhnohgsuhhmihhtrgesghhmrghilhdrtghomhdprhgtphhtthhopegurghvihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomh
X-GND-State: clean
X-Rspamd-Queue-Id: 3809E262B98
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
	TAGGED_FROM(0.00)[bounces-224672-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ghiti.fr:mid,ghiti.fr:email]
X-Rspamd-Action: no action

GFP_TRANSHUGE sets __GFP_DIRECT_RECLAIM so we must clear GFP_RECLAIM
after, not before.

Reported-by: Bing Jiao <bingjiao@google.com>
Closes: https://lore.kernel.org/linux-mm/aXlKOxGGI9zne8sl@google.com/
Fixes: 9933a0c8a539 ("mm/migrate: clear __GFP_RECLAIM to make the migration callback consistent with regular THP allocations")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 2c3d489ecf51..ee533a4d38db 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2190,12 +2190,12 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
 	}
 
 	if (folio_test_large(src)) {
+		gfp_mask |= GFP_TRANSHUGE;
 		/*
 		 * clear __GFP_RECLAIM to make the migration callback
 		 * consistent with regular THP allocations.
 		 */
 		gfp_mask &= ~__GFP_RECLAIM;
-		gfp_mask |= GFP_TRANSHUGE;
 		order = folio_order(src);
 	}
 	zidx = folio_zonenum(src);
-- 
2.53.0


