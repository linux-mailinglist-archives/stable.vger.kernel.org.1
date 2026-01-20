Return-Path: <stable+bounces-210593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDT1HZjwb2m+UQAAu9opvQ
	(envelope-from <stable+bounces-210593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:16:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 175C44C14E
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4691B88006B
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470F647D946;
	Tue, 20 Jan 2026 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIZzplqa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8A449EA0;
	Tue, 20 Jan 2026 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937702; cv=none; b=GgsU609ypalv6xxpkuzr57KBaWcqUtJWq2725Nh4IpMOvMWV7+1dfZ3oYZe3NO4uRcte7lPMciKP4L+0LEW/OmSXnAnX9HIBwZ0H+RnejaJfCxykLjgXFdeszN3UV4qDaKGmhfAYZcjxqhS+2h/ijACa+2RE9nSvTff9Xd0c5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937702; c=relaxed/simple;
	bh=sl0c0tXxSGUlMJVxClFDtN6MdMpzp4gx5cCUIHJzHX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwK1SCOSCafcwMZ7MOfxAyG7xoKewrK8VRv2JmLuziTPihRQNpBXd+JrgC973ESlSGAo5m7CMPorCmTkQCGYNY+ZPy7iNGyWsujf7rOl/rJNQYx6UlaLx5JFsxf18r0kL8FixSUL8Ribl+okyIFB7ZyvpKpJKcl676SJz5/6oac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIZzplqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F51C16AAE;
	Tue, 20 Jan 2026 19:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768937701;
	bh=sl0c0tXxSGUlMJVxClFDtN6MdMpzp4gx5cCUIHJzHX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIZzplqa9uDVBdrS9mbVmcm7D1e+m91XWVDijXUBWSH1vs9kJwmphYlP7jLZhQiPZ
	 dWVauUUbTYEVONAn342xw0bgNuKxKpzA834zEPAc1EbSCYWf2MMv8N7yhfViunTET5
	 DY6MCpcJlOz3l85/++K4sL0D/fYTc3ixChKKLXys7LmQcaO4VGGMjPWhdElFeOyrVo
	 DugbWT4l6SqZbtxIYbVtRc+KoGjGfYxe6DGRwnxorjrOJeY+GdgrrKD+zAqKG3GSXx
	 Zit0OeBSYRbhrz3NQ1eCcBqxMjOzBkiyDHa8j/o5t9LoYSMRlsn0pZvJQG0tITZhr1
	 +Gfl7duD38uKw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Radhi Bajahaw <bajahawradhi@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mario.limonciello@amd.com,
	ravenblack@gmail.com,
	thomasmizra@gmail.com,
	meowmeowbeanz@gmx.com,
	yuzuru_10@proton.me,
	oliver.schramm97@gmail.com,
	queler@gmail.com,
	laodenbach@gmail.com,
	talhah.peerbhai@gmail.com,
	santesegabriel@gmail.com,
	alex.andries.aa@gmail.com,
	syed.sabakareem@amd.com
Subject: [PATCH AUTOSEL 6.18-6.6] ASoC: amd: yc: Fix microphone on ASUS M6500RE
Date: Tue, 20 Jan 2026 14:34:45 -0500
Message-ID: <20260120193456.865383-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120193456.865383-1-sashal@kernel.org>
References: <20260120193456.865383-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,amd.com,gmx.com,proton.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-210593-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 175C44C14E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Radhi Bajahaw <bajahawradhi@gmail.com>

[ Upstream commit 8e29db1b08808f709231e6fd4c79dcdee5b17a17 ]

Add DMI match for ASUSTeK COMPUTER INC. M6500RE to enable the
internal microphone.

Signed-off-by: Radhi Bajahaw <bajahawradhi@gmail.com>
Link: https://patch.msgid.link/20260112203814.155-1-bajahawradhi@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Comprehensive Analysis

### 1. COMMIT MESSAGE ANALYSIS

The commit message is clear and straightforward:
- **Subject**: "ASoC: amd: yc: Fix microphone on ASUS M6500RE"
- **Description**: Adds a DMI match for a specific ASUS laptop model to
  enable the internal microphone
- **Keywords**: "Fix" indicates this is addressing a bug (non-working
  microphone)
- **Tags**: Has proper Signed-off-by and Link tags, reviewed by Mark
  Brown (ASoC maintainer)

The commit addresses a real user-facing issue: the internal microphone
doesn't work on this specific laptop without this DMI quirk entry.

### 2. CODE CHANGE ANALYSIS

The diff shows:
- **Single file changed**: `sound/soc/amd/yc/acp6x-mach.c`
- **Change type**: Addition of a new DMI match entry to the
  `yc_acp_quirk_table[]` array
- **Lines added**: 7 lines (a new table entry)
- **Lines removed**: 0

The actual change is:
```c
{
    .driver_data = &acp6x_card,
    .matches = {
        DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
        DMI_MATCH(DMI_PRODUCT_NAME, "M6500RE"),
    }
},
```

This is identical in structure to the existing entries for other ASUS
models (M6400RC, M3402RA, M6500RC, M6501RM, E1404FA, E1504FA, etc.). The
pattern is well-established.

### 3. CLASSIFICATION

This falls squarely into the **QUIRKS and WORKAROUNDS** exception
category:
- It's a DMI-based hardware quirk for a specific laptop model
- The driver already exists and is functional
- This just adds hardware identification to enable proper audio
  configuration
- It's analogous to adding a new PCI/USB device ID to an existing driver

This is **NOT** adding a new feature - it's enabling existing
functionality on hardware that needs explicit enumeration.

### 4. SCOPE AND RISK ASSESSMENT

**Risk: VERY LOW**
- **Scope**: Extremely minimal - 7 lines added to a quirk table
- **Isolation**: The change only affects ASUS M6500RE laptops - no other
  systems are impacted
- **Pattern**: Follows exact same pattern as dozens of other entries in
  the same table
- **No logic changes**: No behavioral changes to the driver code itself
- **No dependencies**: Self-contained change

Looking at the file, there are already many ASUS laptop entries in this
table (M3402RA, M6400RC, M6500RC, M6501RM, etc.). The M6500RE is just
another variant in the same product family.

### 5. USER IMPACT

**Impact: HIGH for affected users, ZERO risk for others**
- Users with ASUS M6500RE laptops currently have non-working internal
  microphones
- This is a significant functional issue (broken audio input)
- The fix enables basic hardware functionality that users expect
- No impact whatsoever on other systems (DMI match is very specific)

### 6. STABILITY INDICATORS

- **Maintainer review**: Signed off by Mark Brown, the ASoC subsystem
  maintainer
- **Well-tested pattern**: This exact quirk table pattern has been used
  hundreds of times
- **Low complexity**: The change is purely data (no code logic)

### 7. DEPENDENCY CHECK

- **No dependencies**: This is a standalone quirk entry
- **Code exists in stable**: The `yc_acp_quirk_table` and `acp6x_card`
  have been in the kernel since the Yellow Carp (AMD Rembrandt) audio
  support was added
- **Clean backport**: Will apply cleanly to any stable tree that has
  this driver

### Summary

This commit is a textbook example of what SHOULD be backported to
stable:

1. **Fixes a real bug**: Non-working microphone on a specific laptop
2. **Obviously correct**: Follows established pattern exactly
3. **Small and contained**: 7 lines, single file, data-only change
4. **No new features**: Enables existing driver for additional hardware
5. **Zero risk of regression**: Only affects the specific ASUS M6500RE
   model
6. **Tested**: Presumably by the author who owns this hardware
7. **Maintainer approved**: Reviewed and merged by Mark Brown

This matches the "hardware quirks/workarounds" exception to the stable
rules. These DMI/PCI/USB ID additions are routinely backported because
they fix real hardware issues with essentially zero risk.

**YES**

 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index bf4d9d3365617..0294177acc663 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -416,6 +416,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RE"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.51.0


