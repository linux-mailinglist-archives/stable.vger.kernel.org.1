Return-Path: <stable+bounces-78470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA76298BB05
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B071C231AF
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A871BFDE5;
	Tue,  1 Oct 2024 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="To/dlGCm";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="hr25LAVC"
X-Original-To: stable@vger.kernel.org
Received: from mta-03.yadro.com (mta-03.yadro.com [89.207.88.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C21BE844;
	Tue,  1 Oct 2024 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782097; cv=none; b=K9EB/DOxx3Qqn3x3IE3NBf8GmdR4uINNpYMv6tgNDMfqBRRtEP8NI5zeg0TS10lgECNwCVwdypPF+jEezyQmZQL22XVZvwjaLzCZjiZOQNGJ9EKVzq5jLhgwWdRcBhXPei0RXpCkxzjSuBmxiW/vSXXz8meFIUHlWkXq7cLXL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782097; c=relaxed/simple;
	bh=bDoNHdGMvOldNnAHOPFZPgGm8ZvgR8+T8X8OFve4coA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gL7C/w2DK1Ye5wFXXuB1Gegzq9sY7sLO7zyuGGPKeIxvaUwPyAUeomkwV0ttYPJbtUoqdnfO8Pk/9nyAaznIzGM94o6/W0lUsLK4y1PhbmNTCFJ8ag3kKwNPo6QIII+RVj1Hf3i6aJ7LdE9yZQXc4k2LpXo4/OZd+E53TRomMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=To/dlGCm; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=hr25LAVC; arc=none smtp.client-ip=89.207.88.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 4EC53E0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1727781537; bh=4WKPhPCzv0PRccHj8E3gU/C6ldhuqZJP/djUeDytt50=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=To/dlGCmRo5I2ueWSJ1TlL1+Q02GxxSMMkKXGbO+DPWVhwfzSKv+pJUJTrzL7ZC87
	 MqOgXJwRhSlORRv9IuoIJWAQUOkPlTmFaHMFi7Ep4Ym+qF9PpwmU5eYIkPxfcy64wM
	 l3CS+0jWxjrMlBYtydD8yktCUmH0FRUVhONP+am3OfpaEELrjvuBJmtWaPXffoiISR
	 bYIkcKTXxO3dLvwt6D4Y0Xr4W8o7q/x2XAT3LpWCPsc69tOW/hT1uYr/BdZ/03bh5v
	 /+9LcVVxNlZogPK6xKxQMZIRDh6LNuKo+DMOBgNY9Ad94x+KrbGsOBQ6Ti9qkVemAL
	 /5K8tYKFSpObg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1727781537; bh=4WKPhPCzv0PRccHj8E3gU/C6ldhuqZJP/djUeDytt50=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=hr25LAVCZr/c5S3a4NzhxQBomrO88Gb5mSCc93zY402/hJDBrRJoulcayiknUmXfT
	 Ap4dDgyvUfGNNM04JCJzt8fdJAXMvAuALFU3POv/ABS5Us6Ig9D1gd3obH9tDKOeaA
	 AP+rw9MXvT06m4FPJovaOxl1CzryKYPzv2QILz++VOa1yOBuNJD+3bYwkAXASwPcjI
	 Bb4bsTCycBI9YjByWKTzx0woKhnv+EWc78/O5hofT7uQPt8/HpVDA+/VnffYZKJ3V6
	 IirP+PoPBsNCGs3Fr5dutuYNHnXJt6QpPM11+LsegTA5kxQsw4z26HJfYSHAkVtoUW
	 6FcdqDUfqYIpA==
From: Anastasia Kovaleva <a.kovaleva@yadro.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<linux@yadro.com>
Subject: [PATCH net] net: Fix an unsafe loop on the list
Date: Tue, 1 Oct 2024 14:18:40 +0300
Message-ID: <20241001111840.24810-1-a.kovaleva@yadro.com>
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
_______________________________________________________________________
Oops: Kernel access of bad area, sig: 11 [#1]
  ...
  NIP [c000000000c080bc] netlink_update_socket_mc+0x3c/0xc0
  LR [c000000000c0f764] __netlink_clear_multicast_users+0x74/0xc0
  Call Trace:
__netlink_clear_multicast_users+0x74/0xc0
genl_unregister_family+0xd4/0x2d0
_______________________________________________________________________

Change the unsafe loop on the list to a safe one, because inside the
loop there is an element removal from this list.

Fixes: b8273570f802 ("genetlink: fix netns vs. netlink table locking (2)")
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


