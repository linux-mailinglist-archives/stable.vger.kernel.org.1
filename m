Return-Path: <stable+bounces-214298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M4aBdVvg2lgmwMAu9opvQ
	(envelope-from <stable+bounces-214298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:12:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0336FE9FCA
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 612C330A9170
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916902D8DA8;
	Wed,  4 Feb 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RrIAPm79"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CBA2D0292;
	Wed,  4 Feb 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219222; cv=none; b=foirUrFTG3so2FN2atM7Pu3mUvmpWP+moAUwHcPDoUP3R0ziPuUXkPmgUEe+LprDqPlnC66F0Od2NwU6uQjpZ5JboARR1txqeCc3gWeuvmINAUBR/ObbeXH8dGlvrU5/Zf8Pmwcjw4K+i1dLEJKpyEb8WEUB/D1PxKuHqbpPZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219222; c=relaxed/simple;
	bh=Hfj1WIUDoeSm5Z1Czk8Xim8Bd3ybmU8J/zs/m4X7A+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+LnMyog0WHbQf7K1h5eUHF4otUWPRY29MaMYIFfKnuOhXJY8TuCGrj4yl2815BS6xj73TMRh/S5rZk2q/2uA0QSA/soeUkFFEKLf44jIKrr35Wh/mVaEI+JcZSciO3Yhi8jcOiMwUPbAdYadb4+pBmS8oSbAybJ9GuzfITkd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RrIAPm79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECE5C19424;
	Wed,  4 Feb 2026 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219222;
	bh=Hfj1WIUDoeSm5Z1Czk8Xim8Bd3ybmU8J/zs/m4X7A+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrIAPm79UZeQ5MTBlRRxy0lbF3juf3OjWSP1yZuOAOyo/nFk8VPdUv/4DPt5eF1bP
	 MF67epUYCuuwd1Yul/cP/9zEpCBtFoGy9jhA3axFraba7dDoEB3YEMFN3oEc1X0KA+
	 IsMyFMzTLNBhP6q0CVJaqXdAgNP8fZLsCJ86xOVI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 6.18 104/122] drm/imx/tve: fix probe device leak
Date: Wed,  4 Feb 2026 15:41:26 +0100
Message-ID: <20260204143855.594124524@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214298-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,pengutronix.de:email]
X-Rspamd-Queue-Id: 0336FE9FCA
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit e535c23513c63f02f67e3e09e0787907029efeaf upstream.

Make sure to drop the reference taken to the DDC device during probe on
probe failure (e.g. probe deferral) and on driver unbind.

Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
Cc: stable@vger.kernel.org	# 3.10
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251030163456.15807-1-johan@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/imx/ipuv3/imx-tve.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
@@ -525,6 +525,13 @@ static const struct component_ops imx_tv
 	.bind	= imx_tve_bind,
 };
 
+static void imx_tve_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int imx_tve_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -546,6 +553,12 @@ static int imx_tve_probe(struct platform
 	if (ddc_node) {
 		tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
 		of_node_put(ddc_node);
+		if (tve->ddc) {
+			ret = devm_add_action_or_reset(dev, imx_tve_put_device,
+						       &tve->ddc->dev);
+			if (ret)
+				return ret;
+		}
 	}
 
 	tve->mode = of_get_tve_mode(np);



