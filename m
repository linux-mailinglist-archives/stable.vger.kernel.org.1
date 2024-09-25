Return-Path: <stable+bounces-77557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EC5985E78
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9311C25472
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D896211723;
	Wed, 25 Sep 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCBy69NY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F30211718;
	Wed, 25 Sep 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266325; cv=none; b=VJp5XsiF1bmLuqtKp5oBea9cfEkBZXUe70S2jpnmNRPoz2Mn79LHom03lzMo9KUZP08ggyVHdCo/tL+fHPFhnsfdDLW+vU8AQEDbINgvBkKF5leztMffkfvFlKzLbDoF/Fnu78w9iifS+QkWLbf32qzERFgXFsQ0/Y3f2a7oF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266325; c=relaxed/simple;
	bh=9lBC4d65KKRSmO1eJbpsc08w5T/98CswSFBKhln48QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHLX4yssLgKSZqW3cihM1aRRKQT56dA45sCQSDa1xumBUOA5zefSH+VzNY2y2/q7UYJsnO/QcOi+fpHkGMyVjlBSXJ9wPuO3WpbZpJvDUIiRHSHKqCuYEyNHYlFsyBD62HcE6JwgLnm7aqChLM9YwNZD4F2VuFHP9J0U4dY+H2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCBy69NY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4FFC4CEC7;
	Wed, 25 Sep 2024 12:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266325;
	bh=9lBC4d65KKRSmO1eJbpsc08w5T/98CswSFBKhln48QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCBy69NYptVMyvLC1KR7W3fMy1eAHWmtkXzxgMcVI7iU6D/FESI6IVP3wsScLxvK/
	 0X1icSjU0EmzKUSQnGX22jItzzpBahvlCDqm0Lxm05z/KDNAEQD/dR8cfkUy2hQMeQ
	 LDlu6WaOd3wM2A3M4wls5yD59nJnVqHIwfUHzROu2fAktB4H16Ti9WmORb6HvqH6h7
	 7JtTF349dXtaWUiDlXZMs660hAo2tzNWQb+o2sk9whVKT6CVcZ5WrPGJP4PQ2IU4r+
	 IUlgffEPfp2V1oB9KT3E/cH7yiQB3RpuwfBtAYgPF5/ipthkpNxFiCMGqeDIxDpl9K
	 MYOj7hrkLco5A==
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
Subject: [PATCH AUTOSEL 6.6 011/139] net/xen-netback: prevent UAF in xenvif_flush_hash()
Date: Wed, 25 Sep 2024 08:07:11 -0400
Message-ID: <20240925121137.1307574-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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


