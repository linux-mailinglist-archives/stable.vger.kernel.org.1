Return-Path: <stable+bounces-242394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE+KNnmY9GnTCgIAu9opvQ
	(envelope-from <stable+bounces-242394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:11:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1394AC43A
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3717A30173BD
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D974039E6C9;
	Fri,  1 May 2026 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rTgFmT6u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8B350D7D
	for <stable@vger.kernel.org>; Fri,  1 May 2026 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777637493; cv=none; b=P4vhWTDpDRDmwOmMBuZM4cEcJSWOtG6Zg3Tuam42Edd2M4fKN8aXGZT08x+dx1hjEw3mcE/m9HcIwzD5u/SnKNB6yWQRn/qNwxFFjIHLC2TVp81YqUXNGr8DLkOO4BdzKZ7DnlaMmtOzrutZZVSC3kH1DUXJAPOSlXJZh0feyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777637493; c=relaxed/simple;
	bh=mhBdp86ps1QqeyiDvjUHH2JIOSFEPGiC+LfHs9VKAHY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d55/Hj2lj4mnHsQLOUJI/XrLLG+nXMWWssQ3DWPxOn8nzYGmQheoOoe0vKRpwU/RYC5mm4UyVU3TUmO58aqAwr7vmcSD1L3q9xMn0vde0YH40rsfUc6NAYnU+UcyKybs0bIvaZquy/zrFi9JzD+kh0CgRLieXRp8I2PcLMMZBkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rTgFmT6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D41FC2BCB4;
	Fri,  1 May 2026 12:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777637493;
	bh=mhBdp86ps1QqeyiDvjUHH2JIOSFEPGiC+LfHs9VKAHY=;
	h=Subject:To:Cc:From:Date:From;
	b=rTgFmT6uRX2p/qQBnrlkSoUJSRIydJIH6IW83mSsqHTGPtktRdjuGtDg0ietvl6j7
	 VsYoOuGnigb/NxpXRihH5O5g3h2/YztLQBSZuE+Bnc77V+rqY/h74Y1XYeuocT5ZLk
	 6ZNek//tCPMSypITBshlEyBL+tsT/YTl9xVn+RHk=
Subject: FAILED: patch "[PATCH] net: mctp: fix don't require received header reserved bits to" failed to apply to 6.1-stable tree
To: yuanzm2@lenovo.com,jk@codeconstruct.com.au,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 14:11:23 +0200
Message-ID: <2026050123-extent-rosy-a476@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E1394AC43A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242394-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,msgid.link:url,codeconstruct.com.au:email,gregkh:email,lenovo.com:email]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a663bac71a2f0b3ac6c373168ca57b2a6e6381aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050123-extent-rosy-a476@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a663bac71a2f0b3ac6c373168ca57b2a6e6381aa Mon Sep 17 00:00:00 2001
From: Yuan Zhaoming <yuanzm2@lenovo.com>
Date: Fri, 17 Apr 2026 22:13:40 +0800
Subject: [PATCH] net: mctp: fix don't require received header reserved bits to
 be zero

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

diff --git a/include/net/mctp.h b/include/net/mctp.h
index e1e0a69afdce..d8bf9074110d 100644
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
index 26fb8c6bbad2..1f3dccbb7aed 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -441,6 +441,7 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 	unsigned long f;
 	u8 tag, flags;
 	int rc;
+	u8 ver;
 
 	msk = NULL;
 	rc = -EINVAL;
@@ -467,7 +468,8 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 	netid = mctp_cb(skb)->net;
 	skb_pull(skb, sizeof(struct mctp_hdr));
 
-	if (mh->ver != 1)
+	ver = mh->ver & MCTP_HDR_VER_MASK;
+	if (ver < MCTP_VER_MIN || ver > MCTP_VER_MAX)
 		goto out;
 
 	flags = mh->flags_seq_tag & (MCTP_HDR_FLAG_SOM | MCTP_HDR_FLAG_EOM);
@@ -1317,6 +1319,7 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 	struct mctp_dst dst;
 	struct mctp_hdr *mh;
 	int rc;
+	u8 ver;
 
 	rcu_read_lock();
 	mdev = __mctp_dev_get(dev);
@@ -1334,7 +1337,8 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 
 	/* We have enough for a header; decode and route */
 	mh = mctp_hdr(skb);
-	if (mh->ver < MCTP_VER_MIN || mh->ver > MCTP_VER_MAX)
+	ver = mh->ver & MCTP_HDR_VER_MASK;
+	if (ver < MCTP_VER_MIN || ver > MCTP_VER_MAX)
 		goto err_drop;
 
 	/* source must be valid unicast or null; drop reserved ranges and


