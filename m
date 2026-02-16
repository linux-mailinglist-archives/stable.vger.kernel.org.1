Return-Path: <stable+bounces-216748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFkDLEpok2mR4QEAu9opvQ
	(envelope-from <stable+bounces-216748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 19:56:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F014722D
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 19:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B7673002328
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FD42E7199;
	Mon, 16 Feb 2026 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=druschke.network header.i=@druschke.network header.b="ReqAmjEP";
	dkim=permerror (0-bit key) header.d=druschke.network header.i=@druschke.network header.b="wxhjL/ZF"
X-Original-To: stable@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0877275864;
	Mon, 16 Feb 2026 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771268165; cv=pass; b=gp7uXg2RxwZv1tdOD/jEwKgLkcTpjRkVgQM74p4QJw7ybf7NhtmXvzQK6Z0cGzOlwGLyawVY0X1Da5qr5DDePDsT1chjP0+xMONmNEtv4PtDR43T8EOcViZCetD1erEZegqs0xJVcbic0NlHpzS7um9FSLQNDUwjBLLyfKxZAXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771268165; c=relaxed/simple;
	bh=MoqrrdTdCgfhz0JAdfTcrLDLNaX/bjSLsbz4TKzx9Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nZhq9Hpr72cg+Tg08wuEOwcboZ143RRTtoYwjQ6xSrX6i1TRMCrgQaUzJpBcYPj1o37hYSl/rZhkVXXdUHdjxUNqcvRgSKe/GUMIE5oj4h0UdQu5AK2vFwdnN8zwJdmKKP7Rh1EqcdACApjCmzgM6R6tFYtg1HnW/y7/2wZ9+fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=druschke.network; spf=none smtp.mailfrom=druschke.network; dkim=pass (2048-bit key) header.d=druschke.network header.i=@druschke.network header.b=ReqAmjEP; dkim=permerror (0-bit key) header.d=druschke.network header.i=@druschke.network header.b=wxhjL/ZF; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=druschke.network
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=druschke.network
ARC-Seal: i=1; a=rsa-sha256; t=1771267972; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QkfzKodhF6kp/lVTAmTtlVXBUhD5MY/JKwfv86rq0DXGooh/zVQYRq8KA8QNpAH0lt
    GlXJoMwFvXF6y4gAHh9Z+jCzpBxqRFhicSBzrqqxr0Uk0a7fHl6vAwcJ+/mK/2PSEtHl
    1to8ggQ1XE8jK2HKhlUZR0AHF0fPx1B/0T4mLuJTxGXFotZPR2KaiJoVN7mrbTP8uJcS
    gdl0BMVcmqG5ikQ81pnZ/Q8FN9HXOn0lYL5CKVFVZHNJyApt6HXfHAIGYB2G33gSDM/h
    md052+kgu5hJfFoKllrytKv1xnpHBgiYLisHfw/V3AiogJuYP11wZEvjXaoEF8mMqyE9
    tbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1771267972;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=hHzEZychfsVx3Zo+eo1YiGtE3qM6pq4/bW2wMyVxz58=;
    b=ZYLf8HiW+uCFPDn9/Nf46YLJT+R/xaj0GNV4m95oEHY+Xzgtl76iYo510dbvkco9rA
    P0WCl0gN4qso2/6Y/0HjN4BulnWXM71g8lLrf8fAVNyZPcALnu5vmz9sUG4C+m7I6iy/
    6vhvQBZ9M7SxfQ1STkPjtVQVW3qJ+mo0q5zCnEupKuXXfhpzpuZ4zbbp/yjVTkj8tBXG
    KC6txINJ2Z8BTXEiXVzxe+UqIePdFR7ChwMUmLvCkZzgFOCibNYI00feQwnKATGKMMsQ
    9pXv5zBAuHoroiSVYsN+vYBU9ZmhSpdPfaYb7bTuK6n/M8UYleCqT+nK0FNlPVjKCfEO
    5AwQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1771267972;
    s=strato-dkim-0002; d=druschke.network;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=hHzEZychfsVx3Zo+eo1YiGtE3qM6pq4/bW2wMyVxz58=;
    b=ReqAmjEP7HjMd9+khpkKLPCWDluB6XvAdocaJETXMheZqu4VT5TwwkwX1ZN49PlffZ
    mlf5kuOHXTRS5Pputa/mxhmVzyZCpeHyyIL6iB7pj4ixT4pN8ZYJbbgams/4kCNCdiKw
    rlGHsK3DC1rosnXR9y3jjbjGXqKpU43LgmRAjgRJ2jZQ8FBwUN0tEIsq9tfvmxXYHALC
    c/ttpum+Y0jRPJ5gYSIZd2Usw33kvYavBfRk6YLTgbhXjivuZ/OqWY3RQkkev5xULtQM
    /zjfdBg5tmUiuLyOYwRIKL5B7CTlO2N/TdlLzsTyehpntJoVLYuZqgB6jiUJaidYQis1
    s3IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1771267972;
    s=strato-dkim-0003; d=druschke.network;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=hHzEZychfsVx3Zo+eo1YiGtE3qM6pq4/bW2wMyVxz58=;
    b=wxhjL/ZFa7/6AKPvUI+gI/5/qMvPXA/cuwwokJMuLSpHsh2C5YyGDN3lC5d3+RsiyW
    2bHWm/ANZoJ699BuGEBA==
X-RZG-AUTH: ":Km0GfEGmW/TiQgLaTjxkbEgAG+L5On5w0UduP9EjyAiQw4eBNNJkzESAcToIz07Lzclgwxlrml1byJxrK3V+pvZIfJs0SbsGJnZfF3u5"
Received: from toolbx.intranet.druschke.network
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id 39311421GIqpCjX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 16 Feb 2026 19:52:51 +0100 (CET)
From: Fabian Druschke <fabian@druschke.network>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fabian Druschke <fdruschke@outlook.com>
Subject: [PATCH] r8169: avoid OOM when allocating RX buffers
Date: Mon, 16 Feb 2026 19:52:45 +0100
Message-ID: <20260216185245.182450-1-fabian@druschke.network>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[druschke.network,reject];
	R_DKIM_ALLOW(-0.20)[druschke.network:s=strato-dkim-0002,druschke.network:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,outlook.com];
	TAGGED_FROM(0.00)[bounces-216748-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fabian@druschke.network,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[druschke.network:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email,druschke.network:mid,druschke.network:dkim]
X-Rspamd-Queue-Id: 561F014722D
X-Rspamd-Action: no action

From: Fabian Druschke <fdruschke@outlook.com>

r8169 allocates order-2 pages for RX buffers during rtl_open(). Under heavy
memory fragmentation this allocation may trigger the global OOM killer,
causing unrelated user processes to be killed.

Use a GFP mask that avoids OOM killer invocation so the allocation can fail
gracefully and rtl_open() returns -ENOMEM instead.

Cc: stable@vger.kernel.org
Signed-off-by: Fabian Druschke <fdruschke@outlook.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3507c2e28110..3525e889ec1c 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3952,7 +3952,8 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 	dma_addr_t mapping;
 	struct page *data;
 
-	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
+	gfp_t gfp = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+	data = alloc_pages_node(node, gfp, get_order(R8169_RX_BUF_SIZE));
 	if (!data)
 		return NULL;
 
-- 
2.52.0


