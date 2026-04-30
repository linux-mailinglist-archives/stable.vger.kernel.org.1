Return-Path: <stable+bounces-242081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG4bMEYw82m0yAEAu9opvQ
	(envelope-from <stable+bounces-242081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:34:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E5C4A0E37
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797BD3009B25
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC94A3806D7;
	Thu, 30 Apr 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwfosyMi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A7371881
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545205; cv=none; b=FOLkLhpT41Rdi/KVPY834P0WS7jgVrAIiCXX2nVIWT+fUTQ37nI8AMqr+d8CSfYdYIl5nW4a0zH34kJq0h3qEybuAmjypudHvxS3E0gLDlRmo3rbFLepFDnj8PQdE5HcsFA33VeYEfXWPB17b2IB/SIepXO+o4TVQF6og9ADPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545205; c=relaxed/simple;
	bh=HmJDuI15pv/V4UFD9ngUIjPrqHL42c/sRO/HoYWBlO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S+tMPrCmP1CVa5tfdcYt1iIBtnl/SbpLmj85qtQjd7QfJ2NVkhoWHZFJ6UEY8a8MNQLSyQ+v6oNvERCM3PTbCJjdJ9KpvOOJxzuBFcZ4dJUhDhhcsCrWiTTwBuJMp81Jo1lM91tDNmJ/McWu8GKtocqkaOIMFhD/6t7yDhYRpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwfosyMi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so743793a91.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 03:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777545204; x=1778150004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlQdc9ZGGOy1nWwQGOqT37EUu8/n7T3oBCrdhsUWNlU=;
        b=CwfosyMiQX58roqtRTYo8NNy1EBVH+rybYqrkB1n+FpN/maTjzJnD9l3UEh8P6AYTX
         QCulFfig+79Yu+dt92WKu33J7WJ88dwKrO1yrl0QSTVAxOhdMr+QtA0Ob3KAU5WMGhSE
         gYULiU5RJLnO8oFjCdgMbS1vacGGuEqFT2VZjhLCvT5nXHBwnoRwG+42/2ksGlYv2s2W
         ZWZrRE6Ag0dxoR+vdaDfgpbiJG9KMO30dGrmBURSZQakBtn96RVTLyNCLnpnnD6SCypX
         C9yAMIFWjgOaamfSYVGYgjqIHoDvXSWQ3aw90GxxPu9RjWvkvecxTPJb8hD0hnIwbIwv
         rU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777545204; x=1778150004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlQdc9ZGGOy1nWwQGOqT37EUu8/n7T3oBCrdhsUWNlU=;
        b=A0ztlXHGEX4SvB1Z+4B7ZDChh13qp9eLPyAXxcMsEFN4neRyLvXqxVIneq4zfO/2fd
         EPFaS75dCZAPsEkPaAA7v3IVkGP68uRPqd7iEQ4mVviUVJoaU0oxroEBNUOoQPdfWEmd
         S5NGBQCp4pBvz1PqLWvW7bJJRz7SH2O7bmTYUje9Ci5GVsDeH/0fR7SCNRnFlTKn5a5B
         FB9xZvtm3a0Jw+NxS4pT6tN1/3JFj3KVHrEyjEL68G3i329dB5pbJRgoMFohsaytpzky
         cMROERAUFwqCqBnJhet6KisLfEb0qAhkS5xcTVYMFIb7z5s10hNflAxlYxwG0yzIceWx
         R1kQ==
X-Forwarded-Encrypted: i=1; AFNElJ9guw+KYxTFvvActdVFljeNRlvUdlULT2k+VQveMj82uWeYaEjnSaa+8SHmv/dZizY29k2xMzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK2gjjQxgiUiN07T+1Mp8yNKnHFYPFSEG5PoZ2AvlWzQyyWXZi
	1yzVsGxSLAO6jeHA3tUOhvIB9zuZi5D6GSJHYu3+W7+ezQs/1u4qZWD9
X-Gm-Gg: AeBDietrSd7XtT/gV1N8HtACcg/mThSrK13if8Jo6fcZ0tW661usVUoTcAOpjbn6hDJ
	LdApZYH6VDKMaOw1EdkX3g/NiLsggIf/NF/0yDxKTxkFtInHVunCTpoYI+FTE9RvZgE6kxmLfov
	FoyGSSp/QRaUiTkhraJISmhjjpGgyW6RSa/CRothGG+KFGM+Z01GshfT3cMu7RKZ/hYelg4pGts
	ZBbJrGo01+6wteSJ72tZPj9/oF46S40qY5c/iYLvdith9Y3S6JBATDakwZ7cOhmMSpDF+aexgu5
	nvCHwvHbMq0WqbbljjtV98ckCt3EJ/BQFsNGZ71JvuEWmuZwG2C6VibW0Yr1wgs3GuW9MXqY/4B
	g9n9fKQPfQlmVVZz1XrQAsBj9766mxoSX+zN6JFFBjW7XfaAPJ1WhRp4ITeYg61GVwzndjz/6Hm
	N5SXHJPQ68kyRrBTkcbzFrzkrrBIyd+8e6Zseqn28WkTmBzBg9vwJcA5hK
X-Received: by 2002:a17:90b:57d0:b0:362:eaa6:a3a2 with SMTP id 98e67ed59e1d1-364c309b029mr2403183a91.19.1777545203681;
        Thu, 30 Apr 2026 03:33:23 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf5312fsm2486218a91.6.2026.04.30.03.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:33:23 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	shaw.leon@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] ip6_gre: Use cached t->net in ip6erspan_changelink().
Date: Thu, 30 Apr 2026 18:33:18 +0800
Message-Id: <20260430103318.3206018-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 22E5C4A0E37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-242081-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:mid,ntu.edu.sg:email]

After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
ip6gre hash via link_net. ip6erspan_changelink() was not converted in
that series and still uses dev_net(dev), which diverges from the
device's creation netns after IFLA_NET_NS_FD migration.

This re-inserts the tunnel into the wrong per-netns hash. The
original netns keeps a stale entry. When that netns is later
destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
slab-use-after-free reported by KASAN, followed by a kernel BUG at
net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().

Reachable from an unprivileged user namespace (unshare --user
--map-root-user --net).

ip6gre_changelink() earlier in the same file already uses the cached
t->net; only ip6erspan_changelink() has the wrong shape.

Fixes: 2d665034f239 ("net: ip6_gre: Fix ip6erspan hlen calculation")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2 (this submission, addressing v1 review):
    - Fixes: changed to 2d665034f239 ("net: ip6_gre: Fix ip6erspan
      hlen calculation"), the commit that introduced the divergent
      ip6erspan_changelink() shape (per Xiao Liang).
    - dropped Reported-by since the SOB is the same person
      (per Kuniyuki Iwashima).
    - reverse xmas tree local variable order; reused *t instead of
      shadowing it (per Kuniyuki Iwashima).
    - added Reviewed-by Eric Dumazet, Reviewed-by Kuniyuki Iwashima.
v1: originally posted as [PATCH net 2/2] of the
    "ipv6: tunnel changelink: use cached netns pointer" series.
    The sibling patch ([PATCH net 1/2] vti6_changelink) is being
    handled in its own thread.

 net/ipv6/ip6_gre.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index dafcc0dcd..0097d4784 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2261,10 +2261,11 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 				struct nlattr *data[],
 				struct netlink_ext_ack *extack)
 {
-	struct ip6gre_net *ign = net_generic(dev_net(dev), ip6gre_net_id);
+	struct ip6_tnl *t = netdev_priv(dev);
 	struct __ip6_tnl_parm p;
-	struct ip6_tnl *t;
+	struct ip6gre_net *ign;
 
+	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);
-- 
2.34.1


