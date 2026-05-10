Return-Path: <stable+bounces-244996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFTHLfAIAGq9CAEAu9opvQ
	(envelope-from <stable+bounces-244996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:26:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65940502817
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9A9C3028EE2
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 04:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EBB2C027A;
	Sun, 10 May 2026 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSGWCjEw"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8C286D7D
	for <stable@vger.kernel.org>; Sun, 10 May 2026 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778387153; cv=none; b=MlkSasfOJqF0GKFF8K/kZ8cnYQyn5Rb6zCcfhRi6VdT68wXSo3r+ZW0tdAAGlnhrq80d8v7IN36F84RYJS5R8T5fvymQbQRoy5OlflbqyKpv3HvOgcYXUs+WhvGmB5JidoGfQjT8cqubN25NLtFrs0EVorsDdfwkwwiCTGPKMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778387153; c=relaxed/simple;
	bh=8LUDQtMderd6djIBXviEFlt08t4GGAhmClar2YVACLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+Q0TeVVoOHGFNQdJFLnZ8zuZx8kFeCStK+/sV+9aLF48VluvEMgAxG1wgogKmFwvDPjwiSMPx0tmSzo8mrmySw5CH4pxNf2akg7ao0hWq9T3Jpng08P/klIJenAWeqHvDMmvXRL/QOlnTd3x6jdtUNSYYyQGjjHscUGEXU9xIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSGWCjEw; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f68f3b075fso3369133eec.0
        for <stable@vger.kernel.org>; Sat, 09 May 2026 21:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778387151; x=1778991951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnJVHMF3J4KnB49uOjeY/NdO1ByBdmanEQTbiS1LzsE=;
        b=gSGWCjEwr+ZPfijtrCy69MG15wxzsq9xLzv3dY4e9UqdbQ+Z8WK/2nCo11I4S8xtp4
         0j84obEcGJnJhxyb3fAeB5fncC0NtBwVR9Z0F3TVt/+f6Ij8tk3Bp5d1bnHtEVoUPkTg
         thcDHy1h20dM2xDSElSS7VGu7wxhF8RxGnQLKzlOxSyTTQ9I1lIq5ue0U4RHkp+WU5Wn
         diIZcJWpPG2oqKaqJdKdeuwcHbzbWb/i8r8ziiu45pBUYADkm9ZSTqTwZjZOQ0fiyiZK
         uAXpFDlD0KM64YLIewjor9v902HYNyOeSMFvhJiQ/aiIb3KOJsuj1+Ew3df/f4Hi+v0x
         9zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778387151; x=1778991951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JnJVHMF3J4KnB49uOjeY/NdO1ByBdmanEQTbiS1LzsE=;
        b=J2qAsuzs6ols1uCW+YkC1qUKr98QlTF9LcrrDWIuQ4sKhVi0EkoHn1uMx+efxbwCg8
         hmx66r7IAGG/+bNf6rUFTOIGlh/otN/AcT4BZbTY7I946joiuMsyULhb7ujv6M9TEybH
         4iCCP/RLAgEn9C9i9afP4MyGYS3CAeDcK5CiQj204cFIQwH9Kfoek5gmDtXKKTcjbsa2
         82yTYfJNmtvNrCahYu/NzDvclfCjjBtUpF1HmP3j7buP+B0PSLGIzplkxJdlDyBkHuLn
         4Ojb54580Ev8lSix5oR9KekRJoDyg8O6dHu4Z25RyZFr+bmYaTh/3kYhNp5u9Ph/zlia
         8Jrg==
X-Forwarded-Encrypted: i=1; AFNElJ8oMZSF74cvkPuewuPPOyd4xlkbwhWks9pVamtfbE+1eD1k+MQe82Faoh8YG3y0AAW0kP8obBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfaJInBWHzV7f89VQ6vOA/gh0UINJcE1b4T901dFmsS5pmaE7n
	mI+OVcX+3b98OP6VlkUZPnV+nBw+FAd7GSw1d7TmrkiN25/tiuNznzVg
X-Gm-Gg: Acq92OFuP0ErWbr9v3Jc1YwUTE6J+HPS+aq1oOnj8wD06JXT2Hd9PBzMWbV39apexOh
	0TEZzVhAlbaAlVQck/ZzniYPET5sJk7yPZ5mlrdruDuu12MXbu1RKbtudtyENA3CIC9HYwHAoUQ
	a8QGqcQI0rLntcF7zNabow6r6mIFzlBuk9nNTdNtU+R6VxbPKlJxXUA8Tic8nVtpwGFCy+EHhpK
	4BxAQwS1bI9ywj3pvnlKpO0RcUQnW5KwWdBzVabArBZhaIpP/qgFlctaCtq5LTnQrWACIFeAwQ3
	L1Fn1U9ZEh+sQm4zkN6OxxShPGzvg8ZicJmhv/ccYU1Q9njKdkZ6/ZAk8WFVCFaB+0kyWQfp9po
	0BtlCmtsqWc+8YIaqy2B0idt8l4grOxLP5fBLaeoZZ90DJvNAuyN/kVMnRSDccEMMvmpkmMiO6Q
	Vxa5uaIrWrq/WMzRwZUilvq4caJes0b2DKpLd3UfoYFb4Avc6bHM6Ci1RTodsYmAVfh+DV0pXfp
	Xtu
X-Received: by 2002:a05:7301:4088:b0:2ed:6f94:9d9f with SMTP id 5a478bee46e88-2f85c07ca45mr4571233eec.11.1778387151021;
        Sat, 09 May 2026 21:25:51 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm10069960eec.10.2026.05.09.21.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 21:25:50 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	marshall@shzj.cc,
	hyacinth@shzj.cc,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v12 02/16] platform/x86: lenovo-wmi-other: Balance IDA id allocation and free
Date: Sun, 10 May 2026 04:25:32 +0000
Message-ID: <20260510042546.436874-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510042546.436874-1-derekjohn.clark@gmail.com>
References: <20260510042546.436874-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 65940502817
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244996-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[squebb.ca:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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


