Return-Path: <stable+bounces-146309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BB8AC358A
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 17:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8229718954F9
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F831F8ADD;
	Sun, 25 May 2025 15:54:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526712B73;
	Sun, 25 May 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748188477; cv=none; b=Il/zkvZmuIp/XtWfY2G1j/K+mffNT2bSr4RoFQvFquna1dvh6LZRfp5YQqky8u36WyfaNbglQ+eWfxoZClLZCHAa5XGahsZq7naDMtXXKX+5MSsVpgG8vaa+X24IufBqk9c83Al0jeQsiLk4O28P1isTD/Ih9Xu3vJ2yZF91woQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748188477; c=relaxed/simple;
	bh=vrH5fpvU7vRjZ/W60VBI3qyQYO/Wlt462x6MyH8dQh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRNKvp74JiZC7S4MPW04KQzueT8rkW/Uyq6vi/pmo93KGhC+6vPvTGgpX5s0IGk3kdJzJZqNTW6bUMR1bL1DY7hyqTC9R46LT45tRqRZNZlcuRL0CJfUAC+0fNnNW3tJ+KY2ph+D6MqL69wy10LL7jkfnV8yJRYe16AVwgAGZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.199.70.239])
	by APP-03 (Coremail) with SMTP id rQCowADHETEfPTNoi+BnAQ--.40252S2;
	Sun, 25 May 2025 23:54:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: af_key: Add error check in set_sadb_address()
Date: Sun, 25 May 2025 23:53:50 +0800
Message-ID: <20250525155350.1948-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADHETEfPTNoi+BnAQ--.40252S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDAryDKw4xur1UZrW3GFg_yoW8Gw4Up3
	W3Gr1fXrn8Jw15ua1fGr1Fg3W5A34kKFyj9rW8KF4YkwsYgr1rZw45Cw4fWa4UJrZ3Xa1x
	trWYgrZ5GF40vFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkNA2gzMwUSfgAAsB

The function set_sadb_address() calls the function
pfkey_sockaddr_fill(), but does not check its return value.
A proper implementation can be found in set_sadb_kmaddress().

Add an error check for set_sadb_address(), return error code
if the function fails.

Fixes: e5b56652c11b ("key: Share common code path to fill sockaddr{}.")
Cc: stable@vger.kernel.org # v2.6
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/key/af_key.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index c56bb4f451e6..537c9604e356 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3474,15 +3474,17 @@ static int set_sadb_address(struct sk_buff *skb, int sasize, int type,
 	switch (type) {
 	case SADB_EXT_ADDRESS_SRC:
 		addr->sadb_address_prefixlen = sel->prefixlen_s;
-		pfkey_sockaddr_fill(&sel->saddr, 0,
-				    (struct sockaddr *)(addr + 1),
-				    sel->family);
+		if (!pfkey_sockaddr_fill(&sel->saddr, 0,
+					 (struct sockaddr *)(addr + 1),
+					 sel->family))
+			return -EINVAL;
 		break;
 	case SADB_EXT_ADDRESS_DST:
 		addr->sadb_address_prefixlen = sel->prefixlen_d;
-		pfkey_sockaddr_fill(&sel->daddr, 0,
-				    (struct sockaddr *)(addr + 1),
-				    sel->family);
+		if (!pfkey_sockaddr_fill(&sel->daddr, 0,
+					 (struct sockaddr *)(addr + 1),
+					 sel->family))
+			return -EINVAL;
 		break;
 	default:
 		return -EINVAL;
-- 
2.42.0.windows.2


