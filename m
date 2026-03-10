Return-Path: <stable+bounces-223827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCuYEFzgr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:11:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EF124805E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0E633087FD6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7567247276C;
	Tue, 10 Mar 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urSdA2SG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B6646AF1A;
	Tue, 10 Mar 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133356; cv=none; b=mnNzBs8mwanKbp/IUkHLyw6ZUG60SxbOHKJpJ2IDUyh6eZv104WDCkoaLksNjHlU2olFWwqGqz6vdYr43pJsb+PCFNU+G1nOvVEyCdsvXqvc1zCnzC/0lfvm7z7i8xId4DJID/8Nje9WzrGBSBvx3TXFl04tyWPvfRxFSCxWoaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133356; c=relaxed/simple;
	bh=+qkH77Ub+mQy44uR6H6raPDNgH4I2sKT51kJXkKZMgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USa8SX4q6DwMK7AyBT+NUyebpFDL49eABPdg5PCQ3MtV5HvMK3j10NmHvahyWl5PdAdKR2QAH6pyl5oFViUtIKMioOAt6zeWjRUL0LeJ9Q6V+1SsDMhAoLYgRxOJV1v99EtQ2Yy9C/IXORGdksh1lZCXNOc6k2sR4gdl8WlRRV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urSdA2SG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC872C19423;
	Tue, 10 Mar 2026 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773133355;
	bh=+qkH77Ub+mQy44uR6H6raPDNgH4I2sKT51kJXkKZMgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urSdA2SGuk3V/rE+mPC8HAtbh/Z11fNbWzqyX1vpndqz7f0RK+UW/e+vYMIVKMYuu
	 nmhegOAOif1O5pxs9KUSSwVAG10jsbrVyDJ35dfXEAi+MKmhDquuluxk2eRJ8tWfXY
	 SvMNh4DNO9+C0xhhx7RPdmkmid0mj9FUY4pgs7DJLAkzvhtkfTrY/I+hxVWX84cbbv
	 QzMnwvtoOPe8YSpRJIAfDScgQPH2tqJMLusfrv3JP9dgeIibuLmVTKur2u4hhw3btn
	 6dko7mreJVhG+IWUDskAsj7GhpPecDCDb/BDRwBErwdxk2v7zESsuPuRd+qo4jYuCO
	 lHJITnTJzkO/w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	derekjohn.clark@gmail.com,
	samsagax@gmail.com,
	hansg@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] platform/x86: oxpec: Add support for OneXPlayer APEX
Date: Tue, 10 Mar 2026 05:01:34 -0400
Message-ID: <20260310090145.2709021-34-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310090145.2709021-1-sashal@kernel.org>
References: <20260310090145.2709021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B6EF124805E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[antheas.dev,linux.intel.com,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223827-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,antheas.dev:email]
X-Rspamd-Action: no action

From: Antheas Kapenekakis <lkml@antheas.dev>

[ Upstream commit 3385ea97c14d271dcb0c6e6fcf16972f819eecd8 ]

OneXPlayer Apex is a new Strix Halo handheld. It uses the same registers
as the OneXPlayer Fly devices. Add a quirk for it to the oxpec driver.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Link: https://patch.msgid.link/20260223183004.2696892-2-lkml@antheas.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

This commit adds a DMI match entry for the OneXPlayer APEX handheld
device to the existing `oxpec` platform driver. It maps the new device
to the already-supported `oxp_fly` variant, which is used by other
OneXPlayer Fly-series devices (F1, F1 EVA-01, F1 OLED).

### Code Change Analysis

The change is minimal:
1. **7 lines added**: A new DMI table entry matching `ONEXPLAYER APEX`
   board name from vendor `ONE-NETBOOK`, using `oxp_fly` driver data
2. **1 line modified**: Copyright year update (2025 → 2025-2026)

This is a textbook **device ID / hardware quirk addition** to an
existing driver. The `oxp_fly` enum value and all associated logic
already exist and are exercised by three other devices in the same DMI
table. No new code paths, no new logic, no behavioral changes for
existing hardware.

### Classification

This falls clearly into the **"NEW DEVICE IDs"** exception category for
stable backports:
- The driver (`oxpec`) already exists in stable
- The variant (`oxp_fly`) is already fully supported
- Only a DMI identification entry is new
- Enables fan control on a specific handheld device that would otherwise
  have no fan management

### Risk Assessment

**Extremely low risk:**
- DMI matching is board-specific — it cannot affect any other hardware
- The `oxp_fly` code path is already tested by three other devices
- Reviewed by the subsystem maintainer (Ilpo Järvinen)
- No new code paths, APIs, or behavioral changes

### User Impact

Without this quirk, OneXPlayer APEX users running stable kernels have no
fan control through the standard hwmon/pwm interface. For a handheld
gaming device, this is a significant usability issue — inadequate fan
control can lead to thermal throttling or excessive noise.

### Stable Criteria Check

- **Obviously correct**: Yes — trivial DMI table addition using existing
  variant
- **Fixes a real issue**: Yes — enables hardware support for real users
- **Small and contained**: Yes — 7 lines of DMI match data
- **No new features**: Correct — uses existing driver functionality
- **No new APIs**: Correct

### Verification

- Verified the `oxp_fly` variant is already used by three other DMI
  entries in the same table (F1, F1 EVA-01, F1 OLED) by examining the
  diff context
- Verified the change is purely a DMI table addition with no logic
  changes
- Verified the commit has `Reviewed-by: Ilpo Järvinen` (x86 platform
  maintainer)
- Copyright year change is cosmetic and has zero functional impact

This is a standard hardware quirk addition — exactly the type of small,
safe change that stable trees accept to enable hardware support for real
users.

**YES**

 drivers/platform/x86/oxpec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 144a454103b93..59d6f9d9a9052 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -11,7 +11,7 @@
  *
  * Copyright (C) 2022 Joaquín I. Aramendía <samsagax@gmail.com>
  * Copyright (C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
- * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
+ * Copyright (C) 2025-2026 Antheas Kapenekakis <lkml@antheas.dev>
  */
 
 #include <linux/acpi.h>
@@ -142,6 +142,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)oxp_2,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER APEX"),
+		},
+		.driver_data = (void *)oxp_fly,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
-- 
2.51.0


