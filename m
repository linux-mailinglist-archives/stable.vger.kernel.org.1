Return-Path: <stable+bounces-233440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEz0HzgU1GleqwcAu9opvQ
	(envelope-from <stable+bounces-233440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 22:14:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6283A6EC6
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 22:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AC353028F68
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 20:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E480439E192;
	Mon,  6 Apr 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/RcheTx"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70739C658
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506449; cv=none; b=AnlkOfqOUt6tBMZMtllX9w4M1imD6w+FM44gzTRzbvAgLbsSnUBj3D5+ZVNaDAs9KEBKyacLKVfuE85dzkoOw455Jc/QxGxaOU62CCqRodDzMOREwE64KkJeAx5VtEtURknUWl5hFFfGa1qaldQR9HhETSI3Hb1SFshWlSf/ABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506449; c=relaxed/simple;
	bh=fqoWirm15gyR2T5vILMgWW6g7wMD/2DlfAbl65EnpPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jB57+Orw5oW+8uShSbrWCMtxFqzXfq9fq+qt1db7kyT/EoPtne0gt4DO2bRDbLL4WRx6yukrrBe9yh0ECguiSanS7OKcMPoLS4j47Rx9n1Urj5ShjrQW5gQDDz+Sp1vgt1clqAUDl9JZV3KPyzrV+rM+KwSUN21ZJSnlEBZcjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/RcheTx; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1279eced0b9so4901556c88.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775506446; x=1776111246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yX9dP9ip8JwFkjEQDaOaU6XeU3b97kM6xm6qGhhPLg=;
        b=K/RcheTx2d8O4ifahcV7hgMBGOgCHzWlxHex7CzdSB7QdR8pOgKiCB5Sv2osj5k8kQ
         BrhIgOBzZSMoAS2l3JeUtdnIX62jCuiImbZmuaxvVg0ylsFezQCw+AGS1TlkD8ZMdiHy
         /G5lJgns8NuzXgq3Qm+uWnt1SiSqo3C8EHU+rlrkFSShD4VABfNMN9p2fVyFrk7NfSqF
         2BZYI0WKnFY0X0W/etmZbKBeUE5LGaMvskFDBveDE/YZrIeKSIb1DB5yCVYgKWkR4Ep7
         xJ9F7ZzVB3pPQFQsYobvRfvUzmBj+hLLWBrL6lIyBQ1UBKX35puNw0KCjLJTGQlwvyq3
         BkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775506446; x=1776111246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yX9dP9ip8JwFkjEQDaOaU6XeU3b97kM6xm6qGhhPLg=;
        b=L0n1OFL0VfrOnUCAxPV8yTB1lXeaTJu4oM2h/AimPKAI/R5Vq1eh8PpWTvCbY1feMv
         a8DCObjKu9moQUPTne6J/+vAgl0GA5uPc47jExt5lzv9YOJT1Oajuq4CugVUcVrybNS+
         yA866WmL9Rs4jYnS7aqndferJIHMwARaaSKd5kU8ZAspYNNh1/AR/7A4vbWgg63+aMvB
         VXSjTWZAtJkz137xt12sl3cwI7yv+lIWqWQBooLV8UFmywn15/XBpH0WJUPfH29OjqnB
         8rH5PeMXbQAKvBHO4SCCNFDQnlkQCM30dCwvzMQuZrUm3zOkjUEEGrVrMpnbiebvf4Ag
         ATUg==
X-Forwarded-Encrypted: i=1; AJvYcCWP6ycW0bDtvIWGel+y4E0raOfNfSM5kL0k9CuoJYNdvC+QfscFobOoA3xEze7X0EnVJFJ+tRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4eAUmAWfxR+J1IMCreUtnhYJbJ5H9m7UCAUW0d0O4v7dQJpmt
	54BRldilkXQybLGXMAPnWc+Ln91C+xn/O7UoV9Q4q7fQA5WLJwHls/jT
X-Gm-Gg: AeBDies0OKrUSCZQ5X2bB8sfHI5TaTfDqM9Yz3GtePKqzzeJWSBVui2vipG2l4ERUjI
	Jru4KJMcl/Omylg17YS/353zAHBsP1YX1WpItrY2gq+8wO5evyIGKGQpSSTi5N8FE7Hebg8+XIa
	wd/e/Up7jLxbMeUh/ce0bIGeGAmJu6IFWUxWqK0ESx5nX4DsVrBmdkCgd18KeQuMgIyRslAa2iJ
	i8sQZ69n3jrDb6gGvLd9zZdJ1iQP1uWl2k+FG7wZn0YL+Io8tJNkgL3jsdAKxlIDe+6FmqsFB1v
	LRAxyzpzutumOHMzfrr/ywusBuZ9YRrA+7MWSgUcLaBeKDUf9C0afMOeUpXtNJzdoqeCugouNpl
	D3qUYYSxwQqXhMD5U1s754I0nHhDC6aeskJkgtVk4y5XsVSIjm0kcDE5V9Fh08r6HcA2iCyKyQQ
	XIUgBaDP4j+6lwJHOJxypyu1CzCOJ8lWzL6w+Nl0ZQHdjl3HttcrrPIcpNUsYUAHFanzgKnY4Kx
	14ObnUFfEnOoDI=
X-Received: by 2002:a05:7022:43a8:b0:12a:6f8b:36a3 with SMTP id a92af1059eb24-12bfb6e7d0emr6729839c88.6.1775506445573;
        Mon, 06 Apr 2026 13:14:05 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm17022333c88.0.2026.04.06.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:14:05 -0700 (PDT)
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
Subject: [PATCH v8 04/16] platform/x86: lenovo-wmi-other: Zero initialize WMI arguments
Date: Mon,  6 Apr 2026 20:13:48 +0000
Message-ID: <20260406201400.438221-5-derekjohn.clark@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233440-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.987];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rong.moe:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE6283A6EC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adds explicit initialization of wmi_method_args_32 declarations with
zero values to prevent uninitialized data from being sent to the device
BIOS when passed.

No functional change intended.

Fixes: 22024ac5366f ("platform/x86: Add Lenovo Gamezone WMI Driver")
Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
Reported-by: Rong Zhang <i@rong.moe>
Closes: https://lore.kernel.org/platform-driver-x86/95c7e7b539dd0af41189c754fcd35cec5b6fe182.camel@rong.moe/
Cc: stable@vger.kernel.org
Reviewed-by: Rong Zhang <i@rong.moe>
Tested-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v7:
  - Include lwmi_gz_profile_set() fix as well.
---
 drivers/platform/x86/lenovo/wmi-gamezone.c | 2 +-
 drivers/platform/x86/lenovo/wmi-other.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
index 381836d29a96..ca559e6c031d 100644
--- a/drivers/platform/x86/lenovo/wmi-gamezone.c
+++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
@@ -203,7 +203,7 @@ static int lwmi_gz_profile_set(struct device *dev,
 			       enum platform_profile_option profile)
 {
 	struct lwmi_gz_priv *priv = dev_get_drvdata(dev);
-	struct wmi_method_args_32 args;
+	struct wmi_method_args_32 args = {};
 	enum thermal_mode mode;
 	int ret;
 
diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 4b47b5886e33..985cb9859b44 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -166,7 +166,7 @@ MODULE_PARM_DESC(relax_fan_constraint,
  */
 static int lwmi_om_fan_get_set(struct lwmi_om_priv *priv, int channel, u32 *val, bool set)
 {
-	struct wmi_method_args_32 args;
+	struct wmi_method_args_32 args = {};
 	u32 method_id, retval;
 	int err;
 
@@ -773,7 +773,7 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
 					struct tunable_attr_01 *tunable_attr)
 {
 	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
-	struct wmi_method_args_32 args;
+	struct wmi_method_args_32 args = {};
 	struct capdata01 capdata;
 	enum thermal_mode mode;
 	u32 attribute_id;
@@ -836,7 +836,7 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
 				       struct tunable_attr_01 *tunable_attr)
 {
 	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
-	struct wmi_method_args_32 args;
+	struct wmi_method_args_32 args = {};
 	enum thermal_mode mode;
 	u32 attribute_id;
 	int retval;
-- 
2.53.0


