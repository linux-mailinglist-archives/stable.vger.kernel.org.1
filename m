Return-Path: <stable+bounces-74025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F24971B40
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06B61C229D3
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EFD1B86ED;
	Mon,  9 Sep 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwe7QdMh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8E1B3F24
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889227; cv=none; b=Ad2E+ibezWTczptIVELgxtbDdCZMXZv4EpoY/AsOkW4B4bSDmpkBRbhPWLh/RMJNALFXAyNHibedWiME8KNMwICDkJg1kVqqekhhEhX3tPPY7CH06C2r0gp2kuCpKUtm7MdRuDb3MqiieJ5b7GYBFa9QWriTMxn61u2j+q/6iWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889227; c=relaxed/simple;
	bh=vMpt7C1UUtFnIwe4kKFW+wigThKrUl0ZLtKU8XI7TEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PcV9AsvNmso4rLvEse802PYIV6hdMWZL+fp8Xc3mrZUtHMBG8CwTWcgbIeEzxc2hQUX/meVNRLEylAmc+Oh8FwZtqQgnLKnnXeS/tnHhyikNk+eh93htc+ik1iC7zn31pS13t1sTRbu9238HDB3Kpz4ianOpDilOtPSw8oRasTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwe7QdMh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso713010966b.0
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725889224; x=1726494024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgTr3yOPMM9/HsTa4Xh/CiCsNyLHVkPARZCUCRHY3Uk=;
        b=Fwe7QdMhzXnHtHDzySojh3sXPIjn8wBmhSY1CEbz6xddEqq+GXjOXornwmIQujZF5/
         Hq7g6W2aqD1dmXWWcg3emNCF1/rGWjmlBBkjQ2jcFLZ1KeCHv2RFdnJ1DT/XLUGaGKJi
         33GWnZBqueWDDBQ9fhBv72dLy0P8gVEQNMKKR+lTREP3Z9iGrxKRyLDOXPgTbH/k4TJL
         WEB9+E87YlQFKspSrxZygAwId03I652UsrXDhfnufui/5qADCjTRld4WyZJDHkqrGGDv
         O3BvWOm69Aocn8pY9AJvr9/2cMIFVAaBZAdblenfn29zfQJgwDF63HnW4O+103mPwsG+
         52hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889224; x=1726494024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgTr3yOPMM9/HsTa4Xh/CiCsNyLHVkPARZCUCRHY3Uk=;
        b=wkYt/lupwk8PBelGV3qkTtsZde5B6DpoGVh+xXWSmBI1SPylfp8p7HTl0/3aCg+WjE
         lTgaSlHe6f5YDwByRjKbkXPIKs9WSVqeqJBeemeX/JsWfls2LqR9OgLuIB9kS8HnuIHr
         DFRFvQqCPjaqBWHUNQD68ZVoOcbs2ZVnvxxWEeNHeHnLMZzMYYYgi6+ybEA4MYQiNPSx
         uknd33OCLXvHZtoiznGGmGhW64vrJd8ZVnBkByjYOhw1qOPnf0wYQnt7y9cYeJKnGX2W
         VibmK6OUR/bQe8kRSONpjNBe3KQVFWU0lv4irApC241YxogtyhWceO0mBgGHcPvkgDlo
         xjUA==
X-Gm-Message-State: AOJu0Yyr/i4zX8aK44Z6LgZZHrGI+o50yWXEUrsJhatx7WcjAjWfCwxz
	xaWJ9qO+PHQtg8r2dYOkD7AZCVk1PF+GZFNrBoi56rB+9C210nakXrmY9xQkVobpug==
X-Google-Smtp-Source: AGHT+IFKwDX1zANmit9MvZNtslC7TSQSyG1MW5jy//exiGpIGvntyQOJiSHNfEL7QLgEj32SZFIRQQ==
X-Received: by 2002:a17:906:c4f:b0:a8a:6db7:6659 with SMTP id a640c23a62f3a-a8a6db76a6cmr1033477066b.9.1725889222767;
        Mon, 09 Sep 2024 06:40:22 -0700 (PDT)
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced18csm341921066b.161.2024.09.09.06.40.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2024 06:40:22 -0700 (PDT)
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
Subject: [PATCH 6.1.y] memcg: protect concurrent access to mem_cgroup_idr
Date: Mon,  9 Sep 2024 13:40:12 +0000
Message-Id: <20240909134012.11944-1-krckatom@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2024081259-plow-freezing-a93e@gregkh>
References: <2024081259-plow-freezing-a93e@gregkh>
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
[Adapted over commit
6f0df8e16eb5 ("memcontrol: ensure memcg acquired by id is properly set up")
not in the tree]
Signed-off-by: Tomas Krcka <krckatom@amazon.de>
---
 mm/memcontrol.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4ad6e8345b36..280bb6969c0b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5143,11 +5143,28 @@ static struct cftype mem_cgroup_legacy_files[] = {
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
@@ -5270,8 +5287,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (!memcg)
 		return ERR_PTR(error);
 
-	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
+	memcg->id.id = mem_cgroup_alloc_id();
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
 		goto fail;
@@ -5316,7 +5332,9 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
 	memcg->deferred_split_queue.split_queue_len = 0;
 #endif
+	spin_lock(&memcg_idr_lock);
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
+	spin_unlock(&memcg_idr_lock);
 	lru_gen_init_memcg(memcg);
 	return memcg;
 fail:
-- 
2.40.1


