Return-Path: <stable+bounces-80637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C398ED3D
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 12:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2243C2821D6
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD414EC51;
	Thu,  3 Oct 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="IJ1atrWK";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="j6BWHkQ0"
X-Original-To: stable@vger.kernel.org
Received: from mta-03.yadro.com (mta-03.yadro.com [89.207.88.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C71422A2;
	Thu,  3 Oct 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952319; cv=none; b=uR3DkGdjrc0unarT7iWaA2dYWvb8TnZrpYcc05fMAxBCOJVmg6YqyHiVDCAQryTkQnEOrJz8ePAblpWuz4sQ8z0nWniG06snImiOYcyLCBxSwgkFJ3xSwUNEn4w9mrA31I2sq7ZapeHwhI0YGSPzOvFii+Nt8e61+vwh3gx7T6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952319; c=relaxed/simple;
	bh=5WNkX2nvkMV/Z5bPguIJH6kiCPXYPI+dFuAB2k1mKbQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MIMZXcWMqshasewznkXWGmYhAhfXSHEP5gvICBjG9gNfYgtVBkVjoFiAwc4+IISAytv6TRIpuRwc4TeiJ2DulVa3R3wpsAajPzVyYiYoKme+0msR0IcGapx9pEBOyfDT6dRWuWfzqI59JDIO1C8MRce3mWG8lDFKsTGpg+XG650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=IJ1atrWK; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=j6BWHkQ0; arc=none smtp.client-ip=89.207.88.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 249F0E0007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1727952312; bh=T1mrESwd+oV0AK5K7qS7Rlnd3u73OBHdgaj+EkDbM+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=IJ1atrWKZkVtFwgiqZiGUpiRYl5+5RBf/EsWnj5lqOibiBMO/87pAFAydyOcFxStF
	 pRyRIlCsU0efZ87+16tgyBFe9Kgys0A6EtmlX4lUI64nZZq+xj5IlBt9Oyjj2HDBNz
	 ULK0dGfolbU49v/tPPAP00tXYoKg5fDPHa0oUCAWYsFoJQmqqwFgAqJv2v91jw4x5s
	 72T0rXUpoaTEavYf+nQpzpG/t6MuhNhfU3ZBGSNc7CURLQTnv6Xx/G0J5j+8kkkeBj
	 Nf1YV6t7ZkFMnYL3T2R/iSQGunpPcEKHVrTUal2kwclzB77J5rPg4IX/W02R480qZW
	 QNXk7hvHZX1gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1727952312; bh=T1mrESwd+oV0AK5K7qS7Rlnd3u73OBHdgaj+EkDbM+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=j6BWHkQ0fUCR2gC0aegsp8jSyw0CPNSFzZ+Eb4ScG8+XPRM3ifuwEmY6PavdU9Www
	 nsShAszkdW1nB37AvR3CK4yV6YfxrdV7wmcrC/8fQYe7Mr5oIU6Uw8+VxggIHIAqwJ
	 4SxULdha6j1qxx5f2bqHL2KUsPXbQHU/75fNwlewiVCfIW+5chbJghzr5AVXYiI0Ob
	 wlpIey3375XihNTJvOOuoWufTe56wMHVKLE1dZE4/8uPOSzOsX+TtWTvIR8e+f9ZlX
	 vu95y8YMeHyDgP1AKJAs4t6MrDunTK+fjq7KYTU9ElXhjLY6537bA1nFNTVxDP+/nL
	 sNxpKpHuTELvg==
From: Anastasia Kovaleva <a.kovaleva@yadro.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<linux@yadro.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <johannes@sipsolutions.net>
Subject: [PATCH v3 net] net: Fix an unsafe loop on the list
Date: Thu, 3 Oct 2024 13:44:31 +0300
Message-ID: <20241003104431.12391-1-a.kovaleva@yadro.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
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

Fixes: b8273570f802 ("genetlink: fix netns vs. netlink table locking (2)")
Cc: stable@vger.kernel.org
Signed-off-by: Anastasia Kovaleva <a.kovaleva@yadro.com>
Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
v3: remove trailing "\", change spaces to tab
v2: add CC tag for stable
---
 include/net/sock.h       | 2 ++
 net/netlink/af_netlink.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c58ca8dd561b..db29c39e19a7 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -894,6 +894,8 @@ static inline void sk_add_bind_node(struct sock *sk,
 	hlist_for_each_entry_safe(__sk, tmp, list, sk_node)
 #define sk_for_each_bound(__sk, list) \
 	hlist_for_each_entry(__sk, list, sk_bind_node)
+#define sk_for_each_bound_safe(__sk, tmp, list) \
+	hlist_for_each_entry_safe(__sk, tmp, list, sk_bind_node)
 
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


