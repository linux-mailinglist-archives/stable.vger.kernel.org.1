Return-Path: <stable+bounces-260991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZZO8ETdDJWoxFQIAu9opvQ
	(envelope-from <stable+bounces-260991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:08:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A46CD64F58D
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:08:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="i/Xf/Th+";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260991-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260991-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A658E301FC8B
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89202E1EFC;
	Sun,  7 Jun 2026 10:08:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2771DE8AE;
	Sun,  7 Jun 2026 10:08:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826891; cv=none; b=XY55BU++wGqWwItQwoKsgYQdw/I2OHTA4bgi/g1Z2ql11/CEB5zw7tGDahzC7oHOlMXM6cFGU3tT2j8vR7s9nF7VqQr2iikNSpgc+JGmJTmKbnyAAkKFIavODLBYZVuUOudH/8jh/uAdZBER0Zqngjd1zyOf3oWKGMNg4ZppLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826891; c=relaxed/simple;
	bh=PFoCUWaYjgVnl8azmYs7RZaAm/y3dVsMngdyvzpnlOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWhVJU/YI117iHlomy+u/wgB6NnVKbtF44ID76h7ZpUbvYGhXKEethJxC0FkV4lVcTTiUuVYjNzjLoXI/yBgpMz2pScMNAaGVr+RvlDRkBhmEURwRPKgQYjrTjap8oRGFzLVT6oml1wXhtg47P+xxIuNHwmx08NWTmhNhJw+6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i/Xf/Th+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D281B1F00893;
	Sun,  7 Jun 2026 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826890;
	bh=SJNTW/w9m6sltcXGpVvWjlwNrj3AqwKIkP2yBUelgaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i/Xf/Th+QRN8d0hboYJHU7CEZLYQO1vqDNvsIWqj8vMT49Hi9IOjBX5tojgknYWQ7
	 qUK3lWvDHivUDq+6kMV95u6ygobCkQXaGkweZRvGKoMFqvUCTUc5uS4V2r4BwlYTeL
	 wW3Ob26jTWYOkuuTratwSouaOc3FvMJpPbkBMuZI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 020/315] tun: free page on short-frame rejection in tun_xdp_one()
Date: Sun,  7 Jun 2026 11:56:47 +0200
Message-ID: <20260607095728.235630824@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,asu.edu,gmail.com,oracle.com,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-260991-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:xmei5@asu.edu,m:bestswngs@gmail.com,m:dongli.zhang@oracle.com,m:willemb@google.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,asu.edu:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A46CD64F58D

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit f4feb1e20058e407cb00f45aff47f5b7e19a6bbf ]

tun_xdp_one() returns -EINVAL on a frame shorter than ETH_HLEN without
freeing the page that vhost_net_build_xdp() allocated for it.
tun_sendmsg() discards that -EINVAL and still returns total_len, so
vhost_tx_batch() takes the success path and never frees the page; each
short frame in a batch leaks one page-frag chunk.

A local process that can open /dev/net/tun and /dev/vhost-net can hit
this path: it attaches a tun/tap device as the vhost-net backend and
feeds TX descriptors whose length minus the virtio-net header is below
ETH_HLEN. Each kick leaks the page-frag chunks for that batch, and a
tight submission loop exhausts host memory and triggers an OOM panic.
Free the page before returning -EINVAL, matching the XDP-program error
path in the same function.

Fixes: 049584807f1d ("tun: add missing verification for short frame")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260520160020.375349-2-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tun.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 8192740357a09c..afba37965ce3b7 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2392,8 +2392,10 @@ static int tun_xdp_one(struct tun_struct *tun,
 	bool skb_xdp = false;
 	struct page *page;
 
-	if (unlikely(datasize < ETH_HLEN))
+	if (unlikely(datasize < ETH_HLEN)) {
+		put_page(virt_to_head_page(xdp->data));
 		return -EINVAL;
+	}
 
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
-- 
2.53.0




