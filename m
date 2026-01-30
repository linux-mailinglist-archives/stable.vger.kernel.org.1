Return-Path: <stable+bounces-212922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOI9HTc4fWlMQwIAu9opvQ
	(envelope-from <stable+bounces-212922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 00:01:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E6ABF49E
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 00:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4138300B3CB
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 23:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1763446B5;
	Fri, 30 Jan 2026 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R74TAEZm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0435B654
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769814067; cv=none; b=it4qcWhXKh+OhvVL8HceurdplK0QkMzn79Htsuj7iCJUZvGLQK1P2hDg4J34wsoT1moYTltqwZnFpnHxs9j6m3njGO6+lJLUGRQZc9FgapWo1gO/WORjTpS7s8J5EMsEsNLtIatuvBtjFPYzObQsv26VXsdP3y04Ph7Cazxz6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769814067; c=relaxed/simple;
	bh=YcpEfZQTsm6x4i7YQGBxoxQHFpqNqiq87Wo3LOjlTvg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=f27F4Pxaze7CcMcaL0qWTSxAC18xVKtp19U7L0EwSNjIOI79+o8geYtyeYwU62kZfh1tfz5AcWZ6lHixFnj55et+MV2HXhcOwIRHLOcjcDkAPT/l0Bwz5FeY6h56RhOeBVDyefUjAo3bamc2nRGeD6n+htUK3IoI2zjLquRA1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R74TAEZm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8838339fc6so490340166b.0
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 15:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769814063; x=1770418863; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpzJMKrnIvJPiY74TgzeTlKt0Hvq5aWJIdiYlnsoQHE=;
        b=R74TAEZmkgJ1rKpOVAEjLFVYCN23nTlfoMmnRSerH7dbBxhE1evlOo4YBkD7/aBGKB
         QsGOPIeAWI2pgi8bg5DvObR0RBEn92hnkqLkwWERim/3HlRvNToIhqGI3h5vWISJDEbu
         YIq8BrKsP2ZHiVFY/FKBpoBxh4OJl104Dj3oUb7OrUqlomWTIUsbZSPvFnsJJjC+jcr0
         uYDRIP9jDjkIuMgfCzDTfKblDDVbvRWIZZ6EPDCCXdPFGynNTLzTLBxqjtngc7kKZdid
         QuugyDY6DPrsEu+aUYJdeOYGCIxLwJQsJpPUHy5UUMGbrlJ0/GZrKGDvWByuzEIj1kTP
         gEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769814063; x=1770418863;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XpzJMKrnIvJPiY74TgzeTlKt0Hvq5aWJIdiYlnsoQHE=;
        b=uvOQ2Hb29EU+qphH2k4SEabFUk8HTC4Cv0Mn5W4l8GbekIGg+QTKaPd3ijG47bWIOV
         ulrDxfJAvQfNro+RLmQtjS1o/lp5iDyPBYWPJFUff2PqoI1e2aJmP/yIxvoqCJalzdGa
         RWS9tNW7w9E4qE9pcfQ7sGeRVWQU1DVO/YhJHmEyQXBANM8XxWJOvtR0TGmetMsUe6CD
         FPq/RZvpMJpwBfGV3WmBD9iHFyiPJj68w7W48jIs/2o0UP8hSKKF37wfIbxpmsQDa9jJ
         lhBeQzGv0JgbxRmwL+cJXnewe+lthNgwXFqF510s8T9ll+R4eqBreMlHIi5xsc5BJraK
         xQTg==
X-Forwarded-Encrypted: i=1; AJvYcCWXckywtPZdaRYTwT8oIX2sSsZtbURKjRWjhifik8Xz2BbL5tX5hbx1ols86PXd8c1N8R+6WII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN6zRsA9qmh2LIqI+kTEen9Gxk2ceEb+ARIyP+jKxUfL36KVlo
	G8Y/hg+KFEhotYXpa03KPjRRb2TBdnKxa6DN/fsPyzfLIGoIXzINlmBo
X-Gm-Gg: AZuq6aKu5lM7QTXoFtuUJI5WgLpVvRavUakduypKF/RsrnZDS0sRpIiUHtLSWGDKYs1
	0+HaZevRHu5gu3SbG/X4AuiewVdDbJybf3hqVmIEioE2wTr11BuaSOiswamxH+30t55VplcQ2Aq
	IU/aGErbubN3MSbDdt8OXWCL6jQ4GNUp0sIW17iKRlVz8KaIovU4HF2dKExGaq5FO7G30mg2y6D
	ZhgWdxv9uVaksOlPMD4OWe65iCohaEhpg4WsXZ1icDj/q+OvbGqLzOMKGTYpHcR2glsM7MgI2pi
	FjjR8zwD6stVdwWjuV8x5CuEoTgaI2Ztr1eKoi2VF0wAFuIDUNB4LPZcCujqFi633ZKEDBOIFrd
	NLl9PpAclIEhtQyeEjVO10vKrdrqu2+7QfbD3lQQd3qMIuawHTQMbts0RFaS7MIBvmjw/lIshtB
	j+Ak16fiRdEA==
X-Received: by 2002:a17:907:2d0e:b0:b88:1e2:ed49 with SMTP id a640c23a62f3a-b8dff22f549mr298811466b.8.1769814062665;
        Fri, 30 Jan 2026 15:01:02 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e0a5a3b1asm152556866b.57.2026.01.30.15.01.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Jan 2026 15:01:01 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	jannh@google.com,
	gavinguo@igalia.com,
	baolin.wang@linux.alibaba.com,
	ziy@nvidia.com
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when split huge pmd for shared thp
Date: Fri, 30 Jan 2026 23:00:58 +0000
Message-Id: <20260130230058.11471-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-212922-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igalia.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: D1E6ABF49E
X-Rspamd-Action: no action

Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
split_huge_pmd_locked()") return false unconditionally after
split_huge_pmd_locked() which may fail early during try_to_migrate() for
shared thp. This will lead to unexpected folio split failure.

One way to reproduce:

    Create an anonymous thp range and fork 512 children, so we have a
    thp shared mapped in 513 processes. Then trigger folio split with
    /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
    order 0.

Without the above commit, we can successfully split to order 0.
With the above commit, the folio is still a large folio.

The reason is the above commit return false after split pmd
unconditionally in the first process and break try_to_migrate().

The tricky thing in above reproduce method is current debugfs interface
leverage function split_huge_pages_pid(), which will iterate the whole
pmd range and do folio split on each base page address. This means it
will try 512 times, and each time split one pmd from pmd mapped to pte
mapped thp. If there are less than 512 shared mapped process,
the folio is still split successfully at last. But in real world, we
usually try it for once.

This patch fixes this by removing the unconditional false return after
split_huge_pmd_locked(). Later, we may introduce a true fail early if
split_huge_pmd_locked() does fail.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
Cc: Gavin Guo <gavinguo@igalia.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
---
 mm/rmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 618df3385c8b..eed971568d65 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2448,7 +2448,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			if (flags & TTU_SPLIT_HUGE_PMD) {
 				split_huge_pmd_locked(vma, pvmw.address,
 						      pvmw.pmd, true);
-				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
 				break;
 			}
-- 
2.34.1


