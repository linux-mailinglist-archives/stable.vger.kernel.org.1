Return-Path: <stable+bounces-248736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HzGIBZaB2qzzwIAu9opvQ
	(envelope-from <stable+bounces-248736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:38:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7975555A3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5538B312B717
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DBE43CEF6;
	Fri, 15 May 2026 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z+QpFIOY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AB3F58CD;
	Fri, 15 May 2026 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862497; cv=none; b=MEOL185GYV89Uiqokyy9yELIvkl/ebp0sgU1dl0Ow2bXyFyrALypbAhvW+NOc9WHXBGXiePqdpSoMJkvnhXpI4EHoW0fUhWryfaX/vHDgW+zqgL2e8vqAhEBBM38TSUAFnxd5u3EC56narIWMJirBkcwSbPD6Wk4xHjDJOrB5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862497; c=relaxed/simple;
	bh=Iv3aE4PDFcj6+GVRYDGqCX22qKWW8qN49Jxj7MZhv5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0wWYRwUjMWhZ9O0E4G+cNC5wqOJjNzkBAF88TDhBVCwYpLWjidUwgz2KYDPXF95JKIRTvOcI10DRAnFeTCymbuSlw9aQ0zZP/FfSW7QGHwZsOyCzmUXRifZd9IEiovGw82htLtKASLS69GF/wKmT6GOTbLEHG9LuiE8fOpzm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z+QpFIOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8AFC2BCB3;
	Fri, 15 May 2026 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862497;
	bh=Iv3aE4PDFcj6+GVRYDGqCX22qKWW8qN49Jxj7MZhv5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+QpFIOYVbvR0t8ohaM0ra+zAsVNF18Ua8Qm1U96gxcJOZftiD3d3EQe3EOIJp1rj
	 K8tA0MlzYWbgIXwfY81c6z4YxlGQ9KMUbAb3zsBAEFezVbc3TQve08HEl+dQNOpzXH
	 tPIP9z/dcJnz5h+WrGpkbVjmZcewtuOR7vEelZpQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Fend <matthias.fend@emfend.at>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 7.0 070/201] media: i2c: ov08d10: fix runtime PM handling in probe
Date: Fri, 15 May 2026 17:48:08 +0200
Message-ID: <20260515154700.049422769@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: EE7975555A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-248736-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,emfend.at:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Fend <matthias.fend@emfend.at>

commit 35c7046be2be5e60be8128facb359a47f39e99cd upstream.

Set the device's runtime PM status and enable runtime PM before registering
the async sub-device. This is needed to avoid the case where the device is
runtime PM resumed while runtime PM has not been enabled yet.

Remove the related, non-driver-specific comment while at it.

Fixes: 7be91e02ed57 ("media: i2c: Add ov08d10 camera sensor driver")
Cc: stable@vger.kernel.org
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Matthias Fend <matthias.fend@emfend.at>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ov08d10.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/media/i2c/ov08d10.c
+++ b/drivers/media/i2c/ov08d10.c
@@ -1430,6 +1430,9 @@ static int ov08d10_probe(struct i2c_clie
 		goto probe_error_v4l2_ctrl_handler_free;
 	}
 
+	pm_runtime_set_active(ov08d10->dev);
+	pm_runtime_enable(ov08d10->dev);
+
 	ret = v4l2_async_register_subdev_sensor(&ov08d10->sd);
 	if (ret < 0) {
 		dev_err(ov08d10->dev, "failed to register V4L2 subdev: %d",
@@ -1437,17 +1440,13 @@ static int ov08d10_probe(struct i2c_clie
 		goto probe_error_media_entity_cleanup;
 	}
 
-	/*
-	 * Device is already turned on by i2c-core with ACPI domain PM.
-	 * Enable runtime PM and turn off the device.
-	 */
-	pm_runtime_set_active(ov08d10->dev);
-	pm_runtime_enable(ov08d10->dev);
 	pm_runtime_idle(ov08d10->dev);
 
 	return 0;
 
 probe_error_media_entity_cleanup:
+	pm_runtime_disable(ov08d10->dev);
+	pm_runtime_set_suspended(ov08d10->dev);
 	media_entity_cleanup(&ov08d10->sd.entity);
 
 probe_error_v4l2_ctrl_handler_free:



