Return-Path: <stable+bounces-95562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE8E9D9DA0
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 19:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BB928326A
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157C41DA614;
	Tue, 26 Nov 2024 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t83kCGcw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712131D45EF
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646856; cv=none; b=pKBNgDU85IMv89oAmMPUdfzdEoW/0PiAUzI8T/INHa9X4DKM6d8UNYYVODXwhCu25TyEu5Adxdk2gwKgH/nNzBtPlWmfWQjTckGkX21uW3mVYDQ+I9pDFmPMgCO45C5uQlJvGxsnLA+Klje/R9ubjdntyvF/pGwzbZ26Pw2QxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646856; c=relaxed/simple;
	bh=cn59P2T1k9wOl9aoAQKIvgNUfF6Vv0kaGwNzLI+khAs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p25A/7BJbQkfCbFaE6pGbNwR1e+09eaMvkyoCygVsgKfkaX4N+9hLyTN/r/eArLgDsm5V/EoQejFk95d76oDb6XiRfu57n2XdaXZytS7iecYjGRPbkycwKZM+p1KlG5WM0gUcEfj69sQQ4y18CCDwKknz1qb4n7YSRzG1hF+HcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t83kCGcw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2eaf1a11078so7060759a91.1
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 10:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646855; x=1733251655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dq6rrtLxTmg3rcVW1L3Mlmhry+erxLfg0JBunzLXHUk=;
        b=t83kCGcwWTtlxjAN4KL+5fh1OJemPRiMqnCCZLK826v3XaB64wug8CmQJo6LB56VB/
         8xJHTki17wutnnbGcqfBgy3hNAesd99MgADlfMZOUVuqrvo0r9sWbbMx1x9jOmcqzZLi
         RwBuZJPjRt6wbn54hJm3Qt2VIr6B1uqVvpM4oGMHqIEANzKlXI3TRMSk3ya90Y1v+DHq
         kF+M7efnpCbxlz7+2W3oJva7obdlwDpUl3hZmTK1T+YRF0NUK7TaAYG3siLn0oVbn9jI
         8ysIW2+9Jznkz5Sv2D3R7srRjFwTHqoBY8riehc3LfL5GcBx6rIXYjQw2AFnMxrbLfRx
         48YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646855; x=1733251655;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dq6rrtLxTmg3rcVW1L3Mlmhry+erxLfg0JBunzLXHUk=;
        b=m/nOrsVPMLhCTu/MgP/ZnQ4wluN+66kdFD3oUIM5t4lJGSbBB6TaypXC8SqKV+U1yk
         cYnY9bI+PpgzIpsy3iONU6ebDENr/JQ9+wmUEoZdC0kQTSpBwut3iXHLmL+yNfiYByl3
         HsJXqhhVgatRet8oXbJmw6TiKu3DG7nd179+D+2lQvuLK4fETKbRJV0PWOCY3gNS6y/7
         AUDJVg2VAACzGgF4WGR6DiQUTvQdRwMvNoffHoTfMJRnQM70DYNZbUdoFf7IOvva0i6d
         LSkgANWpnbbAxyPChOf51gLw5SSk9+Bl6Bx7qFmD1KAoVdQmvJuPbxMKdBKxSTfgf34B
         Z6cg==
X-Gm-Message-State: AOJu0Yx49o2D2+DiHCs9EOnLe/Jri6RKXyDvNG9KgdsTMFgHbHNyHSMp
	KzEQl5p2H3MpZx/tj5HeK20PbMqW2smCUGvOCKGK087+teWuEXeBpPx5WhnBq2oD9Z0fidqPX8m
	cVI4gEaOrnfB0P3ojpdiOx8r1sd9acP70x6IA6UlEcL1+R85dEprn8SP1QH9jr39VPHSbAMnuJE
	5uH+DZnoFX6G+q/4XSNZZzwLbN7wa2iJP/U9Ye7V22p2owEp/q
X-Google-Smtp-Source: AGHT+IHPvkND8oN7goG94f88mhQrQALu+7FsPq6j2TO9mkjs2xzYyS2zyNkamz1bw3/QHD2xAO7TswQK+5nvZQM=
X-Received: from pjbst5.prod.google.com ([2002:a17:90b:1fc5:b0:2ea:756d:c396])
 (user=ziweixiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d0e:b0:2ea:61ac:a50b with SMTP id 98e67ed59e1d1-2ee097e4795mr382227a91.31.1732646854614;
 Tue, 26 Nov 2024 10:47:34 -0800 (PST)
Date: Tue, 26 Nov 2024 18:47:31 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126184731.2497956-1-ziweixiao@google.com>
Subject: [PATCH 6.1] gve: Fixes for napi_poll when budget is 0
From: Ziwei Xiao <ziweixiao@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, pkaligineedi@google.com, 
	hramamurthy@google.com, Ziwei Xiao <ziweixiao@google.com>
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

Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
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


