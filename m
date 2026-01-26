Return-Path: <stable+bounces-211660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNLDKFmhd2kCjQEAu9opvQ
	(envelope-from <stable+bounces-211660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:16:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3F58B5CE
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 104D2300B12C
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33C33A9D1;
	Mon, 26 Jan 2026 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk0ZESLa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941733C197
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447699; cv=none; b=WCbN2cDBtIEdapZTysUEaj0qdQJcn2iYhFoIJdKjJT+L9v7Yf4V67u2sZKfdEW6mZvGgCWYAvQ0HPnPLZcy7Kzx4cfCOiARLIz0fvoa4SNySriGgWkwpxcHfDIsFKraG4i/dvL/ChUfjMod2nw+YqzD9FBzTtFCP3xIO5763MNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447699; c=relaxed/simple;
	bh=m7gtpX6JlLNBi33iHKaUJijwhNaqEtEM+3TbX6tlFCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDC8A/yDjwT6xZ3/R8b0v2OdWVQNe+oPlFNeLcjc7r8VIloU3R6C9sTg6wVuYH3IFKdTakzZXMXeSO4cyckRisc/xspczQ/WmlWo/Zdm47+SNhLvMMGBF1TF5adVge2UKuOoKY19WsLQmwBBYaRWjGdk4x+wKFXakq0aOk3D5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk0ZESLa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso48090625e9.2
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 09:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769447696; x=1770052496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHXVzDDBmvnIJ3lzKbW0IxNth1KaCaSoyXj6yfLdil0=;
        b=Zk0ZESLaWO2nm1K9H7nQYEE7hCZCu0CSw0aqdObwypvMmsOkIy5xxvEiY0LgIGxFnk
         cgpe5ayLD97dLwvsaVsqIl8Ye3U/S9WYXFPbd259yjVtLAz3nGta7e/kRRDmv370SUVf
         uBz3yw6I1Z+2QkN1HoFYz4AMCR0SK1QuvDV6Ck1o/62D5k+O8TLbNPBL/VFJlwUAowvo
         72YURjduAMfBCH1ghNAgELLItizw3BTcPHA3SR5JwBuhZB8pUJL/9C0TrqA5pViIMVuG
         pZJnBg+wupLmdOXphyI4scH04DNFatLOmFsogGqWE/PKLRz3dmRhMKG68BbXmKjeMNCE
         YfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769447696; x=1770052496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SHXVzDDBmvnIJ3lzKbW0IxNth1KaCaSoyXj6yfLdil0=;
        b=Vb3por+wTOlrIDTaNHg4sMKvmiTyilgTIHxcNaU7yBMG+cv9c8pnoJSTJfT6taAkAu
         iyh34jrDWvY901amRaD/SpkzG2r8FfNC7eJ6ls4Uf8/fQoIDhB1/KS7ltTZNhV8d7Hyq
         6q9QzXqDRypVFlEWZwl3bfLjdBQtSkAfl7HGVY1QS0W4q1Tu7Z6WuyMeopTjuUYgJGDj
         oF5f3HSGAjPEhghSQS4N+4iE9lSH+Af5zSFpC6rVQWD9s7/sdIYw2THmidKOVajgn/6g
         9fRUmkBrCR4CzOOEs5O92h0ZB7Ezor4rZ+X3Mv0m0hLktEVjgd7otkNYa1dj9kBa5WyN
         rSsA==
X-Forwarded-Encrypted: i=1; AJvYcCX5F8Cj0fyabHVlt+DurvGMTqL6d9rb+XCV+tSwwz9v0GMMjgjUJuP0f6KRCI0rQvMMmlEkMq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2cb3t5cLkK6Hj1I8lfdmBEEKWj1S7rWbjzpZH+wQlYVt9Yvt
	5Z4qOBY5m0Cidyj6UFX3SGNnEsEpRrBFPCgekgb1St5sGKH6ow64pWQ=
X-Gm-Gg: AZuq6aLn731z2JwHQ3XNUG1QL0W7xTk9miTrYbmiDq6dfFpMy7WbRShwdzrGxEEzb0q
	iOTFSHpAJDgGn2NFW20KybAGDKVjkO+AJXWNeqMf4lK0h8Sz5MyTgcabP1nQo5bR78I5v92sWMJ
	e/fZGjWhD09sJaFkvgGaWOdpc7hit9lvXVZXK7bkD6tI9I0N6Nh1VhRW8h3c2FtIyEr2q/08GqE
	G0Yh7eWu/ZqFSsp/0QLmfMJ53qDQ25f4dSTg5eBik7nH0eLSPLKgkJ+C46QAr5btYObMQ0OtPe0
	FOTuqtlFtGn20zXlobVuCBDFFBJIXjhz5clDdE3X048THpuSj/Zgf95GJRXk/oJ0U2ErQX8LjRP
	0JiJXVvhJxD08SJq53/qPkRn3/SkCrHNMTfQpfhE/fmUY3vcDdWYGg7o13Wg/MvkSz2W3nu3gEp
	NeBur+
X-Received: by 2002:a05:600c:5395:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-4805cd40961mr78662845e9.7.1769447695886;
        Mon, 26 Jan 2026 09:14:55 -0800 (PST)
Received: from localhost ([2a02:169:c21a:1:5aa8:4ea4:a58b:fc48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066aaf30esm3136815e9.0.2026.01.26.09.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:14:55 -0800 (PST)
From: Tomas Hlavacek <tmshlvck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Yixun Lan <dlan@kernel.org>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Tomas Hlavacek <tmshlvck@gmail.com>
Subject: [PATCH net v2] net: spacemit: k1-emac: program frame size registers for jumbo frames
Date: Mon, 26 Jan 2026 18:14:49 +0100
Message-ID: <20260126171449.83288-1-tmshlvck@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126135919.77168-1-tmshlvck@gmail.com>
References: <20260126135919.77168-1-tmshlvck@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,lists.linux.dev,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,iscas.ac.cn,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-211660-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tmshlvck@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F3F58B5CE
X-Rspamd-Action: no action

The driver allows changing MTU up to 4K via emac_change_mtu() and
allocates appropriately sized DMA buffers, but it never programs the
MAC_MAXIMUM_FRAME_SIZE and MAC_RECEIVE_JABBER_SIZE registers.

This causes the MAC hardware to reject frames larger than the default
1518 bytes, even when larger buffers are allocated. Frames exceeding
the default size trigger jabber errors and are discarded.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Cc: stable@vger.kernel.org
Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>
---
v2: Added Fixes tag and Cc stable.

 drivers/net/ethernet/spacemit/k1_emac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 220eb5ce7583..31b1bdb2827e 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -228,6 +228,12 @@ static void emac_init_hw(struct emac_priv *priv)
 		DEFAULT_TX_THRESHOLD);
 	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
 
+	/* Set maximum frame size and jabber size based on configured buffer
+	 * size.
+	 */
+	emac_wr(priv, MAC_MAXIMUM_FRAME_SIZE, priv->dma_buf_sz);
+	emac_wr(priv, MAC_RECEIVE_JABBER_SIZE, priv->dma_buf_sz);
+
 	/* Configure flow control (enabled in emac_adjust_link() later) */
 	emac_set_mac_addr_reg(priv, fc_dest_addr, MAC_FC_SOURCE_ADDRESS_HIGH);
 	emac_wr(priv, MAC_FC_PAUSE_HIGH_THRESHOLD, DEFAULT_FC_FIFO_HIGH);
-- 
2.52.0


