Return-Path: <stable+bounces-185829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC477BDF44F
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 17:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38A7F4FE9DB
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965B2F1FC2;
	Wed, 15 Oct 2025 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2+JimHg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC62EC0BD
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540459; cv=none; b=LKKB4DTxDeYcaOdVeYg+mIDF7pnF8X1PYzP6DTee8gNzXcZ+qJ3xXYP6k8IRKpdYeEJvTa5/CyiFoHAoZ34+k92BJF8fjyZHRxUDwe98TD+BskszstG3lH+t+38Rjti62tnvFUxm3SK/LrGvYWiXLD2aF6iyxpg5tBrPAkVjbH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540459; c=relaxed/simple;
	bh=60XT5SO34ddHtpkn/CIdJmvGQY2Mb1sF34YxFyRKDfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1ykkO9fH77g9dNeDJTktA7L6dz78X946srmXo0kND4vKis7twbfNafGBhdZuOeHTgoxxUFRYICthctLroozSYJRVBffuAJveLkCdr4RorlBP+l7JvAtx5X8j/tNorTmzcmmV4GGXZAOHcjGswAV3Ij2vRyTtWqtkIuMw2vfR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2+JimHg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27ee41e0798so104828195ad.1
        for <stable@vger.kernel.org>; Wed, 15 Oct 2025 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760540457; x=1761145257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifGvImgtMbsz18j1645Ok+33OIuHZ/lnBEplV9+70Ps=;
        b=K2+JimHgj0OETor0U2PUWLzJe0XalgSCzoHcek+QuqM49FaXClZNjlwZef/myuLBfe
         hX6BQ4BEp+OSEZbtLXkvK/4uITCr9tVcthgkh3sim5kHYWh0ZGL/Q1bglm3rAFkvUHGd
         hejdzMeGEw2cbKRocB/DFBC2ywbCjJSr8LrcnO3+jLuwFJADWg0AM6JCO9rL0/7buJJE
         QNgZOvVyLd6+zL3Y5FhQ1CId7uQlges7VPZVmmPaEiXd2wiRvCdzHBjW1wyjBqe34+a9
         kFCTLo6b9aocn+fdDZrpIUnP4OXxM8qXWH/mKgY1FDdRqd1i6VYTZgfBaA4Fo0Zb3v4y
         du0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760540457; x=1761145257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifGvImgtMbsz18j1645Ok+33OIuHZ/lnBEplV9+70Ps=;
        b=QU2WJef2oAh1FLBjJeFLyOULCw3qNu3LEXwv6fZC2dqZCqgWB4Z+D9o2F9cbKVYZZP
         pab+U8KIhQFe5uVWWZ0Khzdk/1kotpE3QSqtvec2cumu4/yfumbosmBJOV230Ltc48fW
         3tc45E2WnQCsDASTrEOghF1DuT1N0CBkCYIlxyPUHV8sGMxW7w6jbz2wENyWevTeQdeR
         HHB8pc+/gDfBjmwcDn8eQu8DlrtsUE5iVcNlbUNWW8k+PFMDIbNfbrjiOMjmFP2Whi96
         cv0ItQx92LjIqsLEw8qhvNLIrzSCcVKMSkWIHcb14DxRicTJENNeLtS59SxmTG3dxFnJ
         DAYA==
X-Forwarded-Encrypted: i=1; AJvYcCXsUdUvZPOcUZsrT8NFQyrgoSmvB5HC17ogfDuEUExlpblVYb60B61+ikxNEGPHU0ssYh+jZlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGk1aSt7wkLnpjkAQbEZl384Xq4kOdOX+BeHlrPZ9JxHXjVkWP
	kDO3w+e0YHxN8VpYxBCb0+01fYs5TRO4r+A2U67dCUPMXJarR3l4j7U7
X-Gm-Gg: ASbGncvjCtIPqEc7rOlEqsuHRejtPiLbM2tBqli+JjsXMy99BPWfqnWwXwhtikNk88d
	3/dVfjJpIjgPGMOpRbgD1SmhZYFzue9ESGLDunPgxrwHmt53J3T/KPzq3IdW4D+3+juOgWKp+mz
	9zfGAXLYmzSw0eabjFlqMgg3xgFnFVSyYzHiU2UwiDX3LV8mYyN1uOsEgLkx6lLfnE/KSRFsYID
	9J3UsuAn2YNX1GlACmwTTC1MQ7kUam91E1wG78u9EOOiBU6+iPijmWMhkhc3EqQhDqpfUTSdzQq
	Xmfr1KhyIGzmkPV2jurC4aUSvbi0Jni0Q5lssPIwlcdx54IyFZdqJnFpuUO7jSgx4YavJOsvlV6
	1yEBoHpSoHS1UfqEId1bFc3O7chObAPvstAP/HOk9z/g6n936TOUr+ngm5f50z71yoebyYXYCUg
	==
X-Google-Smtp-Source: AGHT+IGqxIssqtEE1gKMyZ/xPQWAaQDO4XMp/cQx9E/SYok7KUMOpcA7WPjXYLzfNma9OBCD3O8baQ==
X-Received: by 2002:a17:903:298c:b0:265:982a:d450 with SMTP id d9443c01a7336-290273ffbf1mr386779325ad.40.1760540456721;
        Wed, 15 Oct 2025 08:00:56 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:f449:63fb:7005:808e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36408sm199642265ad.91.2025.10.15.08.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:00:56 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] net: ravb: Enforce descriptor type ordering to prevent early DMA start
Date: Wed, 15 Oct 2025 16:00:26 +0100
Message-ID: <20251015150026.117587-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015150026.117587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251015150026.117587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Ensure TX descriptor type fields are written in a safe order so the DMA
engine does not begin processing a chain before all descriptors are
fully initialised.

For multi-descriptor transmissions the driver writes DT_FEND into the
last descriptor and DT_FSTART into the first. The DMA engine starts
processing when it sees DT_FSTART. If the compiler or CPU reorders the
writes and publishes DT_FSTART before DT_FEND, the DMA can start early
and process an incomplete chain, leading to corrupted transmissions or
DMA errors.

Fix this by writing DT_FEND before the dma_wmb() barrier, executing
dma_wmb() immediately before DT_FSTART (or DT_FSINGLE in the single
descriptor case), and then adding a wmb() after the type updates to
ensure CPU-side ordering before ringing the hardware doorbell.

On an RZ/G2L platform running an RT kernel, this reordering hazard was
observed as TX stalls and timeouts:

  [  372.968431] NETDEV WATCHDOG: end0 (ravb): transmit queue 0 timed out
  [  372.968494] WARNING: CPU: 0 PID: 10 at net/sched/sch_generic.c:467 dev_watchdog+0x4a4/0x4ac
  [  373.969291] ravb 11c20000.ethernet end0: transmit timed out, status 00000000, resetting...

This change enforces the required ordering and prevents the DMA engine
from observing DT_FSTART before the rest of the descriptor chain is
valid.

Fixes: 2f45d1902acf ("ravb: minimize TX data copying")
Cc: stable@vger.kernel.org
Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a200e205825a..2a995fa9bfff 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2211,15 +2211,19 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 		skb_tx_timestamp(skb);
 	}
-	/* Descriptor type must be set after all the above writes */
-	dma_wmb();
+
+	/* For multi-descriptors set DT_FEND before calling dma_wmb() */
 	if (num_tx_desc > 1) {
 		desc->die_dt = DT_FEND;
 		desc--;
-		desc->die_dt = DT_FSTART;
-	} else {
-		desc->die_dt = DT_FSINGLE;
 	}
+
+	/* Descriptor type must be set after all the above writes */
+	dma_wmb();
+	desc->die_dt = (num_tx_desc > 1) ? DT_FSTART : DT_FSINGLE;
+
+	/* Ensure data is written to RAM before initiating DMA transfer */
+	wmb();
 	ravb_modify(ndev, TCCR, TCCR_TSRQ0 << q, TCCR_TSRQ0 << q);
 
 	priv->cur_tx[q] += num_tx_desc;
-- 
2.43.0


