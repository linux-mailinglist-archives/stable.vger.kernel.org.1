Return-Path: <stable+bounces-95566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A579D9DEF
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 20:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F21B21BEF
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 19:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB121DE2AA;
	Tue, 26 Nov 2024 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o55Fsa4Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9718858E
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648767; cv=none; b=P+ktlkSImz0y3B4ARMEnl+RpbieAX0MMaFW/fq6dW8gtOWtK4Q5h9Mt+3hDtFZSg+bBrl2sbEJPxJAXtd0+QRL0jJXRDIknaJD4KTXMp5Xu4xPyL7g00O26w4HPUW3FGgpMXIXg90DQWWMcOEQVaW6YD4BwIuDxuSkYkqKvsOrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648767; c=relaxed/simple;
	bh=0ycQbzo+BwNOllcn4ZNczpOsjYTAXNWs5z7n+nnUjnU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sQtmvVR09ZlDStP9yCBJcttvRKN6AIxisvzHYB+hdZRMrSm/esAqcs+y9CKNVlFAb7GtPRj6gc2WryK7eKK8DNkG3bNOGKD4mKsqnUIqvyqfNaYb3l5VMyryl/MsXvXKFmY8mgdp1gtg4fLJ3Jpon5izEDar8DJt3oyBoWzRryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o55Fsa4Z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7250da8a2a5so2555202b3a.0
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 11:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732648765; x=1733253565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NDOQAbNycSNXRnM/MeyhS3VQP9GYhOqzCxxjxAfYZn8=;
        b=o55Fsa4ZmsXv6s7K+4w2oLloKE2Vf7HLYICPkzC+h31p1dPrMoh7alwphfBKQsEkQ3
         PhVgCrUcD9Xvqus3tlLgcIlMOAhC6arBTyLt4Gq8c61zqlz2Ni1sxzB04kkdSArZcpEv
         yoGDuKTCKWzcae0QpYvjZ1ldEpNgbj9MmGss45iIozH80f0BDpmJjN8jZD/t0m5dCWAk
         enQ624Pabd6h4eSDcFg0KSnVjtdaskNilwy1LoEZJKTIglP2Oc9Xso9nJaPua9rzbVq6
         4RRpPf26xvWQJRDuBmCFj5jm+w3somcHspSLNO9qBb6XsttUgwx+BZNHReqikuPkq0em
         eeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732648765; x=1733253565;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDOQAbNycSNXRnM/MeyhS3VQP9GYhOqzCxxjxAfYZn8=;
        b=UGCZTvJrqmdW+bsK9XA3Z2DQ7xLomyWvRkcD1rv0PwOGKlotnsZ5pC1B4szPrlX9sJ
         mn3MTRASwVbQJKfX1toeNsL1fMVVLlMsrtGvVHJ6wJTu5GEWdepVInD72G3+kgL2tICN
         lPYgRQplYeh1pyiV1q8RWifNa3/UCZ9byzQVYf+3rhrKyLAiYgciklIaNl4aXAf2dpsV
         ouyTp1ADVJD2IJ/tJClP+wl+0Yc1b2IptfKYF/KxqwHpKMWCmUNAnlma+qa9ofIUz3PG
         kMEZcjcwPwHtCV07tA/N/GXd0NcbRoskv62aaBfgFNGbalBB+aEZAObs1yNgrBBeotdJ
         OV9g==
X-Gm-Message-State: AOJu0Yw/tQBQo9GL9k6Yk3qsAard2HMivq32X/cXZfBSzYMHuP8R+rG+
	mU2Kz9kR2umIbbGUy7myoTIm1gHFPuAe2B6WBQh8gp5oJLEVaZyEw41zSz+es+dRF6D+nvZIESf
	8TJeD+6TVTbDPmZX34WCQCRTq8RUIcKS7fgQGzIuGlQ8bwiie2YIqPdpfN4Ld1yeG2iTzXyWfcm
	ZpxpEy45OSZqcKYuJABflvgTIVpxoUz4JG8SXGiZqQEBN7USv5
X-Google-Smtp-Source: AGHT+IGBGbouGYspNNbL7q+FWpQr3HU2rGbucxk45ddgNH02azZpgKL5YFvCJzM4Z7bSFEMN7vhFzlCsMyxTMQ8=
X-Received: from pjbqn8.prod.google.com ([2002:a17:90b:3d48:b0:2eb:12d7:fedd])
 (user=ziweixiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d10:b0:2ea:7755:a108 with SMTP id 98e67ed59e1d1-2ee08e9c75dmr515774a91.4.1732648765128;
 Tue, 26 Nov 2024 11:19:25 -0800 (PST)
Date: Tue, 26 Nov 2024 19:19:22 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126191922.2504882-1-ziweixiao@google.com>
Subject: [PATCH 5.15] gve: Fixes for napi_poll when budget is 0
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


