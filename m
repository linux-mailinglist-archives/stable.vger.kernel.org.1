Return-Path: <stable+bounces-29838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0AF888F07
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 06:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E62B1C2B32B
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 05:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2E11482FB;
	Sun, 24 Mar 2024 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fztzV6lr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AD1E4A31;
	Sun, 24 Mar 2024 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321283; cv=none; b=HPl7TrKXxj4DG8fW06gugANmHOyY8CJfRNRblFDY6WM4/epllFr5J42j5mCwt0QBlbnPT+mrcfjq13zrT10kPyxXt6GcEHCWtE2jVWteOSIOvQXVl9UulXMDggzuVlWq5xJZ+WK6Sqb4s3/Ltw3qZHWiCl8YDLJ2Iq7YWe5FZuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321283; c=relaxed/simple;
	bh=8z2nE/zW8rE3KsAFpVlPxAcg/pD53I/rou9MThQ9TEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O462WYpW5/smGdy6Tk/v3psNBtMR4zT0XvYkZ+tFiCdh0EghCk0Q4MS/VAyCoIRLKZ34/c/+Vzo6Vl5UNk0W+LN49a/i6sara3BECEJPjhvBh+PJ8x7clgd+Frw7tjr5qMlI+V8D1OhEkFMQQ/eGsf2/MOoWvopbA7JPrfBg7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fztzV6lr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C017FC43390;
	Sun, 24 Mar 2024 23:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321282;
	bh=8z2nE/zW8rE3KsAFpVlPxAcg/pD53I/rou9MThQ9TEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fztzV6lrstsZa0aJQ3iVnQCmcnuQtW4ZablI0T4RRDv41eATEaigby51AUNwEeriG
	 UfvroCzLhW8D3VBlEW3BpwWHM723tC920ZcPBKjfl6T80K1yC3tollCD5DrUcP6SAz
	 6myca5IIUCKSRl/+Pgj19RVBgwHxLXLJY8/U0Fj/DBtEkQp/ZBUIT08dMrZhkHdpMq
	 735nA9bPfQ5igRlZYubd9IrMIwCaOgjKoBPdIF8D108xY2Luzj+ImJaY404Z6eWB5g
	 WfivaBvP7ACBwAccOrf4cfmUsXzJ3b6crxowlnoCAbCkGQDLJkDxAvQFd/yVuwyz73
	 sif5u3vadTI7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 004/638] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
Date: Sun, 24 Mar 2024 18:50:41 -0400
Message-ID: <20240324230116.1348576-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan+linaro@kernel.org>

commit b979f2d50a099f3402418d7ff5f26c3952fb08bb upstream.

A recent DRM series purporting to simplify support for "transparent
bridges" and handling of probe deferrals ironically exposed a
use-after-free issue on pmic_glink_altmode probe deferral.

This has manifested itself as the display subsystem occasionally failing
to initialise and NULL-pointer dereferences during boot of machines like
the Lenovo ThinkPad X13s.

Specifically, the dp-hpd bridge is currently registered before all
resources have been acquired which means that it can also be
deregistered on probe deferrals.

In the meantime there is a race window where the new aux bridge driver
(or PHY driver previously) may have looked up the dp-hpd bridge and
stored a (non-reference-counted) pointer to the bridge which is about to
be deallocated.

When the display controller is later initialised, this triggers a
use-after-free when attaching the bridges:

	dp -> aux -> dp-hpd (freed)

which may, for example, result in the freed bridge failing to attach:

	[drm:drm_bridge_attach [drm]] *ERROR* failed to attach bridge /soc@0/phy@88eb000 to encoder TMDS-31: -16

or a NULL-pointer dereference:

	Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
	...
	Call trace:
	  drm_bridge_attach+0x70/0x1a8 [drm]
	  drm_aux_bridge_attach+0x24/0x38 [aux_bridge]
	  drm_bridge_attach+0x80/0x1a8 [drm]
	  dp_bridge_init+0xa8/0x15c [msm]
	  msm_dp_modeset_init+0x28/0xc4 [msm]

The DRM bridge implementation is clearly fragile and implicitly built on
the assumption that bridges may never go away. In this case, the fix is
to move the bridge registration in the pmic_glink_altmode driver to
after all resources have been looked up.

Incidentally, with the new dp-hpd bridge implementation, which registers
child devices, this is also a requirement due to a long-standing issue
in driver core that can otherwise lead to a probe deferral loop (see
commit fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")).

[DB: slightly fixed commit message by adding the word 'commit']
Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
Fixes: 2bcca96abfbf ("soc: qcom: pmic-glink: switch to DRM_AUX_HPD_BRIDGE")
Cc: <stable@vger.kernel.org>      # 6.3
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240217150228.5788-4-johan+linaro@kernel.org
[ johan: backport to 6.7 which does not have DRM aux bridge ]
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 9b0000b5f064c..a35df66bb07b5 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -469,12 +469,6 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		alt_port->bridge.ops = DRM_BRIDGE_OP_HPD;
 		alt_port->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 
-		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
-		if (ret) {
-			fwnode_handle_put(fwnode);
-			return ret;
-		}
-
 		alt_port->dp_alt.svid = USB_TYPEC_DP_SID;
 		alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
 		alt_port->dp_alt.active = 1;
@@ -525,6 +519,16 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		}
 	}
 
+	for (port = 0; port < ARRAY_SIZE(altmode->ports); port++) {
+		alt_port = &altmode->ports[port];
+		if (!alt_port->altmode)
+			continue;
+
+		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
+		if (ret)
+			return ret;
+	}
+
 	altmode->client = devm_pmic_glink_register_client(dev,
 							  altmode->owner_id,
 							  pmic_glink_altmode_callback,
-- 
2.43.0


