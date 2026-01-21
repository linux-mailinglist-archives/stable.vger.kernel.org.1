Return-Path: <stable+bounces-210872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCdDIL8ecWmodQAAu9opvQ
	(envelope-from <stable+bounces-210872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:45:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D37245B769
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B57D8AE3CD
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBF23A0B24;
	Wed, 21 Jan 2026 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VG7azSB2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E553904DB;
	Wed, 21 Jan 2026 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019671; cv=none; b=FIUPOipBu72qF3kHOI212Hy+k5FKv9eDoI+OHgotan+oNRk4I2/RnOSogHpmTYbqcxXW47vbUTxO8Zc+Wjo1N3VzEHk2KeDyH0YOAH7FTJmRfgZBlq+JTn3yDDm2w2iDuxRgoOTWd4rLJ1un5w24UTEaMCT2a5XIk8hjeJuWi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019671; c=relaxed/simple;
	bh=2do7hs97H7PX/7F8CNVQLeMGdl3pcUo5XMvQR7hrAzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDpLtQj8+9bqscTHG67SlztGzlYxYHft6w2rcv48j8buNbm7d00Rw+QUWRUETpUUIkNWpx10WQgKHWkkKWFtNw9WswynaIYIpU/s7pedLrsDmUgZrPRfcU1FGdXPcm16MUr91ymooVoRcFa+pFECSETRo4CePeVLH1HkTqOsRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VG7azSB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5877AC4CEF1;
	Wed, 21 Jan 2026 18:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019669;
	bh=2do7hs97H7PX/7F8CNVQLeMGdl3pcUo5XMvQR7hrAzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VG7azSB20/Bsfa30MNFpISlOcsMQoqvSTzeJLDqLKh9YFxl87SRR+BFv7XoV1SA5C
	 gjqN8jwXnjepp3uKZgZlDE8TowynC2uqFyzetrGeyLl4n5hXHAhfy+wozmBhekp/Yc
	 jnS3gZCDe1VtO06apySgePGmmNqsooW4D8yjOQNc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Davis <afd@ti.com>,
	Johan Hovold <johan@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.12 074/139] phy: ti: gmii-sel: fix regmap leak on probe failure
Date: Wed, 21 Jan 2026 19:15:22 +0100
Message-ID: <20260121181414.118303826@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210872-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D37245B769
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 4914d67da947031d6f645c81c74f7879e0844d5d upstream.

The mmio regmap that may be allocated during probe is never freed.

Switch to using the device managed allocator so that the regmap is
released on probe failures (e.g. probe deferral) and on driver unbind.

Fixes: 5ab90f40121a ("phy: ti: gmii-sel: Do not use syscon helper to build regmap")
Cc: stable@vger.kernel.org	# 6.14
Cc: Andrew Davis <afd@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://patch.msgid.link/20251127134834.2030-1-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/ti/phy-gmii-sel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -480,7 +480,7 @@ static int phy_gmii_sel_probe(struct pla
 			return dev_err_probe(dev, PTR_ERR(base),
 					     "failed to get base memory resource\n");
 
-		priv->regmap = regmap_init_mmio(dev, base, &phy_gmii_sel_regmap_cfg);
+		priv->regmap = devm_regmap_init_mmio(dev, base, &phy_gmii_sel_regmap_cfg);
 		if (IS_ERR(priv->regmap))
 			return dev_err_probe(dev, PTR_ERR(priv->regmap),
 					     "Failed to get syscon\n");



