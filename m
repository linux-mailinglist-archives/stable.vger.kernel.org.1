Return-Path: <stable+bounces-177764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 070E0B44522
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 20:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7FF164ADA
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF8341AB6;
	Thu,  4 Sep 2025 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="lVBRhgnx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7B340D91
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009585; cv=none; b=QOl4/8CthQa9cTTuSO0IwnOM12DLqwYKWkLof3XMSu2I5EbgGdGUPLy9ga0j8Ejz64aY+YxIrUDwlkpC0uFxnho2yaXdQcdhdFVFnTe/iJ1dStryrJ5E72fRRqsbQJ5hfkM1wJWqYmYYNrpgZm95+NKFvcF2RJiLK9x1YhV1orc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009585; c=relaxed/simple;
	bh=LdmJrCGEit3e57WtUlxe3l4ro0MN1g08DdcmEGpefOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b1MjiEmNJFdaWj+uEuAoF7GuAM9D0D8PTB7sr7spTtfz1sX5o78O1FSuL0sRc6qARKNBXsdpWFwTLESXnnZszNgdge3l/UMNS/A8S4PC9dEPvIxuk/HdrhNNGgpi07/yMESeEpo3aV5fg2iKyM9IhGQ3RX54KHTr0CXSdx0ICaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=lVBRhgnx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61cf0901a72so2309257a12.1
        for <stable@vger.kernel.org>; Thu, 04 Sep 2025 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1757009582; x=1757614382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SayrWq9EL+FzoaA3kSfms075bKzR1bTUIuxyks0UhpI=;
        b=lVBRhgnxjvrIoMdYvNhnX+iXwyRHQAh2b6vcl1UiKLbyAX1DQXUXdoNAC1NYixIBEf
         4gXwBDSXnLQ9jO8n4hkBDBW/5zBeBiXan/ZTPZl6tos0VlPtq6MtKEvzHLTIUvF73dyv
         8iJJfPz10c28oUyWb2nxudwe1Ck6/tBU720eFLKq1BTAJCrbJM6IrrZJYPdeCUHyqbT/
         6X2XUs8AKFoeYE2Kj7SCvzmXdqoCZtHqBU4dRgGmQQUlaFdZy7Tj9Qt1alciG9I3cpTe
         fUvh58QH4okUukquGaJrf6a6PCLoMnDYQ85LKzVnnq1HhH6P+ri0b0vXxqW7sHN4yJ5L
         Q6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757009582; x=1757614382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SayrWq9EL+FzoaA3kSfms075bKzR1bTUIuxyks0UhpI=;
        b=mC0G7djWqxL3m7w/7O7MzYeBo9i4O/mTs1GSZ2RZYWRfPybQYlEGTUNQCH8rb7Y/z7
         8Hjtj95m6SAZeVg9zqg41JkOm649lu7zVApeUR31u5zLtCCi9Yl5y/XqLC+GmCVNQcmY
         a2vswZYmxKnuWC1F3bZQimE/msxfgrYWGmFWXAbEkbtiZzhc3QWJnuQf8mUMrSC2Fs5e
         MRifOQ6yJWPpo+Es//wbXgjOQGH4q3yhcVusS4GKEldOkYKH/Cjlsg0CNijJNgH3Q4Hi
         kQ45fobyOT/KH4T2Idu9Vj0DXcAfbtDV0mOKpNZ+s+RXm+/aL4c7Ipbf3eJtLSSFYl/w
         mZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbQBzhgAZNiOO7lqnmVpV/ATC1OXLRLqhQtg5umtxNKl/Wh98gZJMmGT172WJopTfneN2XcV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9zgzM5q8U5sqRhKQYYaUU0r1mZh9xRVdZ5vl1R8wqOgeSH/Aw
	CRRrgNQDqNnBYUTOkCnQHn017phrenDCgyf5h/BO/3VSxD4zlN5e2ixSshe7veIMRR8=
X-Gm-Gg: ASbGncsAahze4FT+dpWONRRIPrXuq/7unFsdQnhoVH9q8Zxp9sCSSsm7VJSqiyo9lwG
	8m3uzcYFGAa5tpKo844/mdYcBaR7jueV6jpltcuuGb9AYE3uZnwhEblU78VBidp27BylnVIXYxr
	cpTaTgxVVJFFGwXci+qv2X9twzIuyRBCIAcqSrUgQJht/upeQ8K1zQhdE2rpCTMBlmWhl5DCyjR
	vPwAMZgmHin8socB0kVPhAJ2XKZdwrIVwudGbVfbvXQLLn/Q5ZcoOVyQF0bOMhx32YjiHnWRxh2
	GN7NbXDZ0FbB/JJkTECF+QTL0N9+/Uv26uY4ozhIW1C7Yi46QEzo/oe1ImJFW8/uxOXs3Z4E0wX
	Gct2vqQxe1bTH95p9UPJJYjxlrsQLKxgyzpRPSRvZS4/YxSyPaR+6o07D1A==
X-Google-Smtp-Source: AGHT+IHUoe7GgAw674k6cHcnUO6jamtfXKG5fx/D6I4lzI1hf6rw2tZLSQ+zfPP4YmYrq1x5+ZhjMQ==
X-Received: by 2002:a05:6402:27c6:b0:620:bf3a:f6df with SMTP id 4fb4d7f45d1cf-620bf3afa52mr1230412a12.19.1757009581838;
        Thu, 04 Sep 2025 11:13:01 -0700 (PDT)
Received: from localhost ([149.102.246.23])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61cfc4bbc51sm14408641a12.27.2025.09.04.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 11:13:01 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	stable@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH] mm/memcg: v1: account event registrations and drop world-writable cgroup.event_control
Date: Thu,  4 Sep 2025 21:12:48 +0300
Message-Id: <20250904181248.5527-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cgroup v1, the legacy cgroup.event_control file is world-writable and allows unprivileged users to register unbounded events and thresholds. Each registration allocates kernel memory without capping or memcg charging, which can be abused to exhaust kernel memory in affected configurations.

Make the following minimal changes:
- Account allocations with __GFP_ACCOUNT in event and threshold registration.
- Remove CFTYPE_WORLD_WRITABLE from cgroup.event_control to make it owner-writable.

This does not affect cgroup v2. Allocations are still subject to kmem accounting being enabled, but this reduces unbounded global growth.

Reported-by: Stanislav Fort <disclosure@aisle.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: stable@vger.kernel.org
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 mm/memcontrol-v1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 4b94731305b9..9374785319ab 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -761,7 +761,7 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
 
 	/* Allocate memory for new array of thresholds */
-	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
+	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL | __GFP_ACCOUNT);
 	if (!new) {
 		ret = -ENOMEM;
 		goto unlock;
@@ -924,7 +924,7 @@ static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup_eventfd_list *event;
 
-	event = kmalloc(sizeof(*event),	GFP_KERNEL);
+	event = kmalloc(sizeof(*event),	GFP_KERNEL | __GFP_ACCOUNT);
 	if (!event)
 		return -ENOMEM;
 
@@ -1087,7 +1087,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 	CLASS(fd, cfile)(cfd);
 
-	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	event = kzalloc(sizeof(*event), GFP_KERNEL | __GFP_ACCOUNT);
 	if (!event)
 		return -ENOMEM;
 
@@ -2053,7 +2053,7 @@ struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "cgroup.event_control",		/* XXX: for compat */
 		.write = memcg_write_event_control,
-		.flags = CFTYPE_NO_PREFIX | CFTYPE_WORLD_WRITABLE,
+		.flags = CFTYPE_NO_PREFIX,
 	},
 	{
 		.name = "swappiness",
-- 
2.39.3 (Apple Git-146)


