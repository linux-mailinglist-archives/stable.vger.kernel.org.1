Return-Path: <stable+bounces-263973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CZMcLp9sMWrwiwUAu9opvQ
	(envelope-from <stable+bounces-263973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:32:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9C5691201
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:32:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ZjnlArrQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263973-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263973-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA93B30C1E55
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE3A44102F;
	Tue, 16 Jun 2026 15:24:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF18543E4BC;
	Tue, 16 Jun 2026 15:24:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623467; cv=none; b=Q/LyPnthkiqlmi96MY8wg4Uw4BcIRchMkCVeDFJarJnL53KCwlJlA37u8vezGVA+4IDNk7oyVzXN8VumttSH43+Gs5wpkgfXYs8L/WOIVxBYvWEHt9PxTsEE2lLMFrD9wlzVxoqBRIu8q9QKtoTuwav4aVDHuMDoLLq6X3ojYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623467; c=relaxed/simple;
	bh=6TyEpjZmaSrxZTdh7VWaMgv5WVByhB4pcJFHYSBtz/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVINfI7AziMMk8Z9uPreBZb6syb0P0p/FsuJlbjNZnIRZsEOgQfHJIUIxEm3vlZxF+/HydGd70HE6rYL4F1L6RzyRvOcXAoipSeo+p3cjscl/Kvk9oGdOUj2By9yQz8uVN2w2flyfGvjFfPIWTH3P8pbMfj+fVp1IHgNxStkWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZjnlArrQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6B31F000E9;
	Tue, 16 Jun 2026 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623465;
	bh=JWVerD3xiqs7o/I58kqHgD2Q0nxmYyVGVke2VdzpxV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZjnlArrQtciZB3d17A+HnbsVKcnydWk+3G62w6FstVG7oHCde/+lkWErTWTWGkxAf
	 xMXHDRLO2WD/up+aOhKZIPNvLSonLnCJjIm59eNRRTMGHWJzyt/AR2+HyLQtS9JFNC
	 JX2rd8uCLWjx4I81T74BsG39L9huaA/lH1cpaGpE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kean Ren <rh_king@163.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 154/378] ASoC: SDCA: fix NULL pointer dereference in sdca_dev_unregister_functions
Date: Tue, 16 Jun 2026 20:26:25 +0530
Message-ID: <20260616145118.355105732@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,163.com,opensource.cirrus.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-263973-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rh_king@163.com,m:ckeepax@opensource.cirrus.com,m:broonie@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,cirrus.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF9C5691201

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kean Ren <rh_king@163.com>

[ Upstream commit e4c60a1d4b6ccc66aefb3789cd908d4f9482eefd ]

sdca_dev_unregister_functions() iterates over all SDCA function
descriptors and calls sdca_dev_unregister() on each func_dev without
checking for NULL. When a function registration has failed partway
through, or the device cleanup races with probe deferral, func_dev
entries may be NULL, leading to a kernel oops:

  BUG: kernel NULL pointer dereference, address: 0000000000000040
  RIP: 0010:device_del+0x1e/0x3e0
  Call Trace:
   sdca_dev_unregister_functions+0x37/0x60 [snd_soc_sdca]
   release_nodes+0x35/0xb0
   devres_release_all+0x90/0x100
   device_unbind_cleanup+0xe/0x80
   device_release_driver_internal+0x1c1/0x200
   bus_remove_device+0xc6/0x130
   device_del+0x161/0x3e0
   device_unregister+0x17/0x60
   sdw_delete_slave+0xb6/0xd0 [soundwire_bus]
   sdw_bus_master_delete+0x1e/0x50 [soundwire_bus]
   ...
   sof_probe_work+0x19/0x30 [snd_sof]

This was observed on a Lenovo ThinkPad X1 Carbon G14 (Panther Lake)
with the SOF audio driver probe failing due to missing Panther Lake
firmware, causing the subsequent cleanup of SoundWire devices to
trigger the crash.

Fix this with three changes:

1) Add a NULL guard in sdca_dev_unregister() so that callers do not
   need to pre-validate the pointer (defense in depth).

2) In sdca_dev_unregister_functions(), skip NULL func_dev entries
   and clear func_dev to NULL after unregistration, making the
   function idempotent and safe against double-invocation.

3) In sdca_dev_register_functions(), roll back all previously
   registered functions when a later one fails, so the function
   array is never left in a partially-populated state.

Fixes: 4496d1c65bad ("ASoC: SDCA: add function devices")
Signed-off-by: Kean Ren <rh_king@163.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20260611023757.1553960-1-rh_king@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdca/sdca_function_device.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sdca/sdca_function_device.c b/sound/soc/sdca/sdca_function_device.c
index feacfbc6a51880..b5ca98283a8895 100644
--- a/sound/soc/sdca/sdca_function_device.c
+++ b/sound/soc/sdca/sdca_function_device.c
@@ -82,6 +82,9 @@ static struct sdca_dev *sdca_dev_register(struct device *parent,
 
 static void sdca_dev_unregister(struct sdca_dev *sdev)
 {
+	if (!sdev)
+		return;
+
 	auxiliary_device_delete(&sdev->auxdev);
 	auxiliary_device_uninit(&sdev->auxdev);
 }
@@ -90,14 +93,24 @@ int sdca_dev_register_functions(struct sdw_slave *slave)
 {
 	struct sdca_device_data *sdca_data = &slave->sdca_data;
 	int i;
+	int ret;
 
 	for (i = 0; i < sdca_data->num_functions; i++) {
 		struct sdca_dev *func_dev;
 
 		func_dev = sdca_dev_register(&slave->dev,
 					     &sdca_data->function[i]);
-		if (IS_ERR(func_dev))
-			return PTR_ERR(func_dev);
+		if (IS_ERR(func_dev)) {
+			ret = PTR_ERR(func_dev);
+			/*
+			 * Unregister functions that were successfully
+			 * registered before this failure. This also
+			 * sets func_dev to NULL so the caller will not
+			 * try to unregister them again.
+			 */
+			sdca_dev_unregister_functions(slave);
+			return ret;
+		}
 
 		sdca_data->function[i].func_dev = func_dev;
 	}
@@ -111,7 +124,12 @@ void sdca_dev_unregister_functions(struct sdw_slave *slave)
 	struct sdca_device_data *sdca_data = &slave->sdca_data;
 	int i;
 
-	for (i = 0; i < sdca_data->num_functions; i++)
+	for (i = 0; i < sdca_data->num_functions; i++) {
+		if (!sdca_data->function[i].func_dev)
+			continue;
+
 		sdca_dev_unregister(sdca_data->function[i].func_dev);
+		sdca_data->function[i].func_dev = NULL;
+	}
 }
 EXPORT_SYMBOL_NS(sdca_dev_unregister_functions, "SND_SOC_SDCA");
-- 
2.53.0




