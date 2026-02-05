Return-Path: <stable+bounces-214378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJZlAtgEhGmHwwMAu9opvQ
	(envelope-from <stable+bounces-214378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 03:47:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED32EE198
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 03:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4356F300EAA3
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 02:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFBC28DB54;
	Thu,  5 Feb 2026 02:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LADdOVue"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2CA1CDFD5
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259649; cv=none; b=eXEJQ+gToaXYSJAW8+iqAqLrivlKlj3x+KBCfPNsgnFga2SRenJKylg+Bad4JiVonwGMTsJQXDFxU71B/sXCJ7on02fUfyAXoRrDR4vct5YecuBQDWXUXSWPj/b1o9uR0UqrulFWUD0iAApl1nIMPcM0KwKLIrEW4I7rMP3ms7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259649; c=relaxed/simple;
	bh=NkPq/s5BiXpj1kYu6RXFoEWhOuxRY6zyl5jkhvFJ5Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JC5J5wzbdX5AUQ/nizgF5M1/YgyFC89iZ6wvTbTkggMlOJ8ZymipFS1XvOvB40z4lubHw4aj/IYlIYU2PI/1tybEdvboYvl/z4HxYHt1E3BmDrNfDFFZj3ZhWCbkyO0gH4Qy/ATMk1MwzaN3Bd9WZfvfOLStLGPoBUdSCIdzqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LADdOVue; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8947ddce09fso4779906d6.3
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 18:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770259648; x=1770864448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLaqaSS4WB1Humpqpw9lfgDwEEvSzEjuIrUcj+p6NtY=;
        b=LADdOVuew6VF+LM4JwJCLAx66PNHpy0lQPoIzNonCJ0+o46ezKcE5hWUr0b62PAhfK
         w/4KpnhM/lTRDG6DT02HX50mt/ESqULUPw+F848WRFghtrNW+72YIlwNC46B1QNlDcTA
         NyLazLFkb/9jR82XHfI8jwT+azV2sPl5x938Z5cG3Xn/KHRon1lcGBxIggbQ/EDQmeE+
         jdy4eE3mTyab+DGI17gK4N6TbnucpBZNduTqW+HPImbQHFJQ0ZtImHZ+9AXUGO16402Q
         nPPfLT9KM5Ueu0jk07gvLa2IotNzxCI7zrhD/FOgC3v1H1lxAFHfecMnzALLVVe0iYVG
         9PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770259648; x=1770864448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yLaqaSS4WB1Humpqpw9lfgDwEEvSzEjuIrUcj+p6NtY=;
        b=I03rNrHV0HYE0ojNzZYPqE7Fba6HNzxiL7eEJV/mcdHca0wqQNdYhxAdDt9hD6qhq1
         hp1dIFibW2VF62p5oTNq6e0a2M7tpfJ3ree8+MRVWhWgXJltAh1cl69ZCiXyPaYF/bV0
         jMyAaMlIh+fWGPV3PmNqogPPHrCE8E5OrTWV/+vx6QLraJIKRUL1HupZan1UoTYTgcRU
         KjFPdM7JypZsRtwquucPPBZMgs5mayDI7OKjYhUV+PgmywmWPkFXRMhqBud/yn37rVtB
         VNKiwSO7HIjpp2IzVPozwXqNXkyKWaQieC329OP/JO5qFCW8z4SskEehA9S0KxpCdOxa
         u/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIP2/Mr17b+8gzxZvQnrvLRnagdTPtnr0TEibR7EwlQ+h1l0ZHS7NIECGEOkaf40/rIPStBBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGuE+PB8z8ez4o69WaHZZz7c739B+NrkCvNmD3t0PopQYr7vK
	w1TpMU+eLpMl1cm4mXrSgmIwFZElBclqTBLDSVCqCId0xoC6QMLyIzAh
X-Gm-Gg: AZuq6aJTbwlJHuk5sQxvQKTJ+Ai0hRpqHZaFuBmr2xst4VSQ/ryA3jxIepwAoBftdcu
	S8Q0z930tMn/Nv0s6hqwv0fZIRkBKInKKtuYRuENB4o6AdKd25njIYrvVPy98YH1o2x12dAIfgc
	AtKKswRyGgqW1Q2/6gF1PtKp8TyC66udlr1D+h9kI/72B2C1AAnbovJl9ayYcFrNHf8U01RPlPj
	36Uoj0SatBh5C6g1606Z2tUJr021CJZ4pnxYuOz/XFOOhJDYuA4oDFL5mbFuRJmwOahtvPvsSAp
	I2kENbx7ftPop8qLjHkIK89jkhO2yrOV//dnr3kUzfoMNr3daBiC0qBFYJU2Vy9vrfyghK9uN+p
	JG+Txv9aCreg/ZD2wPdg3DE4LkyUIXQNAb6MU156Zq4TgfliWJPwRtBrmRshRIIulvR/WoesINw
	nqfADeJFpbOZ1IJDjb29xo
X-Received: by 2002:a05:6214:501b:b0:88a:35cf:8db3 with SMTP id 6a1803df08f44-89522185775mr76334956d6.18.1770259647646;
        Wed, 04 Feb 2026 18:47:27 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2b5e3sm308193085a.25.2026.02.04.18.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:47:27 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 05 Feb 2026 10:47:02 +0800
Subject: [PATCH net 1/2] net: cpsw_new: Fix unnecessary netdev
 unregistration in cpsw_probe() error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-cpsw-error-path-v1-1-6e58bae6b299@gmail.com>
References: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
In-Reply-To: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
To: netdev@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
 Murali Karicheri <m-karicheri2@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, 
 stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214378-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com,nvidia.com,gmail.com,6wind.com,linaro.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5ED32EE198
X-Rspamd-Action: no action

The current error handling in cpsw_probe() has two issues:
- cpsw_unregister_ports() may be called before cpsw_register_ports() has
  been executed.

- cpsw_unregister_ports() is already invoked within cpsw_register_ports()
  in case of a register_netdev() failure, but the error path would call
  it again.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/ti/cpsw_new.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 21af0a10626aaf0ce6ecb04837899801743f3894..b9fc31eb06134dae33427eaba06341c39eb4b41c 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -2003,7 +2003,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	/* setup netdevs */
 	ret = cpsw_create_ports(cpsw);
 	if (ret)
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 
 	/* Grab RX and TX IRQs. Note that we also have RX_THRESHOLD and
 	 * MISC IRQs which are always kept disabled with this driver so
@@ -2017,14 +2017,14 @@ static int cpsw_probe(struct platform_device *pdev)
 			       0, dev_name(dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	ret = devm_request_irq(dev, cpsw->irqs_table[1], cpsw_tx_interrupt,
 			       0, dev_name(dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	if (!cpsw->cpts)
@@ -2034,7 +2034,7 @@ static int cpsw_probe(struct platform_device *pdev)
 			       0, dev_name(&pdev->dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching misc irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	/* Enable misc CPTS evnt_pend IRQ */
@@ -2043,7 +2043,7 @@ static int cpsw_probe(struct platform_device *pdev)
 skip_cpts:
 	ret = cpsw_register_notifiers(cpsw);
 	if (ret)
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 
 	ret = cpsw_register_devlink(cpsw);
 	if (ret)
@@ -2065,8 +2065,6 @@ static int cpsw_probe(struct platform_device *pdev)
 
 clean_unregister_notifiers:
 	cpsw_unregister_notifiers(cpsw);
-clean_unregister_netdev:
-	cpsw_unregister_ports(cpsw);
 clean_cpts:
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);

-- 
2.52.0


