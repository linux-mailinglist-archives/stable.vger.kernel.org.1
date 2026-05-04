Return-Path: <stable+bounces-242867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFHtHD9U+GnSswIAu9opvQ
	(envelope-from <stable+bounces-242867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:09:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE8C4B9ED1
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 298AE300B5B7
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D967A3161AD;
	Mon,  4 May 2026 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+qlW/A3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669603195FB
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882134; cv=none; b=gVL50Hay7HgBf/b4Gvo6RAu8SrB1aDrhv248gmsDk2DE4P93PnnqcS7TmuSaWfmroIyYMOt0G9HZaaAlNQnOyiDPgnUflJKKJKBKwhMTQOqIhDse+CJ/OiTs2eDIGrzeqerTf3wpTbvEls/ZM521SeiOcLJWO3kGWDUq17mteyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882134; c=relaxed/simple;
	bh=hKJZI7B99bM+HBtBehq4SAoBPn8N4H1C+oq+hP8uFHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBJIzrSj+Bulry9qSuk1eOzBzE/5mAq24GWfChSZ6N2vV0WpGm5YxkDKYug9FsRaGqd4RJXBeInZ+rE7C6N283+5na2BicYIcN0Vca25yMRLhbhToLlUWz4HL/iSxveP7Uu4XDmyg7jmzWoYmgvgb7wqw2x95ouH1tx89HmcnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+qlW/A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D559C2BCB9;
	Mon,  4 May 2026 08:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777882133;
	bh=hKJZI7B99bM+HBtBehq4SAoBPn8N4H1C+oq+hP8uFHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G+qlW/A3jSrxoGTEzY1TAkTXKGRPhcarx4izYOZDMbl4bv5MB/VSCAMkociF9ixJ5
	 4KbOU3ReUKUfA5weMADnCpMdjlyJqdIBePPubsMMzfiXBaWoucRjB0ZiEfki3dKp/e
	 de//n/yfzsJ2rD4CmsFRL+lgE/VPMYEVgjpq7FVGKDrc5MvtvU/X0rGZgKeZAVsbKf
	 4iP+LFr3e9GeJlbbBixmYi+wOjrFhxGZwxXwZmH2F+TNcX810KYnKyKZnAkaNTfdxP
	 7J8jGysMVMmbDK7mgXBe6ypCZmDUA+bSe1IZdIpqrVLmE9G7XUrh/DDVGGgdcwCcDE
	 5s6lhnd9R/AxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuan Zhaoming <yuanzm2@lenovo.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: mctp: fix don't require received header reserved bits to be zero
Date: Mon,  4 May 2026 04:08:48 -0400
Message-ID: <20260504080848.1870640-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050122-underrate-unequal-5308@gregkh>
References: <2026050122-underrate-unequal-5308@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0CE8C4B9ED1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242867-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url]

From: Yuan Zhaoming <yuanzm2@lenovo.com>

[ Upstream commit a663bac71a2f0b3ac6c373168ca57b2a6e6381aa ]

From the MCTP Base specification (DSP0236 v1.2.1), the first byte of
the MCTP header contains a 4 bit reserved field, and 4 bit version.

On our current receive path, we require those 4 reserved bits to be
zero, but the 9500-8i card is non-conformant, and may set these
reserved bits.

DSP0236 states that the reserved bits must be written as zero, and
ignored when read. While the device might not conform to the former,
we should accept these message to conform to the latter.

Relax our check on the MCTP version byte to allow non-zero bits in the
reserved field.

Fixes: 889b7da23abf ("mctp: Add initial routing framework")
Signed-off-by: Yuan Zhaoming <yuanzm2@lenovo.com>
Cc: stable@vger.kernel.org
Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>
Link: https://patch.msgid.link/20260417141340.5306-1-yuanzhaoming901030@126.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/mctp.h | 3 +++
 net/mctp/route.c   | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index 1eb1b4393e46b..6dbed4ca22205 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -26,6 +26,9 @@ struct mctp_hdr {
 #define MCTP_VER_MIN	1
 #define MCTP_VER_MAX	1
 
+/* Definitions for ver field */
+#define MCTP_HDR_VER_MASK	GENMASK(3, 0)
+
 /* Definitions for flags_seq_tag field */
 #define MCTP_HDR_FLAG_SOM	BIT(7)
 #define MCTP_HDR_FLAG_EOM	BIT(6)
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 59fbc54d8e66c..a565cf2bc7330 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -335,6 +335,7 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 	unsigned long f;
 	u8 tag, flags;
 	int rc;
+	u8 ver;
 
 	msk = NULL;
 	rc = -EINVAL;
@@ -357,7 +358,8 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 	mh = mctp_hdr(skb);
 	skb_pull(skb, sizeof(struct mctp_hdr));
 
-	if (mh->ver != 1)
+	ver = mh->ver & MCTP_HDR_VER_MASK;
+	if (ver < MCTP_VER_MIN || ver > MCTP_VER_MAX)
 		goto out;
 
 	flags = mh->flags_seq_tag & (MCTP_HDR_FLAG_SOM | MCTP_HDR_FLAG_EOM);
@@ -1124,6 +1126,7 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 	struct mctp_skb_cb *cb;
 	struct mctp_route *rt;
 	struct mctp_hdr *mh;
+	u8 ver;
 
 	rcu_read_lock();
 	mdev = __mctp_dev_get(dev);
@@ -1141,7 +1144,8 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 
 	/* We have enough for a header; decode and route */
 	mh = mctp_hdr(skb);
-	if (mh->ver < MCTP_VER_MIN || mh->ver > MCTP_VER_MAX)
+	ver = mh->ver & MCTP_HDR_VER_MASK;
+	if (ver < MCTP_VER_MIN || ver > MCTP_VER_MAX)
 		goto err_drop;
 
 	/* source must be valid unicast or null; drop reserved ranges and
-- 
2.53.0


