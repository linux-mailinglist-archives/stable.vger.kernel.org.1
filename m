Return-Path: <stable+bounces-244995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK0uM9kIAGqaCAEAu9opvQ
	(envelope-from <stable+bounces-244995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:26:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 264B55027DD
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3189A3020A77
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 04:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4CF29A9FE;
	Sun, 10 May 2026 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiMikodo"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14177286881
	for <stable@vger.kernel.org>; Sun, 10 May 2026 04:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778387152; cv=none; b=SNsrLkywljGb3fd/rlJbTIxsnliw+f4ITWK4n98QaM23mOsFTyeOZa02Gar7llKGyWeHecGKndJPbzQ0zisj5mZyDr8JC21uedC5XE4bQjF4r7b3biCe5JdqPjP0Ut3npFZlL7IcY5+aCgUGtQA45CAfjIQLEkx5lYH865+t6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778387152; c=relaxed/simple;
	bh=as/Y6rgrCLbxvFJK4woRt4WCiXpZGU5Bmcl75dpz1Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhgKUTrCNn+0upIfwuSQywW8y0YBNfivaKuTiR0uKhU5NQV9Cm0+VqzWsKzYy7WdwfOKCl10dcL1xjqqPjOkCcTlomyy/eojnoC21m8tWo5z+XSISZ7R/pdIPhYuLK1bRZZjG3qgMj39zOvhjW3r3r8HITDwqwTajW18fTBXN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiMikodo; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f7020a928eso4404084eec.1
        for <stable@vger.kernel.org>; Sat, 09 May 2026 21:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778387150; x=1778991950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Epvlpqxnk7CA+C9ymJCfGqy8SHrtqDJZ4fsM6TY9RM=;
        b=hiMikodo+8X16zCDJhpb9ONw7FFkUK6p1I02t7t7D+rdTBojVfKB7EMhf6chktd5QL
         qJIGTi3GM+2rPp4sCDrM/5Hhfkjml6g4q1Yv+0Yw3spHzj7LSQB3wmak+19XCtLakP1T
         agxCvmtEGcg1dgXeJJafeEMIklEICP//FtrqQxb/Har4i79knh4iBBy0OrU5nIhjxonk
         eub3nXLAqQrNT/EYCTKJuzAPJJyzmh+bHccFIpky5aqIIiMUzl98Ytj2ffqo0ftOzBRj
         nvK0sAPGZImtK0UQd9NZnxpBBkHxJq6IWYtbSHAGLKp+mQRTQ1X7OZm/wb5d/r+iXCQ7
         OMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778387150; x=1778991950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Epvlpqxnk7CA+C9ymJCfGqy8SHrtqDJZ4fsM6TY9RM=;
        b=ZgN02+4Iehx/2p7u3zw5NhBKZF6WD+dyT9ZvPwpc5nT0KUBFZO3g1c5DdY2KqBHK5Z
         fOPNGGQ09G+f3P0C/0Joyq+xSVWhqRhEa6CxnpsrC5RyL/tJ8oSvC/YeHcsB8ysi5CBA
         uYi7PN1d7D33hcVBKeoS0OvImRpAMv2HiyY9op8n7I2n58yHdShbw3uombZL5QL5CFK7
         nss2X4KNb0c1HB2YnVJgZsCQm7X+igCZPe71nisekA41WpMiunmBetGFY9affYZ71bZw
         E5ibB9phbbyc8fUFbgeVdMaWH9ItWEw0fwmBKWt7cagj+ZWewWiOn18eu15cpL9jA8Zt
         y+Zw==
X-Forwarded-Encrypted: i=1; AFNElJ+jloXKjyv/xV53/tmDYyzYtmonaB5/NYY894y/+TNEuLH71zyrZmw8T7+hQ8B0XrV+3JwkH/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+9nq2BcV0faLXS8kmUs1P8Stx3QRokR5L8iotl9D8+IE3BnM
	EvJP0UBen3ZOD2Ee3tRRJaCiWxPbhlNrg992gLsVA0BxG4iM6n9mygcT18nkOw==
X-Gm-Gg: Acq92OG2yFqXHe6aSJiUpL0P9/XtM5i1sFNb1MtBgRNsIJlDrezQo+vXN5XnFe7U1CK
	RaRAHwUdPgXflHK1I+Liswqg6wr8oAOidfDONWDASffKlERxmy9XYeX3PkJasHhia+me8RMw+n8
	9wf9PItSdF58WSZRFe+IRCSf/GS5TKgPl732kfaNhqR6Q/7XRQE817mWDUswnwflYJJrl8TBvu/
	fJGG7fHY/KfUIa+AtQXoSeCYE7cx+O4r14gZmBcSqKvSeFlMz9BhGFnLXiBFMFPwj1KirDZoThN
	BgnpWvFdz77qIF4JBaI0THjnd8D+lq+NcgLR6tWbpLTBN2NN9Fru+tBmCiZ+p7dbJvFVOPivVCJ
	FAF/vmr484LdCkN8fOWDq4tmTx/qXqZNaBuTx0OLytB/LlQ+LOJvX1e2khUFttL4q9U01y2wW5+
	AM31SG11vfUpEObmdlyVY2o+XZmsOX6hIUvPh6m9G+PPX0dHiNYkCotX65vEatDQAWzPb0ZyOKF
	eyc
X-Received: by 2002:a05:7301:2c84:b0:2ed:e14:7f5b with SMTP id 5a478bee46e88-2f54b797cf9mr9088145eec.31.1778387150168;
        Sat, 09 May 2026 21:25:50 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm10069960eec.10.2026.05.09.21.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 21:25:49 -0700 (PDT)
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
Subject: [PATCH v12 01/16] platform/x86: lenovo-wmi-helpers: Fix memory leak in lwmi_dev_evaluate_int()
Date: Sun, 10 May 2026 04:25:31 +0000
Message-ID: <20260510042546.436874-2-derekjohn.clark@gmail.com>
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
X-Rspamd-Queue-Id: 264B55027DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244995-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

lwmi_dev_evaluate_int() leaks output.pointer when retval == NULL (found
by sashiko.dev [1]).

Fix it by moving `ret_obj = output.pointer' outside of the `if (retval)'
block so that it is always freed by the __free cleanup callback.

No functional change intended.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Fixes: e521d16e76cd ("platform/x86: Add lenovo-wmi-helpers")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/lenovo/wmi-helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platform/x86/lenovo/wmi-helpers.c
index 7379defac500..018d7642e2bd 100644
--- a/drivers/platform/x86/lenovo/wmi-helpers.c
+++ b/drivers/platform/x86/lenovo/wmi-helpers.c
@@ -46,7 +46,6 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 			  unsigned char *buf, size_t size, u32 *retval)
 {
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *ret_obj __free(kfree) = NULL;
 	struct acpi_buffer input = { size, buf };
 	acpi_status status;
 
@@ -55,8 +54,9 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
+	union acpi_object *ret_obj __free(kfree) = output.pointer;
+
 	if (retval) {
-		ret_obj = output.pointer;
 		if (!ret_obj)
 			return -ENODATA;
 
-- 
2.53.0


