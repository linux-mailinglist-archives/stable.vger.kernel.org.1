Return-Path: <stable+bounces-241505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICW0M3128GkMTwEAu9opvQ
	(envelope-from <stable+bounces-241505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:57:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D34A480B68
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F37AB3040583
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987A83D9DB0;
	Tue, 28 Apr 2026 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h3XbeW10"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B47A3D88F2
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366360; cv=none; b=TcoFYOiZWuXcpxGKIIfElVPqy4teVQJZOcLvDHF5accbr5bGtEN6gbNp24k6bHPci/1YSpQfCQMYYyAnNeeLImNQHUZxF7TtYit/LrGxUQNDFB4j1fnSSV0+jNdYVvT9GD3SauCZhpOelTWt0lArdcssFulTAcFy3DjdGahB/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366360; c=relaxed/simple;
	bh=EwDlAeox+pLWJIfRBalnhzrey1T0agG3+31xvcpS+7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXaFqwkYkH2cItr6seYW2BEBeSlf90fVwxUUdUp11+DjsBLiFpfv5vfyOtBr3aLITnO29mR5W8NwoQCJBfF91F9t6i0o0iv1SGnmUjARmOWbygtO9UcQpAM/mwxtxecYoLQlDyoA4cPBCKvNq9pNxgfuYl7noBu/3e8mMdNGFRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h3XbeW10; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35fbca04006so5585488a91.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777366359; x=1777971159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiF95cax3V5L6nJjgrGO2oz2uPDfmL3HpmR2wC0cXHA=;
        b=h3XbeW10uDPex/USXzWOQjNFM07oBlPE6/00Rgrq7pXTcFHtEP8ZELm+8yqoxH0ZbM
         3iZQyP6fZDfcdODRx2GqkcEw3NqDUsUyGNz2JSgiKfw0kz0bW0CT+LImHMpf4QxGzTfv
         F0hJmFOUsYHnybGvBMP1nbnIMddC9RKbmtAOzuCivbz8Rib1/iIw18Qd/V6Hk4nyomM5
         jYI0AtZW/klCWF5FPMidjtnkrips54DiGqe21RRfS1znQ1Q+wTNbYIST95no8mWJNqKz
         823QwIR28UMtg3VfyIGjN4q0y64w8X4VaNOlTqowPE0qKoTaldFccBaoh2JbuCrQ9d/M
         1HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366359; x=1777971159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jiF95cax3V5L6nJjgrGO2oz2uPDfmL3HpmR2wC0cXHA=;
        b=aJ0sUiixRDxk5VjroXgxSTEUS3kugpqnY4nMkCLfsGGcnUjiYcXw8ONXHSIwpiivjS
         URG+e7xYEeP05He3egxevXqbpn3NWchXnNc/AuLQ7fwIAKTq5qBFPaaxvanW4fWaTRBw
         0RZZS3SVr6rSRkMTa0Uo1WnhqSAJEHsb5oXSKd+xxSKa3w9kvVigGMz/P9gFwRIqrnXz
         d97UYva/OfhG7npHXY1TJwNA57zw/TljRK+sWysRmE0qcZ7U01fGO8pij6KBMIBp+TNj
         2aiOHTrJLP2jY7MGroVZOh/cLA2ywUlm6+vslXZ0yIYFX4//+zqFCj3QPDKJsTUtrucN
         R2Tw==
X-Forwarded-Encrypted: i=1; AFNElJ8Zf37ut/+YcSsynq6T887sGYW8ovHVDjf3wW7pgE46vg/MjcskFA0QbZOaUICcfuPMq5vBD38=@vger.kernel.org
X-Gm-Message-State: AOJu0YydIaNLqiblkerkIUX7QqJ9pqPOFwuP6fG7ASDEiFr/cK5GAX//
	o0B1QbwsT5Kp0ESGoi+XjYgvx3OhfR1Ap42VxMrwP8cCicm/vB9MBSCCRR/vcoRsjs4=
X-Gm-Gg: AeBDieuvpiZotJK4Axc56ZVfg1g9bomqK1rlR4KvRuv9r2xZrAeZMVmmYWWFdytjeq0
	gOo8r9Lb7tycdsIZtKWma5SbIByLuxKMiu3wRO4ChhPKEREsG5+aYwXjRvtp1k18XL0dqGJd98O
	XgBufsgLEIvWAYIDEKXa+7l3s8uOT44A1UVyWvkiG8WKGC5VXcL10P4vh8cjFNGqytViKXViTCE
	cmSn0e5yQ5arHcrtKMCGRQsn1s/0prv7jMxcSFPZr9p8jUY0wBn+m66ay1h1nCWDXOPIuKvfou/
	+LXNQ8L93KE5mYwy4YSgKLNwJUd3VZIr2xtGCFPw6b+UXzGQIqKmiwgEvaCHp29Yj3y828L4+pv
	/sudxvFi5S9AmtN8ld4orAUkuimHE95oYkI5/Bk+yr863fbywOvnJJtyYR/JJGVhXO24Lc54Gjd
	1qOAbbLI77XtXN69vSxT+gIsNISjPWwAiow5TbTlh28Kqp1j+3Smi5U4k=
X-Received: by 2002:a17:90b:554d:b0:35d:a380:6d1a with SMTP id 98e67ed59e1d1-36491f89850mr2386051a91.2.1777366358483;
        Tue, 28 Apr 2026 01:52:38 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364902e7debsm2889080a91.15.2026.04.28.01.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:52:38 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org,
	muchun.song@linux.dev
Subject: [PATCH v2 2/3] drivers/base/memory: fix memory block reference leak in poison accounting
Date: Tue, 28 Apr 2026 16:52:18 +0800
Message-Id: <20260428085219.1316047-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260428085219.1316047-1-songmuchun@bytedance.com>
References: <20260428085219.1316047-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D34A480B68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,kernel.org,huawei.com,kvack.org,vger.kernel.org,lists.linux.dev,bytedance.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241505-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:dkim,bytedance.com:mid,huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

memblk_nr_poison_inc() and memblk_nr_poison_sub() look up a memory
block via find_memory_block_by_id(), which acquires a reference to the
memory block device.

Both helpers use the returned memory block without dropping that
reference, leaking the device reference on each successful lookup. Drop
the reference after updating nr_hwpoison.

Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
v1->v2:
- Add Reviewed-by from Miaohe.
- Add device_hotplug_lock in the next patch.
---
 drivers/base/memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f806a683b767..6981b55d582a 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -1230,8 +1230,10 @@ void memblk_nr_poison_inc(unsigned long pfn)
 	const unsigned long block_id = pfn_to_block_id(pfn);
 	struct memory_block *mem = find_memory_block_by_id(block_id);
 
-	if (mem)
+	if (mem) {
 		atomic_long_inc(&mem->nr_hwpoison);
+		put_device(&mem->dev);
+	}
 }
 
 void memblk_nr_poison_sub(unsigned long pfn, long i)
@@ -1239,8 +1241,10 @@ void memblk_nr_poison_sub(unsigned long pfn, long i)
 	const unsigned long block_id = pfn_to_block_id(pfn);
 	struct memory_block *mem = find_memory_block_by_id(block_id);
 
-	if (mem)
+	if (mem) {
 		atomic_long_sub(i, &mem->nr_hwpoison);
+		put_device(&mem->dev);
+	}
 }
 
 static unsigned long memblk_nr_poison(struct memory_block *mem)
-- 
2.20.1


