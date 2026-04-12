Return-Path: <stable+bounces-235859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIUUKtkK3GlaLgkAu9opvQ
	(envelope-from <stable+bounces-235859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 23:12:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A903E6114
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 23:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47241301E3EE
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 21:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EC238237E;
	Sun, 12 Apr 2026 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cek/NTrw"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D596381AFF
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028289; cv=none; b=CtQ5sWGArrv/6S+mDWpogo7Rs+khNTFfihGgJwqr+TxG5CFv9mVfT58ygVx0QkS9VMjJFbd55OJ27eAVrkaFAkoNMAo8u1U083+JA1kLb8mQkg+EmNd00s/95JU/9mKAWsbkIeBwOkoB8tLbSxtK32kvEhgLC3vtfdZaagIVyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028289; c=relaxed/simple;
	bh=8LUDQtMderd6djIBXviEFlt08t4GGAhmClar2YVACLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9GjSKAVr2FG0IPc1LX5ESlQ6JVoMznc4cyJXwKeiipdmhtEarJushbgzbEPAbDO8CKHeUGxiBxMUCcxJ3o3P4fxEDHM6rdQFNH03rBxRN6WiZxIIm0zsoXgoAqhGcuPGrKavf725hGa+p856eebB7DawjTCsZKbPutY1vlBF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cek/NTrw; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732165d1eso13329247c88.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776028285; x=1776633085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnJVHMF3J4KnB49uOjeY/NdO1ByBdmanEQTbiS1LzsE=;
        b=Cek/NTrwj0gnqNy56kJ0w7TIKVANFl6GBb1SjPx5H2SsR4UPpIriCh0LjkVCsAELZn
         7fYKBWxAVn3Oos9qvdrebals4LjHCxDgPLe43Ck8uPUPCGWeQE7d/vFZActRdtTHeopO
         ksdQSepVZuQKKIYIeMXgqdhBifnN0KyXf3QzyvAM7cjKR7q3bRb8iCYcKvvV7TS8Ro3d
         icEY9DBSoLFalAtVdfdLd6N/8bM49M6h79qiocUUvB1z7c8yGuK6aezUfY1uqSLu03RR
         MhytgPpNCWDczuv7skkRE8pMr127CfkZK7zEgP3NLDkF5y+WZ5MWf3RBu/bUUaUh/nKT
         LuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776028285; x=1776633085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JnJVHMF3J4KnB49uOjeY/NdO1ByBdmanEQTbiS1LzsE=;
        b=PvwPCjTiy5jxSqZio0JqOBWooDzgwg32mwQfpmR5iVtFv0LbT2zrzMvWssCQAwQXpx
         3lMdleYnGikUVP4oBQtTBPlbRKruY4vjvWkkKsaTg6LfPMALdz6F36S+F04CgEpV59f4
         j7mjn96pXiUzX2DmJhTDK6vb9wSSB1ZDaGnjXQdybCbj4WkUQ+dwLF/ZJW+FPCTdunul
         0++qhR/27tUSFXVOa6dAt62BHyBeEknB48uQJR6EO61Rho7EG+oaXiWDhxu5q6QKdyh8
         2tAcDrcaEHJcOVMDLZB9Fkt13m+bl9Uy8l81OXRVqZI23qU4ToL5ITQrEY14lfxjTZAJ
         dykQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5HXvIUXwe1jDbrfAOVv8lv4mxH5CjYXC4m6epDzAP9Fz1xnrEYOZQCL5FF6aJC5XTzqnq+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD2RRLnQFlh4L/KjolLXHMpcyVwm7l9EzYTT+C1QhyPlAkP5rj
	8X48vCbNsy8YmRyk54fvXlCv0xTN2/47QNUYjKhjcam1o7vZa9hqQUA+
X-Gm-Gg: AeBDiesfi7nts+1tHqa8Oz+p55534BnbEAaB0yFvOhe/4ZoL4HXIm7f1tAkB35BLKa8
	ILmYmxkKuh5Smgp5hB9gIvv9Vvcl7y/gxb+SWd5wrCCQx6Y9Ii103WszjP50x2ZjHqrcGXsELy2
	zY1Hwc3Gv5XJYIFZRrmUqC+qrW28oMjYL8030sf7PplzdKZu44Mu8Pp/a7esjFuOM2GlSom2lwi
	vepIOcECAhoVp+HanTZhBvI/PMIR/oTfYw8tZQSVWuiOxKAu8EBxqsB2CddCnKLZd3KLW2m0Z7N
	I/7zoPD1EztQ+UASPop3kpvRvv3tNRPkWIkoGoZMMa75EytUikHfZ945EiAy+sanY8DYFqaFWXp
	T6Xp2mc49HqvVGD20B73tsFBtlYSmO9pgQOKMOsl9dzbFa3KxatJ/eYVYRzkx7LdMMN5kYrGrH+
	upnWEnkUJrN8tmW+V7oRQuJEgRwLbHfzW/eloPGmaALPJDi+cGHRBRPj7Lw9RbqMbN8jtGWfyr5
	FXZLU2/ftOhgNg=
X-Received: by 2002:a05:7022:622:b0:128:df80:1852 with SMTP id a92af1059eb24-12c34e55bc9mr5865117c88.9.1776028285266;
        Sun, 12 Apr 2026 14:11:25 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb141sm11520856c88.12.2026.04.12.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:11:25 -0700 (PDT)
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
Subject: [PATCH v10 02/16] platform/x86: lenovo-wmi-other: Balance IDA id allocation and free
Date: Sun, 12 Apr 2026 14:11:07 -0700
Message-ID: <20260412211121.2220556-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412211121.2220556-1-derekjohn.clark@gmail.com>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235859-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 25A903E6114
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

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v9:
  - Invert err logic for when allocating IDA fails.
  - Rename ida_alloc err goto from 'err' to 'err_no_ida' to disambiguate
    from 'int err'.
---
 drivers/platform/x86/lenovo/wmi-other.c | 36 ++++++++++++++-----------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 6040f45aa2b0..be3309d74e03 100644
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
 
-	priv->ida_id = ida_alloc(&lwmi_om_ida, GFP_KERNEL);
-	if (priv->ida_id < 0)
-		return priv->ida_id;
+	err = ida_alloc(&lwmi_om_ida, GFP_KERNEL);
+	if (err < 0)
+		goto err_no_ida;
+
+	priv->ida_id = err;
 
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
+err_no_ida:
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


