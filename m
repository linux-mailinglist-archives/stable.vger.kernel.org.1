Return-Path: <stable+bounces-241630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO9SMnSW8GmrVQEAu9opvQ
	(envelope-from <stable+bounces-241630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:13:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28383483708
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA510315BE90
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE93EB7F0;
	Tue, 28 Apr 2026 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYENpmII"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4113E8C45
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374448; cv=none; b=DX57NNa+Kuk7rtdCM/GIUaMsvTgUcyPNLbQFFaEhYf3KRx8AwCA1nqd9lWzK3jdHOOJ2EJNe/YLiF9ZiRPPGfEJS2F9NSIJXNkHuFX1KPtKLVa8Z1ZiTcWvboBzk11fyf+X3Vm7NKJOfd2WT3TOXeKJLtBiF4gI9Ns7Dua6k5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374448; c=relaxed/simple;
	bh=t1J1G0DPTGU3Nq5IK8gdpkJgcqUbwU/dQwACfaQ8rfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQGFjDk+uei8ee8mGNCqBfySj8KPdL1joilPF5Q2c9OTReL7q7JhJ9jUX5A4FKwbsJbt3gvxt1rjR4Vh4BvSUk/vHMZHLpIIOgK+5kBkKfrfZC6M8t2D+A1m8oGJXqFpECD6q0CdCQxe6iHhmlHQ0/+5kFz4ZiTdjN175pJM6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYENpmII; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-362e30526f8so2129167a91.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777374443; x=1777979243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbbMQ0UaEkffRakuaSv0SsaIDp6XiWs2fQ+ORE2pX24=;
        b=rYENpmIImf6ID+SbAViIxp/ggJ2TcTkqLd72/oZO2O9PeO8JbTLlv10ujnRP5lJ3JL
         GToWdPOoJxsBm+wkrnFswdeDtWGEbpFejQv12DWD+4Xfv85qsLhKsOKuPaf7vsjKlBKn
         e8Tro0FEKbz2EXLa0p77Z2hxiyY96mxIfq7eIMrOFE8KKMV2Qk1fw3abqtYmiFwMfAj8
         VtlOoNAJJNefcKnaNjD0eIgpM/iqZldcs7n5tcRlZ/c/rwCX0ZU0kPA8+Ilk2xWwAby4
         1GGCP7L+kjE5CYVP8T7PXFMdGVFfjREbp+6Buo1DYHiNL28rPm4fTxNxftyMvl+JnvSJ
         5lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777374443; x=1777979243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbbMQ0UaEkffRakuaSv0SsaIDp6XiWs2fQ+ORE2pX24=;
        b=cv1h5h96FlNzJJLySf91CYefr6eG+HJlenxo5BXEHOd6x4lSxWR6cLxkAFpBNxj/73
         Ph+HTKNzKsDnSadVvK7GXu5tyR/2mUWoNXIqkNhu72XbWYYnkKNiqCh9pupue0IAq7C+
         ehOCLI2zBfuoJDM6WsVKhj2LRUHN66z7/kj09pSV86Wng8sWuG6whYW7GGY5E0cY8UkE
         K9ANMu6j41Z0dAjQ16gvJqzDqMBpAXR+wazo93EZvFbFeFHRwl9l3uJCXJgaW9lN5NKB
         rA8gScPcISbboLyfihTsoGteXWlXqgRf/Sm7fS5OEy83Br+yU5XkfTCOqjndXCIO1Chd
         reJw==
X-Forwarded-Encrypted: i=1; AFNElJ9YV1HjFA5/GFN9vEr8zQwNNxV+n0fyiKZdjxiU1zaIQuMynxDcMPSKm8Gp3W4L8+/nE9V0tfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO5orANwFzW+wRy3r3XvhB9cH+1X0s0C5ZBWq+neYKkoNmW8ck
	aTeo+7PuXpscvzRB+JZN1B9x/YapsKmBZxzFDr3Gbw1S8AFXEKBWqeKb
X-Gm-Gg: AeBDieuMvnDIMvfUaDoTVRjcB7RCkRUpAXY4uKuIg6/6ML9PnyXDUCSC1uHnyM5QDnk
	PydQEYXnZ3CmVGauNKCilBztEB4CVkMNDO9iFFf7+qLhFP/9HGpvG8BpovEBW7kuTM3f5TNWRYW
	TFvijm+4CWVQjTC+HVbBuidDAFzTZU1eg7+2dfesiVwRpPSkP+HVDcxgfghS67PbYD15S2gZzlO
	AdmRsR8iOd+KcJUuNOcYW5flppYL7z0208xr/dl71Wsk5JaGQD46HGsr7TzupvHuh1I1rtV7GaH
	5fgnQSuFSr6BgGpJmuli5kmAkRqS+salMUI8ZeEKlHDHzEFpOxjCwBrfucj1zpHghmeTCugi8gx
	2UU/Xun5N5eyD0Yinle/QVqHWCu8XkLIBlQYIEWJb4ySEZcc/OAe6Pgju8xpjVYOmOMZyWuc0Bo
	08/tF0Fb0kQslpiaotY8LOlinT8Nieq2QvpJg1nKp3sNciPMMaWwaawbnjnVA=
X-Received: by 2002:a17:90b:4c86:b0:35f:d56d:1c45 with SMTP id 98e67ed59e1d1-36491fbc102mr2653279a91.12.1777374442873;
        Tue, 28 Apr 2026 04:07:22 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc33d4e11sm2023328a12.24.2026.04.28.04.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:07:22 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	shaw.leon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org
Subject: [PATCH net 1/2] ip6: vti: Use ip6_tnl.net in vti6_changelink().
Date: Tue, 28 Apr 2026 19:07:12 +0800
Message-Id: <20260428110713.2550315-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 28383483708
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241630-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email]

From: Kuniyuki Iwashima <kuniyu@google.com>

ip netns add ns1
ip netns add ns2
ip -n ns1 link add vti6_test type vti6 remote ::1 local ::2 key 7
ip -n ns1 link set vti6_test netns ns2
ip -n ns2 link set vti6_test type vti6 remote ::3 local ::4 key 9
ip netns del ns2
ip netns del ns1
[  132.495484] ------------[ cut here ]------------
[  132.497609] kernel BUG at net/core/dev.c:12376!

After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
rtnl_link_ops"), vti6_newlink() correctly resolves the per-netns vti6
hash via link_net. vti6_changelink() and vti6_update() were not
converted in that series and still read dev_net(dev) /
dev_net(t->dev), which diverge from the device's creation netns
after IFLA_NET_NS_FD migration. The result is a stale per-netns hash
entry; cleanup_net() of the original netns then walks freed memory.

Reachable from an unprivileged user namespace ("unshare --user
--map-root-user --net"); cross-tenant scope on container hosts.

Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link_ops")
Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_vti.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4..dcb257411 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -722,10 +722,11 @@ vti6_tnl_change(struct ip6_tnl *t, const struct __ip6_tnl_parm *p,
 static int vti6_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p,
 		       bool keep_mtu)
 {
-	struct net *net = dev_net(t->dev);
-	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
+	struct net *net = t->net;
+	struct vti6_net *ip6n;
 	int err;
 
+	ip6n = net_generic(net, vti6_net_id);
 	vti6_tnl_unlink(ip6n, t);
 	synchronize_net();
 	err = vti6_tnl_change(t, p, keep_mtu);
@@ -1031,11 +1032,12 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 			   struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
-	struct ip6_tnl *t;
+	struct ip6_tnl *t = netdev_priv(dev);
+	struct net *net = t->net;
 	struct __ip6_tnl_parm p;
-	struct net *net = dev_net(dev);
-	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
+	struct vti6_net *ip6n;
 
+	ip6n = net_generic(net, vti6_net_id);
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
 
-- 
2.34.1


