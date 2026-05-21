Return-Path: <stable+bounces-253553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHFhN5EID2rqEQYAu9opvQ
	(envelope-from <stable+bounces-253553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:28:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C15565A5C59
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B977A306F213
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D573EDE4A;
	Thu, 21 May 2026 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYEULBhT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A73ED11D
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368768; cv=none; b=XlKpFmhWkASOve3TjeeD8YW8uxfXmWGVo42A+GmTOlpfaSp4XY2sP++/h5cgOjmShTBNe0tKo4+MhKDNnfmVJbRPq9+Xly1MabhJkpf16DgGitImdmzwnkGKbmdSNu3eCwvRvlJ4lxh0CD0msr6tu/d2gY6xq6T6NExo855osYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368768; c=relaxed/simple;
	bh=qY+plYrHUjyEKlEwdjvB+Ilsps0ZT2pjPeZqXaLCeD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKagogrpbusK8e2P+2Cjmqm+4UUeSXZWWMBbGejiMDMHTX0IgsZ/mJUaOufGOwqyq/kJtnN2Kdl8G6iNNaK1S//MheO8kLcNHSkb4mVXCehiUyG+q71nweQPgqxuMuHxB7ECP+EkbAa6OBsG3k7i09qPncZgnGD8l+xP9wn2lbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYEULBhT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so4263166b3a.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368766; x=1779973566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7dYXWxYJ/dsjCJq8MPbJ/YlkTALMLc3dGOHkkHfnHE=;
        b=lYEULBhT41yP7oCnoZ984Au+TwRDfq10EG7j7JJ5w76Tjw+kkVQP1hwacrLoifpiAn
         IrDM5GrH2/UC9DorpTiP7V4UFNkmWuro6oTB0nEHRCIYMJtz02JDh+9efF/w46x/xbID
         HYXrytq9WlDGC/KslYIKc8pMSkbM+cj7EetJYg1uMoVKrqSCSoOcZKtKmSDfAgLdCpXO
         GMQIBzi/Bee8cgTYjioVciVBvK/hELmliGHQoaBTPytuIOf5J19nAH+scEHjFb4od+c7
         6lv4Ebjhok5bHFQjARCTtVxbWoLH52iwCh6rVzykNWQFrNbAgZBbex9kgYJXUsUTXwgV
         lt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368766; x=1779973566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7dYXWxYJ/dsjCJq8MPbJ/YlkTALMLc3dGOHkkHfnHE=;
        b=p51jME6KU/Fkx0CFgU5riLnxTJrQkN7z2+fyt210Czb6/lb7J9nQj+KHvhaOf36LJ5
         rNOgsWLC1ZQRreybbVjkePH70eis9mj7HtY0aYivKPCTtdBQ0I2fRA4u/PC3ouBunLjU
         mz6k7Po3723wIGM8YkmIPO1ucX76Aeyt3FW6nfyUcF5NEL8b14OpflDipjEJ45MdFAQ1
         UM4kaNc4FJVPcwE8up5y3H24p3Jwki8Is9Pvm/Gh4Zo5MqYwdg1Sgq3UtI4yapP3g64A
         nFABG0fArbtC/F5V9y5yKU8r7mdbrXG97PDYo0vnX9jBGwpuUpvZC/jxX6tV3alXf07I
         VryA==
X-Forwarded-Encrypted: i=1; AFNElJ//dI7Oy1MhrxzwR7v7u/4iMFPzzFp7vAV/Cn6uHlW4m8CiyWm7bmzn/lVeIexAHy9EpnyquB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Cq+ChQHIcEahqDo8J43fkyBX1Ba1l/3SmrijAoD09jGljKzu
	eLE8llVOisYryx2TeAhNIwy4x5zMM6EGkyPg3IJ9BXd4xDPEKgee8xYV
X-Gm-Gg: Acq92OFKm3X8gHoMqxFUpgo5UvgWQRJTZHNxkPiurS7jxcNmsugomTcv3OzrjS27isf
	KskTQdK3Ck4NEhjx389Rv8FtfT/tQJKN43pzx0xar9ihtVi57C4o7bnLhnKIovDWSe1CqVYS/sx
	3Iax3FXKqy5A9hcyFue9F5FkS7CPhP+ShV8gUDUFrie5FvRl1krZpkW7a7EQ0NGKTffeK6rDMfp
	A0oKRcaAJjjueCQXbZtP0zQ0nLylLBfFCLHKyd4scw4amIhF7DeiEaX1xtQLix/BVCnRlq0+JbG
	06+IOiNANCobj5w0TaDbbFbAgjZjCk6I29JcKxXOZD5+sqeb+fYi7v2AXgTxuGejsc1yN+ILL76
	/aoX/cSOmfA35IpuZOtDAumZEnNDQjbbHf9Kjy7DiSgKFgxaOJHM3KjGgLWfZfMs68W0BlnhOWM
	VS9u7jkf735FQumUtLQ/XidwaXkITxYIHItUlLAmdBDyCO9XVa
X-Received: by 2002:a05:6a00:419b:b0:82f:1369:7268 with SMTP id d2e1a72fcca58-8414adf69admr3131200b3a.30.1779368766276;
        Thu, 21 May 2026 06:06:06 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841549be20fsm1693993b3a.12.2026.05.21.06.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:06:05 -0700 (PDT)
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
Subject: [PATCH net v4 2/2] ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
Date: Thu, 21 May 2026 21:05:55 +0800
Message-Id: <20260521130555.3421684-3-maoyixie.tju@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253553-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C15565A5C59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After patch 1/2 in this series, vti6_update() unlinks and relinks
the tunnel through t->net. vti6_siocdevprivate() still uses
dev_net(dev) for the collision lookup. For a tunnel moved through
IFLA_NET_NS_FD, dev_net(dev) is the new netns, not t->net.

SIOCCHGTUNNEL on a migrated tunnel then runs:

  net = dev_net(dev)                    /* migrated netns */
  t   = vti6_locate(net, &p1, false)    /* misses target in t->net */
  ...
  t   = netdev_priv(dev)
  vti6_update(t, &p1, false)            /* mutates t->net's hash */

A caller in the migrated netns picks params that match a tunnel
in the creation netns. The lookup in dev_net(dev) finds nothing.
vti6_update() prepends the migrated tunnel at the head of the
creation netns hash bucket for those params. Later lookups in
the creation netns resolve to the migrated device. xfrm receive
delivers the matched packets through a device the caller controls.

Reachable from an unprivileged user namespace (unshare --user
--map-root-user --net). Cross tenant scope on container hosts.

Switch the SIOCCHGTUNNEL path on a non fallback device to use
t->net for the lookup. The lookup now matches the netns
vti6_update() operates on.

Also add ns_capable(self->net->user_ns, CAP_NET_ADMIN) before
the lookup. The check at the top of the case is against
dev_net(dev)->user_ns, which after migration is the attacker's
netns. A caller there can pick params absent from self->net,
the lookup returns NULL, t becomes self, and vti6_update()
inserts the device into the creation netns hash. The new check
requires CAP_NET_ADMIN in the creation netns user_ns too.

SIOCADDTUNNEL and SIOCCHGTUNNEL on the fallback device keep
dev_net(dev), which equals init_net there.

Fixes: 61220ab34948 ("vti6: Enable namespace changing")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Xiao Liang <shaw.leon@gmail.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_vti.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index dcb257411d6e..df793c8bfffb 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -835,17 +835,24 @@ vti6_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data
 		if (p.proto != IPPROTO_IPV6  && p.proto != 0)
 			break;
 		vti6_parm_from_user(&p1, &p);
-		t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
 		if (dev != ip6n->fb_tnl_dev && cmd == SIOCCHGTUNNEL) {
+			struct ip6_tnl *self = netdev_priv(dev);
+
+			err = -EPERM;
+			if (!ns_capable(self->net->user_ns, CAP_NET_ADMIN))
+				break;
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
 			err = 0;
-- 
2.34.1


