Return-Path: <stable+bounces-232848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFfvGm9szWnvdQYAu9opvQ
	(envelope-from <stable+bounces-232848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 21:05:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF9A37F9D2
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 21:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D1153064E98
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05170269B1C;
	Wed,  1 Apr 2026 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Apz2JWyl"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB62F1FEA;
	Wed,  1 Apr 2026 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070161; cv=pass; b=JJaXO/I6adqOMtuNEC4Sfm6A258FtaDNDm1PEQbb3D9NrqUqhpNZ3RAhLvZWJzOIGn//pzkQcDlR9M4A+2XuzFHO5vVTZgGNlfAygdWyq3vWKe+OUWBkiq5ZRxFBXuMeDz6i/tXM3faKRt4vevNLkw9Argdn01wQLrfEU+jNaDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070161; c=relaxed/simple;
	bh=K/4heQCSBx2y/WOPGPm0vZWQI1iInHQeynSlpB+uXDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKo/aWVJNhvD0h1fArXs3BbyIs3h69JTiX5T8CMCCx7bJyZBKVxUKadmyIuMpc7/x8ZfqOc6gJr4JIZPtklyJUopTZzRU//FLy0e+q2U5efB64eN8oe2QLqipq40dIaoDnGt+PRyooo+awZ7A+rRTMEEmCBAVhfU+Clxr7NAiiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Apz2JWyl; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1775070151; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P1Y57HW9zybDhTWyiX4TU9ledMmSsLySUjUarRDAXfup77eg+yAFJ+145KzZA/rbZFSUF+ji/3l8h+H1G1Cdy42ny171X3HohyKCftwNZymA90VMd0+QSOGv+hyIaOv6blGge25xeojCZ9KuWVsBfeimWRaEYd1r0wQeXFOTAgI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775070151; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/e4Sc5qee3F2Uk+M/DgIs5gat9OGFgWOA1zU+xUnZ7U=; 
	b=l/kG0is/Txqrjq7o3iYEtfeM6owH6iJwwuFYzrgkjLspxchOPRdyZC/mg+n9T/yxoS7V1XXarCUpm80BjEM5Yub2TshidbL60hSgArWc2pA/VZbTQHX92/5FToJ8S8slcgkB4xXUHtStoaOBbtiaxHe4dy07NFSf6oK70j4XpGM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775070151;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/e4Sc5qee3F2Uk+M/DgIs5gat9OGFgWOA1zU+xUnZ7U=;
	b=Apz2JWylwen1Uz40PEa5fbEBpN5h7G846Um00mRVkNUDLkzLoTD2R/Nr+tMPrw5+
	Ysr5uPT/3KIPWkwihedAaWOw2UWInf2jF0CPHizvm2QRBTZF/npJTU1H2thYi2HenYl
	d99fDXf/ANSC6KeCA+nHvemS0slvYw2ni6bpLryRVVFMPX5ypMoUz6TVZEZPa3T85zp
	xKWkFPyhwTZi7c6tH4tbPIkQNp5Lkf1IMNIYdHmo1JRz57WKuV0294clMFoFO+v9IrE
	BTzgaBpiRUG7cbjCjfpKfcA6ZaOZXriooiaw3RfIpiNVN8Qo87J70HPkXieu+WJPClu
	dEE0wmaotA==
Received: by mx.zohomail.com with SMTPS id 177507015003269.82753850439974;
	Wed, 1 Apr 2026 12:02:30 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Kurt Borja <kuurtb@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: lenovo-wmi-other: Balance IDA id allocation and free
Date: Thu,  2 Apr 2026 03:00:56 +0800
Message-ID: <20260401190221.1595264-2-i@rong.moe>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <499fa3efd5be054ffdda77dd00ad4d8d3391e073.camel@rong.moe>
References: <499fa3efd5be054ffdda77dd00ad4d8d3391e073.camel@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rong.moe,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rong.moe:s=zmail2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[rong.moe,squebb.ca,gmx.de,lwn.net,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232848-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rong.moe:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rong.moe:dkim,rong.moe:email,rong.moe:mid,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFF9A37F9D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


