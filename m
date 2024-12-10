Return-Path: <stable+bounces-100497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A549EBFAE
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 00:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3128C1649CF
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 23:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32F622C366;
	Tue, 10 Dec 2024 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNRmbKM0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD661EE7BE
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875084; cv=none; b=CrPFHLscGjzvM8iFla17kIkZIw9hrS2YrbEvxsBrgPm29G60VtCrbraERGWNDSltJf12+dxyCHr4ztbSHxrNgqZd9yzHD47SfZj2zqVvosHqQvGtJbpywMIYPr63ph7RNWyIdm/MjpjojkchuNSNRzlbkZZ/qBexrlTE+T5Vvqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875084; c=relaxed/simple;
	bh=tqi1p481EfAMKfpVHgNxcyotwGGdjeQLH5O3ztzJ89I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TeaYwdVfKZChTxssqMQHZcFl/kwds1nspMi4YPNWMlUveaEAhNr3wkOwwsgZwD5Bzv0RRVVo6pxkFumFsTaao9NZuRavIfsv0C/CBVmAFkY9eo7yj582MEjOb3Kg1uTYHfxMg2ChNtiBBsT6zDGD5lJWdz6vm9mDAV5Al3By7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNRmbKM0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2162259a5dcso59980505ad.3
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 15:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733875082; x=1734479882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z8c9o7vnCPF/JxiZeI4R1FPJGEXodP+y9ktpIlNTf9s=;
        b=WNRmbKM0OlHXQPwkGUxB689Ptkn41ylgPOl2Wij55YqZBJA7bZx5A5Nxidse8YmZTR
         QK2gVTPH6uNpSZMBhDJ+OIlwioWL9oCdZLcO34fUWbYD8qzeiY9eUr2Tb0gPh+sXjAvC
         O3YnPe7r8hnzDBj3Q3TxoUq8l/w18tRoOKaKB/wcKeRLoaHpPAf1u/xH+C8F48igzVIh
         oa3gOcTkdzdxCDqhYKSbxpJFzrEQtcEoc3GGslFPTNHqYYMUbnKyZbNQVWXR4FxBQ+Vn
         IjuqgKt/RyetmFbiSeQyUaNDDJtSpTZUObqshXPzG31F8KXBG+H9mgAnO50X25Ctrg15
         SsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733875082; x=1734479882;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8c9o7vnCPF/JxiZeI4R1FPJGEXodP+y9ktpIlNTf9s=;
        b=PVrfvEkP0mWxO4xJRfS+8T+Sf12Kg5YlAmv3dPFe4xSB5MlApjcx/QnCngQyrWfRAJ
         q/9xtZcuguefBmNIwFN/gQORHc87nLWJ943g45JIAyJOGtqfAENopDXXCmfypCr1YCnB
         hZaJPZ8+xxICRey7M9gDjsHOj2EnLr3K2CLhgKRPsp83yPzBln0lP13CwK02LYzNic20
         /Zo1Rx2AXaeke1iVQtnIKupEl9Cy2dxhS9uRk0lJp9N5kWn54INphsw/n3LAyyPdBmAA
         Nwd5/vVGoaNn8oDiXB4U9QgYD1T00A5ViJvIny/yr09xhOKwQVPJKJFoFwO8WDjdPtLy
         Dp3A==
X-Gm-Message-State: AOJu0YyqYAUM4ezchTXnrncQfbv38aFv4Ke6F1fpDm2B0aL2xlP48tX3
	T83E4BH9YLz/lm7iwnm62ld7q3QJvA2ceaFU1i9+HcooK5W5hxXbhL9qAAMbXdEvKLvJJ0LiKf3
	qRBduvMbFALsIfmxDoy8Mxq4ZNSTn06USgFSX0QpAu7ahi/AkNIPQ0z9UgMmWD1PF6kpSpnLpYJ
	fHsFnH/4XZkqEwim6FDLTGuNMHN7+Fkv5G9VR90Een4fgC56d5
X-Google-Smtp-Source: AGHT+IE7rE41oArNZFs72PiIrQkaL3pbY78cl6zSladIqwe9ecDJVQGs4HlN8SbkaJFEu5+JUG7tbOlDcemKaD0=
X-Received: from plfz16.prod.google.com ([2002:a17:902:d550:b0:216:4f2a:7172])
 (user=ziweixiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d2ce:b0:216:6ef9:621 with SMTP id d9443c01a7336-2177853566cmr14958945ad.31.1733875082230;
 Tue, 10 Dec 2024 15:58:02 -0800 (PST)
Date: Tue, 10 Dec 2024 23:57:58 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210235758.637910-1-ziweixiao@google.com>
Subject: [PATCH 6.1 v2] gve: Fixes for napi_poll when budget is 0
From: Ziwei Xiao <ziweixiao@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, pkaligineedi@google.com, 
	hramamurthy@google.com, ziweixiao@google.com
Content-Type: text/plain; charset="UTF-8"

Netpoll will explicitly pass the polling call with a budget of 0 to
indicate it's clearing the Tx path only. For the gve_rx_poll and
gve_xdp_poll, they were mistakenly taking the 0 budget as the indication
to do all the work. Add check to avoid the rx path and xdp path being
called when budget is 0. And also avoid napi_complete_done being called
when budget is 0 for netpoll.

The original fix was merged here:
https://lore.kernel.org/r/20231114004144.2022268-1-ziweixiao@google.com
Resend it since the original one was not cleanly applied to 6.1 kernel.

commit 278a370c1766 ("gve: Fixes for napi_poll when budget is 0")

Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
---
 Changes in v2:
 * Add the original git commit id
---
 drivers/net/ethernet/google/gve/gve_main.c | 7 +++++++
 drivers/net/ethernet/google/gve/gve_rx.c   | 4 ----
 drivers/net/ethernet/google/gve/gve_tx.c   | 4 ----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index d3f6ad586ba1..8771ccfc69b4 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -202,6 +202,10 @@ static int gve_napi_poll(struct napi_struct *napi, int budget)
 
 	if (block->tx)
 		reschedule |= gve_tx_poll(block, budget);
+
+	if (!budget)
+		return 0;
+
 	if (block->rx) {
 		work_done = gve_rx_poll(block, budget);
 		reschedule |= work_done == budget;
@@ -242,6 +246,9 @@ static int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 	if (block->tx)
 		reschedule |= gve_tx_poll_dqo(block, /*do_clean=*/true);
 
+	if (!budget)
+		return 0;
+
 	if (block->rx) {
 		work_done = gve_rx_poll_dqo(block, budget);
 		reschedule |= work_done == budget;
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 021bbf308d68..639eb6848c7d 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -778,10 +778,6 @@ int gve_rx_poll(struct gve_notify_block *block, int budget)
 
 	feat = block->napi.dev->features;
 
-	/* If budget is 0, do all the work */
-	if (budget == 0)
-		budget = INT_MAX;
-
 	if (budget > 0)
 		work_done = gve_clean_rx_done(rx, budget, feat);
 
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 5e11b8236754..bf1ac0d1dc6f 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -725,10 +725,6 @@ bool gve_tx_poll(struct gve_notify_block *block, int budget)
 	u32 nic_done;
 	u32 to_do;
 
-	/* If budget is 0, do all the work */
-	if (budget == 0)
-		budget = INT_MAX;
-
 	/* In TX path, it may try to clean completed pkts in order to xmit,
 	 * to avoid cleaning conflict, use spin_lock(), it yields better
 	 * concurrency between xmit/clean than netif's lock.
-- 
2.47.0.338.g60cca15819-goog


