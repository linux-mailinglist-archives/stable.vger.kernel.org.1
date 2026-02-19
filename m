Return-Path: <stable+bounces-217372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFL7IjVylmlqfQIAu9opvQ
	(envelope-from <stable+bounces-217372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 03:15:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BE515BA3E
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 03:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E727A30F2AD3
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694B930FC1B;
	Thu, 19 Feb 2026 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3HxaUkC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8830F93D;
	Thu, 19 Feb 2026 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771466706; cv=none; b=iGRBxlZS+2e0JdiSobh0wgUOMxB4UrielLYpV0AnlGwLgo+0PNGt8jh8w+mbRBeopSCCJ97ECPvLyf4Q4U3DPqJlyTQUkGdHN48D7atr6k1VtatCWm9F955Y9hQWi72LiC5fBXT9ur2JEF8u9dsApFsAHIVD1NBfBzCpuj2povw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771466706; c=relaxed/simple;
	bh=H8iaY/PK1UVRbp3ySwwROjS5cvfwZ2ZobWy3LlKk+IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phnNd56Vhj44Gys5XSlhGTOm9feSKesD7crlN+1lWMvFdejo4yrXzCRfew6U2LwoNqWCJ0r3gL9ba3qn5DnlXqkJTnp5aspRlvVIQallRi0b0jn+94a58uj8HD0+fRwZEwiUTT/8x9GexT7QbuwXv9k/bpLPj2p2K50q+00y3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3HxaUkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27416C116D0;
	Thu, 19 Feb 2026 02:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771466706;
	bh=H8iaY/PK1UVRbp3ySwwROjS5cvfwZ2ZobWy3LlKk+IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3HxaUkCpNUezwqVlQm4yq2vu7JoSsAYmMTEeSINpMbjZe4GiH/Z5EAVZmgnD25wn
	 5YsMf2/tflXb1HUj0RL3bfUoZoznY92IBXgcQCXfogMjTbNBn6dyZ+6eiHUdtKxQ5u
	 qd3G/LuaDymnf05Qgw9aGI4y+fd4PwfXVWWuxZ7qnv8HWLePC+dFlaXK+5D+la8p7a
	 XKb8Nphq5Ye9i+VvOfcKk5N1+6jgbpEZj3vH7e15JPZRnoipRy61xKiFE++17fd5Lc
	 teNwRkLYZVdJBpDNnd7mMDF19jwam1eTwe1A6o8+wZPhvGO/sykgNuXkIfI+LXNXun
	 NIt1q+AmkE+YQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.1] soundwire: dmi-quirks: add mapping for Avell B.ON (OEM rebranded of NUC15)
Date: Wed, 18 Feb 2026 21:04:09 -0500
Message-ID: <20260219020422.1539798-33-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219020422.1539798-1-sashal@kernel.org>
References: <20260219020422.1539798-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217372-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: D0BE515BA3E
X-Rspamd-Action: no action

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 59946373755d71dbd7614ba235e0093159f80b69 ]

Avell B.ON is an OEM re-branded NUC15 'Bishop County' LAPBC510 and
LAPBC710.

Link: https://github.com/thesofproject/linux/issues/5529
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20251215130947.31385-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Scope and Risk Assessment

- **Lines changed**: 11 lines added, 0 lines modified or deleted
- **Files touched**: 1 file (`drivers/soundwire/dmi-quirks.c`)
- **Complexity**: Minimal — it's a data table entry addition
- **Risk**: Extremely low — the new entry only matches systems with
  `DMI_SYS_VENDOR = "Avell High Performance"` and `DMI_PRODUCT_NAME =
  "B.ON"`. It cannot affect any other system.
- **Pattern**: Identical to the 8+ existing entries in the same table

## User Impact

- **Who is affected**: Users of Avell B.ON laptops (OEM rebranded Intel
  NUC15, sold in Brazil)
- **What happens without this fix**: Audio does not work on these
  laptops because the SoundWire address remapping is not applied
- **Severity**: Complete loss of audio functionality on affected
  hardware
- **Evidence**: GitHub issue #5529 documents the user-reported problem

## Stable Kernel Rules Compliance

1. **Obviously correct and tested**: Yes — follows the exact same
   pattern as all other entries in the table, reviewed by two subsystem
   experts
2. **Fixes a real bug**: Yes — audio is non-functional on Avell B.ON
   laptops without this quirk
3. **Important issue**: Yes — complete hardware functionality loss (no
   audio)
4. **Small and contained**: Yes — 11 lines in one file, data-only change
5. **No new features**: Correct — enables existing hardware support via
   existing mechanism
6. **Applies cleanly**: Should apply cleanly as it's a simple table
   entry addition

## Verification

- **git log** for `drivers/soundwire/dmi-quirks.c` confirms the file has
  a history of receiving similar DMI quirk additions (e.g., LAPBC710,
  Rooks County, HP Omen)
- **Code review** of the file confirms `intel_tgl_bios` is the same
  remap data used by 4 other NUC15/HP entries — this is the correct
  mapping for Bishop County hardware
- **GitHub issue #5529** confirms this is a real user-reported problem
  with Avell B.ON laptops lacking audio functionality
- **Reviewed-by tags** from Kai Vehmanen and Bard Liao (both Intel audio
  subsystem maintainers) confirm correctness
- **File history** shows this file was introduced in 2021 (commit
  f6594cdfec4cd) and exists in stable trees
- The change is purely additive (no existing code modified) and only
  matches a specific DMI vendor/product combination, so it cannot
  regress other hardware

## Conclusion

This is a textbook stable backport candidate. It's a hardware quirk
addition — a trivial, data-only change that enables audio on Avell B.ON
laptops (OEM rebrands of Intel NUC15). The fix is minimal (11 lines),
zero risk to other hardware, follows an established pattern in the file,
was reviewed by multiple Intel audio experts, and addresses a real user-
reported hardware issue. It meets all stable kernel criteria and falls
into the well-established "hardware quirks" exception category.

**YES**

 drivers/soundwire/dmi-quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 91ab97a456fa9..5854218e1a274 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -122,6 +122,17 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)intel_tgl_bios,
 	},
+	{
+		/*
+		 * quirk used for Avell B.ON (OEM rebrand of NUC15 'Bishop County'
+		 * LAPBC510 and LAPBC710)
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Avell High Performance"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "B.ON"),
+		},
+		.driver_data = (void *)intel_tgl_bios,
+	},
 	{
 		/* quirk used for NUC15 'Rooks County' LAPRC510 and LAPRC710 skews */
 		.matches = {
-- 
2.51.0


