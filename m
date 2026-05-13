Return-Path: <stable+bounces-247053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GATUFM8LBWo1RwIAu9opvQ
	(envelope-from <stable+bounces-247053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:39:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD57553C15F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D13D8306102F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0DD3CC32C;
	Wed, 13 May 2026 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elMU24co"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87CD3CEB9E
	for <stable@vger.kernel.org>; Wed, 13 May 2026 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715542; cv=none; b=bUkK1v9HNQebQQnX2tHWeAW+q1n8+FVNpAR0E10+hpUm5d7ikkl0ONuKxLxBIwGXmq9HH9TSuFGzdEXK/+ipvFiBgtdIf6fm90azlBzOrL6PCRCdeQMgn7r5QDNoWko7bYcT/ug343uyf2n/XmH2QQNK34R2nX0x+ya2bYI0l/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715542; c=relaxed/simple;
	bh=yNFOqidkRBNgkU5BEct5DiEOH0XxS4aqc8GDnXCUja0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4Waj1BqY6NlV5pYz7/xKHV/P1FFo4R2O8PttHlNn3TZdbZLij6+VxjaVbYXst4K3A52lLS6yiQSFX5ah9Vz4U59guNqzqccNIph228VOXuGpYMM+lklpn6JD9X4hqPFnn/tOm49zlXEH6Uew0UEVoMVWlAwciBl4M9dZCtCTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elMU24co; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8eab809593cso788239185a.3
        for <stable@vger.kernel.org>; Wed, 13 May 2026 16:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778715540; x=1779320340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyfRQ0H0Q6NSd7lYeTh8kpqekVQ9G1te4Gf1oV/71tU=;
        b=elMU24coeIHXMqBgbRYYf6anFYgmVnSA3S+27luLUM0gYZRLVSgK9ik4sRb3WI6oia
         z9n12yHQdl+kDGNqWkbDbW5tjzHr8o3E10x1Kvn8FTlyBM02RVNSyG49orENp5LZ2giG
         vpNkIznedJzcFUah7M8dYCIwbas+N11dcaZOqyzzE3L6EmLUZNTGbxCCkzSaCg+1RMtw
         dNMjk5EyMgLf30de2UzfPHGLm3kxH7Z5TIqqEcXwHgkqZthDAOd7qr29lQ8TTIFR4dYs
         RnpKUMPCMdQRLK6FnE8anGcZrtxctCJritwl6Gnbf4fCVKbafa9par3UnT/LOV29cdOd
         QUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715540; x=1779320340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kyfRQ0H0Q6NSd7lYeTh8kpqekVQ9G1te4Gf1oV/71tU=;
        b=IQ3VuQBnDqFDjsOwT0d2UqZhx0owvkHi4uyxsmpiot8j3bmk7pc08wGUL1JFB9itKx
         5+pfkiCHBpy9bn/sCxHNNf6QNPVPGQIBDu7IRY0ev3gjwMHPuZECtKqOpIJ/Mdio22z4
         cV9EZmjdddfVYzmTw1+Rki/NfW9/4mn5MlQIcYS7a+cVl9k01ga2AkxljXaNOr8QnDd6
         Dtzw/QkgDRX9NdsDRiROXYK3Yt8L6uOLx5WTWlplYMSsv8J2Y9ESEijiGZavwi/Lty+f
         lrNQLwsOdt9qFfFT6LEzhyyjFMLjt4ctTr1Ppsm5IN2ySRTPqmSzzgsdAb2fAFk+C5ay
         GheA==
X-Forwarded-Encrypted: i=1; AFNElJ8CbrRLDvm7nW3OARJqyhdah0AsEWoWcKfJMO5NcXfkuMZsc2Z6remfELuJ1FhmgMdEUczvw1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SLvEf8MfNLxLBecWU5tSeuQG0cV9VgBbZw88xsKOMznMMXMI
	1aBvC08VFcbelZKGu4r2IMWNIyHKwFeH3Ep3yH20aNwzCWpSrbLFne5Z
X-Gm-Gg: Acq92OFO6kC/76Avp+l2ngiqZIzI0Ca/LWIe2WnU/qWTsawD9McZtEHuzNfEKJeXcot
	lH+NmpRd7by1YsmyyDkbNCSSc+cUkih4/4cKqGAvZVm995ZVICNL8NnfMX28Dfv3kU8dr9rjJoO
	OJcQQ1uF836kMpMxFVJ+dPIe2Jo7L8Tmmum2x+OeDOLxt2Eahj3dPvyKdeeFmlfBrax/q8iMGwK
	SW1pWCTOBS9oOpNOZOuuetuprwaVZ0Q1dR0AvyR0NUkaY8Rmm9TjD00IpbYxlbhN4q8mBYCRqDv
	obGdXhcn6nWrQ9XmSJJc7YLZAWFZndJuXSvm5WAKvF1zKY0qL7sdZipHHsJB2mRCV8FvXujQl1N
	37nzthJDivhdOH03JvO08R32/JB6Wt4UF1kj9U4Iu0qXPScixsbkSAE9sbOROwaLC6nBnzXSYhl
	9Z4znhyjFmXZA3lQ/BNDATMYk2B8z302qdeUHZwJilNfbcnEjKiU68oVlhUw/cXAcsNvcMx4ur/
	CHqQKJgDJUx5EHqJXNXIPyLueUog0x5XwEwELCsdgauPCvLu6fokg==
X-Received: by 2002:a05:620a:4155:b0:8f4:3895:25d7 with SMTP id af79cd13be357-90f88d9aeb1mr853891985a.23.1778715535171;
        Wed, 13 May 2026 16:38:55 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baf2236fsm94186085a.20.2026.05.13.16.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:38:54 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: Felix Maurer <fmaurer@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Luka Gejak <luka.gejak@linux.dev>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/1] net: hsr: defer node table free until after RCU readers
Date: Wed, 13 May 2026 19:38:38 -0400
Message-ID: <20260513233838.3064715-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513233838.3064715-1-michael.bommarito@gmail.com>
References: <20260513233838.3064715-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BD57553C15F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[redhat.com,linutronix.de,linux.dev,gmail.com,smail.nju.edu.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247053-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

HSR node-list and node-status generic-netlink operations run under
rcu_read_lock(). They walk hsr->node_db through hsr_get_next_node() and
hsr_get_node_data(), but RTM_DELLINK teardown removes the same node table
with plain list_del() and frees each node immediately.

That lets a generic-netlink reader hold a struct hsr_node pointer across
hsr_dellink(). In a KASAN build, widening the reader window after
hsr_get_next_node() obtains the node reproduces a slab-use-after-free
when the reader copies node->macaddress_A; the freeing stack is
hsr_del_nodes() from hsr_dellink().

Use list_del_rcu() and defer the free through the existing
hsr_free_node_rcu() callback. This matches the lifetime rule used by the
HSR prune paths, which already delete nodes with list_del_rcu() and
call_rcu().

Fixes: b9a1e627405d ("hsr: implement dellink to clean up resources")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 net/hsr/hsr_framereg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index d09875b33588..06b0977ab099 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -163,8 +163,8 @@ void hsr_del_nodes(struct list_head *node_db)
 	struct hsr_node *tmp;
 
 	list_for_each_entry_safe(node, tmp, node_db, mac_list) {
-		list_del(&node->mac_list);
-		hsr_free_node(node);
+		list_del_rcu(&node->mac_list);
+		call_rcu(&node->rcu_head, hsr_free_node_rcu);
 	}
 }
 
-- 
2.53.0


