Return-Path: <stable+bounces-100498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FED9EBFB8
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 00:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6293818889B1
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 23:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE9122C367;
	Tue, 10 Dec 2024 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjWOMC37"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DA1EE7BE
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875159; cv=none; b=RZ1E727ek/fj3sT6Xp0cxlxO8TXwGUVQtf0W9O7+TrcOd73G9bEFwZ8dNcQOFly6usIvZQ87UCdwqYPZXZbo/akRI11Q0BG+xUQk9TdLL9+KDbMCgKDjShMN0wAWXOwjY0Fi6APgFHpkwGVWFLfLyDu1pTUzNlfkPWW4gEHInHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875159; c=relaxed/simple;
	bh=D2mvNCae4cgHcdaBqQq6ncdcXOxmmKe8udDIp6B/JZA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p2smbQYkzd7mhBfZf1moosTtuXkviEXqPdPbGNmAlGRoNwkXBkq9Ry0CU3ZOKwZ7ZCWihrxquYvVSmoBhKshIizWLjo3ZnF9QFKkGSNCWmVy4iRt6lezbO8fSeV6JsLuTx3dMtYBvK5/o5I4a4BuPPNCakqZy66jfNLl3d0yc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjWOMC37; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725efa0c796so147467b3a.0
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 15:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733875157; x=1734479957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EC7UMk2mXGP5d6GuCLRUNYfyK3sHZW7AU9Ybt2eEFiU=;
        b=LjWOMC37XAefF7f9S1PUmP/7pf8uGnzJ6Q2R9ILpqOxVGu3L0qqXmuJlp8tNvzbtNy
         LLcfRzvDTcwlu4+rdi0GcYAVaRSfc2sts1vmxOPkBNpC1FMjunSLqmMO7knpnJ8KZXB2
         AQFfrdoiPirTRUUzW2qTkAi4uWJmzqjzX6WEXxQNDestWW+/K/uRRgeB6DKPujGD03i4
         ktotXfkWEXQdQOqv9AMWm+P6KifGevol+spAfJGVzx/gHk8e8F2gAhNU3UObUUy9svkd
         h7wlvjmv/OdBPQswqzP70LNszmejVgMWK1tbaE3V5auZnYKH/XHrdE7l7OGFl8D8xojs
         FRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733875157; x=1734479957;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EC7UMk2mXGP5d6GuCLRUNYfyK3sHZW7AU9Ybt2eEFiU=;
        b=nk8coiUab9ajN+lSdGrNW1YRNdK4c5yZveJP+eGjcbci07k85McQ+b03KSA1vsUcKb
         OAd/uRCLNK7v3Su7XFRkgpWhNGKsXU3aHvMelPOvfMbr/6zxkuBbp7TlcB7kWCTwJqK4
         11MeXuDdXTPPWHoJmUBWtFykGOuG76FjDKRc/9Wa5PmGcwr8uW9KhVek0Tj9rLsBEt4E
         DZpxrtpBgJr6pr7/lGeBlDS/fe0sxaSl/pKWLAzGuwTnp2232anQQ+XqVI2cBGufVFMv
         7nlquRmoOpQ2KtvxC2Ie7WlfV3ksaXDuQC8APlaHW3DV5O47v498OBF/RcH2vXf2QMtG
         ydhA==
X-Gm-Message-State: AOJu0YwQSRMwoWrrJv68unbvBqZv7qY4YPwC3wamXhbA/Be4GQ5RXxDb
	YzkEf6q3wWBgwRK46XH2hTH+XYpImU+55+XPMP7Zj6YARols2vFLStX3d8H/gR1BHRvAkfcpXso
	KKTcA+ed2d/T0N/Am52c/c8887oitY7wMtfpj0jfE5qrrjbJehYOze3Fi68binsNIR5XeIV0Mrj
	t3oEmTJTVgfwzR79ZfW722PSYQGRcW4Wv0rsLklBhgDadKfOzB
X-Google-Smtp-Source: AGHT+IHpjBX2N03HBbk+qcatAancLewSOl0PcCopsgGOB4esgMJp3Atpd+m+IQghpxsFiyIp0wLQb52cfei2/Y8=
X-Received: from pfar6.prod.google.com ([2002:a05:6a00:a906:b0:728:9b0a:2ddf])
 (user=ziweixiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1887:b0:725:4301:ed5a with SMTP id d2e1a72fcca58-728edb5c328mr904733b3a.2.1733875157161;
 Tue, 10 Dec 2024 15:59:17 -0800 (PST)
Date: Tue, 10 Dec 2024 23:59:14 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210235914.638427-1-ziweixiao@google.com>
Subject: [PATCH 5.15 v2] gve: Fixes for napi_poll when budget is 0
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
Resend it since the original one was not cleanly applied to 5.15 kernel.

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
index bf8a4a7c43f7..c3f1959533a8 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -198,6 +198,10 @@ static int gve_napi_poll(struct napi_struct *napi, int budget)
 
 	if (block->tx)
 		reschedule |= gve_tx_poll(block, budget);
+
+	if (!budget)
+		return 0;
+
 	if (block->rx)
 		reschedule |= gve_rx_poll(block, budget);
 
@@ -246,6 +250,9 @@ static int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 	if (block->tx)
 		reschedule |= gve_tx_poll_dqo(block, /*do_clean=*/true);
 
+	if (!budget)
+		return 0;
+
 	if (block->rx) {
 		work_done = gve_rx_poll_dqo(block, budget);
 		reschedule |= work_done == budget;
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 94941d4e4744..368e0e770178 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -599,10 +599,6 @@ bool gve_rx_poll(struct gve_notify_block *block, int budget)
 
 	feat = block->napi.dev->features;
 
-	/* If budget is 0, do all the work */
-	if (budget == 0)
-		budget = INT_MAX;
-
 	if (budget > 0)
 		repoll |= gve_clean_rx_done(rx, budget, feat);
 	else
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 665ac795a1ad..d56b8356f1f3 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -691,10 +691,6 @@ bool gve_tx_poll(struct gve_notify_block *block, int budget)
 	u32 nic_done;
 	u32 to_do;
 
-	/* If budget is 0, do all the work */
-	if (budget == 0)
-		budget = INT_MAX;
-
 	/* Find out how much work there is to be done */
 	tx->last_nic_done = gve_tx_load_event_counter(priv, tx);
 	nic_done = be32_to_cpu(tx->last_nic_done);
-- 
2.47.0.338.g60cca15819-goog


