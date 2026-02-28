Return-Path: <stable+bounces-220445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDdAMSo3o2lh+gQAu9opvQ
	(envelope-from <stable+bounces-220445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2751C62B5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9174035B9C85
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711948122D;
	Sat, 28 Feb 2026 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc102TDX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058D93B6CBB;
	Sat, 28 Feb 2026 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300334; cv=none; b=Ue/FC5KtXfIFXT2Niozm8EykgmwaImVjDI9V+F1AEOEF6vEWw1Sl9qojTiJpMYC1ZrqlL02Z24yAniT0pR6wgXEw7K1TUJ4m2S1TCbDEjQ2ZilesJIBn2ilX/5orbl/8+TIxBTpDEgv8upnT1yKL5ajf40bGbGv5nnK/J1iNKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300334; c=relaxed/simple;
	bh=NTHk+Aj+yk0JQZSMKMquAes9wACrqJ8bnwzA5E35qOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhLjCKVZfeIaAvQDXdHIYZkaUiWwGmvbA/OSVmTiqb9e5riwjdb2PxVsGfJZ8gC+8UpAx32GqY9GS6GCF9q4YUNbJ4F0cRc5ohRiF7l/Co7TDDsTjqWn88F+QYGFsiw03UCvBvlhJBxqvVlB0GJvGHRv77BT6T+6MeWf/7HQH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc102TDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2536EC19423;
	Sat, 28 Feb 2026 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300333;
	bh=NTHk+Aj+yk0JQZSMKMquAes9wACrqJ8bnwzA5E35qOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gc102TDXTOaEs0hxXHlrZN6Ds7d/1EObQoqaZuKXxquLC67FsuKEj7ktgbywdbAsb
	 nBMz6gYVeZjLvCvGfGd0E3cXhlxDK1FxeBm370Qzt+rlWfcdEaYYDmHOTiBvRkCvC2
	 QEJxBrBQLEkNKatu7H6QLAArxDW4GgX3rbdEb43Lsack9lQYmJ534/acg824kv8QsN
	 AFIwBqsDpuoJQpsg0LMq+ol3RNznp4+QDzFfLxrPPbl6WRnZ1F5/Ft/iHLefRLinQ0
	 axZ43uGKSacwVh+SDt+JD+yT6YkpyNqWpscKEIHl+Vqqby5iDPZMe/haqq/nBYkSwn
	 kEkEL408UxXpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 366/844] soundwire: dmi-quirks: add mapping for Avell B.ON (OEM rebranded of NUC15)
Date: Sat, 28 Feb 2026 12:24:39 -0500
Message-ID: <20260228173244.1509663-367-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220445-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2C2751C62B5
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


