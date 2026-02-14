Return-Path: <stable+bounces-216455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIzsFU7Lj2nMTgEAu9opvQ
	(envelope-from <stable+bounces-216455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:09:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5CC13A915
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16B5B300E612
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3D6228CB0;
	Sat, 14 Feb 2026 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhqEvJDu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28B21E5B63;
	Sat, 14 Feb 2026 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771031255; cv=none; b=krLwqnG8u9cXgvn18db2wlW9ajBysUeMJvVgwKCTTroIMuHNXhfMjIYHCHEAoBoqBxBPdvGk1nCkH5OUHyGNXUevBpsL2Vo2xGfPwI+E3nhQfJzdwzO8+8E5Skm5+YQ8kn9k8fMMuowjfEpbTpyQZlSE9QBO1SXaX++iWER426M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771031255; c=relaxed/simple;
	bh=eH7GBxutsBYerARSGn0elPJyiXpbxtbh/y6973Psm4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtirVZ0qV/pl+Kmo0BX2Qf4KbumIbsosx0tUgsunn+oPRqrAB38qddVrgdkyLfQKUbNBC0F+Zp/ylfo2jLEwwMOhlM9Fiph4SpbFSkSRGhrvMUdFVvdzxblm7edNAkW3smVEfl1qQ/edHZnyoX1KInouwfCZvlIb/LqYg4iJsdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhqEvJDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F76C19424;
	Sat, 14 Feb 2026 01:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771031255;
	bh=eH7GBxutsBYerARSGn0elPJyiXpbxtbh/y6973Psm4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhqEvJDurRo1wvvoE56OpauhzLxJTsUoVKmuvDB9ZU3dfpiwpwFerjoaykTl9Kkq0
	 5CdJmgCn4UVnqtL3TjMkF1OnyYPzzjMOpcMs9zPP/jSghSkMxpKQP3agimFQ4iScAg
	 9ns08VWE8k4TGABTy4xQsQSxckc0N7FT57I+WTWKgBxaf1GHhaTZGFmhUQrnafdbdf
	 IYUf9QlztR+h+Ek5lC3KGSqH5gtU2h8XMlP63lZJAmKJTdWdxJQMmtG3UQZKgrC1fE
	 nOQYH5WHob0f58jHzEc/QKSm+kO10mtL6qciCB4Mve04YB99TWfQsEpy0eLXyZ1O32
	 jlEFV3j9T6Ujg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] hwmon: (dell-smm) Add support for Dell OptiPlex 7080
Date: Fri, 13 Feb 2026 20:00:03 -0500
Message-ID: <20260214010245.3671907-123-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214010245.3671907-1-sashal@kernel.org>
References: <20260214010245.3671907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216455-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,roeck-us.net,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,roeck-us.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C5CC13A915
X-Rspamd-Action: no action

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 46c3e87a79179454f741f797c274dd25f5c6125e ]

The Dell OptiPlex 7080 supports the legacy SMM interface for reading
sensors and performing fan control. Whitelist this machine so that
this driver loads automatically.

Closes: https://github.com/Wer-Wolf/i8kutils/issues/16
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Acked-by: Pali Rohár <pali@kernel.org>
Link: https://lore.kernel.org/r/20260104000654.6406-1-W_Armin@gmx.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Message Analysis

This commit adds a DMI whitelist entry for the Dell OptiPlex 7080 to the
`dell-smm-hwmon` driver. The commit message explains that this machine
supports the legacy SMM interface for reading sensors and performing fan
control, and the whitelist entry enables the driver to load
automatically on this hardware.

There's a linked issue (`https://github.com/Wer-
Wolf/i8kutils/issues/16`) showing a real user request for this support.

### Code Change Analysis

The change is a simple addition of a single DMI matching entry to the
`i8k_dmi_table[]` array:

```c
{
    .ident = "Dell OptiPlex 7080",
    .matches = {
        DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
        DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7080"),
    },
},
```

This is structurally identical to the existing entries for OptiPlex
7060, 7050, and 7040. The pattern uses `DMI_EXACT_MATCH` for the product
name (matching the convention of other OptiPlex entries), preventing
false matches with similarly named models.

### Classification

This falls squarely into the **device ID / hardware quirk / whitelist**
exception category. It's adding a machine identifier to an existing
driver's whitelist table so the driver auto-loads on that hardware.
Without this entry, the Dell OptiPlex 7080 doesn't get hardware
monitoring and fan control support from this driver (unless force-
loaded).

### Scope and Risk Assessment

- **Lines changed**: +7 lines (a single DMI table entry)
- **Files touched**: 1 (`drivers/hwmon/dell-smm-hwmon.c`)
- **Risk**: Extremely low. The entry only affects Dell OptiPlex 7080
  machines. It cannot affect any other hardware. The matching pattern is
  well-established and identical in structure to dozens of other entries
  in the same table.
- **Complexity**: Trivial

### User Impact

Users with Dell OptiPlex 7080 machines running stable kernels would
benefit from having hardware monitoring and fan control work
automatically. This is a desktop PC used in corporate
environments—exactly the kind of hardware that runs stable/LTS kernels.

### Stability Indicators

- **Acked-by**: Pali Rohár (co-maintainer of this driver)
- **Signed-off-by**: Guenter Roeck (hwmon maintainer)
- The existing driver framework is mature and well-tested
- The same pattern is used for many other Dell models already in the
  table

### Dependency Check

No dependencies. The driver and DMI matching infrastructure exist in all
relevant stable trees. This is a self-contained addition to a data
table.

### Conclusion

This is a textbook example of a hardware whitelist addition that is
appropriate for stable backporting. It enables existing, well-tested
driver functionality on a specific hardware platform. The change is
trivial, zero-risk to other systems, reviewed by the subsystem
maintainers, and benefits real users running stable kernels on Dell
OptiPlex 7080 desktops.

**YES**

 drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 93143cfc157cf..038edffc1ac74 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1325,6 +1325,13 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MP061"),
 		},
 	},
+	{
+		.ident = "Dell OptiPlex 7080",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7080"),
+		},
+	},
 	{
 		.ident = "Dell OptiPlex 7060",
 		.matches = {
-- 
2.51.0


