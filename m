Return-Path: <stable+bounces-10547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299DE82B943
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 02:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA149B24DA1
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 01:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A6D1117;
	Fri, 12 Jan 2024 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cMLJGJQr"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFE2110D
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8A4373F184
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 01:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705024536;
	bh=r3WXFnWFPclS/tkFV/FisWCvXKNSCcSOQQ8WNnFhxeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=cMLJGJQrWoaKXRAZIOU77knVsp8wkjXUASV0YWiWL2iP7wkzf2EjZHFux7bAf2smv
	 uYQJx/L5tN/sV9iIWNIVs3pxgJx9MY4PQb3AZk6zEwF+ULH5Qa9QEIxZcXi8idon3t
	 kz4zJHJWTlI+z8ljOrO/C3t5MySAQMQZdf4xJ93/BuZw0En61Rr4N+28Ej8CPOY6k6
	 hzes+/VFPnvaQX4aSshFB6RYNfey/xv0YvEkODJ/inSX0cCRPsHbSkxb7c4+91jOd2
	 98xe98dfC7VP5ix45Sjj3AexJECd0cLwD+uOswmd4RrfQo0rYBe1ZJassEr6TaKjCP
	 P1APcnzL3YClw==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-429a05fd0b7so41162101cf.3
        for <stable@vger.kernel.org>; Thu, 11 Jan 2024 17:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705024532; x=1705629332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3WXFnWFPclS/tkFV/FisWCvXKNSCcSOQQ8WNnFhxeE=;
        b=Ju+Vfsib2qFdFA5zjnp1yB8qwdLFT9+xtWmb3o0UoeRdWbO1LOrd0s3aFTGHBP7f7n
         Y9RqNPMxzdlqede36jMb0kWdHzCsfUmd1P0AKQgyRQSAijUfiekt0KeO3peOc13UFCsn
         v2RUa8tDBrVwuNjlFXw21NO2Dl8ymooBWY8ppnRgNwmsC/kVOGvAE3nUesq1eECutiOm
         qpMpkZcAgFMQrD+EBKnFV5Tm2yEQ3IKhFP63RT0XRsOGYNn2h7Q9Yrpzj6AfFNhTfK+x
         dZIdXYAeRq0kEFua6yz1P3qmammqdZpscvUOlUJHxdB3lDo85EwTacPEB7wOOnhi2Bog
         vy3Q==
X-Gm-Message-State: AOJu0YzDGhYmHInz46DP33ulzA63DyeTxj1gYimEqyFrX+6kcVwrNNt5
	wGdP7EUtOmGboRlgtjUiFpMiuq6QSDv9Z1oOBqOdXakU2+b60AiQ2gFWpX0DWV9SQs8Mq5RQVh0
	NfES/EZqyho4rOgh372W9HUbvVT3K/nxwMac8p9v9
X-Received: by 2002:ac8:7d45:0:b0:429:c02d:bcd9 with SMTP id h5-20020ac87d45000000b00429c02dbcd9mr648610qtb.8.1705024532793;
        Thu, 11 Jan 2024 17:55:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk8NBvD4XYyK8cUQEl2IIxo7xJg5v3guFwOHhvQ99wUhdX75mRJ/TugTl24xJ2A0ShzWR0kQ==
X-Received: by 2002:ac8:7d45:0:b0:429:c02d:bcd9 with SMTP id h5-20020ac87d45000000b00429c02dbcd9mr648601qtb.8.1705024532558;
        Thu, 11 Jan 2024 17:55:32 -0800 (PST)
Received: from localhost (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id ev11-20020a05622a510b00b0042987c129e7sm956117qtb.55.2024.01.11.17.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 17:55:32 -0800 (PST)
From: Cengiz Can <cengiz.can@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y] netfilter: nf_tables: Reject tables of unsupported family
Date: Fri, 12 Jan 2024 04:54:37 +0300
Message-Id: <20240112015436.1117482-3-cengiz.can@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240112015436.1117482-1-cengiz.can@canonical.com>
References: <20240112015436.1117482-1-cengiz.can@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Sutter <phil@nwl.cc>

commit f1082dd31fe461d482d69da2a8eccfeb7bf07ac2 upstream.

An nftables family is merely a hollow container, its family just a
number and such not reliant on compile-time options other than nftables
support itself. Add an artificial check so attempts at using a family
the kernel can't support fail as early as possible. This helps user
space detect kernels which lack e.g. NFPROTO_INET.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Cengiz Can <cengiz.can@canonical.com>
---
 net/netfilter/nf_tables_api.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3ee0f632a942..3556818c7162 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1247,6 +1247,30 @@ static int nft_objname_hash_cmp(struct rhashtable_compare_arg *arg,
 	return strcmp(obj->key.name, k->name);
 }
 
+static bool nft_supported_family(u8 family)
+{
+	return false
+#ifdef CONFIG_NF_TABLES_INET
+		|| family == NFPROTO_INET
+#endif
+#ifdef CONFIG_NF_TABLES_IPV4
+		|| family == NFPROTO_IPV4
+#endif
+#ifdef CONFIG_NF_TABLES_ARP
+		|| family == NFPROTO_ARP
+#endif
+#ifdef CONFIG_NF_TABLES_NETDEV
+		|| family == NFPROTO_NETDEV
+#endif
+#if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
+		|| family == NFPROTO_BRIDGE
+#endif
+#ifdef CONFIG_NF_TABLES_IPV6
+		|| family == NFPROTO_IPV6
+#endif
+		;
+}
+
 static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
 			      const struct nlattr * const nla[])
 {
@@ -1261,6 +1285,9 @@ static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
 	u32 flags = 0;
 	int err;
 
+	if (!nft_supported_family(family))
+		return -EOPNOTSUPP;
+
 	lockdep_assert_held(&nft_net->commit_mutex);
 	attr = nla[NFTA_TABLE_NAME];
 	table = nft_table_lookup(net, attr, family, genmask,
-- 
2.40.1


