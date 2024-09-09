Return-Path: <stable+bounces-74038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDE8971D49
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA0E1F22CC8
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BB31BBBF0;
	Mon,  9 Sep 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ7v4lTa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62061AE039
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893788; cv=none; b=P1PT+gdUgsa/K+yL5ajP/kRY2YO/0m08ELkelbwruGwVToWN0iksnXWYQvksidY35tXqa59NNWHkX0fB41XNZp9AG218ZAY9A0fuFln+Lf2p81d9vCfbm2ISMBedWXOOGXcGxvxLPRyTlepnMVIJV1OTu79MqWNqw7rfzzUxny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893788; c=relaxed/simple;
	bh=oM35wI3yShV9+YloJzP0hkmwTPFlYqmSx68hP0J6eVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNTzSPaWaE0MawY8npbwFXFHAmlDV+dPB7QhpcQwP/ZN7KlEUQb4cmtR8874UX9LOYr8BB5E0CClMt91q9k+j1J3Vgg0VwwZgqPLKMLjf94OhY6jbfP7LtN/oZEPtbbc6nyXL7613KkGA+2nvHQhI5+kF8a1+qmCeRdTEd3YsVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ7v4lTa; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so292962566b.1
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 07:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725893785; x=1726498585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49HyxIPXe0OyYRBIiBGK4iFxd6ziPbpzEwKqULcn0To=;
        b=OZ7v4lTadLyQ8Jkqyf3YBzhcoowy8bRqfKcXuoMfsa1ZLB4du6oH914FxjlmIGfr6X
         3nv0xaOFvxvDe9EgoamXHph1GqyrcXxahqOFFqMT9god5runacqdEqZZXMB1AqJPOChW
         OQiR0OqAbsD41zzkLeWgjJ5DMKOMJdg9SmAzweXUfY44qOIp33nCdWY+JDf/qD06eH8E
         7RDbGPCE7fj75xH/YBylPrRFEpDFMcBXExLQTsmwbsiNmJScCKKfIYEXB3B1Dd4rbA5C
         J+2rEWgPKIaiqVCYFVs44/2z8IQxC9Kf7eQLQXFPFN0KwOrwLSagTXc1SOOP51lJdxUc
         w5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893785; x=1726498585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49HyxIPXe0OyYRBIiBGK4iFxd6ziPbpzEwKqULcn0To=;
        b=ujZ2q134efHWIS3CLKrTcMWuIrDJpl5tc5Nyi2Pgk8XCw9bO3dsqNcMIxNA5BI6mvV
         lwyGu7JlebNUeo+ZTpRIVouWXEwuDWGfk11Jgp8KtCxolBnmSxwPEn6rvVkqc67fMSuV
         Ix2RS3DNiVJPS841ungLzZGngt6+75Ki54p0cL3iZQamd0wiR8aNBEYbrU4eHpXJSkhQ
         SLabGnOX7flu0WG0XXQszq6oAwgnCpdO8gSn/BOEg++pieN8HmXs4KeC4vpiObbXUOTP
         vc5yviIIJbuTx6c75PrzHwiVIhySgTEtGe7nORWnskZaZMrlK1IcFXZHawL5FzDcnhs7
         C57Q==
X-Gm-Message-State: AOJu0YyvUmx5ZAI854WtGxAxy7dgUbicisXSnb74RprYo75fCi8NGlzv
	3E/nktTODR+SFdD7ybV8GllE5e3GVHfx5Io6OZwFlUv+/Mc8K9yOq1VnnQ1AW5jf9w==
X-Google-Smtp-Source: AGHT+IFo6FzPMo0OTasum5F8QHrGkuSBA2yG240J5VJvKZJgBqbKtNCE4gDTANK7lE7jV+RO1g/qiA==
X-Received: by 2002:a17:907:970c:b0:a8c:d6a3:d03a with SMTP id a640c23a62f3a-a8cd6a3d36fmr1075590066b.21.1725893783844;
        Mon, 09 Sep 2024 07:56:23 -0700 (PDT)
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d63c0fsm352830166b.213.2024.09.09.07.56.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2024 07:56:23 -0700 (PDT)
From: Tomas Krcka <tomas.krcka@gmail.com>
X-Google-Original-From: Tomas Krcka <krckatom@amazon.de>
To: stable@vger.kernel.org
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tomas Krcka <krckatom@amazon.de>
Subject: [PATCH 5.10.y v2] memcg: protect concurrent access to mem_cgroup_idr
Date: Mon,  9 Sep 2024 14:55:57 +0000
Message-Id: <20240909145557.78179-1-krckatom@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2024081218-demote-shakily-f31c@gregkh>
References: <2024081218-demote-shakily-f31c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shakeel Butt <shakeel.butt@linux.dev>

commit 9972605a238339b85bd16b084eed5f18414d22db upstream.

Commit 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure after
many small jobs") decoupled the memcg IDs from the CSS ID space to fix the
cgroup creation failures.  It introduced IDR to maintain the memcg ID
space.  The IDR depends on external synchronization mechanisms for
modifications.  For the mem_cgroup_idr, the idr_alloc() and idr_replace()
happen within css callback and thus are protected through cgroup_mutex
from concurrent modifications.  However idr_remove() for mem_cgroup_idr
was not protected against concurrency and can be run concurrently for
different memcgs when they hit their refcnt to zero.  Fix that.

We have been seeing list_lru based kernel crashes at a low frequency in
our fleet for a long time.  These crashes were in different part of
list_lru code including list_lru_add(), list_lru_del() and reparenting
code.  Upon further inspection, it looked like for a given object (dentry
and inode), the super_block's list_lru didn't have list_lru_one for the
memcg of that object.  The initial suspicions were either the object is
not allocated through kmem_cache_alloc_lru() or somehow
memcg_list_lru_alloc() failed to allocate list_lru_one() for a memcg but
returned success.  No evidence were found for these cases.

Looking more deeply, we started seeing situations where valid memcg's id
is not present in mem_cgroup_idr and in some cases multiple valid memcgs
have same id and mem_cgroup_idr is pointing to one of them.  So, the most
reasonable explanation is that these situations can happen due to race
between multiple idr_remove() calls or race between
idr_alloc()/idr_replace() and idr_remove().  These races are causing
multiple memcgs to acquire the same ID and then offlining of one of them
would cleanup list_lrus on the system for all of them.  Later access from
other memcgs to the list_lru cause crashes due to missing list_lru_one.

Link: https://lkml.kernel.org/r/20240802235822.1830976-1-shakeel.butt@linux.dev
Fixes: 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure after many small jobs")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[Adapted due to commits
be740503ed03 ("mm: memcontrol: fix cannot alloc the maximum memcg ID")
6f0df8e16eb5 ("memcontrol: ensure memcg acquired by id is properly set up")
not in the tree]
Signed-off-by: Tomas Krcka <krckatom@amazon.de>
---
 mm/memcontrol.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 874f91715296..8de7c72ae025 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5160,11 +5160,28 @@ static struct cftype mem_cgroup_legacy_files[] = {
  */
 
 static DEFINE_IDR(mem_cgroup_idr);
+static DEFINE_SPINLOCK(memcg_idr_lock);
+
+static int mem_cgroup_alloc_id(void)
+{
+	int ret;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&memcg_idr_lock);
+	ret = idr_alloc(&mem_cgroup_idr, NULL, 1, MEM_CGROUP_ID_MAX + 1,
+			GFP_NOWAIT);
+	spin_unlock(&memcg_idr_lock);
+	idr_preload_end();
+	return ret;
+}
 
 static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 {
 	if (memcg->id.id > 0) {
+		spin_lock(&memcg_idr_lock);
 		idr_remove(&mem_cgroup_idr, memcg->id.id);
+		spin_unlock(&memcg_idr_lock);
+
 		memcg->id.id = 0;
 	}
 }
@@ -5294,9 +5311,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (!memcg)
 		return ERR_PTR(error);
 
-	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX,
-				 GFP_KERNEL);
+	memcg->id.id = mem_cgroup_alloc_id();
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
 		goto fail;
@@ -5342,7 +5357,9 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
 	memcg->deferred_split_queue.split_queue_len = 0;
 #endif
+	spin_lock(&memcg_idr_lock);
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
+	spin_unlock(&memcg_idr_lock);
 	return memcg;
 fail:
 	mem_cgroup_id_remove(memcg);
-- 
2.40.1


