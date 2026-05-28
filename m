Return-Path: <stable+bounces-256326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI1hG6ysGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:59:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C475C5F9FF1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86A093237771
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A130330B32;
	Thu, 28 May 2026 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tB/A0AyF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2ED327C00;
	Thu, 28 May 2026 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001388; cv=none; b=ovrzwrn3+K8tYt5nfrDXLWjrz02cX1MDTPLfjQRRv73rtsiIgHO1Ivd0GEunTwtfRmf1rQwmaLjNEGufHazAqaovFqMQsSbZhvwAoiXrU+meOCRB5p3/UOkvO7bBiWxXWvugqg5rHswHkOWtxWFCNJVRJC+6NuKzDJr/uz0i4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001388; c=relaxed/simple;
	bh=EqPvrqkoEJImhiLDjNZO2vcJsW/TJ3wIdnlF/9w2yOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtFApMMbt212InYzrRX4LYHjA3jvLEhCmGpFLzJEAmxeK+eR1xdzqSWF4M6iw3rkIO3NP/O/aN4mrE/O4+6f5YF7xcl8U5Ez84/rGOwZ//Qtr/KuHV+BPAH3ct3Knnip4hQby7g0HXDAsi8XGYcwdhr32p6R7mSzYQbgQvAYP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tB/A0AyF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C15C1F00A3A;
	Thu, 28 May 2026 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001387;
	bh=SJWE1ZybbuV/xmh6nZMqSa46rWzEBBxqwEXu67/xkDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tB/A0AyFsQsrLueH02OBuDDPnuo4KcYdEjCuXPDuQYeboUDO1wIqNV+zi9z5ITYxP
	 Z/qmDTCc7937OzirvrorWMKDxOJbyB5PYI43Up3981B7IcLQs/2UHLcVVicRhPfio8
	 C+S8qNYetiP7k+FgjFfPhFzoWJ8dkSwl8u+IPzSA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Ian Ray <ian.ray@gehealthcare.com>
Subject: [PATCH 6.6 072/186] drm/bridge: megachips: remove bridge when irq request fails
Date: Thu, 28 May 2026 21:49:12 +0200
Message-ID: <20260528194930.884555871@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-256326-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,bootlin.com,gehealthcare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,gehealthcare.com:email]
X-Rspamd-Queue-Id: C475C5F9FF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Osama Abdelkader <osama.abdelkader@gmail.com>

commit d45d5c819f2cd0b6b5d76a194a537a5f4aeefecb upstream.

If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
bridge before returning.

Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
tied to the STDP4028 device while ge_b850v3_register() may complete from
either I2C probe; devm would not unwind the bridge if the other client's
probe fails.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: fcfa0ddc18ed ("drm/bridge: Drivers for megachips-stdpxxxx-ge-b850v3-fw (LVDS-DP++)")
Cc: stable@vger.kernel.org
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Ian Ray <ian.ray@gehealthcare.com>
Link: https://patch.msgid.link/20260430195700.80317-1-osama.abdelkader@gmail.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c |   16 +++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -302,7 +302,6 @@ static void ge_b850v3_lvds_remove(void)
 		goto out;
 
 	drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
-
 	ge_b850v3_lvds_ptr = NULL;
 out:
 	mutex_unlock(&ge_b850v3_lvds_dev_mutex);
@@ -312,6 +311,7 @@ static int ge_b850v3_register(void)
 {
 	struct i2c_client *stdp4028_i2c = ge_b850v3_lvds_ptr->stdp4028_i2c;
 	struct device *dev = &stdp4028_i2c->dev;
+	int ret;
 
 	/* drm bridge initialization */
 	ge_b850v3_lvds_ptr->bridge.funcs = &ge_b850v3_lvds_funcs;
@@ -329,11 +329,15 @@ static int ge_b850v3_register(void)
 	if (!stdp4028_i2c->irq)
 		return 0;
 
-	return devm_request_threaded_irq(&stdp4028_i2c->dev,
-			stdp4028_i2c->irq, NULL,
-			ge_b850v3_lvds_irq_handler,
-			IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-			"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
+	ret = devm_request_threaded_irq(&stdp4028_i2c->dev,
+					stdp4028_i2c->irq, NULL,
+					ge_b850v3_lvds_irq_handler,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
+	if (ret)
+		drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
+
+	return ret;
 }
 
 static int stdp4028_ge_b850v3_fw_probe(struct i2c_client *stdp4028_i2c)



