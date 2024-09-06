Return-Path: <stable+bounces-73799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA2296F87B
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 17:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEECA2813CF
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C20B1D2F56;
	Fri,  6 Sep 2024 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4ocLcdH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB01D174A
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637346; cv=none; b=JlzaqAJh2ClGoMFoa7OJ74fWGPSx7CABOhRzbG/BKwCghdQS2zfkPaLCP19ioUqoEJeaCXGQzg6h7X7f8J6WUnUIhnFg6DLrkhebluC729mjhZa6MsvMwzbjcPgjLQ621HEVVJmXG8HHVUlVy8QUThtNfSC2hDQ78pL+jIUnOhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637346; c=relaxed/simple;
	bh=yK8fvleaqVf+smE6kyG913K5mT9tivt0ZRdUeDZhHIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sKDX55bYBUJVwd6gMJY5L4Vq3vhN6DJ8oUf/rtSLS9AwTc57wBSqHXNTjuotX55OMwI2aZplp4XtnvcOhLymNQBltLdhJQ8qrzcKHPH+uNMWuFb6ws/9IYf/Gng7D7dpvnFtEtiQzZRzqEzdiCAGeddKTsBj7M/8aLag12eAGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4ocLcdH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8682bb5e79so301198466b.2
        for <stable@vger.kernel.org>; Fri, 06 Sep 2024 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725637343; x=1726242143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWq2Z5Y2NB/LPQoEsjsZIqIHLDav1GOZXqUkwsg8EvM=;
        b=C4ocLcdHXZ0cEtfUo0auV7iMU7b0dEFWYZxXCArVJXbHdm/p0gPPuw/x2DeBNugAwi
         QbcVXecyPgQBmWOkADIoHvcTyK8omFPppcs6f0iayUkaf15fPCLC4G4yrxf3RVlVd/xX
         vVoyEjwsQeP7zeaZninl/ET9RwvkvK6O/BuRBZBtkNtf7P4kAXUz1uSbphIRvtIsurLU
         HvXPnZB1pQB26ONLgAXCxUUOc8FSzWsdex4GKiKA5TaUEzDeGIBloskZ2b5mAPCeRecp
         NfHOMU3ZxahmSwPRtpg0LLTPjR2m/ughNXnH/pSdoG02ATzv3Q/Ph4Z8IQzkTragxWoj
         fBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637343; x=1726242143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWq2Z5Y2NB/LPQoEsjsZIqIHLDav1GOZXqUkwsg8EvM=;
        b=cw294iUbwFUbvapD7vahXK8Ao4YMNxgHl1hyRE99rS7RV3g8ozfJv15DepXAG861CS
         crFTGoOE513eTpT7MPz6Uy+0BiHiCo+x+kxOsz/fQyllDaxyVPEIK+1U/UPJ5SNvqxi/
         mq/c5gFd/3L9guKUI6wsxIi2dVjEb34y1qxPIC+y4z0R5Vmiu0wnv+MIJzU0M6xk2gQv
         rv7lCgkGNwYGV36MDEST7TezFcJ74gwUVFTCQwJphR2O0lc6DrWrYtwxAaa7CaTzOkq0
         qwq63zaRh/De7NmFTcDKiAje6n2xIrpMDUvf2JsOGUKog8TVmKDEw4BQlVB9J1TyYb79
         NowA==
X-Gm-Message-State: AOJu0YxN7H4Eb2aqpnsOLlISnprqpkPhqMcD0O9CimdmyyYbtZVGV8yG
	gp/yMRKUR68youFk2ws0hLZrXR9JQZpicuPBRq4fyODLQ4CjzkNB0uthIGKi4cf67A==
X-Google-Smtp-Source: AGHT+IHfuSr8X9HPQvA+sdf6dSGEBsOg0/OGqvUen2B2BHzwb7br93wqnd26KBObwC3TldptA62qUQ==
X-Received: by 2002:a17:907:3f0a:b0:a77:eb34:3b4e with SMTP id a640c23a62f3a-a8a885c34e0mr271540366b.7.1725637341558;
        Fri, 06 Sep 2024 08:42:21 -0700 (PDT)
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8aeacb588bsm72787466b.78.2024.09.06.08.42.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2024 08:42:21 -0700 (PDT)
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
Subject: [PATCH 5.10.y] memcg: protect concurrent access to mem_cgroup_idr
Date: Fri,  6 Sep 2024 15:41:40 +0000
Message-Id: <20240906154140.70821-1-krckatom@amazon.de>
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
[Conflict due to
be740503ed03 ("mm: memcontrol: fix cannot alloc the maximum memcg ID")
6f0df8e16eb5 ("memcontrol: ensure memcg acquired by id is properly set up")
both are not in the tree]
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


