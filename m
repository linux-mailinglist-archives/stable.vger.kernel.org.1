Return-Path: <stable+bounces-118185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04816A3BA62
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD6E8025A0
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348C01E51ED;
	Wed, 19 Feb 2025 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z5V1BE8C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F901E503C;
	Wed, 19 Feb 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957480; cv=none; b=DMWtdbHQqBZhG4vfsnW3VQVJ57xpm3i9JAaBVaHnm7mcHAYVB7MxRacFZPZhZsOmHJyD9MKTz5K9PWla6CtWOmATmeYTkCONKnOtW7XUwBzHSRRTzd/2wS/Tl3UUrfgA0lIoEOn+HG/4kmByzggLi2+0IjE+YAQrRA9UejPva1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957480; c=relaxed/simple;
	bh=1lL/3WRYM9YlucqZCxoFE2T0yW8QzOAiPpTiGAt7ifE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2Io3jG32fw0QgGGoSbHcLzVztoZvlDwKAiVriHDz1CGStjoiMqq9oZFN7kvq2dbyj2pviPjq9N5hb9NEhe2POv01AspfMMsZkiGA1CAG7Ks0hrw34MpX/FT6xHRChVCazcZ5KdUe5xMK7wQNkf/vn+gbxaMn3fEPXrgJ1f0q28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z5V1BE8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EDBC4CED1;
	Wed, 19 Feb 2025 09:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957479;
	bh=1lL/3WRYM9YlucqZCxoFE2T0yW8QzOAiPpTiGAt7ifE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5V1BE8CvekVB/KPSiLPSiJTaOgZ1+9DVcfU4TjiuBglknTkY0W+r+GKSN00AeSX7
	 jxHqn2tQtSPTbyByySersjoWA2e0Aunk1uTVZQJlWJEbutipSuuwcjcKurd6wio5hr
	 aMW1twfz01Nfj7lgUJk+ajWvOnuJ6rb7DgX5x1RQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 540/578] net: add dev_net_rcu() helper
Date: Wed, 19 Feb 2025 09:29:04 +0100
Message-ID: <20250219082714.213293497@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 482ad2a4ace2740ca0ff1cbc8f3c7f862f3ab507 ]

dev->nd_net can change, readers should either
use rcu_read_lock() or RTNL.

We currently use a generic helper, dev_net() with
no debugging support. We probably have many hidden bugs.

Add dev_net_rcu() helper for callers using rcu_read_lock()
protection.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250205155120.1676781-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 71b8471c93fa ("ipv4: use RCU protection in ipv4_default_advmss()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h   | 6 ++++++
 include/net/net_namespace.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c75aed1fff7d1..d0b4920dee730 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2538,6 +2538,12 @@ struct net *dev_net(const struct net_device *dev)
 	return read_pnet(&dev->nd_net);
 }
 
+static inline
+struct net *dev_net_rcu(const struct net_device *dev)
+{
+	return read_pnet_rcu(&dev->nd_net);
+}
+
 static inline
 void dev_net_set(struct net_device *dev, struct net *net)
 {
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 3ffcc1b02a590..ee50d54936629 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -373,7 +373,7 @@ static inline struct net *read_pnet(const possible_net_t *pnet)
 #endif
 }
 
-static inline struct net *read_pnet_rcu(possible_net_t *pnet)
+static inline struct net *read_pnet_rcu(const possible_net_t *pnet)
 {
 #ifdef CONFIG_NET_NS
 	return rcu_dereference(pnet->net);
-- 
2.39.5




