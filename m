Return-Path: <stable+bounces-77355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8022E985C35
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213CD1F28455
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A991ABED0;
	Wed, 25 Sep 2024 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIm3c006"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CAE1ABEB3;
	Wed, 25 Sep 2024 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265536; cv=none; b=EHpYpsx7VhKSMP9iBGWGgp00D8cNR2+/vIYYA4gWhnFVNs3+/cWexQc8QwUx8TChgRIC3sVqv9nsb/vjYleZV+SWliTX63Lce33bcFU7tPiWtspTawjj2UQT/G1I6stgYqrvuZhQkMs1grWyDuwQgjivBQVmkD/csvVFWxWQ4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265536; c=relaxed/simple;
	bh=9lBC4d65KKRSmO1eJbpsc08w5T/98CswSFBKhln48QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGvG1JRZuSJI4x9n74HOYC939I+FweaQ0LyxR3ER7fSpEAesInMgPaoH7aiqvf8XtzMpzXpBPFsLjo3M5A9nvO907Ms96Fa1N1d3bmgy1rh4up8sxgNuZSZbuJxlWeX9PxjcaiVqTzzEO9LxjQptlU6IjWGibbSBHUkFIFpUe9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIm3c006; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48799C4CEC3;
	Wed, 25 Sep 2024 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265536;
	bh=9lBC4d65KKRSmO1eJbpsc08w5T/98CswSFBKhln48QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIm3c006HRF7lnnZEgJnZVzFB23p8wxIO3d/+KDjoNwtLBn+OQKGIkz2l+GcRENI2
	 3R2y8twPAt0SapOQYT8t6XSxYyZ72Sh1GX7SLH/LMoPiB9J5M8LHs++Rpy5fPQaJFa
	 p/rwh3MO9G2Y49+x9oz3A4j3pH5ZbNEhP+OIkkywsLSO33OhxTPqJJ1vvORVuKdGot
	 Fd06Qj6Sy0ZIcKdu/dCPpYQeBLiFWPCO+j+r36XjmXAGFHc3KZDcfW6Skoqo9CtsKg
	 MYSPLiEk+mhuRfIfFFMaUFBZN0bpx1Q0VDOgH+TrgIl399GUsoHHhDueagWwUyHRtt
	 lYtFXo8TLRwXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	wei.liu@kernel.org,
	paul@xen.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	xen-devel@lists.xenproject.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 011/197] net/xen-netback: prevent UAF in xenvif_flush_hash()
Date: Wed, 25 Sep 2024 07:50:30 -0400
Message-ID: <20240925115823.1303019-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Jeongjun Park <aha310510@gmail.com>

[ Upstream commit 0fa5e94a1811d68fbffa0725efe6d4ca62c03d12 ]

During the list_for_each_entry_rcu iteration call of xenvif_flush_hash,
kfree_rcu does not exist inside the rcu read critical section, so if
kfree_rcu is called when the rcu grace period ends during the iteration,
UAF occurs when accessing head->next after the entry becomes free.

Therefore, to solve this, you need to change it to list_for_each_entry_safe.

Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Link: https://patch.msgid.link/20240822181109.2577354-1-aha310510@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/xen-netback/hash.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash.c
index ff96f22648efd..45ddce35f6d2c 100644
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
-- 
2.43.0


