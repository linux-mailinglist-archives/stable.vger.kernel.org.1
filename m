Return-Path: <stable+bounces-78474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2341698BBB3
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD252B22D6F
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804601C172F;
	Tue,  1 Oct 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="A/jvAU+F";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="eiZNEInb"
X-Original-To: stable@vger.kernel.org
Received: from mta-03.yadro.com (mta-03.yadro.com [89.207.88.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB41BC09F;
	Tue,  1 Oct 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783927; cv=none; b=FIIGQDvQKAgCQ2VSAktdK+ai6XfBjzJjiaUTkNAiGlggof8M4Lyi//U0KaL2U07DZGDrwaZkZK8EAae45Y1FER2ml67LvAJFGrbX5Dw0dP6Ah/KOU6g0bnQJo5He8lfvwy1oWx3CUg24wLD97WLKOWGPqh/qlImhZ2CeT8+SV8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783927; c=relaxed/simple;
	bh=rr8AJsmtTBcMulaSGXksJr1y9yRtpnPnDXvBlWoRyZ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HSUucd84UMuf1TmXxGX7lfgogK9W3G7hDfeEw2snoa6xjhWVIAAtM1FWignlE/W/vpZ8pQA0OfcrNyBxKeJAxH79v2Znz6gxi3I3zNZjOb6Fau9MmFUcmqtcaKqS1ypxi80I+LNbL4E6oBz4F5V8VWLeb3f25Alpd7MRyKX+43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=A/jvAU+F; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=eiZNEInb; arc=none smtp.client-ip=89.207.88.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com BCD69E0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1727783919; bh=TklAxcAdmadF00iKKdyaTshRkjRv8zK1FN53nNX35+4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=A/jvAU+F6jz4hRQyN82crSk0Yqrg1mTjaIlObFlhqNqsNBGimqK9Zlt7OHpVxx8eI
	 gpVzzoUPY7hHdZpPUnQTDqxxVsqHFw+Iz0ojA18mTqcZ1S0WknC2By8GjNAeBUa4ls
	 wPVGdOHxw2oR5f59eYclAwpI1e6bLLN7ImZPKtE4SRovWGRRtuQVComjr2G14LVJ5H
	 meFcoubrO7ds3IMWFjeDc8pPzdhBrsEV3PQFTFV4SXkZX3Fuqfi7pVZHkJuaUGqQxG
	 kg4rTPC53Sga7RJxvc2NYSBnZibQLp2sJGN8UCX4XY25Mz9yZLFXaoBuaA6jseGJ+A
	 XnpBXmPqJ+40Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1727783919; bh=TklAxcAdmadF00iKKdyaTshRkjRv8zK1FN53nNX35+4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=eiZNEInbbDRxjihJdPjBgNN08xg34khd58d3WAREB5lJPX5ZV4WAQvgIlfYPe8Lri
	 mLJ89Zrv0Bix2vCtNTWUJ4vA7IXA0G/TKv4uJ26clONsuWoY9w8/PUnjd/1HJzuxHL
	 +5qjIf342yb4AHwO3p/58gPkWb5uTCMtZOYGcjrjEOn+KNETsHTKWg1ZZ43/f0r8J9
	 Y99YltDYWjj+MXo4pDEfWyR920qcm620CPGghjJhC9101F6bFlP1ljEvUjA1jxfhTr
	 dsU6/65BAC7NLbb2GNlvduENWKpdd9HcWNu57b9LaPb6M4/a/8A3kJ4RhhzUJ3DHHl
	 VorZspjmv+A8g==
From: Anastasia Kovaleva <a.kovaleva@yadro.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<linux@yadro.com>
Subject: [PATCH v2 net] net: Fix an unsafe loop on the list
Date: Tue, 1 Oct 2024 14:58:28 +0300
Message-ID: <20241001115828.25362-1-a.kovaleva@yadro.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)

The kernel may crash when deleting a genetlink family if there are still
listeners for that family:

Oops: Kernel access of bad area, sig: 11 [#1]
  ...
  NIP [c000000000c080bc] netlink_update_socket_mc+0x3c/0xc0
  LR [c000000000c0f764] __netlink_clear_multicast_users+0x74/0xc0
  Call Trace:
__netlink_clear_multicast_users+0x74/0xc0
genl_unregister_family+0xd4/0x2d0

Change the unsafe loop on the list to a safe one, because inside the
loop there is an element removal from this list.

Fixes: b8273570f802 ("genetlink: fix netns vs. netlink table locking (2)")\
Cc: stable@vger.kernel.org
Signed-off-by: Anastasia Kovaleva <a.kovaleva@yadro.com>
Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 include/net/sock.h       | 2 ++
 net/netlink/af_netlink.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c58ca8dd561b..eec77a18602a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -894,6 +894,8 @@ static inline void sk_add_bind_node(struct sock *sk,
 	hlist_for_each_entry_safe(__sk, tmp, list, sk_node)
 #define sk_for_each_bound(__sk, list) \
 	hlist_for_each_entry(__sk, list, sk_bind_node)
+#define sk_for_each_bound_safe(__sk, tmp, list) \
+        hlist_for_each_entry_safe(__sk, tmp, list, sk_bind_node)
 
 /**
  * sk_for_each_entry_offset_rcu - iterate over a list at a given struct offset
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 0b7a89db3ab7..0a9287fadb47 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2136,8 +2136,9 @@ void __netlink_clear_multicast_users(struct sock *ksk, unsigned int group)
 {
 	struct sock *sk;
 	struct netlink_table *tbl = &nl_table[ksk->sk_protocol];
+	struct hlist_node *tmp;
 
-	sk_for_each_bound(sk, &tbl->mc_list)
+	sk_for_each_bound_safe(sk, tmp, &tbl->mc_list)
 		netlink_update_socket_mc(nlk_sk(sk), group, 0);
 }
 
-- 
2.40.1


