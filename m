Return-Path: <stable+bounces-238695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O0RAKi95Wl3ngEAu9opvQ
	(envelope-from <stable+bounces-238695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:46:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D5426F14
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E45300BCAC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 05:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392963803E5;
	Mon, 20 Apr 2026 05:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="GPajPADq"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C4A35A381;
	Mon, 20 Apr 2026 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776663818; cv=none; b=h1WwrfpRSJcqUkRctt9xkjLufEZWoFOdT8AgvIyrDv+WXsU3I8WXqTLwwxKEUcfofghEFatUxjEwxDivxbaNQCNxfIbK+uiGNwBZF9l6nX9Ze4lzxQEj5QA2h72gEn7uRBzR76IEdxeGYm0YMIbSALrZUapc23cpNMDBHKZfsGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776663818; c=relaxed/simple;
	bh=5IquD4tkjav+yz6CV8S9fLdCQgwSnSz1y85Sh16Wtyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eyk9roZP72ebm1ZV1/IFtNMeC1P9a7TuaCeTSIC6W46A2mIcFAKE2hAga79ft8s8qPiu+015JYTX9tuKDfmlP1zKLng5et53IkDBroTkbl4Wx4i35mBMLYzFErEh/ber5r89iVZ7XBZ7uKvCP69wSmfijLqlUrJd6q5bJuCuiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=GPajPADq; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=GPajPADqQXtPCs5vOa+qhpdRa9wpTx9tiKDThGbCR4SGEvxTvOXb1YEK5I0kJP0alhSjzl1I33Fe9
	 YX/xouBHU6pRu+mLPCTo3ZGCKXJMhu+OjOI0lTPGcmdE/+eLwTpi0UdnFT7HC0o0mE28ILjzwKZivy
	 xQ+Wm2PDBo2KVAtU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-32-12046 (RichMail) with SMTP id 2f0e69e5bcf8d81-01da7;
	Mon, 20 Apr 2026 13:43:24 +0800 (CST)
X-RM-TRANSID:2f0e69e5bcf8d81-01da7
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	heminhong@kylinos.cn
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	david.lebrun@uclouvain.be,
	netdev@vger.kernel.org,
	andrea.mayer@uniroma2.it
Subject: [PATCH 5.15.y] ipv6: add NULL checks for idev in SRv6 paths
Date: Mon, 20 Apr 2026 13:43:21 +0800
Message-Id: <20260420054321.3043814-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238695-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	NEURAL_SPAM(0.00)[0.961];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,139.com:mid,139.com:email,uniroma2.it:email,kylinos.cn:email]
X-Rspamd-Queue-Id: 517D5426F14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Minhong He <heminhong@kylinos.cn>

[ Upstream commit 06413793526251870e20402c39930804f14d59c0 ]

__in6_dev_get() can return NULL when the device has no IPv6 configuration
(e.g. MTU < IPV6_MIN_MTU or after NETDEV_UNREGISTER).

Add NULL checks for idev returned by __in6_dev_get() in both
seg6_hmac_validate_skb() and ipv6_srh_rcv() to prevent potential NULL
pointer dereferences.

Fixes: 1ababeba4a21 ("ipv6: implement dataplane support for rthdr type 4 (Segment Routing Header)")
Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
Signed-off-by: Minhong He <heminhong@kylinos.cn>
Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Link: https://patch.msgid.link/20260316073301.106643-1-heminhong@kylinos.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 net/ipv6/exthdrs.c   | 4 ++++
 net/ipv6/seg6_hmac.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 10772dab66bb..3d249c10e3e9 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -373,6 +373,10 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 	hdr = (struct ipv6_sr_hdr *)skb_transport_header(skb);
 
 	idev = __in6_dev_get(skb->dev);
+	if (!idev) {
+		kfree_skb(skb);
+		return -1;
+	}
 
 	accept_seg6 = net->ipv6.devconf_all->seg6_enabled;
 	if (accept_seg6 > idev->cnf.seg6_enabled)
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 7e3a85769932..68acff337e41 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -244,6 +244,8 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	struct inet6_dev *idev;
 
 	idev = __in6_dev_get(skb->dev);
+	if (!idev)
+		return false;
 
 	srh = (struct ipv6_sr_hdr *)skb_transport_header(skb);
 
-- 
2.34.1



