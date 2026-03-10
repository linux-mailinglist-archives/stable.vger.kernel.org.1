Return-Path: <stable+bounces-223824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCWUBaXgr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:13:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E0A2480F4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC8330F43E4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382546AEDF;
	Tue, 10 Mar 2026 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hlq4l7jc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D8A46AEC7;
	Tue, 10 Mar 2026 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133351; cv=none; b=a+fTcyBokoMFIEfnZrXsTlBYjdMoHF0njQRkzbd1mOWFKbIOIDeW44FsRVRc5gkWJxpEKtM76twEgUu75qsuZ/cuAKPNOcF4UtyoJVCA890dzlZQDg3TELleq5U1u5bqSt95PdXj5Tgxhz9Wxd4KxKjZtW4OXr+ysT5bRVCTPyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133351; c=relaxed/simple;
	bh=+62lrSkNdKk1CwQ38gQbaUGMthXMOhMe0cCsIwFBsuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdLMH1jt7vhtC79FHecILhPkhKdghuWaew0jO9VDymO22rXGCtYWkKoV71qhFrEMM4sfAhNCNLSF4CZesMZ1M01WzGUexYPUeASShtsKgqVOFUQMIbumwkiCqD5zvpsahzsZjcto7oxqnTQgeMYTblfGgk35K2E1pcrMTExjUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hlq4l7jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755CEC2BC86;
	Tue, 10 Mar 2026 09:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773133351;
	bh=+62lrSkNdKk1CwQ38gQbaUGMthXMOhMe0cCsIwFBsuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hlq4l7jcMXN5I4a6hH5Y5OLpvROdIbGjEvVkR8Jh6Ip78QVAuiPUC2Vu4rcgvDpL/
	 DzqDy0sLV84CPJe61rA0CljlspR4w6KQbYEYrmQpQ0CprMUf7AceiDm3myZaQzUHim
	 LmtAg77uN8As50MgAnr2HCCYSG9GHuyDoPiMW+V+3mbdd9D0Fver4bgyxqchKAePJW
	 cYN9GQm10EHE0tlN8ShlqZf+R0BrVm464UqEJzGbw0tYRMxRPYgRR8/uSO5nZpUbgt
	 VHmU0LR6ED5lbw7oKTDd4YH5/N96sMwzw/ne+9eCp3PHe2eqGghlR0k7buRrfVAMYU
	 PPuXRAPMcnpug==
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
Subject: [PATCH AUTOSEL 6.19-6.18] platform/x86: oxpec: Add support for OneXPlayer X1 Air
Date: Tue, 10 Mar 2026 05:01:31 -0400
Message-ID: <20260310090145.2709021-31-sashal@kernel.org>
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
X-Rspamd-Queue-Id: A9E0A2480F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[antheas.dev,linux.intel.com,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223824-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,msgid.link:url,antheas.dev:email]
X-Rspamd-Action: no action

From: Antheas Kapenekakis <lkml@antheas.dev>

[ Upstream commit 2a3b4a8c10a64a62c4243007139d253dc1324dfd ]

X1 Air is an X1 variant with a newer Intel chipset. It uses the same
registers as the X1. Add a quirk for it to the oxpec driver.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Link: https://patch.msgid.link/20260223183004.2696892-4-lkml@antheas.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The `oxp_x1` board type is used extensively in the driver. The key
concern for backporting is:

1. The driver was renamed from `drivers/hwmon/oxp-sensors.c` to
   `drivers/platform/x86/oxpec.c` in April 2025 - stable trees would
   need the patch applied to the old file path
2. The `oxp_x1` enum value and associated X1 DMI entries may have been
   added after the stable branch points

This is a **new device ID addition** to an existing driver - a classic
exception to stable rules. The change is trivially small (7 lines), zero
risk to existing users, and enables the oxpec driver on a real shipping
hardware device.

### Verification

- `git log` confirmed oxpec.c was renamed from `drivers/hwmon/oxp-
  sensors.c` in commit `3012bb39001c4` (April 2025)
- The original driver was added in commit `ed264e8a7d18c` (December
  2022), first appearing in v6.2
- The commit adds a single DMI entry using `oxp_x1` driver_data,
  identical in pattern to 7 other X1 variant entries
- The commit is reviewed by `Ilpo Järvinen` (Intel platform maintainer)
- The patch only touches one file, adding 7 lines (a DMI table entry)
- The driver file has been moved since stable branch points, so
  backporting would require path adjustment

### Conclusion

This is a straightforward device ID / hardware quirk addition that
enables an existing driver on new hardware. It meets all stable
criteria:
- Obviously correct (identical pattern to sibling entries)
- Fixes a real issue (device not recognized without entry)
- Small and contained (7 lines, 1 file)
- No new features (reuses existing `oxp_x1` code path)
- Zero risk (DMI exact match only affects specific hardware)

The only consideration is that backporting will need a path adjustment
since the file was moved, and the `oxp_x1` board type must already exist
in the target stable tree. But the pattern is clearly appropriate for
stable.

**YES**

 drivers/platform/x86/oxpec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 158c545d4efbb..6d4a53a2ed603 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -247,6 +247,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)oxp_x1,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1Air"),
+		},
+		.driver_data = (void *)oxp_x1,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
-- 
2.51.0


