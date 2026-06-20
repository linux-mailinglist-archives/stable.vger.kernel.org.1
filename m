Return-Path: <stable+bounces-267477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tP3jOalgNmr/+wYAu9opvQ
	(envelope-from <stable+bounces-267477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 11:43:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B66A8B18
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 11:43:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=a3MT9u3D;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267477-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267477-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D54FB300668F
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9939D3469FA;
	Sat, 20 Jun 2026 09:43:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E932AACB;
	Sat, 20 Jun 2026 09:42:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781948582; cv=none; b=uYHHw+zkch5D1cHwacl5P2hv65TyouT94J2kjSQ2W/JjEL44kaCBE+Gu7kNHMMTN1n1Ic5PaPRBkMGQwplIPmaBbMlFTLocyODkf6WFonygYxHYRBi7pYVmQKbfzglkj05Hlgpi6fXrZ0hINgUBRHi4CcFzyFqtbW8mxkuhBJdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781948582; c=relaxed/simple;
	bh=8fMNRF0SqSKtMYIVnbt9RS7ifbrZk0Ewvn6V0lL10A4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ddO+FWRVFkCE2WRWm4c7DHbbzi7SOT3R2JgrQakWyHpOESPdnlR8rgLy+acKOiaRtnV4Nol2AS13jBywmDy0Ik1/vU1HOufxJlgb5v1XtPw4gXAXVKrPonW6Xz1ZK6S4/KeNX9NZvWN15CohD/ThRqfZSzm0xJFuVHjjQ9+ez/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=a3MT9u3D; arc=none smtp.client-ip=45.254.49.197
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43192ae6e;
	Sat, 20 Jun 2026 17:37:46 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Taras Chornyi <taras.chornyi@plvision.eu>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
	Andrii Savka <andrii.savka@plvision.eu>,
	Vadym Kochan <vadym.kochan@plvision.eu>,
	Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] net: marvell: prestera: use unaligned accessors for DSA tag
Date: Sat, 20 Jun 2026 17:37:39 +0800
Message-Id: <20260620093739.2164921-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ee464b63203a1kunme267ed1df294f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHUpNVksfS0IdHkgZHhkYHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=a3MT9u3DUyshn2ClhviuzzlH1+nQSFyiCps84FafLHUoYANG6J7JZaTBNYz1wCfT0fnFwk26PUhGA6KVxw3umGe1KAznznN+IE96+RCcbFA2/gCm0xIDP2q7eIKdZSv3cZSUgEuO3e3UAXPrDb3VOyqxcvaZXUjNVlE/HAZGRMA=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=MgB0X53jUypkv0f8t6Xh88X4qD70o0a+demyhV9n3tY=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-267477-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:taras.chornyi@plvision.eu,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:oleksandr.mazur@plvision.eu,m:andrii.savka@plvision.eu,m:vadym.kochan@plvision.eu,m:volodymyr.mytnyk@plvision.eu,m:linux-kernel@vger.kernel.org,m:runyu.xiao@seu.edu.cn,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 841B66A8B18

Prestera parses and builds its 16-byte DSA tag from an skb byte buffer.
The current code casts the tag pointer to __be32 * and then reads or
writes the four tag words through that typed pointer.

The tag pointer is derived from skb data, but that only identifies the
protocol tag location inside the packet buffer. It does not make the tag
a naturally aligned __be32 array. Use the unaligned big-endian helpers
for both parsing and building the tag.

This issue was detected by our static analysis tool and confirmed by
manual audit. The same access pattern was validated with UBSAN alignment
instrumentation by keeping the original cast from a u8 DSA tag buffer to
__be32 * and reading dsa_words[i] from a deliberately misaligned tag
buffer. UBSAN reported misaligned-access loads of type '__be32' in
prestera_dsa_parse().

The driver has the same source-level issue: the RX path parses bytes at
skb->data - ETH_TLEN, and the TX path writes the tag at skb->data +
2 * ETH_ALEN. Those offsets identify the DSA tag bytes, but they do not
establish a __be32 object or a 4-byte alignment guarantee for typed loads
and stores.

Fixes: 501ef3066c89 ("net: marvell: prestera: Add driver for Prestera family ASIC devices")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 .../ethernet/marvell/prestera/prestera_dsa.c  | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_dsa.c b/drivers/net/ethernet/marvell/prestera/prestera_dsa.c
index b7e89c0ca5c0..276f98cbd50e 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_dsa.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_dsa.c
@@ -4,6 +4,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
+#include <linux/unaligned.h>
 #include <linux/string.h>
 
 #include "prestera_dsa.h"
@@ -33,15 +34,14 @@
 
 int prestera_dsa_parse(struct prestera_dsa *dsa, const u8 *dsa_buf)
 {
-	__be32 *dsa_words = (__be32 *)dsa_buf;
 	enum prestera_dsa_cmd cmd;
 	u32 words[4];
 	u32 field;
 
-	words[0] = ntohl(dsa_words[0]);
-	words[1] = ntohl(dsa_words[1]);
-	words[2] = ntohl(dsa_words[2]);
-	words[3] = ntohl(dsa_words[3]);
+	words[0] = get_unaligned_be32(dsa_buf);
+	words[1] = get_unaligned_be32(dsa_buf + 4);
+	words[2] = get_unaligned_be32(dsa_buf + 8);
+	words[3] = get_unaligned_be32(dsa_buf + 12);
 
 	/* set the common parameters */
 	cmd = (enum prestera_dsa_cmd)FIELD_GET(PRESTERA_DSA_W0_CMD, words[0]);
@@ -82,7 +82,6 @@ int prestera_dsa_parse(struct prestera_dsa *dsa, const u8 *dsa_buf)
 
 int prestera_dsa_build(const struct prestera_dsa *dsa, u8 *dsa_buf)
 {
-	__be32 *dsa_words = (__be32 *)dsa_buf;
 	u32 dev_num = dsa->hw_dev_num;
 	u32 words[4] = { 0 };
 
@@ -98,10 +97,10 @@ int prestera_dsa_build(const struct prestera_dsa *dsa, u8 *dsa_buf)
 	words[1] |= FIELD_PREP(PRESTERA_DSA_W1_EXT_BIT, 1);
 	words[2] |= FIELD_PREP(PRESTERA_DSA_W2_EXT_BIT, 1);
 
-	dsa_words[0] = htonl(words[0]);
-	dsa_words[1] = htonl(words[1]);
-	dsa_words[2] = htonl(words[2]);
-	dsa_words[3] = htonl(words[3]);
+	put_unaligned_be32(words[0], dsa_buf);
+	put_unaligned_be32(words[1], dsa_buf + 4);
+	put_unaligned_be32(words[2], dsa_buf + 8);
+	put_unaligned_be32(words[3], dsa_buf + 12);
 
 	return 0;
 }
-- 
2.34.1


