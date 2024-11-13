Return-Path: <stable+bounces-92942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BD99C7A86
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 19:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D601F23718
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E889D2022E8;
	Wed, 13 Nov 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pG7URdrH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A19920262E
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520780; cv=none; b=od/RkoXXX8I9bSQJSjJCRx5pxY4F4tfZ8dPiubkrLMX2GD0CjnfK/tdQrK2NZr7pfmQJyAPtNrisdmdam210RqjWVMNVW4/TLLyqijZ8FO2t9kUF00fBQnAHm4LEbYD/54gNQy3zPBGbPU6p+Oc/sv5ASz28Ii7LHydZDvIYmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520780; c=relaxed/simple;
	bh=oa4jHsPwhGmEGp/xTbs7SGwv0y0lkkYSeGlEeRdKrSE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MLyDjJaI5hbYFiS0ZdvQRkgy2VlPsbXaoOqCYORYiFUik4tcnzS4B9kPd6TxjxJ/BqLnsrljhdjpjp9m39xstRfem6d8QX4n1ek2DeQBwz0owNX6LvOScUPBMzBt0J/lXhjdM6TEoe7cj6+bMAPMEJ3ezuDwQtcszXhIjp6/VAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pG7URdrH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d4dee4dfdcso5800254a12.2
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 09:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731520778; x=1732125578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OGy65TxNl8Iw/c/Xptd/4fsGkFAaUFJrtao3dkf0rx0=;
        b=pG7URdrH49QZFSmgefbyVlRvKbXj2ca5WG+Il4SjAwiT7x/1hjQT10pp75HU21KOrz
         Io+ZDCNL8Lu4nncXTdZx4j+EpSKBUZKw2pOyK5dtHlABthZpZxdm0OYCje2wwHedfAcC
         nlVVZz2RnBmQe1iE21uq50JwnW5MhR4mZT8LbImCZSKRnUbCAQMp4Nq0gbP65CkQXwxr
         nAfgij0L7aUxp2UwwPKCi3773VT7AjPZ22hOHNtuzfZvLG8ZPc52ntyIzalfgsRb3Yhu
         sLyOyhtytDLB6TuIAqwxQ/DA+fmzQ6bOkN5AzSrVOdaw/jo8nduY1ddKcrbSCuakwZxj
         f16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520778; x=1732125578;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OGy65TxNl8Iw/c/Xptd/4fsGkFAaUFJrtao3dkf0rx0=;
        b=TDBepkgT3hFN4Gw/qwKYmSLKSWFOJlC1/5/Vjjyui71KH11AXdzQXw+pyohgQh924L
         ljn1Um2/gY0BRSfA5QIZBkozYUnVdGD0Jgzn0zW77hoKtpWBSfI3+m90ZhKgW6Rjb+Q/
         zN+QZXR7CDeMtmEkM2JGblga6XiNBCfWrgDuxuqbYfA4xZY+0hUBBjc5lu7rNKwgUcjH
         NdvHeuUWnXgrJgNI5qKoNVVDflsTdLZBV3VC2AUn/bAkDix4xQsHMqdmcPAsTnnVw1B+
         Glqy7tTbwI+H3fOXDrP80J1ls1/Hw/odRsw5KC+CEK5246Ql1TkYAYv30S26RuTGTkmO
         0EAg==
X-Forwarded-Encrypted: i=1; AJvYcCWlaEO5fDRW/WQtxluCwBplUZOrsB/jZz9uCrIa6a/WDGOPt8cr934SGnucuRc0GVMNGPyc6L0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2xemOFOZEbUWNKU+TwV5ByWaIbQoFLMSciAK2HaeUhbX64/fU
	Cf36cdNJkTlhEMuxy4kfmpTSk3g0jAUNZJNjz0Xlv3mwxieXxl6LsjofE3n3u1dfQYYHUaE/uIV
	Iqd1TaXfryw==
X-Google-Smtp-Source: AGHT+IFnQmgQwAkgXmsMOhAVpX9rj07R7oOJPSSW/T5CmMuKWbs0D1lxQHdUyOHeErsKTzwFQKa/GTC2muDPJQ==
X-Received: from jeroendb9128802.sea.corp.google.com ([2620:15c:11c:202:6a11:574c:76ac:faa3])
 (user=jeroendb job=sendgmr) by 2002:a63:3e85:0:b0:7e6:b3ab:697 with SMTP id
 41be03b00d2f7-7f6f1a10ac7mr11209a12.5.1731520777728; Wed, 13 Nov 2024
 09:59:37 -0800 (PST)
Date: Wed, 13 Nov 2024 09:59:30 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241113175930.2585680-1-jeroendb@google.com>
Subject: [PATCH net V2] gve: Flow steering trigger reset only for timeout error
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	stable@vger.kernel.org, pabeni@redhat.com, jeroendb@google.com, 
	pkaligineedi@google.com, shailend@google.com, andrew+netdev@lunn.ch, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com
Content-Type: text/plain; charset="UTF-8"

From: Ziwei Xiao <ziweixiao@google.com>

When configuring flow steering rules, the driver is currently going
through a reset for all errors from the device. Instead, the driver
should only reset when there's a timeout error from the device.

Fixes: 57718b60df9b ("gve: Add flow steering adminq commands")
Cc: stable@vger.kernel.org
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v2: Added missing Signed-off-by

 drivers/net/ethernet/google/gve/gve_adminq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index e44e8b139633..060e0e674938 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1248,10 +1248,10 @@ gve_adminq_configure_flow_rule(struct gve_priv *priv,
 			sizeof(struct gve_adminq_configure_flow_rule),
 			flow_rule_cmd);
 
-	if (err) {
+	if (err == -ETIME) {
 		dev_err(&priv->pdev->dev, "Timeout to configure the flow rule, trigger reset");
 		gve_reset(priv, true);
-	} else {
+	} else if (!err) {
 		priv->flow_rules_cache.rules_cache_synced = false;
 	}
 
-- 
2.47.0.277.g8800431eea-goog


