Return-Path: <stable+bounces-253898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMA+MTs9EWpzjAYAu9opvQ
	(envelope-from <stable+bounces-253898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:38:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685A05BD4C3
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195293028ED5
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9FE21C9EA;
	Sat, 23 May 2026 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQeeVL4Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE03314AE
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779514617; cv=none; b=evbmv04LGRrj32zHfJQ/XniwazRpvSz/yZXQWdppWgpBYU8C0zZMujnRkscY1kzJJ+Quf6p+9klalmYb2Qv8hdE2mRFzEF81utA55gfN91IB4X5/NC6Qf9SPP4YZuUobcc7+dR+2VA6qOvZNEuw/ICSa248MiYb43Rng8uxfCvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779514617; c=relaxed/simple;
	bh=Ld1JJn+zGIIrv4OfEQcvAVuHm3e1kxZgfP5KYvnpil4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeiezDmczTOsU9hnYZnpbb/WcGGmnEgg8E5CdLKoX1B1XK8CrGUPCFgC4JWgy6NKT53HwOa86vp2zv/QCQ130/QayOwn+cQm+f4NFCgPGOkY29LstxEwOKZibBPaBE2I8AqZ8OgUoFzicBKcf3UO0InJvcb/5yvVgLBqaSSCDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQeeVL4Q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49039a8851fso25088585e9.2
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779514615; x=1780119415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUwKR3yq6fKwgsxnrOqNBKyVRzqIoUnbsdF3bmKoKC4=;
        b=VQeeVL4QUyCLjLvwJHM1Yqzxhyzk5qt82EpvewGnJZENq4vOseqQLyuzzr1Vq17HRJ
         W2Qr/YFxC9ycyMYHMVD6YPD4AyIrQj12F/HHhg9k3hV+6x/7JtlzqxmuDbdWCnZapBmU
         pd9cwbOtTD4Z5fCR0wHOqHaaAKqjCYRjougNWfR65WBeDQ7+nyL65h6+0MkI8ZTNTqnO
         Sc1mYu/A4kIytUkJ55XLlLBsIeNvqtyyP4lXFNAyv2DJp4V0fU2eDpL0gFepv5zj9DF3
         Z+EGcJrWbVJlFMtoc9W57WlhU9aoDPfvBsinFUnMzOPcfFQE9Q8W3kd5aw4Atrd4r08i
         IYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779514615; x=1780119415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nUwKR3yq6fKwgsxnrOqNBKyVRzqIoUnbsdF3bmKoKC4=;
        b=H39HuOj9DsmsLsH0IC/XYTZSAvnjZcwidJzPHoop6EZOEcpAP86wmt/bCaj54EFnVJ
         BNEZ5MkxHFb6Gptxy7at3kTZVsvxIa2tbOMYtSZgqQtlrBbutRcBerCmL/7Uvpp9wsDU
         V5fMPx2/+y9hVZ9qbpT0c1qfM1np6rLRNUxDaaPy/On7m31dS4eFVOI/JreMhEO/Wz3f
         83Qbt03UUJiQIjlqOfpXai+0z7um1OFhW3bWLW6i3AZzYAKsLBvybuKlEONVLRS+uHYY
         WA1mWSBjKTSicRH62uFK8E49kzzzeJNtWDWVJfkSzzBm/1VgAAktF3ASOhQAVuQs0zc3
         +4fQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JplFgaTVjd4B9bShVpBKgKoA9qfpmid2t+FJuesHbLBYqhZIoAmtR3lB/tgIFoTlEaVcn9G8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4W7FabqUEVju6yTypK8VTPFJUZV5sxkjw2AzBe5dvSVfcbsv0
	1vRiiwlbPer/5Irk7jonnUAQEWQ1coQJJUxF4iNs4T4OY0pOcUgAit/u
X-Gm-Gg: Acq92OHqKssnuIt0SAOEJ2bNp7zR927dhcMTd9VJGZ3XknI4CKIBmf2NUQe8kaahOKx
	SfTn+zrOp6+sTKavQb0Rq+mmRd8nPX3llX+qtrvO5LL/NgackTwxsI52c+5c6QLKRyjLX6Siu/Q
	MKcMf/lE560p2TkuaSgcvSOu0IzXNb/pF4rjMsSjTAWdmiJE29I57/tLhshbAQtSA3dw5x+CM9h
	vyFaWt5u6yqQA3QpT9IZ0GUZXC+VTHV4bRolTkR7SvBQsFh3VF1vkykIT7UjeuJf+nLHFCb/lY9
	NrPPZfxapXKsMlQreLjEuiqFsf/YAp59i/OWZ3ZvSQuCe9HO3DjBKEt9wircLcZGwfMta8fc3ot
	jpDb+BBbiQSUJMV55wkpa2+kTZkO654mhZWinDmMKteH2ng17W8aeg9vZacJzKv8Z91Ty9pu5NQ
	CH/kblm0fee0vqLnKqRGC81OPRdaMmxZzgpnG3IAtHlRwXMxzErJJpkG8wRDkVK01z/JRDoer8b
	9zAkw==
X-Received: by 2002:a05:600c:6287:b0:48f:eb8b:997a with SMTP id 5b1f17b1804b1-49042ae285bmr93143975e9.31.1779514614442;
        Fri, 22 May 2026 22:36:54 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f6ffsm9336779f8f.1.2026.05.22.22.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:36:53 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	stable@vger.kernel.org,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH 2/3] openrisc: Add full instruction cache invalidate functions
Date: Sat, 23 May 2026 06:36:17 +0100
Message-ID: <20260523053624.630443-3-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523053624.630443-1-shorne@gmail.com>
References: <20260523053624.630443-1-shorne@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,southpole.se,saunalahti.fi,infradead.org,nvidia.com,linux-foundation.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-253898-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[shorne@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 685A05BD4C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add functions to invalidate all cache lines which we will use for
static_key patching.

On OpenRISC there is no instruction to invalidate an entire cache so we
loop and invalidate cache lines one by one.  This is not extremely
expensive on OpenRISC as we usually have only a few hundred cache lines.

I considered using the invalidate cache page or range functions.
However, tracking which ranges need invalidation would have been more
expensive than flushing all pages.

Cc: stable@vger.kernel.org
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/cacheflush.h |  4 ++++
 arch/openrisc/kernel/smp.c             | 21 +++++++++++++++++++++
 arch/openrisc/mm/cache.c               | 16 ++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/openrisc/include/asm/cacheflush.h b/arch/openrisc/include/asm/cacheflush.h
index cd8f971c0fec..7b8c043a831d 100644
--- a/arch/openrisc/include/asm/cacheflush.h
+++ b/arch/openrisc/include/asm/cacheflush.h
@@ -26,6 +26,7 @@ extern void local_icache_page_inv(struct page *page);
 extern void local_dcache_range_flush(unsigned long start, unsigned long end);
 extern void local_dcache_range_inv(unsigned long start, unsigned long end);
 extern void local_icache_range_inv(unsigned long start, unsigned long end);
+extern void local_icache_all_inv(void);
 
 /*
  * Data cache flushing always happen on the local cpu. Instruction cache
@@ -35,10 +36,13 @@ extern void local_icache_range_inv(unsigned long start, unsigned long end);
 #ifndef CONFIG_SMP
 #define dcache_page_flush(page)      local_dcache_page_flush(page)
 #define icache_page_inv(page)        local_icache_page_inv(page)
+#define icache_all_inv()             local_icache_all_inv()
 #else  /* CONFIG_SMP */
 #define dcache_page_flush(page)      local_dcache_page_flush(page)
 #define icache_page_inv(page)        smp_icache_page_inv(page)
+#define icache_all_inv()             smp_icache_all_inv()
 extern void smp_icache_page_inv(struct page *page);
+extern void smp_icache_all_inv(void);
 #endif /* CONFIG_SMP */
 
 /*
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 040ca201b692..65599252f3d4 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -346,3 +346,24 @@ void smp_icache_page_inv(struct page *page)
 	on_each_cpu(ipi_icache_page_inv, page, 1);
 }
 EXPORT_SYMBOL(smp_icache_page_inv);
+
+static void ipi_icache_all_inv(void *arg)
+{
+	local_icache_all_inv();
+}
+
+void smp_icache_all_inv(void)
+{
+	if (num_online_cpus() < 2) {
+		local_icache_all_inv();
+		return;
+	}
+
+	/*
+	 * Ensure stores complete before we request remote icaches
+	 * to invalidate.
+	 */
+	mb();
+
+	on_each_cpu(ipi_icache_all_inv, NULL, 1);
+}
diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
index f33df46dae4e..2667d90691b5 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -63,6 +63,22 @@ void local_icache_page_inv(struct page *page)
 }
 EXPORT_SYMBOL(local_icache_page_inv);
 
+void local_icache_all_inv(void)
+{
+	if (cpu_cache_is_present(SPR_UPR_ICP)) {
+		unsigned long iccfgr = mfspr(SPR_ICCFGR);
+		unsigned long sets = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
+		unsigned long block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
+		unsigned long paddr = 0;
+		unsigned long end = sets * block_size;
+
+		while (paddr < end) {
+			mtspr(SPR_ICBIR, paddr);
+			paddr += block_size;
+		}
+	}
+}
+
 void local_dcache_range_flush(unsigned long start, unsigned long end)
 {
 	cache_loop(start, end, SPR_DCBFR, SPR_UPR_DCP);
-- 
2.53.0


