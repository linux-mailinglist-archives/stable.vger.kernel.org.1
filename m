Return-Path: <stable+bounces-235743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJDiIAF22mn82ggAu9opvQ
	(envelope-from <stable+bounces-235743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:25:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA8B3E0D0C
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9967B30547E0
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9703B895E;
	Sat, 11 Apr 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRS+yS5N"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA93B8BA5
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775924623; cv=none; b=V6RJ8KjvEDRKguYU+1AMN9TRmYfrh/tG7y/ebpIqBAIS9qCKnplU+BrSFipAJmtSnbN8wu5jt9csecjYPGwbSAjB/pdMMyQ7Wq0gkQCvlenhYBzCEhQy4wo01xOIwjQb0N1Nuk4tW0uFAXj1tV3e15M1LULQnMdqNRzZLmboUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775924623; c=relaxed/simple;
	bh=Pw+ssuLutbx3g6u/jM5PMxxasbxx9jVlsAJtmVGQOkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qg9Lx3bPZLB60fYrUf3MTMliGPkQfepaS6W2sc2RsAO4H0tdoE7qO4Gdp5haUrn7lX7x5pMRdkv3IPd0PLfez7aevWJyvm82tNqBtmEYVMeGBPIicknST9wCbReb9ZzGb/eupNRqkEvw+2vwoJtJpNuEytUCqTF+Vi7QFVslEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRS+yS5N; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c42a23c8eso375908c88.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775924621; x=1776529421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtTcFBJ7InscTxETiiZ7Szcd4eyMEX33KwP3VapF0JQ=;
        b=FRS+yS5Noj9viJTBLP7ou/JlZtvxKpHBVIdcBJVoYFLGjGLknGjAlVxaQQiOQ1P6oZ
         dPmUqMqHGTDl5onAIFv8zZFysK/0w0zUSJ9gzRyadKn1U+kzzp4tGDlNwsapyMCFhBBe
         vPOB/KtxZj7JSVPnageol0iPRgOvB4gKFEan+kl5lLk3s4kFUeVA5P27smjrGv5gR0qA
         sZnauBv+V5+ccwwcvB7EmCFoSGgJ0C02wXIH0ZNupkRQbt9WvcidBjiP9/lo/OqUNlNp
         6zvhySzI0eBNqNUB2lIXPbLDrIzAj0rC5zVP801CRV1D7Fw5iwc4PBapimGCXK09575t
         ilag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775924621; x=1776529421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VtTcFBJ7InscTxETiiZ7Szcd4eyMEX33KwP3VapF0JQ=;
        b=nvvi0KvsnEs0Bk0GcFNfxQCuvXX0TL/HLTkbob8LMgXM/h6XuPwY8aBnkiuWWdnTbQ
         VVjoM4Hf6eu2b/9DN624eYLDm68f0Ro/z7kC7lgDk1ss2SEb/MrvLFZKhe99ui83qUmS
         q9pa5Y4lJ98z1X6SqfmSQL1xsOr/by2dqA2t9Gjkaa0KqOzRiGsYJ/fGKTGC/6lufpjn
         jriCtx7c173srYYUOPGhWYWrlt2fzJBQWwT2dU1oY+CI8+PiUS20XvjWhhrrbJgS/qJ1
         koJgKGtkBQ8nSRPdLImUQzIOcJp5HkufeKB0v59ZUX2CXlfOJjL2HHxhYiqClDmlrigK
         iMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW82vjWDDUppDPmr8+2ksnz6bDCEormuSyC23yhehKtCL4YVOlTuxNoQdr0v5jNAju5/b79SD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDU2VojN2YrQ/XvFbUao3WV5CLBESa5szleX5ym31QO4lgjThr
	LJLRaoVS/jSAoUZNCbel8QyWjfB/GiKymFPnnpnfQ9EWTGwd3vWuosdt
X-Gm-Gg: AeBDiet6BrGViGPAe8624xlLOIWssynMizULFsnYhwmSqWTccnBfuXrfQy5ga6XLZSR
	P83P5hA2lTDp6+6O+SXpZb9Vht6E31mWbSYKWUacigYsiczR7KB20BNUuU9ycwMfUEFm3myJh2O
	iPZ8dTSMvRGj4MFuabbtYZ5zWxiFs58UsAzHFivP/SjO+ll+8fIzPy22IpE5F/YiDftd30Ds32j
	1p+MExvhGiUtOOw/zpBVWjjQ5lKb4c4L3VusEzp251hgbjmI5cjkTTLFNF8CZO7RCqqduaHlF3c
	E68zSxJxLhiyYny8YrkZpYE1Go5PGqTi0FQgCs++TGks8Y1KqKaEhoLoc8GIxxtmFlI/7XuoQ8J
	HZke7AzSMitBt0op3ESBsHhplH97bh8PXw7MSWpdQixOS+gfh8uym9celRro5B5WnPJw55SSZiu
	WmCxgtJ38AenHwR/fVDpudMEQCKamLEnkn5jhnYfcJVdE55RGeT9ZJshqEzrZUEkwvr5IrD8rU3
	YcdeiqZzvMO1Kw=
X-Received: by 2002:a05:7022:eac4:b0:128:d967:4673 with SMTP id a92af1059eb24-12c34eb6a86mr4884060c88.16.1775924620861;
        Sat, 11 Apr 2026 09:23:40 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55ce46a65sm9358907eec.0.2026.04.11.09.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 09:23:40 -0700 (PDT)
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
Subject: [PATCH v9 04/16] platform/x86: lenovo-wmi-other: Zero initialize WMI arguments
Date: Sat, 11 Apr 2026 16:23:22 +0000
Message-ID: <20260411162334.25682-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411162334.25682-1-derekjohn.clark@gmail.com>
References: <20260411162334.25682-1-derekjohn.clark@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235743-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[squebb.ca:email,rong.moe:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFA8B3E0D0C
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


