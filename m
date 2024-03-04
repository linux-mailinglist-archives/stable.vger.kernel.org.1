Return-Path: <stable+bounces-25822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5702186FA42
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36F2B20C30
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 06:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6B911713;
	Mon,  4 Mar 2024 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pj7N88Kq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F39BA2B
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535127; cv=none; b=MVuv9TSbR6dkoIqyWzB3Yym0a7rINp5dDPqzeaTy2h7vhDJJoz+LcNWxYBKWsOj81ARzjR+blnxAd/KAsLUB6K1Jnc102xV+NjWjsgjF6BMuY617pRYzP60/dl+6MhAKNp/4Xowu6qpW6OcRRFN7m3j2iIQCNidiArokCUMM+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535127; c=relaxed/simple;
	bh=1wtYTHCN9Pj9HvgTX7EI57h9eGFLadEW2VmedyTJiHo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MPvJnYsUQ/qBOZDfPY88kJbV9ZDjVyZXoq1NJR8iin/tl6zCX+VXlgNzAbkG9Tw3Qq404/zU2Tt5A1CrxBoGqwWNaRidAxGUc8aa2kOYw9lKWmANDt4/FQtJk4qdC6QS/mvkEdqEpEHu7g+HSQsQJkZW3TTW6/V6ZAs80zk+3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pj7N88Kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72058C433F1;
	Mon,  4 Mar 2024 06:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709535127;
	bh=1wtYTHCN9Pj9HvgTX7EI57h9eGFLadEW2VmedyTJiHo=;
	h=Subject:To:Cc:From:Date:From;
	b=pj7N88KqyzvmX5xlaGp50zr63veh5ZtgL6H2RajLtBvt42l2YmfTHjNL951BU4PXW
	 uBznKYgVETKgLgbuVeuUatLvthiOtFp2xWLNERgbMvXzJs4d1+cWG2zJkwCqdEIb7k
	 4x67QqjzrN+5/oYO22lLN420pBSX90kza5G1OAmE=
Subject: FAILED: patch "[PATCH] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free" failed to apply to 6.6-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,dmitry.baryshkov@linaro.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 07:51:55 +0100
Message-ID: <2024030455-jolly-catcall-c2e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b979f2d50a099f3402418d7ff5f26c3952fb08bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030455-jolly-catcall-c2e8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

b979f2d50a09 ("soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free")
2bcca96abfbf ("soc: qcom: pmic-glink: switch to DRM_AUX_HPD_BRIDGE")
f86955f2b1ff ("soc: qcom: pmic_glink: fix connector type to be DisplayPort")
5692aeea5bcb ("soc: qcom: pmic: Fix resource leaks in a device_for_each_child_node() loop")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b979f2d50a099f3402418d7ff5f26c3952fb08bb Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Sat, 17 Feb 2024 16:02:25 +0100
Subject: [PATCH] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free

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

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 5fcd0fdd2faa..b3808fc24c69 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -76,7 +76,7 @@ struct pmic_glink_altmode_port {
 
 	struct work_struct work;
 
-	struct device *bridge;
+	struct auxiliary_device *bridge;
 
 	enum typec_orientation orientation;
 	u16 svid;
@@ -230,7 +230,7 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
 	else
 		pmic_glink_altmode_enable_usb(altmode, alt_port);
 
-	drm_aux_hpd_bridge_notify(alt_port->bridge,
+	drm_aux_hpd_bridge_notify(&alt_port->bridge->dev,
 				  alt_port->hpd_state ?
 				  connector_status_connected :
 				  connector_status_disconnected);
@@ -454,7 +454,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		alt_port->index = port;
 		INIT_WORK(&alt_port->work, pmic_glink_altmode_worker);
 
-		alt_port->bridge = drm_dp_hpd_bridge_register(dev, to_of_node(fwnode));
+		alt_port->bridge = devm_drm_dp_hpd_bridge_alloc(dev, to_of_node(fwnode));
 		if (IS_ERR(alt_port->bridge)) {
 			fwnode_handle_put(fwnode);
 			return PTR_ERR(alt_port->bridge);
@@ -510,6 +510,16 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		}
 	}
 
+	for (port = 0; port < ARRAY_SIZE(altmode->ports); port++) {
+		alt_port = &altmode->ports[port];
+		if (!alt_port->bridge)
+			continue;
+
+		ret = devm_drm_dp_hpd_bridge_add(dev, alt_port->bridge);
+		if (ret)
+			return ret;
+	}
+
 	altmode->client = devm_pmic_glink_register_client(dev,
 							  altmode->owner_id,
 							  pmic_glink_altmode_callback,


