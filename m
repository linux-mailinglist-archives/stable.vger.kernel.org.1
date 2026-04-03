Return-Path: <stable+bounces-233245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOsVGWdI0Glu5gYAu9opvQ
	(envelope-from <stable+bounces-233245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 01:08:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F403E398EFB
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 01:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E9AB304C2C9
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 23:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5626438B7C4;
	Fri,  3 Apr 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da8e4PIV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF6538A29A
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257646; cv=none; b=Tyg0ZYg9llTMQiXrzSEtmWwO6NxKqBVW2NRx2wJo4yLpm/5sLwMOyLj3d8sJ2ii2TEYnt3QdwAFE9TQKC2yTV+EqyqdaDJJsRiLUNVb6CBXFc/xyxe5+Z1+oXRYzVuzVLXvfiH8Au5KPJ5olWIVHv68qpC9eVU+ZxGOJO91+YVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257646; c=relaxed/simple;
	bh=6XTjPc1Lb1fLIVViZE6tdIzfmgnICDpV2y3bO3Ij+cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diTnygOaJ8yZpgcPIy5flcBXofZjVGOTtae8AHIOhyGYIX9rzmG0dXoINdpcYpLSmZJoNH70Pu5c8VslB1llwiXmThq3Ue7HC/l7xnlUFd/wqPKxlshaUeVBW2x7GJxEiZ1teKkvuMrEFKluKKdDDS7vGMM/wUsFTohNBXlzO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da8e4PIV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so2116060f8f.3
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 16:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775257641; x=1775862441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOEofDb75q5DY4mpfrtmz9omvpmNusDfp4+owj8UO2I=;
        b=da8e4PIVnCwmwSTT/jl6K36s9yumduItM3wWLz2KwqoHEJ2K4Q0/gZBNbEMFfuBSYn
         ZKXRy0feNjWR/wXq5DncIeG/+94WeYDhgOgPwIPq34ZgkVT/9JLgfUiUnKJ+5AWqvXmm
         zJTNExZdGOGUF+Ef5RjpFk6TdquITTE0PV3dSmUptRY4uQouX3L//wEL/ghiUtkiLgtJ
         husDtx+n6XMq5id4VVVunWJXXaY0Aby4DlrFjOrYnd3gXzQ45z4xdNJP3UUuWGY4IihM
         NJaw/nJrLPynqtXm0b2arh9UA49sgA9yBr0EQdkrXqzxGxNoH0OO0vPkkQiMDZxPWHbW
         DQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257641; x=1775862441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOEofDb75q5DY4mpfrtmz9omvpmNusDfp4+owj8UO2I=;
        b=pRt2KrEe3P9rJq/gbJYW/rEYBYWe9d0kdSOV9bZpi02ZCeSwew0VUQsTWkyGSnneqB
         OnyX3tNFLGbrdNqCm5Yqb+5+t23eSvP+wja2019trqdmMk4daBE07pZAZTcbkQjGr4IC
         htSYi2mY/oLJ3vC88QtITryQ/Y86saP0BRhsuje1icDnNx4BYateSpGagxIJq5WqcnyX
         t7spE86C2uLaEfWtOsHIah/mqBSVZN2B6zPYHQfTdkXXJ/yonzN3CMLRyOIHVG2MKEGs
         0K6FFZv1SdY8txqPW7MStHNAo5r/n6B6100G8b1d0XhdEIifQKMn/8hP5zNtzogSOw9d
         9ebw==
X-Gm-Message-State: AOJu0YxqWvZP+Gy3V1HtjaAXx3fyVfFzE+vZjDtqpbAKXDDjcmWrI47w
	IQ32nMN/BEeL6tomCrNohhKMi4oAGRdIb9v46eBe8RISr71T/chF2ZjM
X-Gm-Gg: AeBDiesY9y7RmooZDNpFaYKYNtXWF/WEhA+q9TM0vXus8R9VsYya2uN3OHtMncvFZLy
	K56VyR28Ielkq5YhB8SH3LYaHq9oAEQfAEsOnqDY/Mdwf55uJVgbEv0IhTQ9Z4bx/VINDdawVWH
	Dc3zuEFVUWB7vhZsZ1+CsGgLGi35btc2yng5tAWk91p1lUnuO8gNM0kE/GzQ006AOYZqb01h5BW
	qe7ElPXjJ3FGze6QhnlD7zVbf8O3Tn9QhbalMbw2Oz7NO4NsvAi66QhCyeze8SvCaRfxzMsmQPc
	Tdart25JPYiAdmtcuO7wPEkEX3v6F2Xt2ViH5QtwLqMqh5ieKXTReGm2EeebcHX9+NFsAU3AoGg
	ZTsiM6qSQYFvdSsP8rljtlqKWaeitIUtVs8RAuvZTl+aki4PJJfGCuFtGj2mHdpU1u5Nwbi7627
	R3aZaI1YwmdLT1DBLCFgqj5xow0n//9Sg3x2AuvOLNSpuEyr+OFSsofHrARd3De0tqOzSUn7A5I
	vOrkvrXBQYE
X-Received: by 2002:a5d:588c:0:b0:43c:fbde:310f with SMTP id ffacd0b85a97d-43d292e40bfmr7213997f8f.36.1775257641423;
        Fri, 03 Apr 2026 16:07:21 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c60a2sm18830924f8f.10.2026.04.03.16.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:07:21 -0700 (PDT)
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
Subject: [PATCH v2 2/3] net: lan966x: fix page pool and resources leak in error paths
Date: Sat,  4 Apr 2026 00:07:13 +0100
Message-ID: <20260403230714.10667-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403230714.10667-1-devnexen@gmail.com>
References: <20260403230714.10667-1-devnexen@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233245-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F403E398EFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

lan966x_fdma_rx_alloc() creates a page pool but does not destroy it if
the subsequent fdma_alloc_coherent() call fails, leaking the pool and
leaving a dangling pointer in rx->page_pool.

Similarly, lan966x_fdma_init() frees the coherent DMA memory when
lan966x_fdma_tx_alloc() fails but does not destroy the page pool that
was successfully created by lan966x_fdma_rx_alloc(), leaking it.

Add the missing page_pool_destroy() calls in both error paths and
NULL-out rx->page_pool after destruction to avoid a dangling pointer.

Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 34bbcae2f068..b985ce64bb50 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -120,8 +120,11 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 		return PTR_ERR(rx->page_pool);
 
 	err = fdma_alloc_coherent(lan966x->dev, fdma);
-	if (err)
+	if (err) {
+		page_pool_destroy(rx->page_pool);
+		rx->page_pool = NULL;
 		return err;
+	}
 
 	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
 		       FDMA_DCB_STATUS_INTR);
@@ -958,6 +961,7 @@ int lan966x_fdma_init(struct lan966x *lan966x)
 	err = lan966x_fdma_tx_alloc(&lan966x->tx);
 	if (err) {
 		fdma_free_coherent(lan966x->dev, &lan966x->rx.fdma);
+		page_pool_destroy(lan966x->rx.page_pool);
 		return err;
 	}
 
-- 
2.53.0


