Return-Path: <stable+bounces-235861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAl3EpoK3GkTLgkAu9opvQ
	(envelope-from <stable+bounces-235861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 23:11:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D55873E60BB
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 23:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E93C3011040
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 21:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13280383C7F;
	Sun, 12 Apr 2026 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHcdvFbo"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FB382384
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028289; cv=none; b=X+HMMvvCd5AV9gxzvYNvcT/AfFqvqOEw63eN6L/TN5UqYFPXYMJCvSY71MTPyxeX+wE7vSreG76THPVcPWqgfjPdZIX07dl23tiIw3y4rAkfZUtrwaYzULP6iEzjyZtuBIH8X6bNgNvCxiFXKK3Wfm8eka8TqMeAYjy6JcJGcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028289; c=relaxed/simple;
	bh=Pw+ssuLutbx3g6u/jM5PMxxasbxx9jVlsAJtmVGQOkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pjj14juXJiJm/CILFH3Z/YyzxG8fQVGE3h5V6wprUgmhc9MdVlpNNOre3h6RxyTY8QCcnZHm03HWPLAwTcDWbd+5jMC+s5lh28ayMzf3XrPuVMx3rsrDb6Fej+v4KL7bDkoV8pxQLygFFkw2wuYCJs2DVJTeBOvtU0pXF1DqJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHcdvFbo; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c45281a06so1167836c88.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776028287; x=1776633087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtTcFBJ7InscTxETiiZ7Szcd4eyMEX33KwP3VapF0JQ=;
        b=AHcdvFbop7/cmhffkByBAgOryuY1Vf03jk/LHnquOSl/+gs1Os2uWcVx67P4jO570N
         YL8Anzww5xo0cSZrhoHlx1sGJzvXeYp9oUgxrd8/QBp6kq/0DjcKGxl+3jSrVyWggdmp
         HiBkRzFVSmQ/ciZsJzjFTC7JAHp+kueUDX8Fyjyxy0AvuKg4XkC4HRh0J3Q9Hwo5lCj8
         XOZdPWSAO7m1929vOmvOQzn6w3FFmvmC+HME1wprwZcWCTE+mIialMFV5W1CIBv6VC94
         gezY3l2qPQPE7xNvM4vnS2YwHz5No76fIWXykPMM/1tfO4jjo/OL+xQcnR3pzRycFbUt
         CIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776028287; x=1776633087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VtTcFBJ7InscTxETiiZ7Szcd4eyMEX33KwP3VapF0JQ=;
        b=QU2XiUdCeiejmhjimRhXcD29rXrKI3yCLDr1Lw+9IhQ0UykPL3kfhaYfHJJMp5J+PR
         sjoV96Oh2g2ujjWoDK4PJiPt7G/h2TL7nYmZ8oPwzv5SxC+vaKUvPzPTAkk8xHpVbQdG
         WS/0IY5xXwrt0JhmFMBndXrKQUo/53Dx7uOSL93MqyK6C+rEXNtAIT8LPENiovGEPnD2
         iG2VXL/5/QAW2ohokRR5f4j/bPLu0r5+xrXNjdVDnZTDG3uv4zFkX/eNJbiLGJo9S3OC
         BuuYIEAdoRS00oZe5QGWTY1GuUgFZlWr0UrcLVc0E5IstJbLSkYBH9ieI+rsCNRvklF9
         0aqA==
X-Forwarded-Encrypted: i=1; AJvYcCUQqudORxb9WD7HVXWLPQ6f3gZ8m4C7bUTeR32EyJYCYA8nF/IKBJiLG8kN31V/1lwAJNUCyjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdweAd1HZJEPCkIwGiPvjlI/zEuSHFxvIaEl7AJdr1XVPkYwT
	BJI4dAwP9oee2Jwzcy0qJ+bnfl1UD9e710DhIlCfoRoeS+jbN5J08hnz
X-Gm-Gg: AeBDiesX9X12VNXS6RRsqqM3iBJGfo4tTrOE8BQqEuWBBaYymbwyakwrki1UMZArrN8
	0RlcNwles6wTfW3qVS00eNgXPRs/5Yh5zxRbCfigPflurT3ZW7XtFXdQ02da78AcWnTXrAN2OCn
	TWRoCEsXjq9LXBt2XxhCwVbQ0EXrUD/nDIG1JW7/JCt8G8M+oDmab9rs0bqsRZMpS3986UbZJ9Y
	wdDmflePziK6t2Tl6mbUk5Xw7LYUJ4rWdpuOjixCKCzlZhft6rZDcUGBhBCkWKI5GLzJqqdKdNH
	VtRkyHGUl/7roG9Uwimal9cpWV2q2jg4gNcWl8LMKaklyq85aBiRRicGma5vXZRHdI9Wf8wYEAv
	cVg0fkiel1MteEiwIGae+4qdZYv1SINHcBegzHPQIxTyCoakIyWzjrIK6PIotLxjMo+2lXhNh+u
	nArgg4USt3W/2P4N2ulXDCVqM9YoaG/CyKUlU+9ThWZXTkpF/KjcThL/9LFBOdg45VARST1UUBr
	AjI
X-Received: by 2002:a05:7022:250d:b0:11b:b3a1:714a with SMTP id a92af1059eb24-12c34e8f8a4mr6821180c88.12.1776028286579;
        Sun, 12 Apr 2026 14:11:26 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb141sm11520856c88.12.2026.04.12.14.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:11:26 -0700 (PDT)
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
Subject: [PATCH v10 04/16] platform/x86: lenovo-wmi-other: Zero initialize WMI arguments
Date: Sun, 12 Apr 2026 14:11:09 -0700
Message-ID: <20260412211121.2220556-5-derekjohn.clark@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235861-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D55873E60BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adds explicit initialization of wmi_method_args_32 declarations with
zero values to prevent uninitialized data from being sent to the device
BIOS when passed.

No functional change intended.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
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
index a6be3463341c..1e06b894cfcc 100644
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


