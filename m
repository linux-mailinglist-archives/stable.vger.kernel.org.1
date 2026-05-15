Return-Path: <stable+bounces-248528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDKXARFXB2p7zAIAu9opvQ
	(envelope-from <stable+bounces-248528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:25:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E34554FD9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D02B310BF6A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D182643CEF6;
	Fri, 15 May 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pk+gJyiy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D143E00A3;
	Fri, 15 May 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861960; cv=none; b=E/mASTJ8uIaPAdI+qMsI4TMX0XZHvxctLAB5r2dZSnSZnPdl7vMF8tOjrbWNJaCJVE/lHtlL0YJDci2qiEMfLhAZ11DsWCA8sSsVyBBAK+OmvIV6xTA2eFLXXIYq8YawYoaPGWvxmtcxVRArM3/nG8mIbjrn25/OQmh/7qpWezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861960; c=relaxed/simple;
	bh=hncTYLhg8B6Ygx7tdUQhty68bzqVWJJq6ZNuc+hQAeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAmCRgq1plCMkvF03kzENKF7/cdNWppcIxAilS8X65tS0g8nqMti4jO+i8QrHgmTaX6H3mstlCivUXqYuWwhwBddWpo15woU2mLFJot9p+n22QBwzQhrOxcD5YF+gpqhSze0onRxt0t5aarBa30VZ3z/tp1e6E9YNRl0u4YUmf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pk+gJyiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13977C2BCB0;
	Fri, 15 May 2026 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861960;
	bh=hncTYLhg8B6Ygx7tdUQhty68bzqVWJJq6ZNuc+hQAeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pk+gJyiyPr53PZw3ugh/QZM3en3DjH3tRKlkAa7pyNbtz85jAfz492M6F85D5t6Bs
	 dslAHVY4wwQsmVT6bcrY/eri3yAkiT/bvj7cEnyBXE7u7KsNuTH2qjeOtiM2fqgza3
	 pDAgX0l/ELna91QDchI7yzZ637qrYQCgB4xR1+Ag=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Fend <matthias.fend@emfend.at>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.18 053/188] media: i2c: ov08d10: fix runtime PM handling in probe
Date: Fri, 15 May 2026 17:47:50 +0200
Message-ID: <20260515154658.464938466@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 97E34554FD9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-248528-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,emfend.at:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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



