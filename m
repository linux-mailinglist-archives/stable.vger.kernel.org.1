Return-Path: <stable+bounces-235837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDYnIWnc22lMHgkAu9opvQ
	(envelope-from <stable+bounces-235837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 19:54:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD30F3E53F5
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 19:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FF4B30087A9
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191236308D;
	Sun, 12 Apr 2026 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rbiioped"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025D2DC76A
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016485; cv=none; b=DRKgUbKYrOBeUDHDrnrZ5GgRBEtpEznd33lAUgybHMVlsEMxn0i4TSG2jprFk6HiHbq667r9aorlr4irJUuoI+bNAMinYpf3ETZYEZXnTCy2sFluJUufLNjxoszhlBkgg8aLzQ4SBxO+aC/4IUKTgc/a1M3YPYOOfBK5MS99KGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016485; c=relaxed/simple;
	bh=eWr2u+WsL7203seYPlzK90nPqYFM0pnWF51zgRqHmO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMLT2ZynrtQQ1zaolJ9xDsZgLHspZenV60KWvK8ykFxj2qs1VSdkbl1v/mrb8FjD4gyF23mb9bIowULcQPymxoOETDpACH6W+trmhi0UKThsLSLnRrdJXn8pGmY6E45QZz/MoXEb4ke9zZGwfU7ZQTd7ow4iH4lHJy/YHuzoCrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rbiioped; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b4583f0a1aso2813885ad.3
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776016483; x=1776621283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDfdf5SNMNx3/WAzaXsxgQ2xJAL/YKTWXjEjNPHPnao=;
        b=RbiiopedT4gGaRXLBcAzMvNSvVOywXDFCwOEJZy21acz3aqvf5LQgeX2xJK8ELnhdn
         xyefg2oAkkpiNYir8KKTKNCVPvqxYn96Qs7Wq2iBZrWJwi5NGHlgQY8yeUD0qOrE4Mg2
         QeTJsFLMefCBWU8H9a8F2OTCZd9I8Wl5OXKrLlQePE3Znfk5+VsqeET36HOjygfyzvLx
         Jo5MG3wEsnWb8FSawN33u8XX7u3m3PS9bZJgeGWukh9Pt0Xo/uC7DpNFlOc2OprD2FGA
         0btHEOYu5SnXJtcomSCKe+gxJuX8xy3ZQn9+jUKJe8QyFemVrh6gn8sj0XQwtXoYS7a7
         kimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776016484; x=1776621284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDfdf5SNMNx3/WAzaXsxgQ2xJAL/YKTWXjEjNPHPnao=;
        b=f1R+43JppzSiQhBr9J8MkD5G7GRVgSw0jxagn47v/mf37rdk3I98GazvKUVmOjO+iD
         vKqZIuTwWy/O23Oxxhbb4XZQs+Uoq/YwwHPnD8C1sMUID4GbxxSW0oh/e3RDBoGCFb6W
         u2+ue23+PTVNY8fT1IfRZGwk3HCqW6ak1o5gBd2pg+1kVqgTm+uf0UBgi+2p7P0DNsM+
         kiBMCR45CBv/q8g2sAnppZyP9gCOgNrSKYfvjIS/vZXMbCO8fISl5QsE0c7NPwKwR+dc
         QRj3fgtOG7dnMYxFdE1s2KRC1rj8AW/TOeSaO/c2knbT5/qmWrsmU9fKXA2FW5QR80Tv
         7pDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+K0qPrupxbjne5D4BfIGvpMlxsYfA5gxNzlG95jsw/E/mapZAqWM0Pz8pyWPZS8sa/WN8B4MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLH/xiBsVhidwsp0iGsg9Yb/n7I57nHOdx5JJgX8r2HKPZHO5
	7nftSxkJ764JYzXOy6rg2/I9lCbxEQ8aIkM4WQsVVMwjFWEpqGzufjHg
X-Gm-Gg: AeBDietLdxcRHYEbzDuuNDLI6RmsguZfkBCMrVos61mbpJ4fyQtGeYHsV9ZGUdRuYbS
	0GhOnRsFkvyJ2C9y5V07rOsseW6OswXcle9pieCxDziF7cQCGGPrZ7Ti6JOH8O1Obhz0jKS9YQN
	zez1HnxTL7GryvWUT7EVti4nCl17Nw9zGA0EPvGn/3W/SjctGaGFVSWBHUhLRiqNxhqxGcBZWBw
	OPqtZ6uQvTwI0ESLQkbH2AMUP8zYGe1zesnYHdYTs+JbwnDnEc2Q7daZ6lyfsGSUfc25l3Wci0o
	R9cmbG56eAePFkGfdLVHHz1NtDaq204PaGWu70kMqHof4QOioK9/zoz4tYKrYtFP4s0jxarby47
	lu/FGOxIoM2YapxDJBwJjM1TgcmtG3THYuImxHNO80R6unlBRCTfTiAHB43q9Y4WDmrkVVXp6Mb
	1HfFKImGgYO8GAcBbUWiaDobxD
X-Received: by 2002:a17:902:f642:b0:2b4:5986:cd80 with SMTP id d9443c01a7336-2b45986d953mr20083035ad.26.1776016483595;
        Sun, 12 Apr 2026 10:54:43 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6dbb:2e05:75d3:967e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f25d83sm92119835ad.58.2026.04.12.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 10:54:42 -0700 (PDT)
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
Subject: [PATCH v2] mm: thp: Fix refcount leak in thpsize_create() error path
Date: Mon, 13 Apr 2026 01:54:28 +0800
Message-ID: <20260412175428.2613383-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-235837-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DD30F3E53F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After kobject_init_and_add(), the lifetime of the embedded struct
kobject is expected to be managed through the kobject core reference
counting.

In thpsize_create(), if kobject_init_and_add() fails, thpsize is freed
directly with kfree() rather than releasing the kobject reference with
kobject_put(). This may leave the reference count of the embedded struct
kobject unbalanced, resulting in a refcount leak.

Fix this by using kobject_put(&thpsize->kobj) in the failure path and
letting thpsize_release() handle the final cleanup.

Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Drop the incorrect UAF mention from the commit message
  - Clarify that the bug is an unbalanced kobject reference in the
  - kobject_init_and_add() failure path

 mm/huge_memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 40cf59301c21..c8ffa188a198 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -726,10 +726,8 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
 
 	ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
 				   "hugepages-%lukB", size);
-	if (ret) {
-		kfree(thpsize);
+	if (ret)
 		goto err;
-	}
 
 
 	ret = sysfs_add_group(&thpsize->kobj, &any_ctrl_attr_grp);
-- 
2.43.0


