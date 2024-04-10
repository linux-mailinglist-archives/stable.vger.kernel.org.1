Return-Path: <stable+bounces-37958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4E089F0D2
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 13:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC0D1F2143A
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD1015CD7F;
	Wed, 10 Apr 2024 11:28:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579EE15CD61
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748495; cv=none; b=oTMCfH1ibP/8c8R77354naCUucSLfvjLiZj9J3QTRNtEnsMBfm5mKA2+FYi1Fn4OJGOO5r6hVEXm5kcIH0ASGh00RGh3+0Fk10jZvAmrR9uPpvoGMOieSnJ7pDnszECpw763Cdr/FAYlt4KElir7HqsZtTh5nmKpU7/7j/VNU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748495; c=relaxed/simple;
	bh=KPp+3XkSniY9Wei27HShCoCmp8telE4FPsHLRTBz1xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmiFsARhPq07UGtWJnorwpqlMX2j4mZfEkJkyA/3WkXoC8HaJ61+w8lPA7r1fUh5D1vbtddAO9cup0Dj7bLXAq7JZBcx7ab3eyhAxuUVUh974lljw2/d4BzeuBO3UpYmtHZ4pp2ePv5sDuEqYAyg3FoZT7MgXaAZu27EvZd3Dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 9995E2F20242; Wed, 10 Apr 2024 11:28:05 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id B523E2F20249;
	Wed, 10 Apr 2024 11:28:03 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Howells <dhowells@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	kernel test robot <lkp@intel.com>,
	Vadim Fedorenko <vfedorenko@novek.ru>,
	stable@vger.kernel.org
Subject: [PATCH 3/4 5.10] rxrpc: Fix dependency on IPv6 in udp tunnel config
Date: Wed, 10 Apr 2024 14:27:45 +0300
Message-ID: <20240410112747.2952012-4-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240410112747.2952012-1-oficerovas@altlinux.org>
References: <20240410112747.2952012-1-oficerovas@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vadim Fedorenko <vfedorenko@novek.ru>

[ Upstream commit 295f830e53f4838344c97e12ce69637e2128ca8d ]

As udp_port_cfg struct changes its members with dependency on IPv6
configuration, the code in rxrpc should also check for IPv6.

Fixes: 1a9b86c9fd95 ("rxrpc: use udp tunnel APIs instead of open code in rxrpc_open_socket")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vadim Fedorenko <vfedorenko@novek.ru>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: stable@vger.kernel.org
---
 net/rxrpc/local_object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 8f9c06fd37e984..6215800db33333 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -120,9 +120,11 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	if (udp_conf.family == AF_INET) {
 		udp_conf.local_ip = srx->transport.sin.sin_addr;
 		udp_conf.local_udp_port = srx->transport.sin.sin_port;
+#if IS_ENABLED(CONFIG_AF_RXRPC_IPV6)
 	} else {
 		udp_conf.local_ip6 = srx->transport.sin6.sin6_addr;
 		udp_conf.local_udp_port = srx->transport.sin6.sin6_port;
+#endif
 	}
 	ret = udp_sock_create(net, &udp_conf, &local->socket);
 	if (ret < 0) {
-- 
2.42.1


