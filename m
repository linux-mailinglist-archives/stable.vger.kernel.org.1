Return-Path: <stable+bounces-225088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHwoLYUgs2m5SQAAu9opvQ
	(envelope-from <stable+bounces-225088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:22:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C10278E76
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6D9D3021C29
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2B1349B03;
	Thu, 12 Mar 2026 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fJqlLaMz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E03491D6;
	Thu, 12 Mar 2026 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346898; cv=none; b=c6CfKpQfmd1M7pPbCTNrLDQ0Dd6lc3nykxY3SGZCJtARICnTVpkTLf0GBc7gn9RQ6O4HpHB/ZyuTnQ1mk8zCny1pRaoa6JnFeNaAtS5q7t1ZbDOteIKWG32PXil5yDaEi8CwfcT7D0IgLUtTFhOC+FAV9DSFrRQSKPQxBaOX4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346898; c=relaxed/simple;
	bh=jH4XqulkH4AYwg3BvuARYy6zLdOFZaODMKfCneDHaQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mm1GSW2ZI8Dk4zzOXFZaQ6Mxk65jqheNHaDBdPRNkZDAfHIilPVH7GVFNEOo1q5oWaPTyXLIrB8gObw97nWmEwHqwIVeNYx7XagWfsfz/g0UYnzh2xJu0Db7mNlLbc3iU9srKDdvjA+7xhLeXy/eWWyIM9N1bI6KGwy5x2b/6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fJqlLaMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539E1C4CEF7;
	Thu, 12 Mar 2026 20:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346898;
	bh=jH4XqulkH4AYwg3BvuARYy6zLdOFZaODMKfCneDHaQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJqlLaMzglwLiOi7yThSvczpx5jmsw4vB1XjxonyScMwkmJckVw0UcvuDsSzQuPUO
	 fJtCWOw6PIUPlBOt+W8q2hPJ77DKIj/9mTfyIR828FYNbYqdE39EU7utu+mSQT++bT
	 376ocAZCxw7w2Swe7fHgMR34z4NZBe97JT3m2eOY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Naim <dnaim@cachyos.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 122/265] ALSA: hda/realtek: Add quirk for Gigabyte G5 KF5 (2023)
Date: Thu, 12 Mar 2026 21:08:29 +0100
Message-ID: <20260312201022.651552912@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225088-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: A7C10278E76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Naim <dnaim@cachyos.org>

[ Upstream commit 405d59fdd2038a65790eaad8c1013d37a2af6561 ]

Fixes microphone detection when a headset is connected to the audio jack
using the ALC256.

Cc: stable@vger.kernel.org
Signed-off-by: Eric Naim <dnaim@cachyos.org>
Link: https://patch.msgid.link/20260210093403.21514-1-dnaim@cachyos.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 85178a0303a57..e321428225f9b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11296,6 +11296,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc886, "Samsung Galaxy Book3 Pro (NP964XFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1ca, "Samsung Galaxy Book3 Pro 360 (NP960QFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1cc, "Samsung Galaxy Book3 Ultra (NT960XFH)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
+	SND_PCI_QUIRK(0x1458, 0x900e, "Gigabyte G5 KF5 (2023)", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),
-- 
2.51.0




