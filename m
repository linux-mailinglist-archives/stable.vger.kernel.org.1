Return-Path: <stable+bounces-81669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA889948AE
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECA6284334
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E692F1DD867;
	Tue,  8 Oct 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nviMAWxX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E3233981;
	Tue,  8 Oct 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389737; cv=none; b=ohIsT+W/H9orkBIw3kzPpckiXPoJggJjorXP4lv0xZcHiUot6jE70RAG61hnngJ2+4QNw9t0PGGbGKw/FPX2HpvEYgHamC7mkFP/VIEb7f0AJq29YqIoDJf23FwNYBybjhwqYTNHbKmzn7HcRD+lfJed7t6Jz/2pwnL7LgtLx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389737; c=relaxed/simple;
	bh=kSymDANh2hvyH53sejtlPjKDax/tXac/3DVio9h0p1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXHx5TwV1xJx47GJqXpKrCzJh5VzEUmrX8rro7hIfkwOPM9sU51grGLbRbY5ldP8uOhCPuvd2iJPi1zoQ7G1CjSKnzUYX+6bMpQTbzBzdz5SeZoKbIKwS36mtFuKDEI6jn59rkTReXWcmv0lBzag5RWwZ6wgzwAlfHwbc8u8gu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nviMAWxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1222DC4CEC7;
	Tue,  8 Oct 2024 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389737;
	bh=kSymDANh2hvyH53sejtlPjKDax/tXac/3DVio9h0p1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nviMAWxXZBQN43qbcxs1xwCCqkRCUc5LoAihdWOsSJNgyME6fkDXoc6AfTily9sfe
	 YR76X0PcFajmofmcLS7Sh9Em7KFaus3bdPht8Xllwe7S7qOGNwhh8YiHflndbk1qiA
	 TZsxx46v/k5bAAMfEUdAUWGQ3v+g4i7bLM3Gzl3g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeongjun Park <aha310510@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 081/482] net/xen-netback: prevent UAF in xenvif_flush_hash()
Date: Tue,  8 Oct 2024 14:02:24 +0200
Message-ID: <20241008115651.494604106@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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




