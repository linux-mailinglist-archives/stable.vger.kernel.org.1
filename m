Return-Path: <stable+bounces-241629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKURFXqX8GmrVQEAu9opvQ
	(envelope-from <stable+bounces-241629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:18:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B729048382A
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39A533310178
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FC43F0748;
	Tue, 28 Apr 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5n5Pa6l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3262BEC52
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374445; cv=none; b=JgAX7iPO8ezm+YTTQTctIHS1Bg2r2jXSGFP8v+d/ZawY/9SvDsw7Fcud86bGQIprjr3T1gag4FcIroptVH6PcIL5n8aftzxBj8eapxGRKKqMMT/vQnIOKzqSP+RycqIoKZUO2JjiBCP8Qj4hEpt2ZNSPKOV21WXd1QluzFcHitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374445; c=relaxed/simple;
	bh=NjtDbOnnEO86ejPTIN4uLHWLgBUoL1OSud1GczR0dAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mLhwS0nI6WvmnaZylP7f5eM2wdud0b0cAwK2LUoTntYp6KdgJ+tHv+L5myaNZYHZPVGGD4u3s/zEVjataWldUl7vbTbhMQC8wXYGMTbEVlJNh9OHNyjo/Bol1P2B4mo6fCQmofqcC6J3JakhFfcg48bGj1WjsAVYqGNHZEyAsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5n5Pa6l; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c648bc907ebso7366618a12.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777374439; x=1777979239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t5gnbIk61J7ja47fuHsFudG56ejf8vLTSwMTzZTnrdk=;
        b=P5n5Pa6lAKroFCMbDkm33qbTSyeMJRlas8iPNwU2wK9sKNFbBbJAfzragLyGOMedOs
         h0pp9wPnYK7/vG8NNTHA6xMopP9aFsD4RRf4sHdjSWUQWBl3ArsL2ePRio69f1/5tRkS
         8zrGHr3IMr3CAqtElvwOUOztxV4lAElnX2iyUVFt+V1OBSL27pSn4o3scnL8SM96nfEV
         oj3OLbid7kjCSJzW4pNTqSTA6n/7Z2d1GqPwnw4OCX9r9NZtwQYAgEmKUFrdDJdeUV9A
         3vqREdr3ghvf1dV6//Sdph1iv5gsQ5vdFgI/hF5cSexm0k5/eNT09AxXYdC+diQq8JOC
         2GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777374439; x=1777979239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5gnbIk61J7ja47fuHsFudG56ejf8vLTSwMTzZTnrdk=;
        b=gHkOSt3VtsYclvhqIYZnkll1uW4t4smebSoU8aD3UguT680h+wa6e4ZHDI/frQVdne
         Qa7T/bsikdUmxEfxHXEt0k3sK2/aZmL/0jNKe5h+iVFo79r3jRJAoerFlJ3zCmDL3mH+
         D36fCv0CLljaZQE8emANGQ8/QlmkffW3fCnxD5SjkRctlYWHFO6M4KJyo6YisvRS4NMe
         KWuNXIfhr/l80RTfsH3DzWoW4kU95wippVS4YQYWHA+Se7cLUHVb4SxxZsoto9EdE+7g
         wzcA++aaq/eKtTkubO7VfUavtU1eb8rHb7IpD2+YX3cEfhlPNqC0d6UZeRKNIDTWKp6Z
         q7EA==
X-Forwarded-Encrypted: i=1; AFNElJ8vnv7HDl99BMIOcC850boFa5hvrbxk/UIrqpBaHI903oVxueDdJghi+lrHk/vVSn2otrwvLWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTyegryX10+22wfk7SIY4sS5yIb0SAPwVU4TYXoyXNi1+hO65+
	AreFcwxgrc1L5NWuyLoaHMWBWrBP76o5LMXCM3avLmIN5NbVZIsFhzvF
X-Gm-Gg: AeBDieuWBGJnPKDWTJHZDybWFPKGIJNyftjfY6lV4BFCnByEqe8qh/7GbUEkD7KHmUr
	8B2ZdfYianBd2uZFpCdEeEbJj7g1BjmtN0/+5eNeyhw9ailVSQdIVPyDHWfLv2JXQpmsJaIhqcm
	depbolSPQk4bacuFPc1AooINUR4VBWttogFeJgnksrxg8164mlA4TvzN+LKRG7DajEsMulN1QuY
	uY9IhVeVT0QtlQnxwcKGRUDeUpOxqqR3FOCXozTEU3YD/ALoCa/gsyX22lHrIACwjw2G7B3OLHT
	S/QvfTkyYrS16CXufTrCaYeZPpmQSzW96i+Gp7DL7xniK07aEmUQIaBhqJWSQ8ECa7qyJ6Xdw1C
	mWqkA7FgaXCQw7FyyrPdlYDt8548xYMDiE+Uqwe7Gs/f1MjxoeBN61qwN6tpHclkwwHqSxTMhuo
	5xq8ymnN7U160kN5Rg3tJJuJHtW6HC5iohHib/xl0j+EumoUKkupOJNv74e4E=
X-Received: by 2002:a05:6a21:3086:b0:39b:e321:784f with SMTP id adf61e73a8af0-3a39c34ad7emr3383963637.40.1777374439315;
        Tue, 28 Apr 2026 04:07:19 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc33d4e11sm2023328a12.24.2026.04.28.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:07:18 -0700 (PDT)
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
Subject: [PATCH net 0/2] ipv6: tunnel changelink: use cached netns pointer
Date: Tue, 28 Apr 2026 19:07:11 +0800
Message-Id: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B729048382A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241629-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ntu.edu.sg:email,ip6_tnl.net:url]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

This series addresses two slab-use-after-free reports against the IPv6
tunnel changelink callbacks vti6_changelink() and ip6erspan_changelink(),
both reachable from an unprivileged user namespace and verified on
Linux v7.0 with KASAN.

Both bugs are sibling misses of commit 5e72ce3e3980 ("net: ipv6: Use
link netns in newlink() of rtnl_link_ops"), which migrated the
*_newlink callbacks for vti6, ip6_gre, ip6_tunnel, sit and ip_tunnel
from dev_net() to link_net but did not convert the corresponding
*_changelink callbacks. As a result, after a device is migrated via
IFLA_NET_NS_FD, the changelink path looks up the per-netns hash in the
wrong namespace, leaving a stale hash entry in the original creation
netns. The next cleanup_net() of that netns walks freed memory.

Patch 1/2 was authored by Kuniyuki Iwashima during the security
disclosure thread; it converts vti6_changelink() and vti6_update() to
use the cached t->net.

Patch 2/2 applies the equivalent conversion to ip6erspan_changelink().
The non-erspan sibling ip6gre_changelink() in the same file already
uses the cached t->net correctly.

Both bugs were originally reported on security@kernel.org on
2026-04-26 and triaged with Kuniyuki Iwashima and Xiao Liang. Posting
publicly per standard practice once the technical fix shape is
settled.

The bugs are present on all maintained LTS branches (v5.15, v6.1, v6.6,
v6.12, v6.18) with byte-identical source, hence Cc: stable@.

Tested with KASAN reproducers (unshare --user --map-root-user --net,
RTM_NEWLINK + IFLA_NET_NS_FD migration, RTM_NEWLINK changelink in
the migrated netns, then teardown of the original netns); without the
patches both reports trip within ~2 seconds, with the patches the
reproducers complete cleanly.

Kuniyuki Iwashima (1):
  ip6: vti: Use ip6_tnl.net in vti6_changelink().

Maoyi Xie (1):
  ip6_gre: Use cached t->net in ip6erspan_changelink().

 net/ipv6/ip6_gre.c |  3 ++-
 net/ipv6/ip6_vti.c | 12 +++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

--
2.34.1


