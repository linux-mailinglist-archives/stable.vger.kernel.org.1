Return-Path: <stable+bounces-259734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHd6FxKSHmodlAkAu9opvQ
	(envelope-from <stable+bounces-259734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 10:19:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B024262A65C
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 10:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8218430958D5
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB693ACF1C;
	Tue,  2 Jun 2026 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="VGYdeI/Q"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37931327A;
	Tue,  2 Jun 2026 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385687; cv=none; b=AFANHk+BAC7K41qnwnz8f5XVcQLlBx/hWUGschy8AP9p4v6qxU/gDVhh6WrXFUuaSOPgEYPLW2VbegAJmqoVdlPkFxBbKS+bODOotcZf6o0wHXsJXAuJaVaOqXGLIqff2Tz3AoCzm4nAlaoppB6kyZp8V37dpLRfgfETfS1ETPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385687; c=relaxed/simple;
	bh=M25O5urq0tLckl3VOjcFwzDpJe8HvKC3/S04qEK4v3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fMD6ct+hWMsCtoLf/3+58Cx+tb2iWz81VM54vx+T0w4emGL0DFkIF8O19PBGgLV7zYVqiRiFmf+e4qq9pgGr1hSDP10RzqUmZjDKo6BixccHAinsEZa1gI/1XpWHYwvaGsMUJAWsEbYUYWBa3ryYb+XpwPnL/DvaVizCzSrbtL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=VGYdeI/Q; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=VGYdeI/QdYblduoXeUwDTILw/ZCDY0bhyRMQw+5FJCctJk+71IFHFcIRbJ6mpNQ1qwiANOrJ/eruh
	 oSesOmDl2m/F0YYerIAzfPnTtyhMvYAaBPwhoBuq+uq6ydpM55nEFc+dltS4sF2I9uPNihpqbn73PF
	 Sc01YQOCln/eYrmo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-18-12021 (RichMail) with SMTP id 2ef56a1e877f2d3-022fc;
	Tue, 02 Jun 2026 15:34:30 +0800 (CST)
X-RM-TRANSID:2ef56a1e877f2d3-022fc
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	jk@codeconstruct.com.au
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	matt@codeconstruct.com.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 6.18.y] net: mctp: ensure our nlmsg responses are initialised
Date: Tue,  2 Jun 2026 15:34:28 +0800
Message-Id: <20260602073428.2865362-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL(3.50)[139.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259734-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,stable@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	NEURAL_SPAM(0.00)[0.889];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,139.com:mid,139.com:email,codeconstruct.com.au:email]
X-Rspamd-Queue-Id: B024262A65C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jeremy Kerr <jk@codeconstruct.com.au>

[ Upstream commit a6a9bc544b675d8b5180f2718ec985ad267b5cbf ]

Syed Faraz Abrar (@farazsth98) from Zellic, and Pumpkin (@u1f383) from
DEVCORE Research Team working with Trend Micro Zero Day Initiative
report that a RTM_GETNEIGH will return uninitalised data in the pad
bytes of the ndmsg data.

Ensure we're initialising the netlink data to zero, in the link, addr
and neigh response messages.

Fixes: 831119f88781 ("mctp: Add neighbour netlink interface")
Fixes: 06d2f4c583a7 ("mctp: Add netlink route management")
Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260209-dev-mctp-nlmsg-v1-1-f1e30c346a43@codeconstruct.com.au
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 net/mctp/device.c | 1 +
 net/mctp/neigh.c  | 1 +
 net/mctp/route.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 4d404edd7446..04c5570bacff 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -70,6 +70,7 @@ static int mctp_fill_addrinfo(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	hdr = nlmsg_data(nlh);
+	memset(hdr, 0, sizeof(*hdr));
 	hdr->ifa_family = AF_MCTP;
 	hdr->ifa_prefixlen = 0;
 	hdr->ifa_flags = 0;
diff --git a/net/mctp/neigh.c b/net/mctp/neigh.c
index 05b899f22d90..fc85f0e69301 100644
--- a/net/mctp/neigh.c
+++ b/net/mctp/neigh.c
@@ -218,6 +218,7 @@ static int mctp_fill_neigh(struct sk_buff *skb, u32 portid, u32 seq, int event,
 		return -EMSGSIZE;
 
 	hdr = nlmsg_data(nlh);
+	memset(hdr, 0, sizeof(*hdr));
 	hdr->ndm_family = AF_MCTP;
 	hdr->ndm_ifindex = dev->ifindex;
 	hdr->ndm_state = 0; // TODO other state bits?
diff --git a/net/mctp/route.c b/net/mctp/route.c
index d4fdaac8037a..eb817f1eb5c8 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -1650,6 +1650,7 @@ static int mctp_fill_rtinfo(struct sk_buff *skb, struct mctp_route *rt,
 		return -EMSGSIZE;
 
 	hdr = nlmsg_data(nlh);
+	memset(hdr, 0, sizeof(*hdr));
 	hdr->rtm_family = AF_MCTP;
 
 	/* we use the _len fields as a number of EIDs, rather than
-- 
2.34.1



