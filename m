Return-Path: <stable+bounces-214921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHiTFPXUiWmBCAAAu9opvQ
	(envelope-from <stable+bounces-214921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 13:37:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F3210EC90
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 13:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D11C73014953
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 12:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A4D36EAA1;
	Mon,  9 Feb 2026 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNYmJ6oR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F43019CB;
	Mon,  9 Feb 2026 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640058; cv=none; b=b+E0IBcZTH0pXCE77d6BPsk6TmMFmDJ2XWpCqSzPzAGaoG6hN6t+GOLW+vSGvsaYKTc0NK5cTY8FUz6jxxJWcfaqixZe0AL7m07utBckgBCP0iox3BiHIcVO6EnDokvPxCv57N7QcyWwtFgD9NOWZO6o92w+Tu6n9SBENkiqaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640058; c=relaxed/simple;
	bh=XcI7n4Wun9l/AsF7vieNILQzEDRMWZ0MUZ9JBnzsG+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ihpu3TusjrJgxle0XCDbZ39Ibv6BUYYNwb3qe/0YcucR7h2ySir9hDnyhu8rIL064BeczZNBqeUe6o1oSxM5ER5MHSwqLg/6IugQGKcBGvYwk1PSHOtqcRg4i2HqrTaRn10yDJ+PyoJ3ctKjRpU1HQ+5KUwlWARQvhwuoTZgP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNYmJ6oR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4CFC16AAE;
	Mon,  9 Feb 2026 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770640058;
	bh=XcI7n4Wun9l/AsF7vieNILQzEDRMWZ0MUZ9JBnzsG+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNYmJ6oRJFRmSkUxUKpQNXyFcmrV5C9mAKkUzIUlJSl3k9HTtuh5ziJLoz6g0If9S
	 8JCDew/fjHaUOFRNHU3g6pTVD+VCCVzeZ+F6FIZbZ/KbxigViPdNMfAjbBBCY8BY9c
	 Io5Xz29Dz2DG/WcjiWx5SyPDUjwE/1gRi+yU+u8pV8VRTbnZUcxauXCA1Tja7+ixS9
	 qTXRGIAD9kqNQDt5mndSRc8UYgw+7OyaEO0/L+DOriMPg57tV5NNDmNkc1bKNuRXyO
	 Pfks33E5WOJOJCBdbyi1sKY/IpZQNT5dm6+rcQbuwkNwAuQeiwEPkmi1eDZfQKYPxW
	 OkCVW8tB7wOQQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	yung-chuan.liao@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ckeepax@opensource.cirrus.com,
	mac.chiang@intel.com,
	naveen.m@intel.com
Subject: [PATCH AUTOSEL 6.18] ASoC: sof_sdw: Add a quirk for Lenovo laptop using sidecar amps with cs42l43
Date: Mon,  9 Feb 2026 07:26:51 -0500
Message-ID: <20260209122714.1037915-12-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209122714.1037915-1-sashal@kernel.org>
References: <20260209122714.1037915-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214921-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3F3210EC90
X-Rspamd-Action: no action

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit 1425900231372acf870dd89e8d3bb4935f7f0c81 ]

Add a quirk for a Lenovo laptop (SSID: 0x17aa3821) to allow using sidecar
CS35L57 amps with CS42L43 codec.

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://patch.msgid.link/20260128092410.1540583-1-mstrozek@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Message Analysis
This commit adds a hardware quirk (PCI SSID entry) for a specific Lenovo
laptop (SSID: 0x17aa3821) to enable sidecar CS35L57 amplifiers with the
CS42L43 codec. The commit message is straightforward and describes a
device-specific quirk addition.

### Code Change Analysis
The change is a **single line addition**:
```c
SND_PCI_QUIRK(0x17aa, 0x3821, "Lenovo 0x3821", SOC_SDW_SIDECAR_AMPS),
```

This adds an entry to the `sof_sdw_ssid_quirk_table[]` array, which is a
table of PCI subsystem ID quirks. The entry maps a specific Lenovo
laptop's subsystem ID (vendor 0x17aa, device 0x3821) to the
`SOC_SDW_SIDECAR_AMPS` quirk flag.

### Classification: Hardware Quirk / Device ID Addition

This falls squarely into the **QUIRKS and WORKAROUNDS** exception
category for stable backports:
- It's a hardware-specific quirk for a specific laptop model
- It uses an existing mechanism (`SND_PCI_QUIRK` macro,
  `sof_sdw_ssid_quirk_table`)
- It adds to an existing table with similar entries already present
- The quirk flag `SOC_SDW_SIDECAR_AMPS` already exists and is used by
  the driver

### Risk Assessment
- **Scope**: Single line, single file change
- **Risk**: Extremely low — only affects the specific Lenovo laptop with
  SSID 0x17aa:0x3821
- **Side effects**: None for any other hardware; the quirk is matched by
  PCI subsystem ID
- **Dependencies**: The `SOC_SDW_SIDECAR_AMPS` flag and the quirk
  infrastructure must exist in the stable tree

### User Impact
Without this quirk, owners of this specific Lenovo laptop would have
non-functional or incorrectly configured audio (the sidecar amplifiers
wouldn't be recognized/used). This is a real hardware enablement issue —
the laptop's speakers likely don't work properly without this quirk.

### Stability Indicators
- **Reviewed-by**: Cezary Rojewski (Intel audio maintainer)
- **Signed-off-by**: Mark Brown (ASoC subsystem maintainer)
- This is a well-understood, minimal pattern used extensively in audio
  drivers

### Concerns
- The `SOC_SDW_SIDECAR_AMPS` quirk flag must exist in the target stable
  tree. This flag and the cs42l43 sidecar amp support may be relatively
  new, so it may only apply to recent stable branches (e.g., 6.12.y or
  later). If the flag doesn't exist in older stable trees, the patch
  simply won't apply, which is safe.
- No other dependencies — this is a self-contained table entry addition.

### Verdict
This is a textbook stable-worthy hardware quirk addition: a single-line
entry in an existing quirk table, enabling audio hardware on a specific
laptop model. It has zero risk to other hardware, is reviewed by
subsystem maintainers, and fixes a real user-facing problem (broken
audio).

**YES**

 sound/soc/intel/boards/sof_sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index c013e31d098e7..198858b57d9f5 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -794,6 +794,7 @@ static const struct snd_pci_quirk sof_sdw_ssid_quirk_table[] = {
 	SND_PCI_QUIRK(0x17aa, 0x2347, "Lenovo P16", SOC_SDW_CODEC_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x2348, "Lenovo P16", SOC_SDW_CODEC_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x2349, "Lenovo P1", SOC_SDW_CODEC_MIC),
+	SND_PCI_QUIRK(0x17aa, 0x3821, "Lenovo 0x3821", SOC_SDW_SIDECAR_AMPS),
 	{}
 };
 
-- 
2.51.0


