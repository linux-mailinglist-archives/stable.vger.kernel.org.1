Return-Path: <stable+bounces-220492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH44Olc3o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:43:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EA11C6323
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93CD13184FBC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51E73C7564;
	Sat, 28 Feb 2026 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9PAN+dn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94153C7559;
	Sat, 28 Feb 2026 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300377; cv=none; b=dLTZ18r9COC8bSRu4Q7ydi4z3JoWXiyi+ZSSyFDYE4WgEGZi7JSAlQ0+oV4sDTuU5R0tVFLgw2CTDslV8QI8YMcUFoLTTbWDF2nICU0D6Mub2JYT4DgbjJhO+Kf7bb5dknTOUJ/8/immWyUwN6xKRvqthScV2UxL+k5F+V3usWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300377; c=relaxed/simple;
	bh=LRvyp1T7495ebwokwEb5xk3tnpAB4BOXNi8MmubQZjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LloOGc0IM32wS4xkhPG8rjOefKQICYDooXCmgbAAvVUwlDfyIMy/lgQn05X4BdbSHOPbIOAJ1Lm3ZEDxuc5xo6+kmBrR9ZJvMwWGmd4A4Blrju9RJPwhH7glx/PDF9YCv0jRz5wD5zex6ozhFGxCVPwQyy7YMZcUKz3aakpHpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9PAN+dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3307C116D0;
	Sat, 28 Feb 2026 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300377;
	bh=LRvyp1T7495ebwokwEb5xk3tnpAB4BOXNi8MmubQZjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9PAN+dnhNDBuHO9gcln1jTPn3RqLBg8oYdJg2Va5l1Mn7OVabpqy7E7it02iqA92
	 kNszaOodf+3gtaZeaKOhFXng1XZI9x/h1+3ARwEC+iAb1DhINeIWjXrviJxvT0YRGh
	 qC1r3VGRCH+gNdMmUDrBTt00CfG8kci9ImNyPowwz2f+4Fk296tnBTnDM6fjqLlMLC
	 WpGlDT6NKWHcw6uB7CNlUY9XtKpPVr5oiwCLJTTPj4NT/2nus/bcb/5asQFBbjPPtC
	 OswjE2gdz2i6+3fhmD6UFOmZBGXDQQIrztw0ZwpOuMfSiyXk64nNeEgyfWXcbc7JjM
	 2vWIYOp3qb2HQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yauhen Kharuzhy <jekhor@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 413/844] ACPI: x86: Force enabling of PWM2 on the Yogabook YB1-X90
Date: Sat, 28 Feb 2026 12:25:26 -0500
Message-ID: <20260228173244.1509663-414-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220492-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 58EA11C6323
X-Rspamd-Action: no action

From: Yauhen Kharuzhy <jekhor@gmail.com>

[ Upstream commit a8c975302868c716afef0f50467bebbd069a35b8 ]

The PWM2 on YB1-X90 tablets is used for keyboard backlight control but
it is disabled in the ACPI DSDT table. Add it to the override_status_ids
list to allow keyboard function control driver
(drivers/platform/x86/lenovo/yogabook.c) to use it.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Link: https://patch.msgid.link/20260211222242.4101162-1-jekhor@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 4ee30c2897a2b..418951639f511 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -81,6 +81,18 @@ static const struct override_status_id override_status_ids[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 	      }),
 
+	/*
+	 * Lenovo Yoga Book uses PWM2 for touch keyboard backlight control.
+	 * It needs to be enabled only for the Android device version (YB1-X90*
+	 * aka YETI-11); the Windows version (YB1-X91*) uses ACPI control
+	 * methods.
+	 */
+	PRESENT_ENTRY_HID("80862289", "2", INTEL_ATOM_AIRMONT, {
+		DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+		DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+		DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+	      }),
+
 	/*
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
-- 
2.51.0


