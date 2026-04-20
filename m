Return-Path: <stable+bounces-239231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id im2OH1tW5mlQvAEAu9opvQ
	(envelope-from <stable+bounces-239231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:37:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B42942FBB4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9E0D31F0D6E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16DA342CB0;
	Mon, 20 Apr 2026 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz0otMsN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62131342524
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693600; cv=none; b=YboKXwOGej978QjMecQ+4UUSdyZPYmUlLOZ5JTJUcIs3rNRR94qcLnVQ0IEkBfebdH+St7J+LFOv8Q3blMgBlPYMdA3kSHTJfwHEL7TfKdk4FGslnOmGpzDW250Lk85JnqMP70lgne/Eh1tpGd40D8iH/hetYRPGg7c0mFNLuJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693600; c=relaxed/simple;
	bh=SrgFMyROmHNBLrFbCgp+FteKbeTypwiuhwV7d4eZYLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4N9NP9zaJTe9BY6q1Jkzyh3NOxejk4zquWl449mSi5fPm8ohnj0S55pi8+tF6r6eWqiViFIkaJcPpGkbYXEy707U3rNET8vN4YcozOyXAfb5fda9JmXKS1hE9d3Gm8TRKaDn2kePenzPnb5xbweLBJcIVQcwk0UAl5+wh3dJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz0otMsN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so27271555ad.2
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776693599; x=1777298399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtA7XaAsBped8tzDKGVHSMvp1WbWNwbAvXQ8vkybz/I=;
        b=Dz0otMsNBrkSCoftCpN6lgdJzZGySk2ML3Gi0iXbv4MCNDcOPEhpj+lzWWGNAlbTAI
         hL2n4lmaRlU3GmtU8jNskPwEi6F2ovaH+6OAqlm9wCNLSS9HWwbkGzzUOHvE2j9iNhsQ
         BR2EL2o/NDPHLoAax39Y6aqKBbvz7rymXPprPa4Y4gAFtnyI+VamwVwrYGzO4/Yi0O9v
         uAczbASKykuQQhrzoG024NKStsrgEOkJEUNcrMANQ7x/2PVMxLAOHKrnY/uYGW1tEnba
         B+7JrHXdFh2e6++zQpz9V54zoYVPhS1zuk73L4iSslChBoWx9nG07AJUvtONCg1LoVs3
         FfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693599; x=1777298399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtA7XaAsBped8tzDKGVHSMvp1WbWNwbAvXQ8vkybz/I=;
        b=klO0erRHl71eI4L/vEA4vY5ZDMbt9yDQFAnBHHIAxMidA5BAR2O31Y6AirqAavWROp
         ZiZd14UJFvtB9cP06qzhRnl1wDG6e5tR4By/nGFD2szruc5w/nFzA6FLFbjEGQu9O7JP
         S0mw02bAFmrqBWp5tlqEZwOV4yRY3yYp0d/J1hRxOHsH7Ay4afpnHH9BoFm01A0wl2Qt
         g8UzyUPAEkk7aQvc6sI6sSimIRV646iC22FhLAtnYMF1Dgrd5j4rSL4Vg/Y+mJkvGW6C
         XWR4ste3uFKktNIcTI6XmkqddEz/bTkdFZyfKzP/31iStmNqKos6wRf/pFCo2AdOXJam
         OOHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bw3ix9XhhUhscFxoGYfJP9Dc17NTnohUfdK1gt+I1uvW1s0nXSGYs4i4bAtXOsgHc1drndBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvX4q/nLPwowhRvp49wcMuMFw4tK/hlwDCnouVPbNZ0ux6QJaF
	punMqq2N7DVam/cMEXzpENBqv8wRf5vmKpG/X4I154+PSrusfeCnc7GEyVl/uXTd
X-Gm-Gg: AeBDieu1Fza1ZDTvFCnEVOmqzLwzV6nn6powhLlhfV30nt3zhVXMYMuCSrLGLoFgmLm
	J0d/Zbi0abqFhk1U8tTY5933RQK+lDTu/yGnp6BgmUs5kygwL6i1XtWBDqr7ImDxslpSzVb8PqH
	hsaeCyPC+8lL9FFPHo0QRlxPgYeKzbHunqFUT9+z9OoOBHG7aCvg16Y/65AAEQABgZoqvbyxsCI
	HNI+P75vwkJ0ZCOTiB4ptH172xD+MAvNUC5uVVSxP8nUqFuGPRIsUSijvVOF3lIdnTVJ5AiuAh/
	/fjBnJZhlwl6it9Fdkfom8q7qdtXqUBOZfdy88oczJzDd+pJdBry2Xn5nCb+jo92KhQgbmgBX4i
	9CjFKLLT8+/bnDdfiB94J7kOpvAlNBa9As2ZbRqmIsbVuHJ1hPv0234gP1fInB9pYmTG7CkIAVL
	0qKgRYE5oaQYxQdVslzPl3b+dNuoqssvcIKrHEsZPGH/PJEiJnZBDfkQTeG6uQoggPZQBMLatc
X-Received: by 2002:a17:902:ee84:b0:2b2:4697:78f4 with SMTP id d9443c01a7336-2b5f9fe094fmr113361365ad.31.1776693598648;
        Mon, 20 Apr 2026 06:59:58 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cd18sm112575965ad.45.2026.04.20.06.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:59:58 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: bhuvanchandra.dv@toradex.com,
	Frank.Li@nxp.com,
	peng.fan@nxp.com,
	sherry.sun@nxp.com,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH] serial: fsl_lpuart: fix rx buffer and DMA map leaks in start_rx_dma
Date: Mon, 20 Apr 2026 19:29:03 +0530
Message-Id: <20260420135903.2062024-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-239231-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B42942FBB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

lpuart_start_rx_dma() allocates sport->rx_ring.buf with kzalloc() and
then maps a scatterlist via dma_map_sg().  On three subsequent error
paths the function returns directly without releasing those resources:

  - when dma_map_sg() returns 0 (-EINVAL):
      ring->buf is leaked.
  - when dmaengine_slave_config() fails:
      ring->buf and the DMA mapping are leaked.
  - when dmaengine_prep_dma_cyclic() returns NULL:
      ring->buf and the DMA mapping are leaked.

The sole cleanup path, lpuart_dma_rx_free(), is only reached when
lpuart_dma_rx_use is set, and the caller lpuart_rx_dma_startup() clears
that flag on failure of lpuart_start_rx_dma().  So these resources are
permanently leaked on every failure in this function.  Repeated port
open/close or termios changes under error conditions will slowly consume
memory and leave stale streaming DMA mappings behind.

Fix it by introducing two error labels that unmap the scatterlist and
free the ring buffer as appropriate.  While here, replace the misleading
-EFAULT (bad userspace pointer) returned when dmaengine_prep_dma_cyclic()
fails with the more accurate -ENOMEM, matching how other dmaengine users
in the tree treat this failure.

No functional change on the success path.

Fixes: 5887ad43ee02 ("tty: serial: fsl_lpuart: Use cyclic DMA for Rx")
Cc: stable@vger.kernel.org

Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/tty/serial/fsl_lpuart.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f36d50fe056f..296a096be351 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1376,7 +1376,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 
 	if (!nent) {
 		dev_err(sport->port.dev, "DMA Rx mapping error\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free_buf;
 	}
 
 	dma_rx_sconfig.src_addr = lpuart_dma_datareg_addr(sport);
@@ -1388,7 +1389,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	if (ret < 0) {
 		dev_err(sport->port.dev,
 				"DMA Rx slave config failed, err = %d\n", ret);
-		return ret;
+		goto err_unmap_sg;
 	}
 
 	sport->dma_rx_desc = dmaengine_prep_dma_cyclic(chan,
@@ -1399,7 +1400,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 				 DMA_PREP_INTERRUPT);
 	if (!sport->dma_rx_desc) {
 		dev_err(sport->port.dev, "Cannot prepare cyclic DMA\n");
-		return -EFAULT;
+		ret = -ENOMEM;
+		goto err_unmap_sg;
 	}
 
 	sport->dma_rx_desc->callback = lpuart_dma_rx_complete;
@@ -1423,6 +1425,13 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	}
 
 	return 0;
+
+err_unmap_sg:
+	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
+err_free_buf:
+	kfree(ring->buf);
+	ring->buf = NULL;
+	return ret;
 }
 
 static void lpuart_dma_rx_free(struct uart_port *port)
-- 
2.25.1


