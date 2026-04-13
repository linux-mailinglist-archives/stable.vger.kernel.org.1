Return-Path: <stable+bounces-237372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK92Mgwj3WkYaQkAu9opvQ
	(envelope-from <stable+bounces-237372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:08:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 412B43F0D23
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A1BD305F766
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098B13195E4;
	Mon, 13 Apr 2026 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kHlJTS/I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0879318EC4;
	Mon, 13 Apr 2026 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099284; cv=none; b=PjRg4lDHhSfoXDQZJV/+4L5bI+y9UXwTrBwGpD8Nj3gOSxcCQ8UukjpR5WrgISZ4pWuX09F3YCKyev2t4JpsyKojrcz3yWFIDYNjuS1IOPvhqjrU6G9FbASJo8TfanmUXspD9T2lEsTfLp6PBmdwcnmpkPmxRuxKCsNLXcsg60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099284; c=relaxed/simple;
	bh=IhFkLnd1FM8F4U7F7AZyixpzf5PENNgIpWdZHEd+uiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9HjMpPFSaRkHCWOhlIaPhrrKxyeLdyYxtJrjtJrmR3yP3fwUcXvbMH3cSBJrwFwJ87PIHQRHniwDkUV8R6AxAtXxSftDvdJoPuGfIHI0R2HV90V4fSVoF+3u4ZTcUdvmtVS5UAv+tRJ5vbeGwgMEDMyuqh5IqrvUGY6J3Rj03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kHlJTS/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A5EC2BCAF;
	Mon, 13 Apr 2026 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099284;
	bh=IhFkLnd1FM8F4U7F7AZyixpzf5PENNgIpWdZHEd+uiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHlJTS/IfnpYxOEKwQiutQF9vaMaYWAX4ZSxOP0D50+MzuPvwDMbTG5ye3JGH2Iz4
	 eqGVcqTRTjtgcZbp13sLs2+M3ihPbUpiEAqSyoEZlq/C7G9Ekt7NeGmXopJvuVHSpX
	 7yRei98K7+0I/YxERLgM4lOEgBJvcZTjWg9iMnDI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+b518dfc8e021988fbd55@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 250/491] af_key: validate families in pfkey_send_migrate()
Date: Mon, 13 Apr 2026 17:58:15 +0200
Message-ID: <20260413155828.415168506@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-237372-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,b518dfc8e021988fbd55];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,apana.org.au:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:email]
X-Rspamd-Queue-Id: 412B43F0D23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit eb2d16a7d599dc9d4df391b5e660df9949963786 ]

syzbot was able to trigger a crash in skb_put() [1]

Issue is that pfkey_send_migrate() does not check old/new families,
and that set_ipsecrequest() @family argument was truncated,
thus possibly overfilling the skb.

Validate families early, do not wait set_ipsecrequest().

[1]

skbuff: skb_over_panic: text:ffffffff8a752120 len:392 put:16 head:ffff88802a4ad040 data:ffff88802a4ad040 tail:0x188 end:0x180 dev:<NULL>
 kernel BUG at net/core/skbuff.c:214 !
Call Trace:
 <TASK>
  skb_over_panic net/core/skbuff.c:219 [inline]
  skb_put+0x159/0x210 net/core/skbuff.c:2655
  skb_put_zero include/linux/skbuff.h:2788 [inline]
  set_ipsecrequest net/key/af_key.c:3532 [inline]
  pfkey_send_migrate+0x1270/0x2e50 net/key/af_key.c:3636
  km_migrate+0x155/0x260 net/xfrm/xfrm_state.c:2848
  xfrm_migrate+0x2140/0x2450 net/xfrm/xfrm_policy.c:4705
  xfrm_do_migrate+0x8ff/0xaa0 net/xfrm/xfrm_user.c:3150

Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")
Reported-by: syzbot+b518dfc8e021988fbd55@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69b5933c.050a0220.248e02.00f2.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/key/af_key.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index de4606d2eb643..95f7e363c2f6a 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3522,7 +3522,7 @@ static int set_sadb_kmaddress(struct sk_buff *skb, const struct xfrm_kmaddress *
 
 static int set_ipsecrequest(struct sk_buff *skb,
 			    uint8_t proto, uint8_t mode, int level,
-			    uint32_t reqid, uint8_t family,
+			    uint32_t reqid, sa_family_t family,
 			    const xfrm_address_t *src, const xfrm_address_t *dst)
 {
 	struct sadb_x_ipsecrequest *rq;
@@ -3587,12 +3587,17 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 
 	/* ipsecrequests */
 	for (i = 0, mp = m; i < num_bundles; i++, mp++) {
-		/* old locator pair */
-		size_pol += sizeof(struct sadb_x_ipsecrequest) +
-			    pfkey_sockaddr_pair_size(mp->old_family);
-		/* new locator pair */
-		size_pol += sizeof(struct sadb_x_ipsecrequest) +
-			    pfkey_sockaddr_pair_size(mp->new_family);
+		int pair_size;
+
+		pair_size = pfkey_sockaddr_pair_size(mp->old_family);
+		if (!pair_size)
+			return -EINVAL;
+		size_pol += sizeof(struct sadb_x_ipsecrequest) + pair_size;
+
+		pair_size = pfkey_sockaddr_pair_size(mp->new_family);
+		if (!pair_size)
+			return -EINVAL;
+		size_pol += sizeof(struct sadb_x_ipsecrequest) + pair_size;
 	}
 
 	size += sizeof(struct sadb_msg) + size_pol;
-- 
2.51.0




