Return-Path: <stable+bounces-249576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOINKqZaDGodfwUAu9opvQ
	(envelope-from <stable+bounces-249576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:42:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F00957EE3B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63CAF30DE4EF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A794DBD9F;
	Tue, 19 May 2026 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxdNV23U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919994CA294
	for <stable@vger.kernel.org>; Tue, 19 May 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194162; cv=none; b=skBnjRcT/hnEltW675id41pjxqB7oPnnLGOIi4NUjwgPUhkp/JM2KK6cjpZW+8NtzQxp5mesIbcTmMvvYxACzozevktKqejXjFHgD5pYEnILk+KqCkkail94lbV5uTn+U9Rv5lyyryjFChDY1NTMP7/vQgHCF+7YLLtUNAh4D1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194162; c=relaxed/simple;
	bh=lIc9IvGukuTxrcKPyEANUt/P7j7/XDF0to6T1xKrVwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFmuuktCaDUZKXh+14y6SLvp8LQKwD7KceaqoIsyG34Ptah6fXT/MbNiKxzXn6v39FRhDsd10wIKI2IySmblk0m/m4u8wIepONIuIYGeWRV6vQ2XnqX8Vm10JwaYdifxBLwSvpDLPdRIECdi+xBFt99k4y3c0XuYPifIax2slbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxdNV23U; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bab82d75fdso16018545ad.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779194159; x=1779798959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnqfNLPf1FZpTLzCn6yNj1v+FRpfxLX1loWYM78LAiU=;
        b=RxdNV23U+rPsSJ2il8ENIcIFV40H/lty0OrdzTXSVqMXYIz66s5o3jbYDXuRgDRHZc
         mocdfsHTWeH9IxBBe0SpTmTOyhbvkoQYYcewzG1coz4ZXz9ebX1CjusnhKYHmlIAKyHG
         APx13kdteRvuESCs92OtIkWtLS64LSRezJpseyRGKI+MwXAvBcnDuCeLpXWa1lf1qcLV
         s94bvNCIl2PF6LeweFQBTzIQ6Xk74SazVQE0VsSY7VtGWCxu7IZZa7oc3ZMPTkFLf5z9
         Aibou2FWyPxzTDquj6XAkfcb3Bs2SJ7ePLXMFsP97O+thyIjOqZtrtz29wNF/n+9vyWE
         1hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194159; x=1779798959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WnqfNLPf1FZpTLzCn6yNj1v+FRpfxLX1loWYM78LAiU=;
        b=BL0D5f5IKSS8xa3AcDfO+vlunuvKrMI//rMF+F2FQuwqBPFu4NIpSg5c5hke9Us1qW
         D/Uzvui10/S1mQofj1wXydqZSWhM2KBWEIcuqTWJOUi/KUCAiG73GT8teW21g4f8RRoz
         vf3qjj3cQeKYicd38A5jRh8nnsrWWjvIJpecotS6yVufz5ZfMGmcrMYhEISKVgon7tJj
         Fz5ybU8KeKc1+kyFCTjLzHhS/WAqyE7wtzcnp8DdCDbYD1i6ZTRO0Tn3Mlvw/+laz52W
         eA+9VJxe6p7c17t9G3jwG3EM43kbsgrDVhb+pW31rkVC6FihXfoOunHk8PjxuM023sms
         JsuA==
X-Forwarded-Encrypted: i=1; AFNElJ+lY+HhV8jj/XkvD8j0uhTuyE7rfQB2frTQ1Oh747MThJiK07CArSt8VC1kZWTpe6inLDUq3Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvN+C24cLmXOCPJPiPT0uAsIrPXncCpz7aXzQPzgkbRgTT+iVU
	so3auLad5JfZ4/TJaD3YjK0uGdEPMvwJkwrTOO6+jBO/9aZX6Tmc4Xvb
X-Gm-Gg: Acq92OGnPbh/VOB5jAvnrBr8QTSKvn21NIG/R3Uo9nsSEa+PGx+N2Cxz1fUOWbxda7m
	A0J6zSbLp5hMwXoF6nMtP6A05lG43KVUH7+Ur6PLiIJf7YFrU7tTJ6wFMLsYFUPrnQZtZY3UhWp
	tcf3FKwY6aiY758bp90UXgpBsVdFQecwNlBlJS1fAN3Hoi7TUipm8KPQS/oA8++5/hagt8GxBH6
	nYyOCyqREFjiaUpvB56L4gDwLluz1vAbNy96GMWppsAaRMIABQa+hYZ4tFTTZNFeMZ8zusdwtHF
	bCwSLZw/g/Dg/uNcU30FX8xPFwErBI0LQgSdmxkkPxb3p5QvmWADkE2ssde+hTIKnyRsREyLy4U
	Vw10yzcIeyjtB7YcsMPCXPt8CFh2WpkiXZWpMovRMDOqvjUVEcc/O7LbcqrJehI68azGqDQG74y
	xj0SGSt+I1809tU/9mc0nKoHFuF1DxSbIvFf2v8b3EqcJRW6Io
X-Received: by 2002:a17:903:950:b0:2bd:a3c5:6d96 with SMTP id d9443c01a7336-2bda3c56ef9mr147376025ad.14.1779194158910;
        Tue, 19 May 2026 05:35:58 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc60sm193216245ad.9.2026.05.19.05.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:35:58 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Shaw Leon <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/2] ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
Date: Tue, 19 May 2026 20:35:47 +0800
Message-Id: <20260519123547.2055911-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
References: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-249576-lists,stable=lfdr.de];
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
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ip6_tnl.net:url]
X-Rspamd-Queue-Id: 0F00957EE3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After "ip6: vti: Use ip6_tnl.net in vti6_changelink()." in the same
series, vti6_update() unlinks and relinks the tunnel through t->net.
vti6_siocdevprivate() still uses dev_net(dev) for the collision
lookup. For a tunnel migrated through IFLA_NET_NS_FD, dev_net(dev)
is the new namespace, not t->net.

The SIOCCHGTUNNEL path on a migrated tunnel then proceeds as
follows:

  net = dev_net(dev)                    /* migrated netns */
  t   = vti6_locate(net, &p1, false)    /* misses target in t->net */
  ...
  t   = netdev_priv(dev)
  vti6_update(t, &p1, false)            /* mutates t->net's hash */

A caller in the migrated netns sets the migrated tunnel's parameters
to those of a tunnel that lives only in the creation netns. The
collision check in dev_net(dev) sees nothing. vti6_update() then
prepends the migrated tunnel at the head of the creation netns
hash bucket for those parameters. Subsequent lookups in the creation
netns resolve to the migrated device. xfrm receive delivers packets
matching those parameters through a device the caller controls.

Reachable from an unprivileged user namespace ("unshare --user
--map-root-user --net"). Cross tenant scope on container hosts.

Use t->net for the SIOCCHGTUNNEL path on a non fallback device. The
lookup then matches the namespace vti6_update() operates on.
SIOCADDTUNNEL and SIOCCHGTUNNEL on the fallback device retain
dev_net(dev), which equals init_net for the fallback.

Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link_ops")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_vti.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -834,15 +834,19 @@ vti6_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data
 		if (p.proto != IPPROTO_IPV6  && p.proto != 0)
 			break;
 		vti6_parm_from_user(&p1, &p);
-		t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
 		if (dev != ip6n->fb_tnl_dev && cmd == SIOCCHGTUNNEL) {
+			struct ip6_tnl *self = netdev_priv(dev);
+
+			t = vti6_locate(self->net, &p1, false);
 			if (t) {
 				if (t->dev != dev) {
 					err = -EEXIST;
 					break;
 				}
 			} else
-				t = netdev_priv(dev);
+				t = self;

 			err = vti6_update(t, &p1, false);
+		} else {
+			t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
 		}
 		if (t) {
--
2.34.1


