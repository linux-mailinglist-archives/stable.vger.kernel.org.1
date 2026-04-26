Return-Path: <stable+bounces-241174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJr9CRsl7mn0qwAAu9opvQ
	(envelope-from <stable+bounces-241174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 16:45:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C5846A696
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9691B3004D91
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AF36AB4B;
	Sun, 26 Apr 2026 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GH9QmemW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2610367F4D
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214724; cv=none; b=DReo9C5kc6JNmT1ELnTS6Etm09x0bS9Bu4wjIJR27tcXBBtD8v27P4f+33bGoq+aMpIK5eeqwvMw3N18bC4uoCJJMTY1FxdYYaPL7WXzUaeQ+iWDteWeQ0BjbJgPkGRaglTxzA9RirTuISI2JdyyCADTCfUMoa+/1hzJkuyNsEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214724; c=relaxed/simple;
	bh=7YaBT6iNVRZFSk14jBUoMTS77VVYE51p/LoYdbnTAqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDfYGxHr7LfDJvo0MSD5Epx1i6/UIz1rgtPTbEZABQze507FDVbMeTX0tDj0BZIiP0SEuKWPrg2lD1CKc6WiiMCz88ZNfHLKbLv2ptvppu0JK3Z/UKK6uNuxk8tLzsKZmhokwmNnw+5WtPwgRgkASMDVdIO88iEOfHL4UPVKBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GH9QmemW; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35691a231a7so6213783a91.3
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777214719; x=1777819519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYEWwYPnxNhfjfvrN9NBByfvj86/jsr9iqTYqVjgdNU=;
        b=GH9QmemWAO9ojjYIbbd1iH538EruKq2wI1OUxm1dKsRhiyxk/fLxgHlYEne+8ot/wg
         48evAYTITwF8ITQ+NVqt3HtgOiVGqArjuATqTQvioK58yeRfHeECak0NmOOPNa5i+jnI
         9BzBcV8VgctM/Q3MJ1Rtgyd6FpcTjrFuBrc19rvp13T8pWzDffEYBjWyysazNadIWzeb
         n4GGdPsFM8cvsG0J+3cNqmDZWhubeWhgTOkHyJw6piDUDoeKSxCHFuA1WNHnSy9Bo0OD
         jrpTNaekELKoOYUIRd+l+7ZrDiMwmOmKp6NPXvf0GjSB8c684h8PztLjL3yghoz5mpCz
         sN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214719; x=1777819519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mYEWwYPnxNhfjfvrN9NBByfvj86/jsr9iqTYqVjgdNU=;
        b=Cy6ktPvfp+t8Lk2bSC+HVaA0QTyi/D1AOM2YWHltBpldFiN86edPyQzJdSWGbswnla
         G244OhGJZJnQcRH7ao9i64vRF4Ty1vMYyNl/DdX8imA73EyrKTuvWoF3wYKgkt9TCOTo
         S7LnXP9XDoeVdXNqKuOfT+7BbIWnuT7DXxT80wL01cPLEvKMNgMHb09B3K0J+srKbt36
         phtb+T5RWbqHl/F5D8ceSR2I5OuOat6mvf5z7u0RgGX2zLy3dKKtCu4nmfd7/zhS4vHv
         zVQ8EGET9yX27nIcdHRph1P2qNVCz4faKvnW5L1fOHX1U0615n6oYdLCali+IIOSS09I
         eKqg==
X-Forwarded-Encrypted: i=1; AFNElJ91N8qTZW6KZR2DngQk9+iRfKUxY1KOC8Kdljm2SOc9oXCDR68IRnzkBIQg6EldUpz5gJ2ZZ1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXcEZsZfTmsZp/Ttom3QBftNjp+wcu49BogL7GhtNneK1vXrFE
	tqFpN0W6T37Uj0be4nQjCmBjcEJerQ93NL8B3QVO46icJ5Tiqs87m1SdCDayhB4rgi0=
X-Gm-Gg: AeBDiesV8BGDDqNhC/hB4wSKskg8RHp23R8OOBF+VEUPB3yeW3P1l1xnEyBdvVSPHsd
	0TYPdUFAwJk0tLXpuzgtqUsijGDTgyvKvwKCwQmQp/zSGWrG+kVjQDnENVM5OmtD6GgjI+ehGXV
	be7pjfHHFjBpK8nACduaPzPxinEdmK+818tMezBcm6yW7FuHGe4wi5HvrrlfRyhTiCEAwIfFWqJ
	j3VorJq0aq2cpNDn0ZtRLDrXMEWBQLboQ3dqD9qokMnCqywOJS2jeXVgRpnOIWfl3wrnEXShVvw
	t/vDZ02eeymzEB0sxE9GWtzPJR2vDqR79vnpg97RPjdo0BrQ3hf3LYrRgodNJlLNmbHXnjsO5dU
	e392wfnKwtSUnDWUIqxOvaXA6AUzG0F8wDlyxI603oJFQe5KUPlvAAPWmWpIe160ge9lDeFLwJF
	e6vFJZ7JJofVV5fbQ0Stnt/jZq8zfD
X-Received: by 2002:a17:90a:f94f:b0:35f:c5cd:cc5 with SMTP id 98e67ed59e1d1-36140498686mr40821690a91.24.1777214718891;
        Sun, 26 Apr 2026 07:45:18 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::349])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703059fsm22340550a12.24.2026.04.26.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:45:18 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: muchun.song@linux.dev,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drivers/base/memory: fix memory block reference leak in poison accounting
Date: Sun, 26 Apr 2026 22:44:47 +0800
Message-Id: <20260426144447.817722-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260426144447.817722-1-songmuchun@bytedance.com>
References: <20260426144447.817722-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 42C5846A696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,intel.com,huawei.com,kvack.org,vger.kernel.org,lists.linux.dev,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241174-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid]

memblk_nr_poison_inc() and memblk_nr_poison_sub() look up a memory
block via find_memory_block_by_id(), which acquires a reference to the
memory block device.

Both helpers use the returned memory block without dropping that
reference, leaking the device reference on each successful lookup. Drop
the reference after updating nr_hwpoison.

Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
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


