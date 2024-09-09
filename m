Return-Path: <stable+bounces-74026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159AB971B46
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 15:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F301F230C4
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CBD1B86FE;
	Mon,  9 Sep 2024 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9JldlFx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012C1B86ED
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889254; cv=none; b=AqhmUeWVRp06ujSn1b7N3a7Q0Kbds17CsI3XIc/7+rZJQ9V1BaV/ndCPVOxIvC5EUX0ChASYAMIQjgSteS2NWzDssCmRTGvMRURi+BUjKmiq0zxh2NPyvcER8hYKRmhjvmKA1Yhe14Pd1eZhKH4x6n2syziC19rdEJEwltm/TBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889254; c=relaxed/simple;
	bh=BVvdxUW9B/NYrnNwh5gscCPM1KzJapduFv2CsiBgDIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t33h019dGhc6XDwCkFEf5ucw7rGZfgP7G2m4cX+pKHFLsO5qmJ3INA5fxTlohR9gKaG1TKCi3iDaMWQhszjnEEuBmKXjlZy26hMjuyXOoiqyUi7MFPeiqNlGx/XxXjfiQifh5QSFhuTU/p5UhC1pQqIUYL3c2QQJjt+5nWDhj8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9JldlFx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c26b5f1ea6so5241072a12.0
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725889250; x=1726494050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI4Ixeagld2ahPHgT8MJ0PA0Greh3xh6WRCmECUwbjU=;
        b=M9JldlFxT3fxgYIeVHVVV6Lc+zdcJYqT0GbgE8sO8dJAiueG3Xu35rx1SWtdEsptTC
         NMA/REW7aSAuUvRcmpsnTx82/2MVSGzSaSc5OqEUx3XJ9Wd63A5jbHpeo+adkOPbT3ZR
         FiIVabMxFCObQtwIALmwbI4vzF9hiHfteESRQ6rNoAiJHIuIVAI6l5JOV/Yz6RmAGNGy
         y+XrkZUEeF388KrsnpZq4Dah2QRSCtuTihKv/gvBwv6ojnpKmxxMwb827a9HO0G4PaJh
         JGVhBQQtLMB/LccSLmwCqBf0NjgAIODnCTI/X63rGlZLp6mn+troBlz/hyL8NysMIezb
         +DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889250; x=1726494050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI4Ixeagld2ahPHgT8MJ0PA0Greh3xh6WRCmECUwbjU=;
        b=ZsGFe7VNnCrjR8lvXr0MM91NZOodMJB3I7Au3jQrv3+FX4i8iZSTDI5bqSbArRc3A+
         OssKmiWuAIxw6ylH7ZzZ9RBz3BzdlDXo/BA94Vk8x5gs43Arv2hjatOtyNJEMhDBqC4w
         ATdqOMV+6OuW77fLWbyqxKh32frggBdw5A92DNw/jAR2L4tVKhSixfVjuMhJtP9XdLO5
         WINMUtXdoJ4LrroghKYf1FxE9f/xCF9nF/PFHHosNQm8DAurp2FCdIHlcgmSByfn82lo
         f7oU+yBoP0fAk5nhJJbjXKM4CH0EZycCbIqj+wGX6mMK/vQqIWiMal9/DKOqlMsdFVRL
         khEw==
X-Gm-Message-State: AOJu0YzgahAbsowFzRQDlOReIVyXc/RTSaSyddm8X3OWGee73DeSeBQJ
	vbdnkTe2kB4kBydaGR8qbkL/qGnPLZuB2ym4nvC3GWIkoLWsd4AP8a+SPU846l8tOQ==
X-Google-Smtp-Source: AGHT+IFRqXeu4FQXP38H6G2QMP97VZZrGS5/ikDKa3hj23d6PsCO0yAiLLRNYQ5sEglpckQ9qBE1Gw==
X-Received: by 2002:a05:6402:2110:b0:5c2:2b1d:31e6 with SMTP id 4fb4d7f45d1cf-5c3dc7c3e8emr7392759a12.29.1725889249348;
        Mon, 09 Sep 2024 06:40:49 -0700 (PDT)
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com (54-240-197-239.amazon.com. [54.240.197.239])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd5217asm3045734a12.45.2024.09.09.06.40.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2024 06:40:49 -0700 (PDT)
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
Subject: [PATCH 5.15.y] memcg: protect concurrent access to mem_cgroup_idr
Date: Mon,  9 Sep 2024 13:40:46 +0000
Message-Id: <20240909134046.12713-1-krckatom@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2024081211-owl-snowdrop-d2aa@gregkh>
References: <2024081211-owl-snowdrop-d2aa@gregkh>
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
[Adapted over commits
be740503ed03 ("mm: memcontrol: fix cannot alloc the maximum memcg ID")
6f0df8e16eb5 ("memcontrol: ensure memcg acquired by id is properly set up")
both are not in the tree]
Signed-off-by: Tomas Krcka <krckatom@amazon.de>
---
 mm/memcontrol.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69dd12a79942..6dd32ed164ea 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5083,11 +5083,28 @@ static struct cftype mem_cgroup_legacy_files[] = {
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
@@ -5201,9 +5218,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (!memcg)
 		return ERR_PTR(error);
 
-	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX,
-				 GFP_KERNEL);
+	memcg->id.id = mem_cgroup_alloc_id();
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
 		goto fail;
@@ -5244,7 +5259,9 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
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


