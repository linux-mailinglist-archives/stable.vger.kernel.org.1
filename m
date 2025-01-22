Return-Path: <stable+bounces-110213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1721A1980A
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 18:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1747188EFFB
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CFD215F7F;
	Wed, 22 Jan 2025 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C4zerS2n"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F3215F64
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567852; cv=none; b=XtyPBsIbkSLv2jXuMGKCxtB+Uik0S0nYihR3KXN+UDkCZRY1ck5GfWkJ3/DH9rSNDxgTUMZ4eDZd0Ju+LZfD5bXuruByylMnZT0QV/MWThJyC16hLklsWCNjGprJyWq2MYVq/72SodWZ5VvJCeDbADvRsaO3HsFSZm0CUwES2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567852; c=relaxed/simple;
	bh=KqsHtKXxfGP2I4i7DHGmcJWXwfp+mgVRvl/P75xg3Oc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IAzgFVybNT+JKZkcwT9xomObRwu2jGAySPWOumiKhxEWueicp4rtjhdFNEPqLM/mCo5ZBhm2UekrrFKjRRPSS0VOtt6IonfgF3hGdWW/5yLyk+oH8+rzWaNZ8B2no1gs3/nT3enGO7T3M4pWKcAnQntvxFuhXHWIIGAW+SlM258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=C4zerS2n; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737567851; x=1769103851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UDpqeoO+ccQM9VAf9qPAbaUbyC4Fo6a2wxtZ7836Scw=;
  b=C4zerS2n0lgeN9nn4PHXpPiqec37t6p0/9Jn8TApURR4DRerXs/aJ80N
   t/6kzUqF1Ydsh72VupGKJIAFySTin/fTsdzyNOfu98+o+gXG0GJjFO5E3
   wuZYtsDi47SvhFiPf/A3LeVrqoiPfvoWy2B4KEH7QrGTPbSFIwVWTPls/
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,225,1732579200"; 
   d="scan'208";a="792927805"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 17:44:05 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.29.78:48099]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.8.105:2525] with esmtp (Farcaster)
 id 0b55e2df-eaf2-43ce-b2b4-91c046ef41d1; Wed, 22 Jan 2025 17:44:04 +0000 (UTC)
X-Farcaster-Flow-ID: 0b55e2df-eaf2-43ce-b2b4-91c046ef41d1
Received: from EX19EXOUEB002.ant.amazon.com (10.252.135.74) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 17:43:59 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19EXOUEB002.ant.amazon.com (10.252.135.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 17:43:57 +0000
Received: from email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Wed, 22 Jan 2025 17:43:57 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com (Postfix) with ESMTP id EF58D8010E;
	Wed, 22 Jan 2025 17:43:56 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id ACBF820DAC; Wed, 22 Jan 2025 17:43:56 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Madhuparna Bhowmik
	<madhuparnabhowmik04@gmail.com>, Wei Liu <wei.liu@kernel.org>, "David S .
 Miller" <davem@davemloft.net>, Hagar Hemdan <hagarhem@amazon.com>
Subject: [PATCH 5.4] net: xen-netback: hash.c: Use built-in RCU list checking
Date: Wed, 22 Jan 2025 17:43:43 +0000
Message-ID: <20250122174344.10000-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

commit f3265971ded98a069ad699b51b8a5ab95e9e5be1 upstream.

list_for_each_entry_rcu has built-in RCU and lock checking.
Pass cond argument to list_for_each_entry_rcu.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
This is a dependency to fix CVE-2024-49936 in 5.4.

diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash.c
--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -51,7 +51,8 @@ static void xenvif_add_hash(struct xenvif *vif, const u8 *tag,
 
 	found = false;
 	oldest = NULL;
-	list_for_each_entry_rcu(entry, &vif->hash.cache.list, link) {
+	list_for_each_entry_rcu(entry, &vif->hash.cache.list, link,
+				lockdep_is_held(&vif->hash.cache.lock)) {
 		/* Make sure we don't add duplicate entries */
 		if (entry->len == len &&
 		    memcmp(entry->tag, tag, len) == 0)
@@ -102,7 +103,8 @@ static void xenvif_flush_hash(struct xenvif *vif)
 
 	spin_lock_irqsave(&vif->hash.cache.lock, flags);
 
-	list_for_each_entry_rcu(entry, &vif->hash.cache.list, link) {
+	list_for_each_entry_rcu(entry, &vif->hash.cache.list, link,
+				lockdep_is_held(&vif->hash.cache.lock)) {
 		list_del_rcu(&entry->link);
 		vif->hash.cache.count--;
 		kfree_rcu(entry, rcu);

