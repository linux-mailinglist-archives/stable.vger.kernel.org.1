Return-Path: <stable+bounces-262336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B7fgEm9HKGoiBgMAu9opvQ
	(envelope-from <stable+bounces-262336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 19:03:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F201662BD7
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 19:03:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ksWFifbg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262336-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262336-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3EA2322438D
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2C843E49B;
	Tue,  9 Jun 2026 16:31:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521949691F
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:31:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022702; cv=none; b=pHfyDd6cVE608LLREURrcVeVRc569JtlyeKx5DixGpFx4QJlilGtB5s7Z8j4tBY/MOrxUzOwFD8IPb4nV7lEL2+WwwET6un/9CIGw6uybVDstphjkgL2Lu/oCUujl6txOjGN51x8FmDYlyytDI4neG9DScuSFtoD2p9+FYz/fqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022702; c=relaxed/simple;
	bh=964slByQ2g57y1gfeoWWO0abKPXFuUrmXKARDVr3EQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ts4tki3eYOPUiWiA5C8Tys2Gi9xjrKOBkazQKGXR6bNjEKOweEsyW7abURoABmknjt3QukMELz+aZ2XW56w83PnnP85MoBbZCQM1X3KUMtBSAXNVnv+GF8gFRg8O+kkiYlpH24BSEozCp5NTIKWtrlpPi33EIOAmnbiUbQjI6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksWFifbg; arc=none smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8584e80bd9so2214488a12.3
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022700; x=1781627500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etjlWY0ED/lfXMUZNVvEX8hp93y3gVFfFSFVc3VEUY8=;
        b=ksWFifbgukn948JGak0w1XMZtmuyXzfLOV8eHxKB2py8aOONDgqi5GTsyQm57wBlPY
         eDG0uOpLpBZ9BFvgu4aY1inAYsoc410sTFRW5xXnMAD9EZvHpq+65UqF/mGDL4qST6XF
         RmE+ufukXusQjq7Tnthyrml1uExotzoC3SsFmyB61IoFYINfdDwCkFaM3TVClgdf7x19
         W8VgDy6NX1u+XZvbBdNWcXe0fDWQZrnJZ1e5/fGS3Tib88Pp2Cu3NmKj6PcySEdcB0LN
         /CZB91hZy71rNAdHumW1X+eJDhS9H1kftJfr5LpnU/bFyEL3SV6Aix7WA57z0Y5RrDqw
         9hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022700; x=1781627500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etjlWY0ED/lfXMUZNVvEX8hp93y3gVFfFSFVc3VEUY8=;
        b=hd7vofQtVR5zqjoD89UjxYH2QfWAfDUJeme6//wjX+Y+EowY65VzG2S6AdAgMg75oj
         XM96uUKnMoJNV/d1EQj+/KL26J2r8KQvAPPUXmv86NsFtJ4Jd7Drejojgetnvke0VdWp
         1X3EneurBoDybT54o5ywm2Phj4rMWpBP1XU4PEF/xmqZolnY5bfj4D8Gs2QGShYjTI5r
         MweIDUYKUIHzIbnMWVURU2uckkOQ1326irtA7bLgaNh7zE+F4V+GhJp6T+u2KhxiSDyL
         7y40L3PghjTVXvQLAPOEi0V8sg7YzM/djAL0oCMygXaUxy3oY79S/ScuJtYZQTu3A0Vc
         D+1Q==
X-Forwarded-Encrypted: i=1; AFNElJ93xiKcEqD1wmeMbbvxEoPNPtjug8B7IhzF4QNE/LRdhRHKdieCE4XQGpp2y4WoeXuLdHQnFFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hkN4buG0uwAbiharsmg6tKZ5CCI84HOcfqOpEwZThMnwL05e
	20aVExYOKTNGE0VpVYb8bIRNo38uhS4hPSDxiKp+DsHf+BPUOr0AlkLh
X-Gm-Gg: Acq92OGktXJswHSy16AkUXonh+O/+0pNTsSzle/uLau7bulzirGWRRw7yTw8qA9P01e
	JCLW90xlCvnWhxXEdfyKoPanBlMNAaspU8EACHOJpHDw501Z/y9/sLZb9NTVgMSM7J75oGTTmpi
	XGfvyrOORmqV9Qg0J/DNqSpvqQFCfmBgjOS6OsTG395fOb57aMulHn4rnakVNOI2dmAo3Mg60Eb
	WN2AyP05hJ6H0gVOgCdGbBNfnCag45VX6RbOLhwSlFhApQHYqxW0Wkq2eUyoJU3Rs241UEd0bWB
	Sblrrdq+XFgLQNNPtVHHLYYeuxOR60kmm46FzYXLl4ujF58uP6X1lckv7aRMaHT7kGp0GudW4ug
	c89IYYJ6oZe626fksLndx8/f1tYvvpj6h6Tne8C3QqIoq/jD9clFh1dXbH/cPYZWSygLDCHukRj
	aJbb7aClnpNZ8WiTMbFjWGofvaS+fKqR0Nqefv5w/848CHNiEfhQF6Nhj/bXA=
X-Received: by 2002:a17:903:38d0:b0:2bd:ba75:81c4 with SMTP id d9443c01a7336-2c1e7b150a9mr267590715ad.13.1781022700012;
        Tue, 09 Jun 2026 09:31:40 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:39 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 6/7] net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 10 Jun 2026 00:31:09 +0800
Message-Id: <20260609163110.1717419-7-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
References: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-262336-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shawleon@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ip6_tnl.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F201662BD7

vti6_changelink() rewrites the tunnel in its creation netns. After an
IFLA_NET_NS_FD migration that netns is not the caller's, but the rtnl
changelink path only checks CAP_NET_ADMIN against the caller's netns. A
caller with caps only in its current netns can then rewrite a tunnel in
another netns and pick its endpoint addresses.

Gate the op on net_admin_capable() at its top, before any attribute is
parsed. The check is skipped when the tunnel netns is the device's
current netns, where the rtnl path already checked the cap.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in vti6_changelink().")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_vti.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index df793c8bfffb..ec82626363f7 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1044,6 +1044,9 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct vti6_net *ip6n;
 
+	if (!net_admin_capable(net, dev_net(dev)))
+		return -EPERM;
+
 	ip6n = net_generic(net, vti6_net_id);
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
-- 
2.34.1


