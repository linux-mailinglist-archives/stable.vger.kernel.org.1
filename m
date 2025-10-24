Return-Path: <stable+bounces-189221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5D8C05463
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 11:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90D725047DE
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D72853F2;
	Fri, 24 Oct 2025 09:12:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276B308F23;
	Fri, 24 Oct 2025 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297143; cv=none; b=Vr0jmmkT/wNLCItBEVnP2mB0+S5xj15nxC9sSQaPvDEyGjvam1WkCiE1m6zDhlNVd1ANGg/dqJSMJDnhSLxHfPp3mAv6go20rFa9jJnUHvFGPvrnoFlQNCkXXhzniZVyN0rYvnr/oC1DBrG1kiiqifwkIkTqGXlpthQbDl6OAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297143; c=relaxed/simple;
	bh=YSC6FsqlELdxKSyHLCQ02qgBDZHrh3li0uO739QAyYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkKGf42EjVQnL8gOGRTJh5lLrf7fZTywNbXFzqT6QaMCZC0al4SIBD57Wpr3X1kdTY9bCQBQ1kX3lduzM/TazWaVuZWT9bYChwnze29lzaPKqACcyzfRVv/B9nfbgdpydNNkCnAvcv4XGmhzCiaycr85GgpDE6+AmW3rTsB7Mqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c5970781D8b076411Bb4c554a3.dip0.t-ipconnect.de [IPv6:2003:c5:9707:81d8:b076:411b:b4c5:54a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id BEF03FA14B;
	Fri, 24 Oct 2025 11:12:13 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 1/1] batman-adv: Release references to inactive interfaces
Date: Fri, 24 Oct 2025 11:11:50 +0200
Message-ID: <20251024091150.231141-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024091150.231141-1-sw@simonwunderlich.de>
References: <20251024091150.231141-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

Trying to dump the originators or the neighbors via netlink for a meshif
with an inactive primary interface is not allowed. The dump functions were
checking this correctly but they didn't handle non-existing primary
interfaces and existing _inactive_ interfaces differently.

(Primary) batadv_hard_ifaces hold a references to a net_device. And
accessing them is only allowed when either being in a RCU/spinlock
protected section or when holding a valid reference to them. The netlink
dump functions use the latter.

But because the missing specific error handling for inactive primary
interfaces, the reference was never dropped. This reference counting error
was only detected when the interface should have been removed from the
system:

  unregister_netdevice: waiting for batadv_slave_0 to become free. Usage count = 2

Cc: stable@vger.kernel.org
Fixes: 6ecc4fd6c2f4 ("batman-adv: netlink: reduce duplicate code by returning interfaces")
Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index a464ff96b9291..ed89d7fd1e7f4 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -764,11 +764,16 @@ int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	bat_priv = netdev_priv(mesh_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
+	if (!primary_if) {
 		ret = -ENOENT;
 		goto out_put_mesh_iface;
 	}
 
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
+		ret = -ENOENT;
+		goto out_put_primary_if;
+	}
+
 	hard_iface = batadv_netlink_get_hardif(bat_priv, cb);
 	if (IS_ERR(hard_iface) && PTR_ERR(hard_iface) != -ENONET) {
 		ret = PTR_ERR(hard_iface);
@@ -1333,11 +1338,16 @@ int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	bat_priv = netdev_priv(mesh_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
+	if (!primary_if) {
 		ret = -ENOENT;
 		goto out_put_mesh_iface;
 	}
 
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
+		ret = -ENOENT;
+		goto out_put_primary_if;
+	}
+
 	hard_iface = batadv_netlink_get_hardif(bat_priv, cb);
 	if (IS_ERR(hard_iface) && PTR_ERR(hard_iface) != -ENONET) {
 		ret = PTR_ERR(hard_iface);
-- 
2.47.3


