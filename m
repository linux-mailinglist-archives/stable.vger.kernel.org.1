Return-Path: <stable+bounces-243966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGXHC2p8+Wl59AIAu9opvQ
	(envelope-from <stable+bounces-243966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:13:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9193B4C6BDE
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3CFF3027971
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDEE3BED5F;
	Tue,  5 May 2026 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATGH2O+s"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A735A938
	for <stable@vger.kernel.org>; Tue,  5 May 2026 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957963; cv=none; b=Jbec30q03Jl90KN7eoIeOWmODDusPHm+QDBdUEn9TzH82Da3Xxek+C5eYzdrAVL3+CGbpCg3ro123owTCbdKC6ZwCA3etstVvRKnI4jStFR8ojBGzTzYugXAFuOoi8irg3pK/9LG+i06MqAxGDZjMQ5VjtUK+eZfYDRWmKr7Syg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957963; c=relaxed/simple;
	bh=iUgeGSsqv7MOSHVQK8yrYNQjBQhy4lMDkURuG/cYfgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9NDGXuh8BpgndI/J/dzxdksY1WDLlau4FvpJICbdFZTEiPO3WOsgF3hPgVl1hcWMfvgnsHc0RoLm4y4DGYPZDnIi6VXo0uKaYLsKZDm7ArvDUpeYa08iSLna5+U2zUHFMrJzMIzkNIY/1CCtvuwo6W+O+W8a/sya/mXQWErvA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATGH2O+s; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36534668247so1911811a91.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 22:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957961; x=1778562761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NrhTMqHn+rMdQZeR0f4MqPn+xrSow9rW/RMkyGQyv4Q=;
        b=ATGH2O+swMAsO4QhgOqgtXsjMBSGxUHlO6WqLXQvHOu+dMrJB6f5zYw/2oSa1TMQ4k
         Y65WnbOUjJRzFXz7zNn9y6MQ+f3kTUd0zOviw4JeY5aCaF41HSui9ClbWkgfqTnPuhjG
         UGsZfibRcsh/qCoMj2sC7z4dvTRHbV1BbCJ6oXmNivv78JK+nWBD2jxEPa5daL2aROg3
         tkhF0qCSJOwpZmhS/mqHJEo+aFswaKF1D6f5eSfANPgK6iqy4ZDEYh9WUAYd/INwzQds
         5qxLSg+PUYHgzmKbrmU0qGYyqrZFB+/VvyLnbnxhhLEAUkK4XYz0+RTQup+qWhYN2rCU
         z61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957961; x=1778562761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrhTMqHn+rMdQZeR0f4MqPn+xrSow9rW/RMkyGQyv4Q=;
        b=mcFcOVA1hZr5pAfB5/O5/fK/f2cqfJ/7zjyKyBuprv7c4AQGX4dmbwasEHRjeP79gb
         1pEQDz8H3eFARc9eZBhBQhdkTr9okdnXyQJ7N9Bc5X8+9ZbG8UbkSOOJBnwM3fwe3sAA
         0ZNKILIlww9xrTMRgDgBspr3kRGqo+nNMoa71IEQO4yE5JGL/LZS51iPO5SWLKidQ6Id
         yL3Z/AtvNO8viO37TJH/gVLUXl9Wty+evAyKhxFeTOt6ZcVjOseYOI96pEKgv/1VPWvx
         /R0XlTYYDIu5wZnw2ldFLV1hSod5iSnFOL4+aC0BvkENKdGqXItoPxzHx6URdraCVkzn
         o0jg==
X-Forwarded-Encrypted: i=1; AFNElJ/p4v/jafmS2x9FLznWxmUSfATQun3eYFCjZ+k7G5wQBweD10EAyzQL34kNBHgyfsLiYonZrvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2cglTZCjtcB6S0XdLEu/u3tqWHjdX3DYlq0CsvD9tVDjH6dHW
	/YU8y3MoHIDemoUI8qsHN8uXcZ2KiphJV5MH0OPKXTaGcai6u6oDl/kl
X-Gm-Gg: AeBDietcQEEQfuLmB5A5BaQ2X0kpl2b9uGaBGgdD0MFVE03TPZI//qxXGXR8f40B2MY
	nPW+dk2UzQEWqd8xIfbrqtyxNR9RQBzWl71kgxWW7uYZLj9KSCBGMNx+EX1JwAPNKPfJX0qsq9J
	poeiLBDe81ebLsz9NsAAu58OF/NlMGTgfzI3XjcD5f0yR6xCAsLPCA5FxiMMbgDia2ngAGaPC5H
	EN+b+ClhmFZwW8Ln/X1vX3u//uLT35fBGEYA72o5dZy/r1u82o8fwcbPgUjL899KFi5E3flfe7z
	c8IzjM7TFp2md4fplb1hj1F77FlaWycVdHNwys+ARI6TJc5Pfkp0RjyNtjNu1i7jq20MykQXRW5
	Vz8Xj+IKEQ6viaaIySlptrpqiChyZcCWU37KqSDSS9i2dtzbReq85oj3ugsDta9wF7leLqAEIKv
	UnUgk51JhYBPTd5E9mTDL4n+UNIFH9PdgqYZjx/U14MO74wCJ3hr2Hx19EZCerdS2v9Waq7fXjv
	0pUEocCTncsct67UZgAAAL3qZX+BgXXWgwzO5LzbClJ+HiKjM+soy2gtMZJspadv7Doi09Ctj0=
X-Received: by 2002:a17:902:f651:b0:2b0:6e12:bb21 with SMTP id d9443c01a7336-2b9f2846196mr116836475ad.41.1777957960980;
        Mon, 04 May 2026 22:12:40 -0700 (PDT)
Received: from alchemy-Precision-3630-Tower.tail7db246.ts.net ([156.146.97.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0e5fasm120896855ad.54.2026.05.04.22.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:12:40 -0700 (PDT)
From: Pratham Gupta <pratham36gupta@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pratham Gupta <pratham36gupta@gmail.com>
Subject: [PATCH net] netfilter: ctnetlink: use nf_ct_exp_net() in expectation dump
Date: Mon,  4 May 2026 22:11:57 -0700
Message-ID: <20260505051157.3895177-1-pratham36gupta@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9193B4C6BDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-243966-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratham36gupta@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Commit 02a3231b6d82 ("netfilter: nf_conntrack_expect: store netns and zone in expectation")
introduced exp->net so RCU-only expectation paths no longer need to
dereference exp->master for netns lookups.

Commit 3db5647984de ("netfilter: nf_conntrack_expect: skip expectations in other netns via proc")
updated the proc path accordingly, but ctnetlink_exp_dump_table() still
compares against nf_ct_net(exp->master).

Use nf_ct_exp_net(exp) here as well so the netlink dump path matches
the rest of the March 2026 expectation netns/RCU cleanup.

Fixes: 02a3231b6d82 ("netfilter: nf_conntrack_expect: store netns and zone in expectation")
Cc: stable@vger.kernel.org
Signed-off-by: Pratham Gupta <pratham36gupta@gmail.com>
---
Tested expectation create/dump/delete on the host and in fresh Ubuntu 24.04
Docker userspace. Concurrent namespace churn/dump testing did not reproduce
a cross-netns leak.
 net/netfilter/nf_conntrack_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index eda5fe4a75c8..8ae3f6acc2d2 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3158,7 +3158,7 @@ ctnetlink_exp_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 			if (l3proto && exp->tuple.src.l3num != l3proto)
 				continue;
 
-			if (!net_eq(nf_ct_net(exp->master), net))
+			if (!net_eq(nf_ct_exp_net(exp), net))
 				continue;
 
 			if (cb->args[1]) {
-- 
2.43.0


