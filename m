Return-Path: <stable+bounces-212617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDC2Lwo0eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:06:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F944A5167
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5AB93046365
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958F33033E4;
	Wed, 28 Jan 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZuHY3EgZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907D18027;
	Wed, 28 Jan 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616121; cv=none; b=CjR1CAxpBXQ2LQU1VJ9XDmLOjyFGQCO0w9xuzP43tJGwh815kzFUagKTu13GLhB26MczWnAaARao3M8pdvTTgaakQYQTVGyRc9FPdlYpm/YsQESGO1H+cAqskPIvJOM24s4ie1BcHsTnKYl/npvVEtyzY8fU/No95IufstehOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616121; c=relaxed/simple;
	bh=2ewflZ9ZXxnoSmizBldznpGKd3yTy07l23W7Y4bZGcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7klcILEGR38vwX+l16wZFq7u0Fu5TPgQTOEy6m6BdlnddSah5qK3hlkyTnDivbl4PuciQTs18dN8D+xDqtIkufqtdjN3Va6YvhSkeb954hU+ETgl7vE5TEgi+vQyS0xhcMbQvMs99fSzskhbINt48y89JIVrYapi3SFPjJJ1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZuHY3EgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA9BC4CEF1;
	Wed, 28 Jan 2026 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616121;
	bh=2ewflZ9ZXxnoSmizBldznpGKd3yTy07l23W7Y4bZGcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZuHY3EgZW8Pba0SVs5eQQ6ULAFzPFi9xw36z1fZjxgrB6DoKry/pHmuYonCq/G3wa
	 1dAjmc0WZ66jJ5SxZD5xueQX0S2hTAuCrZn/1/xX9SmA54Apz1ham37lmLb+bP7U75
	 Rx2aAAOog2xTnu2k2SmVvdqJe4IfaoIgP9vH5WxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 6.18 213/227] drm/bridge: synopsys: dw-dp: fix error paths of dw_dp_bind
Date: Wed, 28 Jan 2026 16:24:18 +0100
Message-ID: <20260128145352.099322698@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-212617-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,bootlin.com:email]
X-Rspamd-Queue-Id: 5F944A5167
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Osama Abdelkader <osama.abdelkader@gmail.com>

commit 1a0f69e3c28477b97d3609569b7e8feb4b6162e8 upstream.

Fix several issues in dw_dp_bind() error handling:

1. Missing return after drm_bridge_attach() failure - the function
   continued execution instead of returning an error.

2. Resource leak: drm_dp_aux_register() is not a devm function, so
   drm_dp_aux_unregister() must be called on all error paths after
   aux registration succeeds. This affects errors from:
   - drm_bridge_attach()
   - phy_init()
   - devm_add_action_or_reset()
   - platform_get_irq()
   - devm_request_threaded_irq()

3. Bug fix: platform_get_irq() returns the IRQ number or a negative
   error code, but the error path was returning ERR_PTR(ret) instead
   of ERR_PTR(dp->irq).

Use a goto label for cleanup to ensure consistent error handling.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Cc: stable@vger.kernel.org

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20260102155553.13243-1-osama.abdelkader@gmail.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2060,33 +2060,41 @@ struct dw_dp *dw_dp_bind(struct device *
 	}
 
 	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
-	if (ret)
+	if (ret) {
 		dev_err_probe(dev, ret, "Failed to attach bridge\n");
+		goto unregister_aux;
+	}
 
 	dw_dp_init_hw(dp);
 
 	ret = phy_init(dp->phy);
 	if (ret) {
 		dev_err_probe(dev, ret, "phy init failed\n");
-		return ERR_PTR(ret);
+		goto unregister_aux;
 	}
 
 	ret = devm_add_action_or_reset(dev, dw_dp_phy_exit, dp);
 	if (ret)
-		return ERR_PTR(ret);
+		goto unregister_aux;
 
 	dp->irq = platform_get_irq(pdev, 0);
-	if (dp->irq < 0)
-		return ERR_PTR(ret);
+	if (dp->irq < 0) {
+		ret = dp->irq;
+		goto unregister_aux;
+	}
 
 	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
 					IRQF_ONESHOT, dev_name(dev), dp);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to request irq\n");
-		return ERR_PTR(ret);
+		goto unregister_aux;
 	}
 
 	return dp;
+
+unregister_aux:
+	drm_dp_aux_unregister(&dp->aux);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(dw_dp_bind);
 



