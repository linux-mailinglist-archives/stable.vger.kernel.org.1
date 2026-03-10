Return-Path: <stable+bounces-223819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENClBlLir2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:20:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BEA248383
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6EC232A598D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC6345BD7B;
	Tue, 10 Mar 2026 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sznofwif"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE94508F2;
	Tue, 10 Mar 2026 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133345; cv=none; b=iNhkBV7SGmlmuguVnX7k4ApQNWM7um3q5FupWI0CfxlNR5FS1Q8swRzt5wfgDNh1xsyFn+Pemod4m7qota5g5ifktUXbNHNE4rkeO8mnsK/HrW19Ur0FcIpMBLH+4+onrHQWAgcdlCW5E5vX9JGNvyTW9Iv7E1WZ7lPt5CibZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133345; c=relaxed/simple;
	bh=LR8yxGsfAO5JGNEsZtgdYEhWHG34ymOAfWN9E2eLdfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOMQ9BMaGKKZPk6iO9AqebLLe97molWl2ib8m1LbkKJEFXq/GNuFkMkHQ/DTTPAbDSGtzGHqaCn/ERYabIA2URmFYvAshbvSVLQxsrOyOOfvXMZ5gaOM8ITV9z2ollA3YJPCCmdIBsvkJULImNDokLlhm4lSKyAsrJ9kEHbBpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sznofwif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40D9C19423;
	Tue, 10 Mar 2026 09:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773133344;
	bh=LR8yxGsfAO5JGNEsZtgdYEhWHG34ymOAfWN9E2eLdfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sznofwifwPyQTC1ssSDdDpojKbSxmKl2OVlyf2K8/L2U71ukNW4hJtS37Y0ywsj5b
	 MJMLORHPq4U07vUXKagfiQUnHFhidq9JAqXq91A9qD3dlvh2xNHndSeAr5xyDBZv0p
	 oKdriK3XA3FoBvRJS/aseIS3JRUX5tZnOHqmBZrasQdTnOANnU/5y7amQhq7Qn8Fbk
	 P2Cb9N1G42FtwY0VUReLkmwXSiPMBJgiaTgvzAbAGuiLpwuy8nu1XQ656PHxSen0FY
	 hruYAAjDjKeo/7y9aedSG3BucSO2FDGTcbkyngDS6ONgledMTDl8NMAjFt4J9n0/n9
	 zhOWURrV27koQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Krishna Chomal <krishna.chomal108@gmail.com>,
	Varad Amol Pisale <varadpisale.work@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hansg@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] platform/x86: hp-wmi: Add Omen 16-xd0xxx fan and thermal support
Date: Tue, 10 Mar 2026 05:01:26 -0400
Message-ID: <20260310090145.2709021-26-sashal@kernel.org>
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
X-Rspamd-Queue-Id: 77BEA248383
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223819-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Krishna Chomal <krishna.chomal108@gmail.com>

[ Upstream commit 3c99a545b372c77b5d39715968a141f523eccbf2 ]

The HP Omen 16-xd0xxx (board ID: 8BCD) has the same WMI interface as
other Victus S boards, but requires quirks for correctly switching
thermal profile (similar to HP Omen 16-wf1xxx, board ID: 8C78).

Add the DMI board name to victus_s_thermal_profile_boards[] table and
map it to omen_v1_thermal_params.

Testing on HP Omen 16-xd0xxx confirmed that platform profile is
registered successfully and fan RPMs are readable and controllable.

Tested-by: Varad Amol Pisale <varadpisale.work@gmail.com>
Signed-off-by: Krishna Chomal <krishna.chomal108@gmail.com>
Link: https://patch.msgid.link/20260218050235.94687-1-krishna.chomal108@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

This commit adds a DMI board name entry ("8BCD") for the HP Omen
16-xd0xxx laptop to the `victus_s_thermal_profile_boards[]` table,
mapping it to `omen_v1_thermal_params`. This is a hardware quirk/device
ID addition to an existing driver.

### Change Classification

This is a **hardware quirk addition** — one of the explicitly allowed
exception categories for stable backports. The change:
- Adds exactly 4 lines to an existing DMI matching table
- Uses an already-existing parameter set (`omen_v1_thermal_params`)
- Only affects the specific board ID "8BCD" (HP Omen 16-xd0xxx)
- Follows the exact same pattern as other entries in the table (e.g.,
  board "8C78" also uses `omen_v1_thermal_params`)

### Risk Assessment

**Extremely low risk:**
- The change is confined to a single DMI match table — it cannot affect
  any other hardware
- It uses existing infrastructure (`omen_v1_thermal_params`) that is
  already tested with board "8C78"
- The commit has both `Tested-by` and `Reviewed-by` tags from the
  subsystem maintainer (Ilpo Järvinen)
- No code logic changes, no new functions, no new data structures

### User Impact

Without this entry, HP Omen 16-xd0xxx users cannot:
- Control fan speeds through the platform profile interface
- Switch thermal profiles (performance/balanced/quiet)

This is real hardware enablement for real users — the "Tested-by" from a
different person than the author confirms at least two users need this.

### Stable Criteria Check

- **Obviously correct**: Yes — trivial table entry addition matching
  existing patterns
- **Fixes real issue**: Yes — enables hardware control on specific
  laptop (quirk category)
- **Small and contained**: Yes — 4 lines in one file
- **No new features/APIs**: Correct — uses existing driver
  infrastructure
- **Tested**: Yes — explicitly tested on the hardware

### Verification

- Verified the diff is purely a table entry addition to
  `victus_s_thermal_profile_boards[]` — no code logic changes
- Verified `omen_v1_thermal_params` is already used by board "8C78" in
  the same table, confirming it's an existing, tested parameter set
- Verified the commit has `Tested-by: Varad Amol Pisale` and `Reviewed-
  by: Ilpo Järvinen` (subsystem maintainer)
- Verified the change follows the exact DMI_MATCH pattern used by all
  other entries in the table
- The commit message explicitly states "Testing on HP Omen 16-xd0xxx
  confirmed that platform profile is registered successfully and fan
  RPMs are readable and controllable"

This is a textbook hardware quirk addition — small, safe, tested, and
enables real hardware for real users. It matches the stable exception
for device quirks/IDs perfectly.

**YES**

 drivers/platform/x86/hp/hp-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 9fcc18635e4e7..bc550da031fa1 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -168,6 +168,10 @@ static const struct dmi_system_id victus_s_thermal_profile_boards[] __initconst
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8BBE") },
 		.driver_data = (void *)&victus_s_thermal_params,
 	},
+	{
+		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8BCD") },
+		.driver_data = (void *)&omen_v1_thermal_params,
+	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8BD4") },
 		.driver_data = (void *)&victus_s_thermal_params,
-- 
2.51.0


