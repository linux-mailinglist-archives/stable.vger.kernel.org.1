Return-Path: <stable+bounces-232899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAklEevhzWlVigYAu9opvQ
	(envelope-from <stable+bounces-232899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:26:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1A73831DD
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34D94306C879
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 03:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D254335F60A;
	Thu,  2 Apr 2026 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvB7N8yA"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231BA3563DD
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100272; cv=none; b=Jl4cQS+hLW8JhQMaLWKfKiLKGfjyaX5O3HopxOWXqmVUeIVMsGA4EH1Wnq4+1TUTSyDCPi+G298iEDovHFEwOzFRA3tyzbzWrQaC2L9fI5AxLhTCBgYuA02z9FdDrX3DOBH4LCoLw/s0jzG8PEWbJFs3LqkWStJVub/KxqxwVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100272; c=relaxed/simple;
	bh=fqoWirm15gyR2T5vILMgWW6g7wMD/2DlfAbl65EnpPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNZ+/NQP5YC6XXc5CX9H6g5fJ90M+0hA0/ufLFl/mzrNcHNtXZCX2v3zxY5ALTBvIyQdqbzh+vNoeyDRphDYy16bzeHwOi635JmVZv3tFyzb7lCwblUozNlX1FWo1RPrt6HrHe0jtC9zBQYRR2ITzu21ZeuO+CDBkXP65snwC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvB7N8yA; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b4520f6b32so598370eec.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 20:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775100270; x=1775705070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yX9dP9ip8JwFkjEQDaOaU6XeU3b97kM6xm6qGhhPLg=;
        b=gvB7N8yAGoxM3WrpDbg2sVtW5HbAqlsLuFc2brd/PlqVWs6qBIqJBVOIZ9y+C+HrLB
         fDTdNK188Pny2zh5PYGLrD5/Bno/odfFU9dzwXBvUts4h9bafYT0i3zmsDz0F+vbaPzv
         2RHcSMjVMhWaTcMuatbvFEtDEppdQoo0LjQVeazyLHotLvxYz6HsZ/RAgctPmONIoNJj
         3xjrpNSHlm/TDhJinJBUKkALGn4b8YENqOqoOEqQcID9H4V374kaxiJqxDNf59psKHel
         hLdlEeebwT4+pwuhBy5RyD5Qc9UPV6qcOBYp16h1kzaphNkxPO5ySpMcUxClTx/Hit26
         7OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775100270; x=1775705070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yX9dP9ip8JwFkjEQDaOaU6XeU3b97kM6xm6qGhhPLg=;
        b=eAO5RKoqGn+1ByeC63Q9bPGO7Hoe+4+OCxGaWdqd7nS2t3GQW5ofJU784EZcNvyiz2
         +zTrHTtEKuiLRA4jlOdL9AzEosGawF7SOUyhntbjj9fkF0xQEHHzk7A4/MIcv6zu5Y30
         z84sqWbiY4sKnVEqG3GiaHl3UMYPTpdL9zTSuAvfwYUBexCW8a3MT9B5Ecy+t/w2e6Ck
         9WfUXQu9hfxgv7vPL8z8eVe5d89K3+u8Ybm1lQZbUC0hYUDz9zRKlRNXytSlchm/bYOi
         3QlHREF3YbMZhQCDGN/F2ixMuY0kpwCKYwaMMKtJvFh9XCNEYUg/XTLrFXjNstvb43WW
         0GEw==
X-Forwarded-Encrypted: i=1; AJvYcCXfIEz8BSWHN2ZC4bF/8Bmdm65v/9mSKd/7tJ5Jgc++Jqa+GmCCsnng4hEH7qAqXyLKPbYwv18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3iU1rnNsJrYfw4W67GJgWQGnr9GMLbR1IJ5/z1plZQFqTX3rZ
	JQTrz3PhCqb2yf8p5oznT7Wkmdk49p6C8jceU1h3Uai0BV7Ls0s1qRSU
X-Gm-Gg: ATEYQzy4bR8UEYfq/tYcGxJSP+YeG+ZsJu3NSEt8GYSEX4/Mzc00emAiMwGLA9L4a+y
	KmqfIy0YnigcQK0IoRsMqc1/Qql6jAfBZHTvbt4n0OvkwiCDitolY87uONJV0UiQ3+7vOFOSrGu
	Mw70/vQjSCvq1Eyskob8P29jNu3M8Z3Tur8GvrT3OVkLnlLHV85ssylMlzneodATPxM7Sh+OMm0
	WeI+J3Pw62lSZRJO63DU0+dxNqwH+0RcxNjZ9g4aXNwbCX0kKH1ubI51Ezt8KQbB3DwUjwfNC4m
	Rr6k44tDwNUuqPDcbncJiIoxEoCrb+5LD/rjimkDzZ8yx0hl7FZsD/dKj9nAuc+qns/egw77Dh6
	hIPBvQtDSYM725FMlTynQu1TZLKRp5/tP1n1LlZCSWlqbryGuj8w1LK1zVdI8myI92bYiX0s9Ef
	HAM1wcy6j75k3XGB7SLQeVZb/9CgtTi400ZGyp7CmPa650tW/vzTnOlJyhji5UANlhpLU5hIr2O
	Trz
X-Received: by 2002:a05:7301:fa0d:b0:2c1:85a:d25d with SMTP id 5a478bee46e88-2c930e6bc1emr3147985eec.1.1775100270216;
        Wed, 01 Apr 2026 20:24:30 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cae9e9esm1265981eec.23.2026.04.01.20.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:24:29 -0700 (PDT)
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
Subject: [PATCH v7 04/16] platform/x86: lenovo-wmi-other: Zero initialize WMI arguments
Date: Thu,  2 Apr 2026 03:24:12 +0000
Message-ID: <20260402032424.678528-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402032424.678528-1-derekjohn.clark@gmail.com>
References: <20260402032424.678528-1-derekjohn.clark@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232899-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: CC1A73831DD
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


