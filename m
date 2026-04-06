Return-Path: <stable+bounces-233437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLSIACAU1GksqwcAu9opvQ
	(envelope-from <stable+bounces-233437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 22:14:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C043A6EA8
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 22:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4288A301CD87
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A2339D6D3;
	Mon,  6 Apr 2026 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzF24vC+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CCC39C62A
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506446; cv=none; b=VIMmTDfNUx4/Lks2X01QGeUznqMU0qz/U/7GEOF855L5+NEXvkbxaU9AoKOvXHu0f7/9oKsgCHB9CdpHYZa4SD4K9GG2oQXqYYYKw7/5H7y8euifjl75+P6PNvq5wwKJJCi3cJkyJCqFo4LeIQ0zLw1mzLt7y4CYv/3tni+pe7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506446; c=relaxed/simple;
	bh=WAyuXvHg+IDaHK96s8SFan2J1QbE5G5c5VzthemtNBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/5BUn2X/+mCnxU7ZOuNfJqmZrfdoTlgCxjtN7ncRAO/VUPUbBC+vPhGoxcf7F1nPDA7lgc1+zn/wXLCNg1J9McX2wSIgbusObeeO5b9a2sU9k1QewfdyVGnSqgq5Qs9tBXgwNBaAdblTwDHqP1HPFKkmQQR1gUEYAN5yz59zR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzF24vC+; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1271257ae53so4591454c88.1
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 13:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775506444; x=1776111244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtWSJAsPoNeIGexvUzam2g4A6bay7wxoWEXeu9FJabM=;
        b=PzF24vC+vYWCfIvwd9U5wFTsDs1cYnKBwsfqHYD8CQJxYnRujtA/UWbEY6j/WORXiO
         5Pn0ohyRJsV/iVjnhAjQV7SoDg6kdBDSHcLOVud6oqRww154NsoS9e/m7rh6Uvstye0C
         1M+vtCfikxA9hoK3xTo9Le/NckovI5c6m+Ya/RSI1lFzaF4BUZAWEEB+aUM1yOyltuPZ
         gREFYh+j0vbFMsxhEGDXGhn7t0e6ske20+y743qy9Mir7BKKEwHYHDTRE54sMyrHRv6i
         WO8b6woSfv6AO4guer3cW3FTBrRZyQGkW3cdbwsYyuqtEV/6tcJC/DpltJa7qExfZZ7f
         bHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775506444; x=1776111244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtWSJAsPoNeIGexvUzam2g4A6bay7wxoWEXeu9FJabM=;
        b=eatvK4AB/jayZOtBd2m/V1ssax5iK0AdSsCfMmMhXWdW9G0+K69PL9TbSASA8BnbaX
         A6Q0xJMbepyz8SdbiUzy2Xf1OlpCanPkFOCL4DPT/6F3ryZvjtUUO+w/xpon7i7D1cbL
         oWzsSkRcQTFkEEQcM3H2LQUPhMKOfFDGxuXbrCn64YmtVIj316FAVDr7rFYNsI/eSOoS
         Dlk6sKyo2RBcO+rhlHmlzDrNs5DORSPXStjT4KzSOOiEGIwQn4k96Cq30gKyWEhDtfir
         AkHplveXRedPdQdruLCkZ0nEjtseh94JQlyoYrDEPPtRB1G2NlfFb3eIjjGLZGGLsOI+
         AKjw==
X-Forwarded-Encrypted: i=1; AJvYcCXcIcjx+WV8UccrGdXqIGaBqAC3ArfSFCvZT8c63nxGjd2x++3/YW+iiWmTkis5lHgHGnIIT8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1y7UVNConaFRAnAFdSt0Mf/Djvd0Q+/0thu+WB0m1SI7Lw/9c
	/V54WfAXY9Q+j7g6dJmFSijUkBEGQ6nEi2wnOcHWnb0m6BhRW/MUS+ea
X-Gm-Gg: AeBDieuccHJ38ciAdfoJMN4KeU4XpAoGJuGFZ3Aeb2UbH6vtkKGtexD/xWPzKezs74N
	Cfnk8jw79IQ1Ddt0+7vcNuKsXQVr4A1gx78sBFYJ7x5yXXfb/tvZWF8zzRSXxCSVd7XdB2Sbthi
	8g/g50ia89sn50za7uACtMFMuysQ/eMWEVjstVbfL04bvHK3dzX2U2SrSzGiLtaPtZOZkuIGqb2
	oW26cRkNfpp9BvIL4mKKRX2cCh79qd5lJ91Crp7ogH7Tdj4sPqv6eE9GWAzjKR4baytBtJsjOe2
	2hzk96macIjk9ReVf/rcRJ1nWTC1YHFtJO69DWgB0H6gFM9GGEXDE4CW3uGjviv52VZqq/rq75t
	DthdmwBX+Ude+U6VNg6jxmymXyyyay5+gn3FyGEGvEr8uCQAzSYnSS6u16SSfm+M9PUunLYzth8
	ooRAaYZ2Ewgecgcn2G4VObCIFeZ+LMfkhAOB7f045lxR+I3K9OcescCdvVIjomuXEzzOLS3AM9V
	jaO
X-Received: by 2002:a05:7022:112:b0:128:e6d0:d7c3 with SMTP id a92af1059eb24-12bfb73eec9mr6480840c88.20.1775506444250;
        Mon, 06 Apr 2026 13:14:04 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm17022333c88.0.2026.04.06.13.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:14:03 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v8 02/16] platform/x86: lenovo-wmi-other: Balance IDA id allocation and free
Date: Mon,  6 Apr 2026 20:13:46 +0000
Message-ID: <20260406201400.438221-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406201400.438221-1-derekjohn.clark@gmail.com>
References: <20260406201400.438221-1-derekjohn.clark@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233437-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,rong.moe:email]
X-Rspamd-Queue-Id: B5C043A6EA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rong Zhang <i@rong.moe>

Currently, the IDA id is only freed on wmi-other device removal or
failure to create firmware-attributes device, kset, or attributes. It
leaks IDA ids if the wmi-other device is bound multiple times, as the
unbind callback never frees the previously allocated IDA id.
Additionally, if the wmi-other device has failed to create a
firmware-attributes device before it gets removed, the wmi-device
removal callback double frees the same IDA id.

These bugs were found by sashiko.dev [1].

Fix them by moving ida_free() into lwmi_om_fw_attr_remove() so it is
balanced with ida_alloc() in lwmi_om_fw_attr_add(). With them fixed,
properly set and utilize the validity of priv->ida_id to balance
firmware-attributes registration and removal, without relying on
propagating the registration error to the component framework, which is
more reliable and aligns with the hwmon device registration and removal
sequences.

No functional change intended.

Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/wmi-other.c | 34 +++++++++++++++----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 6040f45aa2b0..b47418df099f 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -957,17 +957,17 @@ static struct capdata01_attr_group cd01_attr_groups[] = {
 /**
  * lwmi_om_fw_attr_add() - Register all firmware_attributes_class members
  * @priv: The Other Mode driver data.
- *
- * Return: Either 0, or an error code.
  */
-static int lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
+static void lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
 {
 	unsigned int i;
 	int err;
 
 	priv->ida_id = ida_alloc(&lwmi_om_ida, GFP_KERNEL);
-	if (priv->ida_id < 0)
-		return priv->ida_id;
+	if (priv->ida_id < 0) {
+		err = priv->ida_id;
+		goto err;
+	}
 
 	priv->fw_attr_dev = device_create(&firmware_attributes_class, NULL,
 					  MKDEV(0, 0), NULL, "%s-%u",
@@ -993,7 +993,7 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
 
 		cd01_attr_groups[i].tunable_attr->dev = &priv->wdev->dev;
 	}
-	return 0;
+	return;
 
 err_remove_groups:
 	while (i--)
@@ -1007,7 +1007,12 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
 
 err_free_ida:
 	ida_free(&lwmi_om_ida, priv->ida_id);
-	return err;
+
+err:
+	priv->ida_id = -EIDRM;
+
+	dev_warn(&priv->wdev->dev,
+		 "failed to register firmware-attributes device: %d\n", err);
 }
 
 /**
@@ -1016,12 +1021,17 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
  */
 static void lwmi_om_fw_attr_remove(struct lwmi_om_priv *priv)
 {
+	if (priv->ida_id < 0)
+		return;
+
 	for (unsigned int i = 0; i < ARRAY_SIZE(cd01_attr_groups) - 1; i++)
 		sysfs_remove_group(&priv->fw_attr_kset->kobj,
 				   cd01_attr_groups[i].attr_group);
 
 	kset_unregister(priv->fw_attr_kset);
 	device_unregister(priv->fw_attr_dev);
+	ida_free(&lwmi_om_ida, priv->ida_id);
+	priv->ida_id = -EIDRM;
 }
 
 /* ======== Self (master: lenovo-wmi-other) ======== */
@@ -1063,7 +1073,9 @@ static int lwmi_om_master_bind(struct device *dev)
 
 	lwmi_om_fan_info_collect_cd00(priv);
 
-	return lwmi_om_fw_attr_add(priv);
+	lwmi_om_fw_attr_add(priv);
+
+	return 0;
 }
 
 /**
@@ -1115,13 +1127,7 @@ static int lwmi_other_probe(struct wmi_device *wdev, const void *context)
 
 static void lwmi_other_remove(struct wmi_device *wdev)
 {
-	struct lwmi_om_priv *priv = dev_get_drvdata(&wdev->dev);
-
 	component_master_del(&wdev->dev, &lwmi_om_master_ops);
-
-	/* No IDA to free if the driver is never bound to its components. */
-	if (priv->ida_id >= 0)
-		ida_free(&lwmi_om_ida, priv->ida_id);
 }
 
 static const struct wmi_device_id lwmi_other_id_table[] = {
-- 
2.53.0


