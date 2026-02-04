Return-Path: <stable+bounces-213330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC+1MkKWgmllWgMAu9opvQ
	(envelope-from <stable+bounces-213330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:43:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29113E016D
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D3D5303E2EA
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 00:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3381D8E01;
	Wed,  4 Feb 2026 00:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODbshDW2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F1187346
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165745; cv=none; b=CYuhmRl4Ptyt2/bqMIDPz5z7XoXMocCaB/AUdIfZxrxOU05AgKf9XeBsxAw0SGpcZRPp6ShomSGB8VGwdw5b8es6MNyAKsGw+x9wKXVxvloOPiAIb9O1Kvl85T8+lo+AXBckyPdVDvE8ygAUsbHjE91h7Q3VCfd12C5KuX8gzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165745; c=relaxed/simple;
	bh=yF2+2AM7pXRYXfWMA+W81Vm2c5Jgp+2kYqPNOr0s1Sw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tsqHMrRxgJduTd0uxo+0t9K/yrw1jaJjSQKHSyhX9/LJGC5RS+5RIMRtdqMr9Kgox8BjlYLtT8KEiInXQTlZqSfavqd9RmFs8yfbUfSzcNnb1/Fp0tHu27aQXf5OeCDzMXn1Ua8g3nfFRX16qpjDNxUR1s2+AqRD07yL0a9svpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODbshDW2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65819e75691so10398351a12.3
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 16:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770165742; x=1770770542; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K+Ad73ToZAC0tkIKIowUNqNkC41RThWypaaBO1pALw=;
        b=ODbshDW2A7AhZpcEay+Wh12+TTiSEVR8BQpNIZy49YtqHTGMk/IPIzm0+32U4Q/HVt
         5Y5hGAJrgAkqaLeFP363I4f2xwXCYcBet+nC5qzL2q/3KbI4YoG4cE1SCaPLmYVMIYQf
         kwenP3bgqGDUCrqp+97Ghxddwuu90dyINmD+OOQl/uVWVp91Ep1NTu97Sdghxd/4agef
         8JC2iGzYrmPLyJQMw9x8lJiu0v+bkChO25th7S5kdsY9rTGWGeFxV6aKmropJVUld7b+
         sc2Jm4GUl5saTdH5TUN4uk/riApoNsjrzY2IW26viH147YB/pxqmQAJOmqtEv9FEh9md
         k7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770165742; x=1770770542;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9K+Ad73ToZAC0tkIKIowUNqNkC41RThWypaaBO1pALw=;
        b=ihmxK5xo6eoYwgxZWoIl7PZwoU7WOm6Y4RU5iQjyOYZ1kFtfXRMfwL9FzZND6Zx941
         tK8Pz/2E/byq1EyjVGuwVNG+JjNKu3GmgW/59cu19YlwrQDgLFEWT8uOqAc0/lP6ajP6
         hymAlhheIsbT4aw0z4HjGElruQ0OXqmbcw/zxtrO6fTcKH44q+k6wwuh8x26uIcxlwO7
         yEZcXryEaSkF+6i6HxGOx45wIZZcc4xyU2VUqQ8QdK6a6MuPDC8mzn/V6VxiBuHdCpps
         2Ze/q2O92VqNEE24xu33iPUJ7DoEnVO+zGasdFOkqmhhsx1rSrJF04xThDiKSnDKEQCj
         ObEw==
X-Forwarded-Encrypted: i=1; AJvYcCVOixGC2y81lxQ8+laZZtil7+rbujmV+Fv9aJw1W7B97fSD7R6Q49HY9aq4w+DrOJX1x/i70uU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz3Hmfv8AK2J2F9BJ8UkNC4BOexHhrX0Ghfq609+3Byw2O9Xhm
	yPMqDDnI5sJgC6F3tVCIJMigbVcWRHAC0pEWeoZdjr2DgDfM89BrU4RN
X-Gm-Gg: AZuq6aKAuo3enjixzT7gT+2CUqLyuffTCFzdv6VPdWkKIN5tqZq/bB9yQuwFdO0v/oi
	yMG5BooGRg+QXZhivPI+Yo+Lf3xu399gXusQiMDLwst5M9kvfwJAjjSwUGQ1HMcfB/QamNQ9vFm
	Jd1bm7kR+63uS6h5Ns/+9a/VptcWamTPOhIpb5s1Nd/wELYDdgnTQF30FcHO8G/1yeZ1z/nLUhF
	aVE9GJdkXM6/Dkc7aTG4PkY7N4JdV+vLiwm9U+K1zP9ugC6WGc5NaIos/E0FjOOs+db396RGAJ0
	KZMAxNLu0l0wc18qu2ccJLiCyMjmSzJpznPSygYtHBif3MXL/WyxNYuhiYyXxy+PJ/y3+6i/Dru
	v1kdWRY1Bb74u/U6CatbUFizTpGW9Ow32EfRjuif+NcnSi9hpSrc0KInB/exM3j6xQqh5ZGGWwV
	SQ4BP8GqgceA==
X-Received: by 2002:a17:907:7fa8:b0:b8a:f29e:307a with SMTP id a640c23a62f3a-b8e9f396397mr90493166b.57.1770165741562;
        Tue, 03 Feb 2026 16:42:21 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea0057dd1sm57062766b.65.2026.02.03.16.42.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Feb 2026 16:42:20 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	jannh@google.com,
	ziy@nvidia.com,
	gavinguo@igalia.com,
	baolin.wang@linux.alibaba.com
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Lance Yang <lance.yang@linux.dev>,
	stable@vger.kernel.org
Subject: [Patch v2] mm/huge_memory: fix early failure try_to_migrate() when split huge pmd for shared thp
Date: Wed,  4 Feb 2026 00:42:19 +0000
Message-Id: <20260204004219.6524-1-richard.weiyang@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-213330-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,igalia.com:email,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 29113E016D
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

This patch fixes this by restart page_vma_mapped_walk() after
split_huge_pmd_locked(). Because split_huge_pmd_locked() may fall back to
(freeze = false) if folio_try_share_anon_rmap_pmd() fails and the PMD is
just split instead of split to migration entry. Restart
page_vma_mapped_walk() and let try_to_migrate_one() try on each PTE
again and fail try_to_migrate() early if it fails.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
Cc: Gavin Guo <gavinguo@igalia.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: <stable@vger.kernel.org>

---
v2:
  * restart page_vma_mapped_walk() after split_huge_pmd_locked()
---
 mm/rmap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 618df3385c8b..5b853ec8901d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2446,11 +2446,16 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			__maybe_unused pmd_t pmdval;
 
 			if (flags & TTU_SPLIT_HUGE_PMD) {
+				/*
+				 * After split_huge_pmd_locked(), restart the
+				 * walk to detect PageAnonExclusive handling
+				 * failure in __split_huge_pmd_locked().
+				 */
 				split_huge_pmd_locked(vma, pvmw.address,
 						      pvmw.pmd, true);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				flags &= ~TTU_SPLIT_HUGE_PMD;
+				page_vma_mapped_walk_restart(&pvmw);
+				continue;
 			}
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 			pmdval = pmdp_get(pvmw.pmd);
-- 
2.34.1


