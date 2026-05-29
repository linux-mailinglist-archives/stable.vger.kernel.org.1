Return-Path: <stable+bounces-256522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDuxCcAuGWrmsAgAu9opvQ
	(envelope-from <stable+bounces-256522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:14:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 746005FDCC0
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43C3D30FFB71
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E52C15A5;
	Fri, 29 May 2026 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="a8N3VyLL"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB42E7389
	for <stable@vger.kernel.org>; Fri, 29 May 2026 06:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035010; cv=none; b=lNlHpINJYW2dxbZw9J6UxtioZ5D9wC3G9oZAHdK6TZcnM+Jkxob4yBayD9JAzUhHnwJtPO8aAO4uwCXcbQgHP9tdi4IydeAGWlhwFWvOwzZoufaXjwu4joJ62vaKmNKfhJWs61FNSS+iLwGaHhQyynHRfGEswY5Kh4wwNxVSzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035010; c=relaxed/simple;
	bh=ZhiJI4r6NwrkbNYKE8PtSf/pog/UKalMvA+Fkj02jI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDulG3YcYBX8g8gzGO+uKno1AQ90WVMEtGLyzpakLazFwJHdfi4IlJZmtuSm/UYMhR3ICZowcpAr+E9T1ttwCSOexESwUqw7L+0VOsB4X5H0jz1k3xfOSH+gg7R3ousbkj/q4bM3WFklh6mYdbQE7x6u6lCNPQ4dnX3kLNrlUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=a8N3VyLL; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=a8N3VyLL/Xb1vaFNqCzxma+EIQQalIrOcasIxPKC96iSgmkeNBt/hOkesT2HtTRTWV6VdIc4LxDkI
	 UWQi1NJPurLWvh/whC/S4d0qJ6UbgdrE3uy22V3JYbser/p+JOUbkCV4B3KtmY4uvVQkLmC2STT3rs
	 gZf1k7yJEQG+CpNU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[124.64.124.40])
	by rmsmtp-lg-appmail-06-12084 (RichMail) with SMTP id 2f346a192da9da7-10e3c;
	Fri, 29 May 2026 14:09:53 +0800 (CST)
X-RM-TRANSID:2f346a192da9da7-10e3c
From: Miles Wang <13621186580@139.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: yuantan098@gmail.com,
	steffen.klassert@secunet.com,
	zcliangcn@gmail.com,
	lx24@stu.ynu.edu.cn,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn
Subject: [PATCH 6.6.y] net: af_key: zero aligned sockaddr tail in PF_KEY exports
Date: Fri, 29 May 2026 14:09:45 +0800
Message-ID: <20260529060945.4813-1-13621186580@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,secunet.com,stu.ynu.edu.cn,lzu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256522-lists,stable=lfdr.de];
	DMARC_NA(0.00)[139.com];
	DKIM_TRACE(0.00)[139.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[13621186580@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.558];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,secunet.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 746005FDCC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhengchuan Liang <zcliangcn@gmail.com>

[ Upstream commit 426c355742f02cf743b347d9d7dbdc1bfbfa31ef ]

PF_KEY export paths use `pfkey_sockaddr_size()` when reserving sockaddr
payload space, so IPv6 addresses occupy 32 bytes on the wire. However,
`pfkey_sockaddr_fill()` initializes only the first 28 bytes of
`struct sockaddr_in6`, leaving the final 4 aligned bytes uninitialized.

Not every PF_KEY message is affected. The state and policy dump builders
already zero the whole message buffer before filling the sockaddr
payloads. Keep the fix to the export paths that still append aligned
sockaddr payloads with plain `skb_put()`:

  - `SADB_ACQUIRE`
  - `SADB_X_NAT_T_NEW_MAPPING`
  - `SADB_X_MIGRATE`

Fix those paths by clearing only the aligned sockaddr tail after
`pfkey_sockaddr_fill()`.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miles Wang <13621186580@139.com>
---
 net/key/af_key.c | 52 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 4849407da86d..486c9a2e1f52 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -757,6 +757,22 @@ static unsigned int pfkey_sockaddr_fill(const xfrm_address_t *xaddr, __be16 port
 	return 0;
 }
 
+static unsigned int pfkey_sockaddr_fill_zero_tail(const xfrm_address_t *xaddr,
+						  __be16 port,
+						  struct sockaddr *sa,
+						  unsigned short family)
+{
+	unsigned int prefixlen;
+	int sockaddr_len = pfkey_sockaddr_len(family);
+	int sockaddr_size = pfkey_sockaddr_size(family);
+
+	prefixlen = pfkey_sockaddr_fill(xaddr, port, sa, family);
+	if (sockaddr_size > sockaddr_len)
+		memset((u8 *)sa + sockaddr_len, 0, sockaddr_size - sockaddr_len);
+
+	return prefixlen;
+}
+
 static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 					      int add_keys, int hsc)
 {
@@ -3205,9 +3221,9 @@ static int pfkey_send_acquire(struct xfrm_state *x, struct xfrm_tmpl *t, struct
 	addr->sadb_address_proto = 0;
 	addr->sadb_address_reserved = 0;
 	addr->sadb_address_prefixlen =
-		pfkey_sockaddr_fill(&x->props.saddr, 0,
-				    (struct sockaddr *) (addr + 1),
-				    x->props.family);
+		pfkey_sockaddr_fill_zero_tail(&x->props.saddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      x->props.family);
 	if (!addr->sadb_address_prefixlen)
 		BUG();
 
@@ -3220,9 +3236,9 @@ static int pfkey_send_acquire(struct xfrm_state *x, struct xfrm_tmpl *t, struct
 	addr->sadb_address_proto = 0;
 	addr->sadb_address_reserved = 0;
 	addr->sadb_address_prefixlen =
-		pfkey_sockaddr_fill(&x->id.daddr, 0,
-				    (struct sockaddr *) (addr + 1),
-				    x->props.family);
+		pfkey_sockaddr_fill_zero_tail(&x->id.daddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      x->props.family);
 	if (!addr->sadb_address_prefixlen)
 		BUG();
 
@@ -3420,9 +3436,9 @@ static int pfkey_send_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr,
 	addr->sadb_address_proto = 0;
 	addr->sadb_address_reserved = 0;
 	addr->sadb_address_prefixlen =
-		pfkey_sockaddr_fill(&x->props.saddr, 0,
-				    (struct sockaddr *) (addr + 1),
-				    x->props.family);
+		pfkey_sockaddr_fill_zero_tail(&x->props.saddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      x->props.family);
 	if (!addr->sadb_address_prefixlen)
 		BUG();
 
@@ -3442,9 +3458,9 @@ static int pfkey_send_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr,
 	addr->sadb_address_proto = 0;
 	addr->sadb_address_reserved = 0;
 	addr->sadb_address_prefixlen =
-		pfkey_sockaddr_fill(ipaddr, 0,
-				    (struct sockaddr *) (addr + 1),
-				    x->props.family);
+		pfkey_sockaddr_fill_zero_tail(ipaddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      x->props.family);
 	if (!addr->sadb_address_prefixlen)
 		BUG();
 
@@ -3473,15 +3489,15 @@ static int set_sadb_address(struct sk_buff *skb, int sasize, int type,
 	switch (type) {
 	case SADB_EXT_ADDRESS_SRC:
 		addr->sadb_address_prefixlen = sel->prefixlen_s;
-		pfkey_sockaddr_fill(&sel->saddr, 0,
-				    (struct sockaddr *)(addr + 1),
-				    sel->family);
+		pfkey_sockaddr_fill_zero_tail(&sel->saddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      sel->family);
 		break;
 	case SADB_EXT_ADDRESS_DST:
 		addr->sadb_address_prefixlen = sel->prefixlen_d;
-		pfkey_sockaddr_fill(&sel->daddr, 0,
-				    (struct sockaddr *)(addr + 1),
-				    sel->family);
+		pfkey_sockaddr_fill_zero_tail(&sel->daddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      sel->family);
 		break;
 	default:
 		return -EINVAL;
-- 
2.34.1



