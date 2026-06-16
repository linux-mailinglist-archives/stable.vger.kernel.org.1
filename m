Return-Path: <stable+bounces-266224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EhjKL+6YMWo2nwUAu9opvQ
	(envelope-from <stable+bounces-266224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:41:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F78694581
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:41:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Yj8TG3Ds;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266224-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266224-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5F3730067A6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE144418D7;
	Tue, 16 Jun 2026 18:41:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90413777E;
	Tue, 16 Jun 2026 18:41:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635306; cv=none; b=QIlPXiOxCv/+ojJ9czUwExZC67m5/CIT0XmdOrCJq5oaHM57h1PhSeqvxuf9oeJDAk/70dW8Or1oGsHdV9sQc1xsTlSx9lAI5Cw1BCZh173K44rW950lQ6QOxn+JVtxicEMAAYWArSR6T+PngQ33/At+AqeBaxtTWicaBAR2dHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635306; c=relaxed/simple;
	bh=eXEBugUleZp2jyjjC87kxX5Xtcr2yq82fduKNbrRX3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWmHzDxaAI1OgAC+iYeNuDyh6YuyCvPfK4zksIF7v61pvFjYAoj4IZ/EqGYoz6lwgaNNrze35czvTw7ln5R9oRQDNDQWXEgTrgxWp3mzHhRSrpNbisclEwBB50I+8KE5m0v+IEIyaCQuVd4k1y1bFGfKPit8SSfR5vAYGsaV08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yj8TG3Ds; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429491F000E9;
	Tue, 16 Jun 2026 18:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635305;
	bh=KPuInXZVIHR5vms47uY25HZoMJMMGetC4m6Nxh9oQ8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yj8TG3DssoPluXNDgYs/jwpG7jQ6LftOTatAtwzQYj6HyT2rdKWojKnTKYEm6+bsF
	 Rxo0HG5TrktI3IS/39LPv4t5lU2HwyZ3IInZqDgIqloQMbdpZQrb4xVRnNrPym5XKQ
	 2G3uOJpe4/LFG1NE1jpsT4y1hyQMZyAHi95I/CtA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 024/342] Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()
Date: Tue, 16 Jun 2026 20:25:20 +0530
Message-ID: <20260616145049.385337510@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266224-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:zhaodongdong@kylinos.cn,m:luiz.von.dentz@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,intel.com:email,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57F78694581

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

[ Upstream commit 3c40d381ce04f9575a5d8b542898183c3b4b38dc ]

The skb_clone() function can return NULL if memory allocation fails.
send_mcast_pkt() calls skb_clone() without checking the return value, which
can lead to a NULL pointer dereference in send_pkt() when it dereferences
skb->data.
Add a NULL check after skb_clone() and skip the peer if the clone fails.

Fixes: 18722c247023 ("Bluetooth: Enable 6LoWPAN support for BT LE devices")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/6lowpan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 9486d66863264f..4ab9a31163b8b9 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -514,6 +514,8 @@ static int send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 			int ret;
 
 			local_skb = skb_clone(skb, GFP_ATOMIC);
+			if (!local_skb)
+				continue;
 
 			BT_DBG("xmit %s to %pMR type %d IP %pI6c chan %p",
 			       netdev->name,
-- 
2.53.0




