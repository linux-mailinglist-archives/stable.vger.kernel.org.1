Return-Path: <stable+bounces-110214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4249A1980B
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 18:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A4E188D2F1
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB6A215F5E;
	Wed, 22 Jan 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="W9bZ0d2S"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04216216385
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567862; cv=none; b=XTho1WoAXzsNEQV2VATEsJvPBAPPaKeOcNZCqFCMkIlDZswbp/o/2PtozsrIZZDCnUI8SHvs9azZ/tac2v/FSRB9vbhedrqWYb2BZfNmMKpEDDoVorwT5cF0Vf/XqT8/sZDax3E+TY2swOycIZhmgnQk65erq2JlgpndDiBwdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567862; c=relaxed/simple;
	bh=+mzlx06GkbGzjONW5mXgv9rUGAvq2ZikqUqkwxZe99o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kj8au+pEdp/5Zr9bKHJzVhF7H27SoERDdPqje9oQWUeOIVdbXUeBgYEqBXv8kB2Jx2RgL5hzwEKnjShf7qGHimZ3vz/gQ5C1ck5SKWvMfrR/8WMy7yLkYC66tK32d5IzyWAeOBQLn/zBYHhBZrEzgHjNELu2Ss3qqLOkIjFAASI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=W9bZ0d2S; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737567861; x=1769103861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6y9l2jTueQXTtQdNepADYkKCmFeQR3EqDi5WusbSWBc=;
  b=W9bZ0d2S5wHTbch5+lp0cbRbrDSlXcYfdyorYDTQuONbPrboxbCSrs9b
   aRqXUUYcOu1+ReaAQul3KS/JaXNU71ZpoYc4+YK4PM1fnP3FuAqTObZgf
   NEjVdhrbO2M8vrjmQDXOjGqwdht0NzBGWo8yO0xg5Ymg/Yd4c09NybHqz
   E=;
X-IronPort-AV: E=Sophos;i="6.13,225,1732579200"; 
   d="scan'208";a="460771318"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 17:44:17 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.29.78:29868]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.8.105:2525] with esmtp (Farcaster)
 id 1a391197-2fb6-4b6d-955f-7d000238b2ae; Wed, 22 Jan 2025 17:44:17 +0000 (UTC)
X-Farcaster-Flow-ID: 1a391197-2fb6-4b6d-955f-7d000238b2ae
Received: from EX19EXOUEB001.ant.amazon.com (10.252.135.46) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 17:44:09 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19EXOUEB001.ant.amazon.com (10.252.135.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 17:44:09 +0000
Received: from email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Wed, 22 Jan 2025 17:44:09 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com (Postfix) with ESMTP id DAE44C0499;
	Wed, 22 Jan 2025 17:44:08 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 7536D20DAC; Wed, 22 Jan 2025 17:44:08 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Jeongjun Park <aha310510@gmail.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Hagar Hemdan <hagarhem@amazon.com>
Subject: [PATCH 5.4] net/xen-netback: prevent UAF in xenvif_flush_hash()
Date: Wed, 22 Jan 2025 17:43:44 +0000
Message-ID: <20250122174344.10000-2-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250122174344.10000-1-hagarhem@amazon.com>
References: <20250122174344.10000-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Jeongjun Park <aha310510@gmail.com>

commit 0fa5e94a1811d68fbffa0725efe6d4ca62c03d12 upstream.

During the list_for_each_entry_rcu iteration call of xenvif_flush_hash,
kfree_rcu does not exist inside the rcu read critical section, so if
kfree_rcu is called when the rcu grace period ends during the iteration,
UAF occurs when accessing head->next after the entry becomes free.

Therefore, to solve this, you need to change it to list_for_each_entry_safe.

Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Link: https://patch.msgid.link/20240822181109.2577354-1-aha310510@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
This is the main fix for CVE-2024-49936.

diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash.c
--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -95,7 +95,7 @@ static u32 xenvif_new_hash(struct xenvif *vif, const u8 *data,
 
 static void xenvif_flush_hash(struct xenvif *vif)
 {
-	struct xenvif_hash_cache_entry *entry;
+	struct xenvif_hash_cache_entry *entry, *n;
 	unsigned long flags;
 
 	if (xenvif_hash_cache_size == 0)
@@ -103,8 +103,7 @@ static void xenvif_flush_hash(struct xenvif *vif)
 
 	spin_lock_irqsave(&vif->hash.cache.lock, flags);
 
-	list_for_each_entry_rcu(entry, &vif->hash.cache.list, link,
-				lockdep_is_held(&vif->hash.cache.lock)) {
+	list_for_each_entry_safe(entry, n, &vif->hash.cache.list, link) {
 		list_del_rcu(&entry->link);
 		vif->hash.cache.count--;
 		kfree_rcu(entry, rcu);

