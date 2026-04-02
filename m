Return-Path: <stable+bounces-232900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N9JIwzizWlVigYAu9opvQ
	(envelope-from <stable+bounces-232900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:27:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 345A7383203
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D27D30B2FE6
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 03:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2743612F5;
	Thu,  2 Apr 2026 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIMwCmcF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBDD35AC05
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100273; cv=none; b=K/r+XkWIRIxqk+czWegBBhPWXTtLKeHniH/pb2Uz1BH5/vfe+v7qcApiYgFmdvc8H1CQiudKmfSuoMF2JU8wwuOk2rZN+/kFv/j09TQBlccvbaapOwdfy5gDy0jU/y7HrIEOS4IiGHb4qjynlUs/5e8G9cogoe6+yLYsejCOERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100273; c=relaxed/simple;
	bh=rSDmCCEiDg6H2odhJiDoxieO0TKl6hml/thK1WrMGBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uylz9JJXUaBh8crzyHADaKcbDHZjZBnfltFKfrvZ9SAdoyD6xQdpDjM0JsVn7dTsRr5OTpTmllhdPhkQyGgv0bHlrVQzACpMrHmt+GitP9qTCCctx9o/ID9FsPxnA71Eanzp/uw7wwq1zIPnr6rOLy4iakf9qiepDlBFgdFB1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIMwCmcF; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1271257ae53so522279c88.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 20:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775100271; x=1775705071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN+fnLwvwAoWFMaejyWO9zQ/OWEWR+6r67Ac0CIVd7Y=;
        b=GIMwCmcFZVUn+ZFqa8Qkf+N8Ye8N01raD1qk5FSjyxB/u/QF2zfPP3wUrr9jJSEsd2
         mgdvL8vKFK/gJaYTjOYtIagfSXpfU0IVv2cmNhEql08H7bG71EcNTmJaVxtdoA7lA740
         e2eawrm4uOn+okigMn3UWbHzY7MlJCmHv0wN01jfGBCtgWkmF764TaFQb5NcadtMQa+Z
         NFrCPFr1mxy2BCAj8JpRWOyAsGv4SHWLsQCbfgtCrp6bQr9Pewju7IapnF2D+ayMoaVH
         +Tty2eBtuUpZq+9xwgrv+X3k+5lAXqMKopp1TZpsw2n0z0+sboTRO5M67q/Isxtq1YY0
         aEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775100271; x=1775705071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VN+fnLwvwAoWFMaejyWO9zQ/OWEWR+6r67Ac0CIVd7Y=;
        b=lkZnUIzhpJCpEI3aVg9lDqLBSOF8grH4RwwLZrqf85HIvOizrMJpWmkVuXcByrOxBR
         4/kBq5MsD+zUZycZaykR9x/nVv65hHUZ8/s/uPWfgkH9RznGWLIZxBJ+dq69P3uEZoXN
         lif9fVJwTy/TAXkHoWOOjBZNvSf1Syf6k+qqzJqEzkf9Fr0ny8i7VzJg4KkiIY85ubqb
         ulBlrbHJwLw4zeJ0tu0I8bHs6yXWMtHKJmtNMuecvNpcpp6bicBF6AE5Y6nQFVf8aQrf
         BlCS1mgADT2e9iy/V+XB8urMJSnhw7JUmNXxNZKTBUY+8xo0g/x2XGPDSHsoSNt+lX3O
         mOiw==
X-Forwarded-Encrypted: i=1; AJvYcCVEGt0K2PYg6UwbJnOPnKWJKBhDfcZKerXeHirZ032UTqT+YxEIr1Ye9Jta9jze1Kh8YG8hMOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuNrTpl7GGyvBvRDDJtwLlTx60O4Pk31ZB4ZJs4XQI77kQoz9G
	ePLR38+5BQ3CIiokrDXrpZeIfKVqPGtIZNxdU7BT1Dz134D92fjb43j0
X-Gm-Gg: ATEYQzy4nl39yBNJOQvbqaQIDtz7Vqfeswsbur442gbneJ5oz3wNp3GIjyOzTeZG47m
	hHgqhFNqpxEwjN7elqYao8MUkMMmZv70HB0oC1xKrfqB7RZNUTD15f7yKLAMpm/0JH3q/R0JDnL
	aX0V//gx0U5VAV5wJAAcqWqbCDforZgChyHIGKCpi7sCXmvAcDs0jLfunkmwq1+nSUzGOPrk/mQ
	kZFYx284XiH9qb4V767VTwz8LLqrm4zkELDTv2rroXfoKhzaT8lyUo3OLCtvHa32Z/y/9L9BEwF
	Rpv/kGd5JxZ8+5Ox4v8LF6xXKFkYnSz1ntr75IXJ22mbyUWMhaGtwX3ljWG3ZS5/N1JgmZC07rv
	v+QDARSXiL6LDfdbS1emZjrLioU2R/BuVJVY3O4NZhcFL4D/Tcjq7WkYKbM2hHlfxf2TGbX+d3H
	jPgDIwOVTKYV0j2sYIOL3/r8UXJyrf94WRgmFisVPUros6SrkPGNcvWmwiSNIg18VCCIJDq+Uqv
	Vij
X-Received: by 2002:a05:7300:e613:b0:2c8:b5e1:6b03 with SMTP id 5a478bee46e88-2c932ea9d1bmr3195433eec.23.1775100270860;
        Wed, 01 Apr 2026 20:24:30 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cae9e9esm1265981eec.23.2026.04.01.20.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:24:30 -0700 (PDT)
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
Subject: [PATCH v7 05/16] platform/x86: lenovo-wmi-other: Fix tunable_attr_01 struct members
Date: Thu,  2 Apr 2026 03:24:13 +0000
Message-ID: <20260402032424.678528-6-derekjohn.clark@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-232900-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 345A7383203
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


