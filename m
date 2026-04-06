Return-Path: <stable+bounces-233439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDaSIFwU1GksqwcAu9opvQ
	(envelope-from <stable+bounces-233439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 22:15:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBDB3A6F17
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 22:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB05F30479C1
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 20:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7838C3093B8;
	Mon,  6 Apr 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWqkZ8OX"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7F39C631
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506449; cv=none; b=YUkv6QMj1vG1LxcpVbdgtmOK50yj5ohfXXGTwBuZxvw9oFvjuFDBXIjkLJIUyB9cawKrj3z6hkEdVFJJnWGmjtticSnnFdKgPc7/vtq2cUAAt/T4ODYHRWMJH1odGNzcsGm/dblChCO0i2w8ORnTf38/ukBXHiiDywF+L8IbLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506449; c=relaxed/simple;
	bh=rSDmCCEiDg6H2odhJiDoxieO0TKl6hml/thK1WrMGBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOKT99uESHf+yYVScenGHlqqOh+2kV2ZMqnLIwJpB4jTJAnRV0Z57eQCImvE0uR17fAKb39SOqFcTgcDVax2qq/q4JHP3+I54Dey8g6UFxUELqxZ+zzgC2s65vzl/lxVcy1lRSaQ4bLkHIB8kDjcxXIMD11WSJyLzY9xfW4Wq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWqkZ8OX; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c15414820so410304c88.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775506446; x=1776111246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN+fnLwvwAoWFMaejyWO9zQ/OWEWR+6r67Ac0CIVd7Y=;
        b=HWqkZ8OXLuCwAX89PyH0UNW1dSsOeI9VjKb8cyR9RvZb9POP6HWGuWHCKA8Q6cm7KW
         IauvlkU3Rhk8INyMl9nKyh+Tn6gARv7eWdc+5OlLqJWtaG/DkUa7toSl6hiVJm3SDuOX
         Be3LvgvYfdC+FXaqXcjQHs42ltF/hk91Q8HZASX0WnEZaJJ6Rgl43BtV9DC8LlHLNiiZ
         wfLooP/NxOB+jJ+34VtdqvTDE+viKOLgavanQMqAILt++h8dDLplzxPDkr8f3a6bInRP
         texa1aaaSpo69OYTgU1bLc2XwiiB0FGJmGhw9/p5y/kiCYeQ1L6e4zTyCWFOfBS4lPNk
         iiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775506446; x=1776111246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VN+fnLwvwAoWFMaejyWO9zQ/OWEWR+6r67Ac0CIVd7Y=;
        b=PFcRj8+oaYI0gLzjnZYLd3mUhWqCuEzwo+Tr1N9fUO5e6F83pD3gNK4gVRln+A4ZaO
         CZPL5KO5UHT5W3yOR/FTCmQ0HrO9z+VlrKPEwJbngX8AGcbOtesXHy1ePx2DqcLaI4Ka
         cV93gDYNJZ/1RbkAHvZW9z28Zq4WEY/F1+giOTVDEWe12AEzvJ2lDwoxiAcp1NSofq3p
         c1oIufDKLZWmKXxD2VSfyPhw4fYLn96EtfAWACL3ZucZlwIuJt17HxojY1jBk/99suBQ
         cY+I/wwSEf+Yk52ee5PnaTa2nDhVDOaaAJtoJ+qayPLUH++YFTn74ktuQrfIp1Jr+Fel
         zTbw==
X-Forwarded-Encrypted: i=1; AJvYcCXCM0Pv3XvoS+PeR47CbISrVvLJiNT6pltEKvQ6+hq4eoflc9Zhcap2btAhtRCCbNhbA0tFaj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzri00YWP0EIXT6Mg0KNrZpVUSIALlN3AI0WkmKut/RO9Zu+Ify
	O/59uZ0nOvKNfdNJx87qjkuM36S58P5DXD+7xI+lYc9HyAWGE5iDqKCB
X-Gm-Gg: AeBDietkBWgO3sxlVWKWBBz9ic7axxzoIfXg3wWJw0DgJTWTxoBZUiFdGUzDgUocyLi
	ui2w1l9dOEg744ENUW7eCjUOs5uE4ZXxCfBmwYnRpd8Ig9LMR3vV3pHdJU9yzi7E75AFoCu1DuN
	vmakLrJM0CEMPN1yMVq2066dpHWAiqfxfudGfUQmagmH3v0X7oB2/5vaoY3ojsnSkzjp/pF2l0W
	+rDngqg0EuZ2gTxgtUYT8S6G3WhFz454sybNInpHlEV9YTFu6qUrV+gaYt/M0r6qmQhfTrFNdBN
	jEn639BpJ7olIfbs8s0EvyRMuEEJO1wnyJUdQ7VM/LDvaB1VVubrdRemBaknlF0CzWR8C9788Lo
	jUBMUHzDCg5iC9lMC0D7OfDdrl4gxhnLm+dkW4z6Duel0ZvzyZPiEyyF54N6LzA0xOp285GVjTD
	MPGX2t16qzgpDsSk9bAxvvyAftZ373GRrzFQSjZFTZhPgQjI2/Fh2o3RLN+U1Sgtlg3aU+0fD94
	TCAIW1QhBypkec=
X-Received: by 2002:a05:701b:220c:b0:12c:839:7462 with SMTP id a92af1059eb24-12c083975ccmr1603169c88.12.1775506446333;
        Mon, 06 Apr 2026 13:14:06 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm17022333c88.0.2026.04.06.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:14:06 -0700 (PDT)
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
Subject: [PATCH v8 05/16] platform/x86: lenovo-wmi-other: Fix tunable_attr_01 struct members
Date: Mon,  6 Apr 2026 20:13:49 +0000
Message-ID: <20260406201400.438221-6-derekjohn.clark@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233439-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.981];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rong.moe:email]
X-Rspamd-Queue-Id: 2CBDB3A6F17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In struct tunable_attr_01 the capdata pointer is unused and the size of
the id members is u32 when it should be u8. Fix these prior to adding
additional members.

No functional change intended.

Fixes: e1a5fe662b59 ("platform/x86: Add Lenovo Capability Data 01 WMI Driver")
Cc: stable@vger.kernel.org
Reviewed-by: Rong Zhang <i@rong.moe>
Tested-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/lenovo/wmi-other.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 985cb9859b44..0e8a69309ec4 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -546,11 +546,10 @@ static void lwmi_om_fan_info_collect_cd_fan(struct device *dev, struct cd_list *
 /* ======== fw_attributes (component: lenovo-wmi-capdata 01) ======== */
 
 struct tunable_attr_01 {
-	struct capdata01 *capdata;
 	struct device *dev;
-	u32 feature_id;
-	u32 device_id;
-	u32 type_id;
+	u8 feature_id;
+	u8 device_id;
+	u8 type_id;
 };
 
 static struct tunable_attr_01 ppt_pl1_spl = {
-- 
2.53.0


