Return-Path: <stable+bounces-230810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPPKMJMoyGnEhQUAu9opvQ
	(envelope-from <stable+bounces-230810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 20:14:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCE934FBE1
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 20:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4583051A82
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D04B345CA5;
	Sat, 28 Mar 2026 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq635Hk0"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FCB346A02
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725185; cv=none; b=NfclCNbYB5F/T3woMTZHvCAPbPwo1dCtC5dkiqvp6A1MxqJtp4f1faTB9nVlwGNbops7X5PfmW5SKo5IgiezFyrJvTn0Hxjjhurma3Q0fLimPx5IAScymFRLsMCIANcREO66CXmwgOBwf6C4w+GAdy4KX5a3OiweKynX/8F8X+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725185; c=relaxed/simple;
	bh=qGFTzlpUUEI4pKdSdaSVMTnjSAfvQHYO8xeTqhyGGNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pranHOw+ExaTlsRQquTaFmvfrBgDv1hLiLqzQ+/YLAVeaYxa1k5xnp7azwZ5hUhqG3h67L5lIxNHM1KkON1CDt/qhns4N50cyhPPCchkWSMyPhWf8gmv6sLoebaTWHrt/6HOgVkQzim8/HWbg1Qo5Gv4gzY9nrmaLOmWarAGNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq635Hk0; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-128b9b7e3edso571803c88.0
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 12:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774725183; x=1775329983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV0vTDjXno/BRjs9UsVyAooL1Z9SQRTeEW/NqAyKUfY=;
        b=bq635Hk08G52PmB4wUjBX1P9YGeKaD4Gl3lrxEBOaE5c9Gg9KGzd/w8GhZ8T+ugp2p
         j0mBWYH+5bnAxRcuKqaXM9h2LD+N1xEh0y+WamdrA3mxlSOibdl880GmCOguQ0g7uVYD
         k+Oo1eU6QKRA0Ktch/xVyjsCBAMj1PqMdOkET5HWAwAaNgMwCj66xvPrsqLyKu8ZkiML
         sPQtFDYwMnF/9OsWHQ8gb0eaIiL9rSx1ozqTzxAFYqaxTJWpe686GOG0qBIJ8qSm8Fff
         I/he+SDCkRGZ0WfaK5w/JdvQik/xmoCMZ/9hG6yACD7bXknPHnF6ykqNEtQC/JWl+6te
         ScHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725183; x=1775329983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nV0vTDjXno/BRjs9UsVyAooL1Z9SQRTeEW/NqAyKUfY=;
        b=hjtL/wLa3fme7vOO5N5UKDRrlJ4vvfQDdkj8bdaeb5AT/pvbh15JoR8ZOf622PMjMx
         n5xbqqHF6N6qhKWxKSGDyZKYiixJ1blaRgBBpLiqmv5bbcPgE3JEVdvMHEpDYYoNWYzd
         cBbCHhTMHlTZn509GHswDFoP037GZg/8FG28fhErmJUBumLlSo2WZEnZOjxcx6GgR+eJ
         t58vVhY4lxpPoFEkcnx1ojoLR7z12pqilGb1PZpQajthGQbRlOHQjkjg5fM3a+ZQdoBy
         kSDNxRYC2mOZ0+jYb2yszCHYaqgquNGdA77I+BhVh/Xl+4vfgIRCY5N0FQCj2HMRC7wO
         f+6w==
X-Forwarded-Encrypted: i=1; AJvYcCVabJa1XvwsBuMIJZE13pH6Uar/gHRPDQc7vK4Mo7jMKbFsO0ErPI8/AqgchWM84AG5Ju01q1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTwXMeXBIMHxgYJH1bJL2I+fFCK3+PVj2E6Gv97dIC9HkyjgR
	kwyPNUV9+QKONbWEjPLnsl9PkmSiF39grgb+ssXOxrM99mJ3SG6vsexQ
X-Gm-Gg: ATEYQzyoTuYJyNhb7ahvt8JDxSSLU7mZU0oU6HqNwlJ6mUP9NVmPTbwphJWiM8F+wiH
	3ugTsSF6k/mTJ6bZnG7eJOIkUUSeNYAWb6AVZCNZLa0kAwLVPyqrapgXdWZc1djShlnAtWtghwj
	vd/wnrONWj3gNzdggiLwh1MgDQacSrr0RwEHGR82YJgy4pTLaomXZTrdHPfry2UCpH6OwZjEh9T
	3Ghm+Fi8CyRk9AtVG9k2pQGZubsOSFn/SDUjFohhzfzUd6sk4xyzOUsTBgObk2yAIFhEE9JVX63
	FqNCD111grhZ/WqLpEOLsz6Pjtw3oYENSZvgVDI5ZRQxKcRNPce25ethvTKISdyG1vK4sgg+8Zq
	kqUxkk7fnY4wEq8H3RjOsmcH0PFzGWfRuLVv7LFFPr47g7LcD64t4Pn28hvsBibGUfzuGnibTLR
	lJt7PRHvD3g7F5XsK6hVWWii6vBBVyAYQL+BeO22EMlWUYdQ2/4HqiYVUt
X-Received: by 2002:a05:7022:f102:b0:11d:fd26:234e with SMTP id a92af1059eb24-12ab28cdebbmr4140608c88.16.1774725182824;
        Sat, 28 Mar 2026 12:13:02 -0700 (PDT)
Received: from localhost (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-12abbe21787sm2071517c88.11.2026.03.28.12.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:13:02 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] net: stmmac: Prevent indefinite RX stall on buffer exhaustion
Date: Sat, 28 Mar 2026 12:12:33 -0700
Message-ID: <20260328191233.519950-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328191233.519950-1-CFSworks@gmail.com>
References: <20260328191233.519950-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230810-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CCE934FBE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The stmmac driver handles interrupts in the usual NAPI way: an interrupt
arrives, the NAPI instance is scheduled and interrupts are masked, and
the actual work occurs in the NAPI polling function. Once no further
work remains, interrupts are unmasked and the NAPI instance is put to
sleep to await a future interrupt. In the receive case, the MAC only
sends the interrupt when a DMA operation completes; thus the driver must
make sure a usable RX DMA descriptor exists before expecting a future
interrupt.

The main receive loop in stmmac_rx() exits under one of 3 conditions:
1) It encounters a DMA descriptor with OWN=1, indicating that no further
   pending data exists. The MAC will use this descriptor for the next
   RX DMA operation, so the driver can expect a future interrupt.
2) It exhausts the NAPI budget. In this case, the driver doesn't know
   whether the MAC has any usable DMA descriptors. But when the driver
   consumes its full budget, that signals NAPI to keep polling, so the
   question is moot.
3) It runs out of (non-dirty) descriptors in the RX ring. In this case,
   the MAC will only have a usable descriptor if stmmac_rx_refill()
   succeeds (at least partially).

Currently, stmmac_rx() lacks any check against scenario #3 and
stmmac_rx_refill() failing: it will stop NAPI polling and unmask
interrupts to await an interrupt that will never arrive, stalling the
receive pipeline indefinitely.

Fix this by checking stmmac_rx_dirty(): it will return 0 if
stmmac_rx_refill() fully succeeded and we can safely await an interrupt.
Any nonzero value means some allocations failed, in which case we risk
dropping frames if a large traffic burst exhausts the surviving
non-dirties. Therefore, simply return the full budget (to keep polling)
until all allocations succeed.

Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f98b070073c0..81f764352f3d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5604,6 +5604,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
+	int budget = limit;
 	int xdp_status = 0;
 	int bufsz;
 
@@ -5870,6 +5871,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	priv->xstats.rx_dropped += rx_dropped;
 	priv->xstats.rx_errors += rx_errors;
 
+	/* If stmmac_rx_refill() failed, keep trying until it doesn't. */
+	if (unlikely(stmmac_rx_dirty(priv, queue) > 0))
+		return budget;
+
 	return count;
 }
 
-- 
2.52.0


