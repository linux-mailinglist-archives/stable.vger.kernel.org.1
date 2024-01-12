Return-Path: <stable+bounces-10545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE8B82B941
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 02:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9051FB24956
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 01:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094A7ED7;
	Fri, 12 Jan 2024 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oOBnntgv"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0EFA51
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C548C41030
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 01:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705024517;
	bh=jvwX17G0Q0vq/d9/SKrVYC8Q6zYjuHiSy0YFMqjjsQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=oOBnntgvzMDL2ULaDha4Z7Xhvyui87+4Jsi8Mz9SRNQu1N08OSU4cqCUT4whpaXet
	 W+iighb/WSSwWOfs/ne16agPAnGKPcZNyMPzOCT6WCyqI+ms2gCMecEv2J8+oyA2Te
	 w9sN49llM7R15jM+AjlJICiP84Am9zIq+ugIM0NhOgE/fW8TDPtG7cq6k2rGkrxCQA
	 mw3reXdaZ4BhxL7IbfbN8quT0g9YGtZGp7UsBNQbC6R6b1EsMkCMTvYTqlgMmKIyNb
	 3MBlLSMhrUaiOlwY8dcMBDCyNE6dta6OJzuRBj26abUlE0j0uKuoDLXyPBdVrQ6T/C
	 TVcTUdfyrKtEQ==
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6800aa45af1so110647246d6.3
        for <stable@vger.kernel.org>; Thu, 11 Jan 2024 17:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705024516; x=1705629316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvwX17G0Q0vq/d9/SKrVYC8Q6zYjuHiSy0YFMqjjsQA=;
        b=gkln963R9YceAwCzk22C5quQR21DhYojnBubPCqZjsfr39J3Woo/Feb4unhfI/i7sZ
         y0pQsLa+zQzSjhXDkyrNBZ5wpKeveIutH2XSLgl8aQwFFm9PLOAKaLjDOfjBGk/guG6B
         8qQXUkS6NNFkkhwNKjpZRsWU83/o1m3mDyBW1GgbM8is4vnnpwKcNf3YuIfsUGFDupCN
         c/VBclTs+9h+S6S70mwdFuJUAMyrUt6x5EOiqYwJJoNR47M7u9v1JQX0MsgRNZzgq4hJ
         haGZAjo6QITZETf5675z9x91z0itpgoqiRrByxY1F31sr/UrmmXGV6v/cJE4VxTylRiv
         3h1A==
X-Gm-Message-State: AOJu0Yxzn8zBT6fsKM6LsU+l2tWIUff+IyKZWoLCOJsW0BExFM/ALbCq
	BlxIC0VZjPFTw8Wo+MxoPFuUDyIJ0HA8HaQ9wkR9z1/7q6FSkdnb2hdHRHWQGnQxZvhsvm7kkcn
	14vbd9Aip7ODvmoa9ZiG3cgIfI8oywBW+cRHO84rqXbStRQBxg0VYJhHj
X-Received: by 2002:a05:6214:5010:b0:680:40d:5f90 with SMTP id jo16-20020a056214501000b00680040d5f90mr189891qvb.92.1705024515865;
        Thu, 11 Jan 2024 17:55:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaxlbqqz3nD/ysCr16z6vWgGfKGt52re/KMo1M+JQ0GHpRT2yfmO9wwScJqQJ3hf4L65M2+A==
X-Received: by 2002:a05:6214:5010:b0:680:40d:5f90 with SMTP id jo16-20020a056214501000b00680040d5f90mr189883qvb.92.1705024515539;
        Thu, 11 Jan 2024 17:55:15 -0800 (PST)
Received: from localhost (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id x4-20020ad440c4000000b0068111bbd2ccsm701057qvp.143.2024.01.11.17.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 17:55:15 -0800 (PST)
From: Cengiz Can <cengiz.can@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	stable@vger.kernel.org
Subject: [PATCH 5.4.y] netfilter: nf_tables: Reject tables of unsupported family
Date: Fri, 12 Jan 2024 04:54:35 +0300
Message-Id: <20240112015436.1117482-1-cengiz.can@canonical.com>
X-Mailer: git-send-email 2.40.1
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
index 78be121f38ac..915df77161e1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1005,6 +1005,30 @@ static int nft_objname_hash_cmp(struct rhashtable_compare_arg *arg,
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
@@ -1020,6 +1044,9 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 	struct nft_ctx ctx;
 	int err;
 
+	if (!nft_supported_family(family))
+		return -EOPNOTSUPP;
+
 	lockdep_assert_held(&nft_net->commit_mutex);
 	attr = nla[NFTA_TABLE_NAME];
 	table = nft_table_lookup(net, attr, family, genmask);
-- 
2.40.1


