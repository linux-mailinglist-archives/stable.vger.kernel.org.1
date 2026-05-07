Return-Path: <stable+bounces-244619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PUQEJfU/GlvUQAAu9opvQ
	(envelope-from <stable+bounces-244619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:06:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B594ED2B5
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0FFB3019979
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A7447276E;
	Thu,  7 May 2026 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7y5f7n1"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2F3E8C56
	for <stable@vger.kernel.org>; Thu,  7 May 2026 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177126; cv=none; b=VJhFSxEvAz4srGW+kvspRnnESz2fit60tWsH9nN1Xapnu3aV2kIFjeJN02SNLetUPbTcgcoYYDWLblrW9LhBYnPshpdr9sjs5xB0lBpl+1VASZP3b+Rs6OPNg3WCDn7AY5ch8GAM68g4k+/sF40gCiZlNqK6krYNpeuWMyZSk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177126; c=relaxed/simple;
	bh=Pw+ssuLutbx3g6u/jM5PMxxasbxx9jVlsAJtmVGQOkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ31oiUrj3s6bYh9tIZUuM2iKgOBUauLydOy+YEWT8uYFTP+5n/ArwRdNWKwbeghgkQGFRgphEq7EUgXQTDyn2Z3byudry8RBiWSTK45JBDA7C7dKWnZS2eby5keh6XFlPni71atRD7mXCw6kEHNfLTqT2CNn/iJoyfEU7CzDds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7y5f7n1; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f30a4601bbso1305763eec.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778177125; x=1778781925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtTcFBJ7InscTxETiiZ7Szcd4eyMEX33KwP3VapF0JQ=;
        b=P7y5f7n1h+pr4X/Iy60Gz4zGRAzIb5kycIhtxcsmZtLKy1U2Z3lrtlCA3x70FMe5em
         wfsAhlopLqLaeUFSWZ7lXq5JEYFlBwp7xweH0XB77cDq4CjhYokpW6TXRCqKE/q6PhSV
         myp3dGJDGcHuDvuXDOhxJNT5Q6rIEMZcgTw2dKlgrcD6/cJ3x3kKOqEQjd5BTDQtgnv2
         D2lyxqRDSc15QPMf5rjFxFxeshNLHt+0WQ9+GgdBmzW6j/x6DXO/Ojv17QPaOVg/JKsW
         b5d5+NSKQmVWX3RaWoROXB26ahqzhr2+JCdDuTTHpJBEgnNYKL0Wl64Fa7TZzSujBEF6
         fmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778177125; x=1778781925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VtTcFBJ7InscTxETiiZ7Szcd4eyMEX33KwP3VapF0JQ=;
        b=aM21hNdo0NoIW/cJxZ9UFi8qnXeQJG/E9N7Pj1nx0RdXZcEK0+E715b8Nn0xg9UOzZ
         n5ajuESMR7nl+pXCJivtxzIS85G01wavZyP61VcTpTVmZYgeKQvQhxuSHxtR2m0darsN
         wElWkLt4A16L+jndZ4tY08Qgo5R3sssIFPKKLK8UOUZGWKQIr/glNzNgOrdhPoVOk6xz
         x5IbRGGb17Iiidc2WyGN5cgMoYlo1JDaJGUzxHG8ESxItuQqZVk/icbPBEDcp+xImE8t
         yJqWVBSw+9+R1WB1CYUrlHpcL7na7uTq99PErqUVJVQwPcC6nstbFTAqMX4KeYKHTAqV
         5YvA==
X-Forwarded-Encrypted: i=1; AFNElJ/rqUwyMAlzoD/hIcEsWVQw2qV9DrsATOkMaSmxNFmscdIj9KqVPYearsmSeqgZGO84fzCfdb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyVVxFxpNHjv9QRCOLLjiMc6zZyT5J90N9YDzg4D06OeAkgJY8
	WZ1KitEiYxRNtJm0DaHO0QN3RUWjLN1mbsXHyZVZeXXZdG5zESaZ3JDb
X-Gm-Gg: Acq92OHj5aCSJooyPLry6UvE6lwnepVH4LdLgdaGb22PZA1LXnwuLgEOVN39UXkxaBM
	PCjZShxWf8Nq26pmebBGX5tK5R2Ka2eQxff9XrDZyO1u94aRLVzHhtPiSUK35FAccnOSzKLwiW/
	Xu6VWJ/0RIjtImuZ17BqIfwBZS257Ksz1yFLVfDwvjCgznIM/lRS/2P78mKA7zUHaROg3gELQyk
	JHvPF0zNuwXiGGZXe41f6kGk7xi+wkbC5tt5ZIDvmtp41k5xJ/nxDLvO32aq8ccbZZlgzYLAf+L
	HyVlCbz5YD0Y5Q/sXRATZsGkBLt4gYYIauqSsMsVeq2Z6nFkxxznosYvczeSKY1SbrG0XSIt+rv
	EuGTLMu02Ms3OtFStoYQB6gs0hA70a268LFq+QHyzML6XQ9DYVfetwFeVTScNO0+rLWZ2/a5/CX
	jGzMl1ZEcs8W+ZeievoNg+7SPfD3yNOQJBe/4i8KbTVTjou6zhZHHSUWySekFCwdi6icRo1RCPG
	2awrOJKZrn66Go=
X-Received: by 2002:a05:7300:e82b:b0:2ca:7eb4:3e0f with SMTP id 5a478bee46e88-2f54b897f52mr4549823eec.5.1778177124530;
        Thu, 07 May 2026 11:05:24 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f82bd73a64sm44332eec.12.2026.05.07.11.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:05:24 -0700 (PDT)
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
Subject: [PATCH v11 04/15] platform/x86: lenovo-wmi-other: Zero initialize WMI arguments
Date: Thu,  7 May 2026 18:04:56 +0000
Message-ID: <20260507180507.912966-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507180507.912966-1-derekjohn.clark@gmail.com>
References: <20260507180507.912966-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58B594ED2B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244619-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[squebb.ca:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,rong.moe:email]
X-Rspamd-Action: no action

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


