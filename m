Return-Path: <stable+bounces-233318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKB+FNn40Wm9RwcAu9opvQ
	(envelope-from <stable+bounces-233318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 07:53:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF14439D759
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 07:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C4B13018BF1
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 05:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483C536BCE2;
	Sun,  5 Apr 2026 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ/KsOGd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85E7369207
	for <stable@vger.kernel.org>; Sun,  5 Apr 2026 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775368369; cv=none; b=lM1KrmR5TjDwAx4GM1WLR+3UnC/FNqC4wTa6Na9O13HEdHVha77wPHWEPwnLemYq1zO8cpDh4mB2eAAPctBnUsKUFxqGY/y+OAigWfwIXtmNnL+GEhcYOq7wthKWCudORNNUwgpKzQTtJ0XarSa4KSfcE8Wx/Q0ljl6UhdG8Mao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775368369; c=relaxed/simple;
	bh=0tTTbC/ebQuK84WVTeLENCfRkHSaH8uFUAbuP1W5FdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqflyov/W791DYmOKdVp2pP0OkJHWcVMSJLD7TVW9Z/11VS2+LRfuYbTCxRyGPM4pFLR+Cgv5mZh6IQGqvGi2/oazMzj5Zv8F6A2N0HNTF4Tp5aAS7ndd+OwG9JBUEAgtT7WKfzzdrmbUGP1CpusgF0qyKgjBHGf6Jo5l0GGask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ/KsOGd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so30316945e9.1
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 22:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775368366; x=1775973166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7nMVD+VOcNWUuhtqvwltUnQm85Jrmb6cAMzCcy5HCI=;
        b=GZ/KsOGd41hD4c3HUTOhAwJATP8z7SYWev84NsPtekiKicIwETvw4yv3KjqijLEH5t
         MTH6+iViXXozluCaWxBqF/H0Iimx0EDH7S9wSYFvvDNJ9zWBduxkKOq4+KaE42IZsNTN
         wiU7aMAQDQB+KUIaAFljXeX1fnX4PHnsyZcQ/9IUE2br5gtidcNJkQiQxuahDTEavybS
         cGU5jW+CHi8mfcVpfT5WxaGZyVO787I6T8QOqCRWkcrMIUIGQ3qFD3vUo1bcklNNRhNY
         wWdv6ukY+0XJxgyglEpY/6X4oiBnFGpOq6nQCtzoVNzJT+nJjYaY3wiv9Smc593xVcQk
         qGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775368366; x=1775973166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e7nMVD+VOcNWUuhtqvwltUnQm85Jrmb6cAMzCcy5HCI=;
        b=o5C51GlmaKWTu9qherv7gXKIPDcJk6hteMvKR2AX6e6uFXZNy3hjgPC4qYJprkFy3c
         eoo8tWsTTtNr3PS+UZ8qQhdJTkA2eXQ1vtfdiOa6480DIrJbfuXsVwixW43beBRPlTM/
         cR0kgD803wCg+iRiEngovK7ZsTLvNTbUglUUONHhJj8Z//f+f5+wdsosRMvf3/GcWJiN
         q4P6ucQNvdXiJgGpHx2bvywD9HMVb15SgMG2yxmjiKN8ETRH7F95mms1Us88vCl/6Ii0
         Emth/rh0z9SAo4Xdq/Lf+T1fr1pGcV+vl2WniXCF92OxDNTU+UFXs5w8e/OQSdycaDLG
         KOng==
X-Gm-Message-State: AOJu0Ywz9UCHVVU5y97G1aayGYS1s8f8IalK4kfASX5TegzETkl6h//S
	j9dWnk6mZJ6CB+p8BpMqxvnZRW/RW/MDOFaZbCii0VQHuPeTwo+n2AeL
X-Gm-Gg: AeBDieuBKOEL47wRB/eqpabdpPIdRP0HtRwv/VtaCNYkHu2b5eL9ByuEoqKZYa1YL7s
	XGfieAsBS+LNNwX+0JbvOHPEeWLn9chJa5S4IT/XNZiqNqb7Jwj7NSJN6lve/P7tuOINfZqurLm
	zhbCTcpzsF3Uzh4sfxuy8AgT2JeUP7Fsmk+i443IISZmahOAdCxlHRG6fEr5HZXfiCrVVuRpn+L
	E+I2rKASXngWT9lzYOmoHVvQuIn3dey07R/w91dXwLIVLdz3WTB6Dc0u8qc+Ftj6E32F6edLyiT
	+Y3AwCoY18nyPrpMP4VJfK7AAs720IvvM6DA7Nv6gShD0fsm/6oN0XxQhV9H9tzj6C5XnJ+YE03
	ZtZBK9GGYtWZpDQk4HxCwp6G+ZxXdk2cXymeEH/oUl4u1/1pQ01A27rKJCT+AF74h56JbcXezWN
	dskBJOgnZIORLcm16WmxopKBCgiCrVPubeGwmXy/2dediXqiRf40IpscMxFByMzKO3pBRl/Qnv8
	qCQPJ1qGjS/
X-Received: by 2002:a05:600c:4f87:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488994a77b1mr117703095e9.12.1775368366063;
        Sat, 04 Apr 2026 22:52:46 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899e960a7sm55847465e9.27.2026.04.04.22.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 22:52:45 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net v3 v3 1/3] net: lan966x: fix page_pool error handling in lan966x_fdma_rx_alloc_page_pool()
Date: Sun,  5 Apr 2026 06:52:39 +0100
Message-ID: <20260405055241.35767-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405055241.35767-1-devnexen@gmail.com>
References: <20260405055241.35767-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233318-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF14439D759
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

page_pool_create() can return an ERR_PTR on failure. The return value
is used unconditionally in the loop that follows, passing the error
pointer through xdp_rxq_info_reg_mem_model() into page_pool_use_xdp_mem(),
which dereferences it, causing a kernel oops.

Add an IS_ERR check after page_pool_create() to return early on failure.

Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 7b6369e43451..74851c63e46a 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -91,6 +91,8 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 		pp_params.dma_dir = DMA_BIDIRECTIONAL;
 
 	rx->page_pool = page_pool_create(&pp_params);
+	if (unlikely(IS_ERR(rx->page_pool)))
+		return PTR_ERR(rx->page_pool);
 
 	for (int i = 0; i < lan966x->num_phys_ports; ++i) {
 		struct lan966x_port *port;
-- 
2.53.0


