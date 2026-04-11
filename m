Return-Path: <stable+bounces-235685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMXeLJ3o2Wk5vQgAu9opvQ
	(envelope-from <stable+bounces-235685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 08:22:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BDA3DE854
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 08:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 898893012205
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 06:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9990832694F;
	Sat, 11 Apr 2026 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIPQ2qDv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA123EABC
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775888533; cv=none; b=FBjsZTJoNWcojjML+bjul22+kIxlyrKsjaDjAfjb3oEVwozjRYx6W8IQDbm88t95OCWM7rTTNVX7KwTjxHqUVX4Wmf6vPAFAZjWmZYndKtQj/8Ktn9eoaE0rmoMxE0QNxQXv6R5lgh7vgrEM2GCna75srhqxX41D0l2yYGSrfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775888533; c=relaxed/simple;
	bh=ezbnLKObzxWsEZhhwlrdDzWmHnEKMRaJ/Hw/qDz8cLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EEj/BGZqpMCGcIRMg/2vSuMnkmHTJmQQIZMlMhsJtXwWpZjPcyPql7pRVqK4o0evIMQyDZelnjSBkEvGbRqrbYx0B6IMZSs7zDzp9rtVG7qhG/3Bbx8L9rPrzF07PxmKcgLdedXbte2AizatFcaxQonbDs4QiPHRw58fpSrrM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIPQ2qDv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d965648a2so2382179a91.0
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 23:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775888530; x=1776493330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjzGaFEIwJAqPl0XoclvOseGR/HD6ox/UHRHYtHUC04=;
        b=CIPQ2qDvffhH/8slp7wxa9NyjBvDtFcOgUQH8U71SvTYLc4DgAsbpX/Kp8xorhbYLz
         89/avPxL+a+MUTMx4Nu6hZ35eNtiSb2TxaJj1qn2N07SdxCbOGvRSxqzYzyr9uAk9lxu
         C3C598BkWsJkPXE71M/BWtbnY2j9Inyj+X9hzdnQ+e1HSks8+ieUXX1wi0X7z4hWMZWZ
         kReKpElVDhATTVoKc5M+Bbw1BwB+D4GLzhn8pHdBKFYbQ/aGvZvJWZ5lJN5w365vwU3j
         UvYtAHZELAVDfTSz3OZjrmmI/AoWg/TYdXx4BYtgkbrylYZnk1rsXjgnNgYFp6ma/acH
         zZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775888530; x=1776493330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjzGaFEIwJAqPl0XoclvOseGR/HD6ox/UHRHYtHUC04=;
        b=PSP4JGdmwAgOoakRA8lQMsT3S6Q55KDbulNLGx2f0BanahwnzAILK9WHTxNd4JwciJ
         nwHqANCbjtWFrp+5fUSSEg230PT5qIL06IQ65wxFkC/yctLeurj0VKYwBot/i4MHGuPv
         c2YggYzXvxd8xoh2R7pasqi7pqf3gvJaXNrik2EMzoQE3SilxoiuSkAjiLBqPgfeeoqR
         uB54rgDS8QZ/vv/0pMhKQD6rUAaKihIaVlvavqCs9LUWnm5R9an7o9e0dm8bMKi+M/hf
         oXsz6lBvorkQm/SvqcyavVm2Hc74kdyofR135t8jeeMkuCruT+LchXMx+6NBvUjN6erL
         OTJw==
X-Forwarded-Encrypted: i=1; AJvYcCVle/lmA7CsySaKlK4PYHqmmIuGTGEwa0CIRdCDefRyA2PRu/He6zZxnhKjdpSqk3UyFY8PQ8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHAATW9ePcL3nKqQ4Vd2d84p5LYsTDyV04SM9EGXIwrWcjfyd5
	GSk1PvqGVEKopqKUrZ3NdW5zlUZi9bP3sNHPf/fJHVbjwDzLHDO/PYSh
X-Gm-Gg: AeBDieszB43lwH1CIuml9qlpJgei+PfFoX8GgUXkw8esx0I4864SOs9Q6pqnMzuKQgm
	276dvzzMpJDAzmYiUwNk9+mmpSlh97dpUalKWa0u9geD6CkWOKT7Er7P74TP5nALFLYJLkiVeG0
	+NzZoeyDwZVcszh6bBGCywzNXqd24Zw3r86wjQ5hZSnc7isuRVKx0pBwIxGN3GOUXv73DcVIIf1
	Mi0djvDZl3NIuMNp8v9iwGwnwkqFOt8mG0QhX7ZI2TcYnSU85888LrHPhyU0J+H591VVnLZDaLR
	5tGoDSVAlSic3l6zDNa+BhGTwYT07Hw25kSe5Ub6COXi8KNA7mwapvQMiTOgSKo2+HESGYiNmO/
	cfYRd2e2tzvBXE7iGrx5ZqtmzA6sH3vWW7i8e/qNHhuMDdFjgZXXtJkVB/av9LKA4vCg28SP/78
	ZS3mvyejCycFSovQ==
X-Received: by 2002:a17:90a:e7cf:b0:34c:fe57:2793 with SMTP id 98e67ed59e1d1-35e42881e54mr6189487a91.20.1775888530399;
        Fri, 10 Apr 2026 23:22:10 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e41345f63sm5345346a91.16.2026.04.10.23.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 23:22:10 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: thp: Fix refcount leak in thpsize_create() error path
Date: Sat, 11 Apr 2026 14:21:52 +0800
Message-ID: <20260411062152.2092967-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235685-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50BDA3DE854
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After kobject_init_and_add(), the lifetime of the embedded struct
kobject is expected to be managed through the kobject core reference
counting.

In thpsize_create(), if kobject_init_and_add() fails, thpsize is freed
directly with kfree() rather than releasing the kobject reference with
kobject_put(). This may leave the reference count of the embedded struct
kobject unbalanced, resulting in a refcount leak and potentially leading
to a use-after-free.

Fix this by using kobject_put(&thpsize->kobj) in the failure path and
letting thpsize_release() handle the final cleanup.

Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 mm/huge_memory.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 40cf59301c21..ae6ed483cd53 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -726,11 +726,8 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
 
 	ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
 				   "hugepages-%lukB", size);
-	if (ret) {
-		kfree(thpsize);
-		goto err;
-	}
-
+	if (ret)
+		goto err_put;
 
 	ret = sysfs_add_group(&thpsize->kobj, &any_ctrl_attr_grp);
 	if (ret)
-- 
2.43.0


