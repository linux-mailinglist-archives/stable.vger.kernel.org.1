Return-Path: <stable+bounces-195206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D55E4C7177B
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 00:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 921244E18F1
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 23:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD62FB986;
	Wed, 19 Nov 2025 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxwz4bW1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3582FF66B
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763596391; cv=none; b=AmjlIajZvmWn2sIiNdzXC4z2MK04XhFRdzRi4YXNy0sHDVMzSidvYnh8XMHmk8+CCafyhyVRCN7frnoIkDimo29vCXFbFIhCAuDzhczncS4Yct2zWZ2LmDVH+N9SrkJidiVSYPz6fujZcV4kxARGZ5WxlUscz7Db3EsC6xhgjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763596391; c=relaxed/simple;
	bh=vb3OR+3kq1eKmp2dDyZen2C6sLqEwG7WoGJB7Swt7h0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Q73SdGqV0oiH8laArVMedWHaoGR10Es6pq8DYhdK8hL1w4+yPOjdWNzz2EhEovcx0dBU/aI0BlS04AEy6WUGBPT4j69vQoeLbEcX4RBiuAiX5dp8YRgpVOT86UCcHmOpmJWy/9lsZn3y24ovOU6Gn5GaZ2+y/ik+kUJQWCZvDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wxwz4bW1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso447480a12.2
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 15:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763596386; x=1764201186; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnOOo5ncytdwKVtZqcSLcwiXzE3PwnOveMBhVLi1LEc=;
        b=Wxwz4bW10douoICAyeZXqtmFTtFFCG6ym9c3D05HOllbwlhUZXNPi0xlYxWysKPjzI
         t5MZu8wp5dqLD0yndF7fDhrhE0PwMD2w/5OylIYCwlhXtkNIkb4UMZAeXhift1a5VX1J
         4AbEjowWi65Z9LI0qRvrxdUtPs0jhwfSdZx5SjN0VBY2svG6vmCF4c/Qh56jRw34s0YV
         E+29Ngwi79t7XgSI4m7f+HTmmRIlkMoRx2EtRDxbSPIO+eVH5h4wq/uKuszlNyEBulpe
         cnUvrFTXx0filxysJ58Q3a/jddFobQncQ4X8juXmmGhhhkLWezx5gIlymsuGbfm4CGwX
         b+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763596386; x=1764201186;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JnOOo5ncytdwKVtZqcSLcwiXzE3PwnOveMBhVLi1LEc=;
        b=Kkti8CmQcyjS7lKyGYPLq3qmblh1RlEEEf+8bqIeH39kyigNteINE5XgjqjAo9f9DD
         /rK95ReTRzYGvCVEef3FzvFdX8BDSlpHMA2krtsAmh4wo60YGdYSnR5Y+RE/0E6uH2EL
         t2IbN1fYp8GRpaEKe5GwVnr2HHTro5AQUA/HMw7P6TGhsKHx6VGMBkHSh6OicBc+biM/
         QySq3YfnrZChI8gtfkMI51NG5nClUywWvkqgGhdkz667w6+s8bCgYFINQgPE6vKLFKHV
         08fST7gSDyFVILYoC8sxbwAlt2nDu3rW8ixBmZUBy+y0QrLQQgmmWRhaKzDj8kVFLNaU
         fOqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBfZWs3DK+Yp3jXSzSuJaPo7uI72jaMINMdtfpg11fK+GQkAh+Ublzk0X7f+ngJlpaFb3qRI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIGtsdRqTx7UPvt6WcHiON19kQfHIhpysUpVRIpLtN6IZfai1
	rNFO5hP163JKjoF4U17ZNtsmI5CwiDdMrPRfC4gJPYvtT4G2ihoEz95O
X-Gm-Gg: ASbGnctMkqPT8moh+5tUG7l64cxVdmFJ4Ks45418flJGKzF4TrqvCpxh0ZptS14hpNK
	LSLTSLyzm9j1susS2s/c9ObXRt8rFYhH7SipnfW0GXSNVjtWUJ2hZj6K9LQKmv5p1t1mXvsscPX
	mwlob+Im2HX5dXNQqCqxgjbt23eP6aAsln6kyX36F69QnB1rxKngKXYipZrWiFyduFtTYylf+ty
	Hz76LjBCB7hOC38EDTIJvuX33CwrvTKrGUPYTjaw+FaWECdqMMRI6R91fPTWyBOmz1ZqNjPAniS
	WFIbCbntp2xaDeh9+am8yAXNxpwP1xspTGTyjyCAi7tVh1wSBvYr+Rp92Fkm/NE9KGA4FGE+OPS
	MUG3GXLuyzzq+aKJFvmYXhXusX7/mk54fLANfnfm1U57sKEsEpZ3iOZuGosMR9OGcXKJF3aMbBd
	RA6rmXweV5pmKa+DBYWsttAlx9
X-Google-Smtp-Source: AGHT+IGkTPnmhR4gMTnNbAhjowqyAFNlU5ODY9bQ2xesxliBe0zfnRE8ekW9twCPyXvzIhFCmjCY7A==
X-Received: by 2002:a17:906:dc91:b0:b71:df18:9fb6 with SMTP id a640c23a62f3a-b76554f2f8emr95563866b.26.1763596385574;
        Wed, 19 Nov 2025 15:53:05 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdabd0sm63024566b.12.2025.11.19.15.53.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Nov 2025 15:53:05 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	stable@vger.kernel.org
Subject: [Patch v2] mm/huge_memory: fix NULL pointer deference when splitting folio
Date: Wed, 19 Nov 2025 23:53:02 +0000
Message-Id: <20251119235302.24773-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Commit c010d47f107f ("mm: thp: split huge page to any lower order
pages") introduced an early check on the folio's order via
mapping->flags before proceeding with the split work.

This check introduced a bug: for shmem folios in the swap cache and
truncated folios, the mapping pointer can be NULL. Accessing
mapping->flags in this state leads directly to a NULL pointer
dereference.

This commit fixes the issue by moving the check for mapping != NULL
before any attempt to access mapping->flags.

Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: <stable@vger.kernel.org>

---
This patch is based on current mm-new, latest commit:

    febb34c02328 dt-bindings: riscv: Add Svrsw60t59b extension description

v2:
  * just move folio->mapping ahead
---
 mm/huge_memory.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index efea42d68157..4e9e920f306d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3929,6 +3929,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
 		return -EINVAL;
 
+	/*
+	 * Folios that just got truncated cannot get split. Signal to the
+	 * caller that there was a race.
+	 *
+	 * TODO: this will also currently refuse shmem folios that are in the
+	 * swapcache.
+	 */
+	if (!is_anon && !folio->mapping)
+		return -EBUSY;
+
 	if (new_order >= old_order)
 		return -EINVAL;
 
@@ -3965,18 +3975,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		gfp_t gfp;
 
 		mapping = folio->mapping;
-
-		/* Truncated ? */
-		/*
-		 * TODO: add support for large shmem folio in swap cache.
-		 * When shmem is in swap cache, mapping is NULL and
-		 * folio_test_swapcache() is true.
-		 */
-		if (!mapping) {
-			ret = -EBUSY;
-			goto out;
-		}
-
 		min_order = mapping_min_folio_order(folio->mapping);
 		if (new_order < min_order) {
 			ret = -EINVAL;
-- 
2.34.1


