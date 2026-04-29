Return-Path: <stable+bounces-241927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JQXFXBG8mmApQEAu9opvQ
	(envelope-from <stable+bounces-241927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:57:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7F0498628
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B937A301AAB6
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CD8421892;
	Wed, 29 Apr 2026 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOCqCjDy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2241323A
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485380; cv=none; b=D0ZzQMjh4E63lykfYhjRmS7nZrIX2ScaXdUa8M7HggICxqoQWB/uMdGaNvJsOa1MY+uvTGrNY5uReWdIutQP9osaENgL+zE+1v8euLiACTbhDBYRhnL9lPn2I5jfaebdAhxPK3mF6gDYM1s7gg9dtq7GseKnIwV6/F9uWwmnYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485380; c=relaxed/simple;
	bh=hPxaXd3xjy2aLoQlfjNn2TCMZsSvXUAXKxOi1BUCOho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0lnsCnrRTBo4W0ZwvHKJ/IoOoZDmjgF/iov7ojAvptCIL4hUfAYYybJecPuk7XpgazABxNVxGM15FsXRbOh+Y60PQTJX7TJLienrEOAOUtp0mbCpEdtJXAxby2CDt+ZeNwT78utitjIqMxBR1ULvU59V0lEJssVY5X2z00niFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOCqCjDy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-448528f4e69so55664f8f.3
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485376; x=1778090176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+m+c0QFSmHtefs8UGhgSoeILNWZg2rQuDAplxBi5ys=;
        b=cOCqCjDy12B6ro9esSG+onM18Ju1+DNt8/lJj8j5rlGgFor/h5mlDqT3erRDdbA+ES
         gHnNUhRutovnkf/sUDku21JaD+l5b3ZO7HzsvKFyA+v1p8eOYzU+H/FXzPAMhg2ke7yG
         UNeh6nngm5LEjC2jXkbTF3ix0qJV3IHHLcfDQX/YcUUl2BwRkS8XkBfbgD6gMUlnw+ji
         lC5Ht0vquY4rWMH8MPLqKQAS/TYI6O7AFSiq9VyoMmWuzZPY4MDdk5o1k7fLD+0zEts9
         TKqYWefBXPw6owlzPTYACRXr2GBB3VqLj7eitM5b9JV8SJJyPi5S7jhq1CfRZOEhEsBv
         eMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485376; x=1778090176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+m+c0QFSmHtefs8UGhgSoeILNWZg2rQuDAplxBi5ys=;
        b=K8/c1/0v2wHK7bYX2nxeNMhPbu0qlFZH1t8UNu9x4aIWhBbCnwciM0RVfwNEBJH6gj
         IHWBLpv+iIer4fGF1KalmuPTsHoOaZAsRBkHmlpBbdtP9JLHx0uhfJPFGOZApHd09eru
         YqR4zjZklbUgEXUucS8vmOPZv3kKW8uRJzWZlJj0DEoHhHS6VhnP8Mh5TgJCurDPPVI8
         IgtZJ5CQiaQGzHkruuciTTfXedRKiFwMvrA4OFPXdnbOxtj2gwUXtXXpcJcw1W7tKM8e
         w2gBgYNK5HQp5wB6bRfpgEO6hHZ6dKUlnptp44/ncVvAAzREHLdliH9e2IH4X/v1alsl
         SPkA==
X-Forwarded-Encrypted: i=1; AFNElJ8Tfh9gOUFbkKeTZ/9ARXRr7r+yM486Y5L3Y/aM9RAXQbqcOlJvI/yTxhHo2Q4wR1VFwmdjFrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+rW97i79QRwdApWBkqWOGtgIK3mHuxvDkfDfwifKWwHxd99wB
	Ci8qeRYxPnk8D22wbY3p/QfwZpGrg0V/QnsKYvQdeKlMfJmdOzL3ZaE=
X-Gm-Gg: AeBDieuwaS+gOHa2+RH1J0z6lWczMthm0CKyaPjAONH4s7RHw0ki2zlSJ7S1yukEHV5
	2y9JG1rKLP+eFshQ8gYd1EfvkUw+6UcwYjBrONHkazSYuiRIoXWjDpKHD/QFk9zzBvCXuBWctvC
	HkroPi9VUP3K5Cl7vMH49MRrH7RjPO7hFBxo1+wR1zK7NXf8FaSxHeMgEV+xtKTWtZyV4gN6iZC
	mpiZOUEkvkTJbaLM86TfVx2PAl//uNGAkfkEH+LzgnLpArSDjJP5fnRFoJf1nhBaKvMVFUYa2oc
	I2u3juMf2kuORXlIT30sSlLjvKfTaGbEdNiV4iTCQREs2e5Y/6rjORX1XvGQNg8o1tc+aMBthc8
	RgvnehzaeVx+k3uGWj64SaMU/QinONV4vl1MdyPecJY6/R70dmsCR+GPZOci0wQBb/54om9Oe+w
	NqDyEbmOdymPOQVw==
X-Received: by 2002:a5d:5848:0:b0:441:2473:c30a with SMTP id ffacd0b85a97d-446496d79aemr15475160f8f.31.1777485376333;
        Wed, 29 Apr 2026 10:56:16 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm6183750f8f.5.2026.04.29.10.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:56:15 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 2/2] netfilter: ip6_tables: allocate hook ops before making table visible
Date: Wed, 29 Apr 2026 17:56:12 +0000
Message-ID: <20260429175613.1459342-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429175613.1459342-1-tristmd@gmail.com>
References: <20260429175613.1459342-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F7F0498628
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241927-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]

From: Tristan Madani <tristan@talencesecurity.com>

ip6t_register_table() first calls xt_register_table() which adds the
table to the per-netns list, making it visible to other code paths. Only
after that does it allocate the per-net copy of hook ops via
kmemdup_array(). This leaves a window where the table is findable via
xt_find_table() but has ops=NULL.

If cleanup_net runs during this window (racing namespace teardown
against lazy table init), ip6t_unregister_table_pre_exit() finds the
table via xt_find_table() and passes the NULL ops pointer to
nf_unregister_net_hooks(), causing a general protection fault when it
dereferences ops[0].pf.

Fix this by allocating the ops array before calling xt_register_table(),
so the table is never visible in the list with a NULL ops pointer.

Fixes: ee177a54413a ("netfilter: ip6_tables: pass table pointer via nf_hook_ops")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/ipv6/netfilter/ip6_tables.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index d585ac3c11133..17143277637a5 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1754,6 +1754,21 @@ int ip6t_register_table(struct net *net, const struct xt_table *table,
 		return ret;
 	}
 
+	if (template_ops) {
+		num_ops = hweight32(table->valid_hooks);
+		if (num_ops == 0) {
+			xt_free_table_info(newinfo);
+			return -EINVAL;
+		}
+
+		ops = kmemdup_array(template_ops, num_ops, sizeof(*ops),
+				    GFP_KERNEL);
+		if (!ops) {
+			xt_free_table_info(newinfo);
+			return -ENOMEM;
+		}
+	}
+
 	new_table = xt_register_table(net, table, &bootstrap, newinfo);
 	if (IS_ERR(new_table)) {
 		struct ip6t_entry *iter;
@@ -1761,24 +1776,13 @@ int ip6t_register_table(struct net *net, const struct xt_table *table,
 		xt_entry_foreach(iter, loc_cpu_entry, newinfo->size)
 			cleanup_entry(iter, net);
 		xt_free_table_info(newinfo);
+		kfree(ops);
 		return PTR_ERR(new_table);
 	}
 
 	if (!template_ops)
 		return 0;
 
-	num_ops = hweight32(table->valid_hooks);
-	if (num_ops == 0) {
-		ret = -EINVAL;
-		goto out_free;
-	}
-
-	ops = kmemdup_array(template_ops, num_ops, sizeof(*ops), GFP_KERNEL);
-	if (!ops) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-
 	for (i = 0; i < num_ops; i++)
 		ops[i].priv = new_table;
 
-- 
2.47.3


