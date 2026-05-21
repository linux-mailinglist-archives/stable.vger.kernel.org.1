Return-Path: <stable+bounces-253552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC45LN8HD2rREQYAu9opvQ
	(envelope-from <stable+bounces-253552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:25:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 417B05A5B8B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5B4C32178D1
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DBA3EB808;
	Thu, 21 May 2026 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK7in4bI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440AD3E8337
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368766; cv=none; b=lWdgxRFSjn97WHcdk99ChpvJhrSUmF4MDNsmEO+oJoEep0xQQ+6IKwEjLirMR9d9O04zm+yKCY1a30L6XsnFC51XfFY86bXlkrZSKDs757DuO4/RcBG3qO967UHbyl4mBlQQNPdhAOgSX0O4SeKiKLmhc1KfQEB8qWwVw0weKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368766; c=relaxed/simple;
	bh=o0+Uc1eRtmlTav0dVo/A4qHTGC+dTGpAF8PyhhZm7+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZnWe/IG6h9hyws/90mrzPpaXqDo4LdlbhuSY/Kuk1U/8ASQaZ0kZzxXcPdYQgUpbDlArn06Cb0HzPgWWu3jiswUs/iWp3bGr0Nb5OMZ0c7pBlCHPjimdTAZzGOxsHfh0K0Q5NumTDQVKt73NPGUZJBJ+C5HKkU3R6BBZ1ESX+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cK7in4bI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-83537a80ab6so4060623b3a.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368763; x=1779973563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tgtXH02C6zRbkOdG+i0RmY3ValCYoij0GD+Hz/Vc9g=;
        b=cK7in4bIs4TuLszQ+fRTJ9Dt/L4Qu5FTqdp04ooxQdsPZ8RQCd+2HFL2Cq2/LEZVVM
         y2q59LUKw8s8Mk3HMs8PIiktc9HlIPGqb87XfAplqjQPYmeVnokD2kYIYUj5O8LpHjAW
         Ga6a3tZvZkErmKSq36JZth6fCMsyJ4yy11nrg2v2qt46Ial/K3vwG64BYv8SSavyiXwv
         I45fASOzlO+UYoRV48ufEtAMZ3JeB7iWkbdywMIrHVHkq4USKV5MfJFxPTmS1e6sl0ui
         0JaanlzthHvDXlzIoutM+SJkuwmfcmAiyy1648pJssPvG2CF2Lvv/AyCMcXA6iWQR3RN
         0Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368763; x=1779973563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tgtXH02C6zRbkOdG+i0RmY3ValCYoij0GD+Hz/Vc9g=;
        b=J6yFp2U1UVwRNApKEFBoYCf58jWHufq9VvQo/5bMJ4gZDtgIKYUUPUSzRBZX8LHyrA
         dQW3/JTcj9NQPrt4Rz+arjVZxMdmpBiEtgMUxXU4UVc1A66c8XwMoDrQBr+hQC0/q94p
         nqbRb2DMBxQGY5A9N3y6V8AcBOzcTWyS7SBGYYY1tjYq52uq3oiKGqNUSpgfMvUENJOW
         X8eRgFMH92zNxlJSYijpzAekLnnEtvdnUNOCqZUpEiPWO5OiUSH1AiwcZDxNpQScX/jd
         ylfC2ASG0UfcX0XWTcbjQ0/LRRqfvhCt6iIYP9ExO74UbWFWZBY4tu7QAPDVxJI8O89a
         l6yQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9On5MOaU5H/OzwmiWTaGuHTYrgzZ6CA0bDIRrFLWoRzaDD8LA8IElEmAnMYDYImwgziZDXmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS3efK40L6frpiPnNuL7XyluZR+jqblvPoXvnNDdN+ip9sH8lS
	8cHi6oScdXagLWlj9UTlE7wpM5TozB9t2DcaY0n0VNfmOfJ9INEIVplu
X-Gm-Gg: Acq92OFRPwJGXcDXvozjiko3OAYvjPQAlPQ34yYpNn8cyXaSXJa85O6ihjmLGUb3fYA
	VDbxKsxZ6PBRbZfRQInIoY5YxADvecVBp8Zi2TdztiGaVaMAFS877VIc9xR9W4sFVr2NwOBZjSJ
	DWKKUUJKwi/0h8FQh8r54RBVBlh5Xr86ie2kvuyznuBAGd1W4P5/D/0kbFLG2qQsUZ/wzk36Ddu
	KHpmLMM5j7wL+6bU7lj+y2wYgD3yaEvruXiaNEx3/ocJ9NI4OxG3ILmyrcQhXS1MPDbjAdGW6wJ
	HzfFYikjA4o9mcQxr0EnsxhjsiAjzgXTgdP5FY8G38jC5SM6Pl//YVHuYjWOD6jotCovpJB1niQ
	S5bdT+LzcoUtkzGjnvb4fIFd1r/FaUPcc0fJn2y2zDLBdMbKR9XwURd+Qd7wJpMUcC855oxHcyr
	k5djrY7Aj3y//xxD94GxcrE6XkmXYzh6i3WCVQ35On7J+c35Hl
X-Received: by 2002:a05:6a00:850:b0:835:41f3:f449 with SMTP id d2e1a72fcca58-8414acda757mr2821717b3a.13.1779368763468;
        Thu, 21 May 2026 06:06:03 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841549be20fsm1693993b3a.12.2026.05.21.06.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:06:03 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] ip6: vti: Use ip6_tnl.net in vti6_changelink().
Date: Thu, 21 May 2026 21:05:54 +0800
Message-Id: <20260521130555.3421684-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521130555.3421684-1-maoyixie.tju@gmail.com>
References: <20260521130555.3421684-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253552-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,secunet.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 417B05A5B8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Commit 61220ab34948 ("vti6: Enable namespace changing") dropped
NETIF_F_NETNS_LOCAL from vti6 devices. A vti6 tunnel can then
move through IFLA_NET_NS_FD. After the move dev_net(dev) points
at the new netns while t->net stays at the creation netns.

vti6_changelink() and vti6_update() still use dev_net(dev) and
dev_net(t->dev). They unlink from one per netns hash and relink
into another. The creation netns is left with a stale entry.
cleanup_net() of that netns later walks freed memory.

Reachable from an unprivileged user namespace (unshare --user
--map-root-user --net). Cross tenant scope on container hosts.

Fixes: 61220ab34948 ("vti6: Enable namespace changing")
Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_vti.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4dd6..dcb257411d6e 100644
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


