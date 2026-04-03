Return-Path: <stable+bounces-233246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPW4KEFI0Glu5gYAu9opvQ
	(envelope-from <stable+bounces-233246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 01:07:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C44398EE5
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 01:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E0D9300B9D5
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 23:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB3A38C2BD;
	Fri,  3 Apr 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln3CJhCC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389B338947A
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257646; cv=none; b=uvRYZ5PmRO0V/yX3J5p1NSlSb/wi09yhVrH0W//qefkJsjdjh+X3COa+26iOXDVrXaUtegDD4Kh6unPnWqdP3ihHzFiFzVDa3inj02RY9zuRSLbU+XiK+cluTPnTDwqRcScDAYASCdAoKp1MlywTIxadDru8hAMBsNNPqqLvOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257646; c=relaxed/simple;
	bh=kO50n60u5cKMLMq7RE6Byr6qxzOcZmTtOgxcHMgoYbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo2M2crHdqPlEL4VVCHC6tvmKY/Y3EngThrw8d1+hhQ+7U2VuFvCGYacWE2vZYKumrB6COIei/tGffkBrxLEM/PEp8/akuGFD4VcJ6ULMImpOw3Ychp22hHw+KvvTl6JF7RKmXbkCm3e8HySDO/g6+QMORZZH3yqdaEfPw0MqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln3CJhCC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so20071005e9.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 16:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775257642; x=1775862442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW4zLdxlBcXiJ8+qk/5YoKQ6P7XuOl6e7flfCk5XlwM=;
        b=ln3CJhCCKgk9pqt20DmevWCsSeNLu1Zy6CrgB855d0og+kmbm3JYEMOQDUPczGl3fR
         JR4oHIQ+zyE17zYEdQkCq6Ub8vFWUXCh6Kox64rGDMduNjorbdGZv2Obynv3gibmzJjO
         Wjyv2wHO9le0BG139R9RewEO8LE9DX1QuIIQSt3jexUL7vY+1OnCyCcxuyZeehV2KKpT
         o1kvk9z1NDQc9YUAheNTD3sAA99UEnet8h/NJZu5v/qFXz87TKBh+pbXecLrC0xWAPZ8
         xu+wON8SQG0mlh00Ql377COha1yv1kkydnVlQ2pKAXtCeGrH6+0nYkxlOoDrNOR4PnGu
         kpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257642; x=1775862442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LW4zLdxlBcXiJ8+qk/5YoKQ6P7XuOl6e7flfCk5XlwM=;
        b=fxckBNa7OF4vIJgL7jXFJAFrmDGSjmj8/0tBBJBY0J4SPIDMF4tl05+BRt6n0kBtKV
         Y1ACapuskGu0atK10OYww4a9jApffeBF+557/x2KIpCynHZKbQFCOI7xW+MG6QK+0Hl9
         htIuEy+gVVsolT+RBQlTiW8H6c3ZRGDM7miaRKrHuU+lMwB0b04Ebk4GFmoYViYW9cF7
         S5G8ZrhRYpzlpJKWbnxjzO2J08HgGwGnCl7Yuc3OsliZR1qhxXvsvGftpmQHqwA8vEgo
         r01F+WCRPPjPBJIsEMd9q92ZmJsJFWkl+tNTyszy487lUj5FNvJlDWsOBsfVvT/vv0tD
         19ng==
X-Gm-Message-State: AOJu0Yx2F90W5y0x32liAs+za8b/tIR0+4xVjQeyle4TBw3IUrQuNrVZ
	WZdla1RWTZYKyFgbSmdrSv3wgEcA43oYafvPcFGy2R7oUqJsUt2gwFyf
X-Gm-Gg: ATEYQzx0LJ9oNYJMFFug3RgsZUGT8AjsK8QBi+w3+Tkd6SIcoSmL5Sue//TBRshpv1K
	d1kodiW9X4B34A0cCx96XoKcKecwIbE0r1QUFY9ugr8gsAnsVEnOVFFognH+iHwYcmAHQNepIzm
	iFsusvZSvwY48dFXho3uUtfN0hNqoF4xn+grHk+Myj6C1++RoAY1yvpfqk2zOlL4nRElmYoRqF2
	vi8lpA56aJNYytU8OMef2QthQbfmKFG1n/+LhSEPmItEudTEhXpvPMsjnnXc/zoRn0PH/LISWBN
	H993+yRmQ4S4BWuIBEN3fkM1cApeMkKX0jHzswYz7e/d/7LFT78NBHCvY2uDrRWuAQkZxPLcmKw
	EqdMAMR+BfBo+FJ7uy0+K1khLMyCaVSb4YMaGug8yZdMelXKk8NvjA2zvTVV+45PszW0y+NiKus
	aC4Gd10+lSjbksFdeYscfPZlDSN5xkrYF6ACmnzUBu+EZ+Ms/sA1TbjMmGClpuufPmG2irbSCe4
	7qXOeFXw8Bf
X-Received: by 2002:a05:600c:1c11:b0:487:e2d:f649 with SMTP id 5b1f17b1804b1-488997c1c46mr62311855e9.26.1775257642481;
        Fri, 03 Apr 2026 16:07:22 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c60a2sm18830924f8f.10.2026.04.03.16.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:07:22 -0700 (PDT)
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
Subject: [PATCH v2 3/3] net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()
Date: Sat,  4 Apr 2026 00:07:14 +0100
Message-ID: <20260403230714.10667-3-devnexen@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233246-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69C44398EE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When lan966x_fdma_reload() fails to allocate new RX buffers, the restore
path restarts DMA using old descriptors whose pages were already freed
via lan966x_fdma_rx_free_pages(). Since page_pool_put_full_page() can
release pages back to the buddy allocator, the hardware may DMA into
memory now owned by other kernel subsystems.

Additionally, on the restore path, the newly created page pool (if
allocation partially succeeded) is overwritten without being destroyed,
leaking it.

Fix both issues by deferring the release of old pages until after the
new allocation succeeds. Save the old page array before the allocation
so old pages can be freed on the success path. On the failure path, the
old descriptors, pages and page pool are all still valid, making the
restore safe. Also ensure the restore path re-enables NAPI and wakes
the netdev, matching the success path.

Fixes: 89ba464fcf54 ("net: lan966x: refactor buffer reload function")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../ethernet/microchip/lan966x/lan966x_fdma.c | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index b985ce64bb50..fd6718a23676 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -814,9 +814,16 @@ static int lan966x_qsys_sw_status(struct lan966x *lan966x)
 
 static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 {
+	struct page *(*old_pages)[FDMA_RX_DCB_MAX_DBS];
 	struct page_pool *page_pool;
 	struct fdma fdma_rx_old;
-	int err;
+	int err, i, j;
+
+	old_pages = kmemdup(lan966x->rx.page, sizeof(lan966x->rx.page),
+			   GFP_KERNEL);
+
+	if (!old_pages)
+		return -ENOMEM;
 
 	/* Store these for later to free them */
 	memcpy(&fdma_rx_old, &lan966x->rx.fdma, sizeof(struct fdma));
@@ -827,7 +834,6 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	lan966x_fdma_stop_netdev(lan966x);
 
 	lan966x_fdma_rx_disable(&lan966x->rx);
-	lan966x_fdma_rx_free_pages(&lan966x->rx);
 	lan966x->rx.page_order = round_up(new_mtu, PAGE_SIZE) / PAGE_SIZE - 1;
 	lan966x->rx.max_mtu = new_mtu;
 	err = lan966x_fdma_rx_alloc(&lan966x->rx);
@@ -835,6 +841,11 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 		goto restore;
 	lan966x_fdma_rx_start(&lan966x->rx);
 
+	for (i = 0; i < fdma_rx_old.n_dcbs; ++i)
+		for (j = 0; j < fdma_rx_old.n_dbs; ++j)
+			page_pool_put_full_page(page_pool,
+						old_pages[i][j], false);
+
 	fdma_free_coherent(lan966x->dev, &fdma_rx_old);
 
 	page_pool_destroy(page_pool);
@@ -842,12 +853,17 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	lan966x_fdma_wakeup_netdev(lan966x);
 	napi_enable(&lan966x->napi);
 
-	return err;
+	kfree(old_pages);
+	return 0;
 restore:
 	lan966x->rx.page_pool = page_pool;
 	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
 	lan966x_fdma_rx_start(&lan966x->rx);
 
+	lan966x_fdma_wakeup_netdev(lan966x);
+	napi_enable(&lan966x->napi);
+
+	kfree(old_pages);
 	return err;
 }
 
-- 
2.53.0


