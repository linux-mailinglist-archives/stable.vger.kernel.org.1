Return-Path: <stable+bounces-10546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC4B82B942
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 02:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2FD1F25DB3
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 01:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25A91110;
	Fri, 12 Jan 2024 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EaSvvl2H"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C41108
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A129F41149
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 01:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705024527;
	bh=DFnNUcCxq6F+U2RwUcyXEVilx+K0iPIjM0OI7y8iC5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=EaSvvl2HIerDcdtpgAbqsycuK1l5J4W8vd5LFsKzPfHLSmeJ45GpkcY8dmL9kI4eS
	 SAndkf1wVdiYWTd/vNpPhlEByp2WIsTMQWvyyzE4jFbxc4HOfit3g/iehcpBBRnZTH
	 6kboGcQoMzvx3BVINURaIaMJNTcPRnIg2QJKOhM75dLv1uxT4jgbHTOvyMffQID9Hp
	 L3qiid8l+ual1L8Uc5Cs6Y0BOha2hUKNOjJgGwiCci+MheA5Czsp7F08DTlZgF1Qeo
	 T5LrpiDky0Z777t0wPFjt9mKp0eMGHGHd2+APUWuvdamqSrxYJJa0CEc+UQeoLlzAo
	 AFkZqegCk0Qcw==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42992345c48so60492271cf.3
        for <stable@vger.kernel.org>; Thu, 11 Jan 2024 17:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705024526; x=1705629326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFnNUcCxq6F+U2RwUcyXEVilx+K0iPIjM0OI7y8iC5o=;
        b=ueqHIlaVbmaf5kA7vIp0PJnUXvjlGNOUq9n902XjmIB+9Ni6FLRraD+wSIVxW+0LY6
         oyFlEC6zPvDCaJtXYeu4gNHj7AFUdKkqrMcDbB3ctwNOLsSB5Zfj7SyCcGJd8MpbmZ8/
         bDluhfZXkH2bCPadJ/soI7NoXGyX4xSVNnIdt7c21gx+LDGvtfOeMAyVtBK7/G1EFtol
         Eq1N1ffcqp8ouOzlMoFw7ukeDEocUGkVdNx862hFBcOLycUoIfLNWAJPdhAE3X2tq6A9
         7QVY5XF+td+EWCihZhZC+JkVCvvvYuSUOUl0QvsP3+n5DbdpU5YKScoePWtDEeKGU+vf
         JQKQ==
X-Gm-Message-State: AOJu0YyYyfnmqsEqagSeFKMHHgSGvbHN9jJveNyXncw3OS90AO4pUt6x
	BD5jsn9dxcPeUzES/et9DwQ+O4CQ02IQ6GQTLOUtPQgRB+ly+xIE+nAF7GJmOOy23xAz4W7Ex7k
	IpF+pGmbjQjCSqcc1ouEXWOr6Ee6gR/TDwuMxC76f7YRebxKg+l6OR4yH
X-Received: by 2002:ac8:5bd2:0:b0:429:bb77:39a6 with SMTP id b18-20020ac85bd2000000b00429bb7739a6mr756728qtb.94.1705024525791;
        Thu, 11 Jan 2024 17:55:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDTpbPSwt4d3Rf8D3/ZT6DyWurCZglGxF23neGrt43qyLc8SDB61qnLnnjAo53uwx9SILl4Q==
X-Received: by 2002:ac8:5bd2:0:b0:429:bb77:39a6 with SMTP id b18-20020ac85bd2000000b00429bb7739a6mr756725qtb.94.1705024525564;
        Thu, 11 Jan 2024 17:55:25 -0800 (PST)
Received: from localhost (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id hg24-20020a05622a611800b00427f47af434sm934904qtb.61.2024.01.11.17.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 17:55:25 -0800 (PST)
From: Cengiz Can <cengiz.can@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	stable@vger.kernel.org
Subject: [PATCH 5.10.y] netfilter: nf_tables: Reject tables of unsupported family
Date: Fri, 12 Jan 2024 04:54:36 +0300
Message-Id: <20240112015436.1117482-2-cengiz.can@canonical.com>
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
index f244a4323a43..d7c9475639f2 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1186,6 +1186,30 @@ static int nft_objname_hash_cmp(struct rhashtable_compare_arg *arg,
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
 static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 			      struct sk_buff *skb, const struct nlmsghdr *nlh,
 			      const struct nlattr * const nla[],
@@ -1201,6 +1225,9 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 	u32 flags = 0;
 	int err;
 
+	if (!nft_supported_family(family))
+		return -EOPNOTSUPP;
+
 	lockdep_assert_held(&nft_net->commit_mutex);
 	attr = nla[NFTA_TABLE_NAME];
 	table = nft_table_lookup(net, attr, family, genmask);
-- 
2.40.1


