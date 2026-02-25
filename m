Return-Path: <stable+bounces-219621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGQCL4H9nmlAYgQAu9opvQ
	(envelope-from <stable+bounces-219621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:47:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A286198584
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7EF630ED0B1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962433C1997;
	Wed, 25 Feb 2026 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="i4C2PrQr"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D483C198F
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027048; cv=none; b=fZF/5t45UzWMay53Z/qhasJeWSqnYQb7A+Wsjt6jzNGWacjtfa8np0x4mrS7xPE65P2PHv3U2RUKhSvYAroe0wUuAyGDRSs0sYBDST2vmE7qelCuIqYr3E3G03qOi3b+RwYUjiAQyzlCgLoQQ7HQbNlIqLLpmQv9U1ZDwG3VR7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027048; c=relaxed/simple;
	bh=Tv8D3ooWHsrrQJZJU6Zs5IraaN6Rhqt7asbjzaLch48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRQh/kvB/B36ZTO/jHxpAWkWMUvtxVCo66SrV26cFChxmOwp9Teei7uey05ksqZ/4XVEbAHLQEFPP+6cJAUkLAZ6pH2Q/LnKP0UtirnZZtbDEjelScXFvGZBgIkROucKwEj0j2v5d0KgMAqIec/1G0X5Ph+iqzfP/sXo0NW2rlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=i4C2PrQr; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-566fe6a4ceeso3206518e0c.3
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 05:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772027046; x=1772631846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vuB5WURp7hHKc2L/wHlQOaLe5kBJBFcQNgXO3P8yPlc=;
        b=i4C2PrQr8Tjgi9TH4oU4tNwDrye1t59p/MttTHR7Djs32QJhaIsaXj+G/Ko5DaTcZG
         VV69rkOX4286DbkJ20ijZ31XgNqMpC5dU9aQ/TU6/P0MIhwQPnW9rRJ+Hw0WA8rxURdq
         SY4drUMKb4IOrKNXkSHj1nRwVZedpG+OTQaC4Zmd0Ho490PkPFgqbwobnzHhdCGagoUp
         4EXubLKboxXoqa02dVvw5aV+MkG7Hk00Jxp6W6TH/dCozCwe0a7aI5dVGPs4DSTtMrTs
         BO+c6ABIsnMBGAzUcCUBZ191l6b6+xXi2pS6wsSii3ZUrXPLUOD62W/A9v7utXqtWPV9
         3Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772027046; x=1772631846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuB5WURp7hHKc2L/wHlQOaLe5kBJBFcQNgXO3P8yPlc=;
        b=OxvBUM+57kRI5Ro6j/wFyEEqd/eI2nlDjV1cMkTfDWOxTKg4l/F4EJ0p+cKKQXAFJf
         iPXNFC+RnKfKp9GpzDk6qb0eQl2WmQNGiS+YXowCPt5aFxO3wkZZVefqcEvejqNga16V
         gpX+Yt7GztiqL4KXjqP6tRzwQzxI/hOX5Rx3SBZHVlTtP54STLsfGSp5EWc9BSlQVoff
         Wb6f5lUYFY7oH4WBpJsLuDJDeS9mYGJm9Qg3SBmrR8yMnzpGjgc/KGMghtXNqdQNv9oK
         FB5L0W/EocQZuY1kQzOMSwJBTazvpt4ulJkgOoNY0PvZUXbWBBzThloV05KL5pnNxk3A
         i71w==
X-Forwarded-Encrypted: i=1; AJvYcCXZJlY0VQteZCJYiR0sDKlL5jih01ma4kISkAWguRTLbcpT0ZCmgUPFtnVDXZE3wyGUNU+C2Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDXQ6iVnaQ8ODfLH7yT+t+SCP4WhpH8Hu6OAYRVzxfChKWWZvT
	MFqMqRLnb2ivv8hbBwqTlot/a1eghL8DjsOmmvqhXcHJ+dEA6Esi7gkAdrLQjlN9Ig==
X-Gm-Gg: ATEYQzyB//7LeRaFLIpQmc/xgXiHoWcZTFoX9zyIFyQrpkOlVxYfTUg+YrOXm+XDC4h
	+ELRkulqDRqKO6oWfMG1LCkE1QgPWAJXV4CgJiJDTEzKh5i1C2vp4cgKUBZ2RbMbKlVbx9Dvdla
	QTXDcwqklw6JKoZ8jBG3Ky2KJxrsZzqjLUpQHhHRMlpnOBFg1eGaGrmVxaPQ+TL3oWcDFNwCjbt
	DXbtE7LBgOME617R6czsXUfxWbRieU8ApTKiC4atMi+WFqqtj2OUkcByGkH9e+9Z+RtKnEeOBSk
	UkLemejXZgK2LdDFl72PzVfBd4pheJATtpuVuvxDpZQnR/LxgZUrfP2gWtMaONO3Xs5LdMjhfGl
	vm6bVTVE5OsfZgczTrIkZbYwo8zPqSj4PlKWxs437isiCordNJAWDxKP2Wz9wFnWH0BZRmfh8Ft
	9VQdHD1AE=
X-Received: by 2002:a05:6122:318b:b0:566:eb31:4713 with SMTP id 71dfb90a1353d-568e4867e06mr6015124e0c.9.1772027045652;
        Wed, 25 Feb 2026 05:44:05 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-568e57d42fbsm15971517e0c.6.2026.02.25.05.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:44:04 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	taoliu828@163.com
Cc: netdev@vger.kernel.org,
	pctammela@mojatatu.com,
	km.kim1503@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net/sched: Only allow act_ct to bind to clsact/ingress qdiscs and shared blocks
Date: Wed, 25 Feb 2026 10:43:48 -0300
Message-ID: <20260225134349.1287037-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,163.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219621-lists,stable=lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: 0A286198584
X-Rspamd-Action: no action

As Paolo said earlier [1]:

"Since the blamed commit below, classify can return TC_ACT_CONSUMED while
the current skb being held by the defragmentation engine. As reported by
GangMin Kim, if such packet is that may cause a UaF when the defrag engine
later on tries to tuch again such packet."

act_ct was never meant to be used in the egress path, however some users
are attaching it to egress today [2]. Attempting to reach a middle
ground, we noticed that, while most qdiscs are not handling
TC_ACT_CONSUMED, clsact/ingress qdiscs are. With that in mind, we
address the issue by only allowing act_ct to bind to clsact/ingress
qdiscs and shared blocks. That way it's still possible to attach act_ct to
egress (albeit only with clsact).

[1] https://lore.kernel.org/netdev/674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com/
[2] https://lore.kernel.org/netdev/cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org/

Reported-by: GangMin Kim <km.kim1503@gmail.com>
Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo frags")
CC: stable@vger.kernel.org
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/act_api.h | 1 +
 net/sched/act_ct.c    | 6 ++++++
 net/sched/cls_api.c   | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 91a24b5e0b93..2ba40eb45aad 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -70,6 +70,7 @@ struct tc_action {
 #define TCA_ACT_FLAGS_REPLACE	(1U << (TCA_ACT_FLAGS_USER_BITS + 2))
 #define TCA_ACT_FLAGS_NO_RTNL	(1U << (TCA_ACT_FLAGS_USER_BITS + 3))
 #define TCA_ACT_FLAGS_AT_INGRESS	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
+#define TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT	(1U << (TCA_ACT_FLAGS_USER_BITS + 5))
 
 /* Update lastuse only if needed, to avoid dirtying a cache line.
  * We use a temp variable to avoid fetching jiffies twice.
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 81d488655793..7de6eb3ff53b 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1360,6 +1360,12 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
 		return -EINVAL;
 	}
 
+	if (bind && !(flags & TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Attaching ct to a non ingress/clsact qdisc is unsupported");
+		return -EOPNOTSUPP;
+	}
+
 	err = nla_parse_nested(tb, TCA_CT_MAX, nla, ct_policy, extack);
 	if (err < 0)
 		return err;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index ebca4b926dcf..8c72faf3314d 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2228,6 +2228,11 @@ static bool is_qdisc_ingress(__u32 classid)
 	return (TC_H_MIN(classid) == TC_H_MIN(TC_H_MIN_INGRESS));
 }
 
+static bool is_ingress_or_clsact(struct tcf_block *block, struct Qdisc *q)
+{
+	return tcf_block_shared(block) || (q && !!(q->flags & TCQ_F_INGRESS));
+}
+
 static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 			  struct netlink_ext_ack *extack)
 {
@@ -2420,6 +2425,8 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		flags |= TCA_ACT_FLAGS_NO_RTNL;
 	if (is_qdisc_ingress(parent))
 		flags |= TCA_ACT_FLAGS_AT_INGRESS;
+	if (is_ingress_or_clsact(block, q))
+		flags |= TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT;
 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
 			      flags, extack);
 	if (err == 0) {
-- 
2.52.0


