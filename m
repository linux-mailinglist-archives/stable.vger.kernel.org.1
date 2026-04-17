Return-Path: <stable+bounces-238453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBppLirn4WmKzgAAu9opvQ
	(envelope-from <stable+bounces-238453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:54:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5920A41838D
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50883300E629
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD1234B1A6;
	Fri, 17 Apr 2026 07:54:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A412D0C9D;
	Fri, 17 Apr 2026 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412450; cv=none; b=mme49OimmciuCX1iu1Bbxz2EKdKgip3U4vxCapa5vaegYunCwiQtG84JKSiv6QxLirpg81xzh2sXcmKCZNzE6ZdZsgUI29eJg+BACPDUbgHGB4TiJfj2XPlgN5QRfsI6HXT4lc+E6e9dbyNCIHFOSg6IPwwi9gOM7ZLu7SiXLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412450; c=relaxed/simple;
	bh=CYKDZxJQKUrLh7QKNrheyZSYwWaflRAAVhogKFRQNFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBGQzGf8ilEaV9eKXnnZ1k5QqUWh5Z6mASGZkKv0yhcCdEcW+pAtAOR/aJsj0xfNSmKEWl1unJpfMDkLID2HvvGKtcrLVG+J3RvZikPHb+zoxscImSGzEScO/KwyKU56LImot+o/1OwApHCvfsReHd6mr2bMgkbFoNyoy78VC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowAAHlwoT5+FpD1TYDQ--.22372S2;
	Fri, 17 Apr 2026 15:53:55 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] tipc: crypto: require a NUL-terminated AEAD algorithm name
Date: Fri, 17 Apr 2026 15:53:53 +0800
Message-ID: <20260417075353.30662-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHlwoT5+FpD1TYDQ--.22372S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4kur1UGFy7AryxCF43Awb_yoW8uw4kpF
	WFkasrJayDJrsrK395tr4fCF13K3sakrZrGrs8W3W5ZwsFqw1IgFyfCFWjyr13JFy7Jr47
	uayqq345CF1UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUDOz3UUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238453-lists,stable=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 5920A41838D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

struct tipc_aead_key carries alg_name in a fixed 32-byte field, but both
the generic netlink validation path and the MSG_CRYPTO receive path pass
that field straight to crypto_has_alg(), strcmp(), and
crypto_alloc_aead() without first proving that it contains a terminating
NUL.

Reject locally supplied and received keys whose algorithm name fills the
entire fixed-width field without a terminator.

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Cc: stable@vger.kernel.org

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 net/tipc/crypto.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 6d3b6b89b1d1..60110ea0fe7c 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -307,6 +307,11 @@ static void tipc_crypto_work_tx(struct work_struct *work);
 static void tipc_crypto_work_rx(struct work_struct *work);
 static int tipc_aead_key_generate(struct tipc_aead_key *skey);
 
+static bool tipc_aead_alg_name_valid(const char *alg_name)
+{
+	return strnlen(alg_name, TIPC_AEAD_ALG_NAME) < TIPC_AEAD_ALG_NAME;
+}
+
 #define is_tx(crypto) (!(crypto)->node)
 #define is_rx(crypto) (!is_tx(crypto))
 
@@ -335,6 +340,11 @@ int tipc_aead_key_validate(struct tipc_aead_key *ukey, struct genl_info *info)
 {
 	int keylen;
 
+	if (unlikely(!tipc_aead_alg_name_valid(ukey->alg_name))) {
+		GENL_SET_ERR_MSG(info, "algorithm name is not NUL-terminated");
+		return -EINVAL;
+	}
+
 	/* Check if algorithm exists */
 	if (unlikely(!crypto_has_alg(ukey->alg_name, 0, 0))) {
 		GENL_SET_ERR_MSG(info, "unable to load the algorithm (module existed?)");
@@ -2298,6 +2308,10 @@ static bool tipc_crypto_key_rcv(struct tipc_crypto *rx, struct tipc_msg *hdr)
 		pr_debug("%s: invalid MSG_CRYPTO key size\n", rx->name);
 		goto exit;
 	}
+	if (unlikely(!tipc_aead_alg_name_valid(data))) {
+		pr_debug("%s: invalid MSG_CRYPTO algorithm name\n", rx->name);
+		goto exit;
+	}
 
 	spin_lock(&rx->lock);
 	if (unlikely(rx->skey || (key_gen == rx->key_gen && rx->key.keys))) {
-- 
2.50.1 (Apple Git-155)


