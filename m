Return-Path: <stable+bounces-223993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEvYCfb9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:18:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8477224A570
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 615A6313CFD5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D5A2D24B7;
	Tue, 10 Mar 2026 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbgNCGCc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E23313537;
	Tue, 10 Mar 2026 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141126; cv=none; b=DJ33gToxehaIWnlZ1otoWZ27NMi8tJ33ku9a03z0S7LyVuXAZK5u4ewIE5X69HnKGlIi5Ielwy5PN9Fk2tNeFAiwUMRwfBe4D5SLkqCc0bJsKONNDDLrOmRmIKl5tJo+mDMo93z5Nq/FnW53CE3ykvJR3OVyPiK01D+Z5V9EEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141126; c=relaxed/simple;
	bh=PQXfIqEl2LN46kWtD699Ib7xtS22W4RVRuBU1FzHzv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZKUGi4h4KHCXmEesdrgm7M6R3qjAUSSBdGbLsXAWR5IdaXnUhOnRM98AdGWMDaAc1hVjW9g2S8pEKK0Ancod4xiA2Fs+2+qjWYngTh8zVxpka3TzTDOSHm+pi/yVes7RMvAvVy/zcHz0Rehnyfbdw4YekoiM7UM0f1wzk+nYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbgNCGCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42601C19423;
	Tue, 10 Mar 2026 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141125;
	bh=PQXfIqEl2LN46kWtD699Ib7xtS22W4RVRuBU1FzHzv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbgNCGCcxxMOohW5ia+LRnCIqK4J3i/B5Ja1ddBPfutCA7NZHZGfgH3jsmkzFxUfH
	 0qUW5AHzdl7a4cPq7wTPEtyvkRgg5h1FBqreNhSrxQKkJMlKjuwjOA2RdG0ocxSu1f
	 1+3Gkh0rf+Hw0sz94jqeep+XTEyV8ai4jTpvUrx49I1zwWPV97GVZjiUrO9cTm8BVn
	 j2lTm6ImmTgw5QM3Hi1o6jnns9Czig6YiG0M81uTH6Np5SJMMZT3Ergindvd+40kwT
	 Jt06QvyIEuWHJgNpyQGQMH3EMQr/Io3paK5eZW/X+Ztsm0ut3CMnpCya64AgClR2AY
	 0W9QrfBL7vt4w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Juhyung Park <qkrwngud825@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.19 128/311] ALSA: hda/realtek: fix model name typo for Samsung Galaxy Book Flex (NT950QCG-X716)
Date: Tue, 10 Mar 2026 07:02:55 -0400
Message-ID: <f9ebdbe0c98470a6acfb77d5fe9ded02a4c1532f.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8477224A570
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223993-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,samsung.com:url]
X-Rspamd-Action: no action

From: Juhyung Park <qkrwngud825@gmail.com>

commit 43a44fb7f2fa163926b23149805e989ba2395db1 upstream.

There's no product named "Samsung Galaxy Flex Book".
Use the correct "Samsung Galaxy Book Flex" name.

Link: https://www.samsung.com/sec/support/model/NT950QCG-X716
Link: https://www.samsung.com/us/computing/galaxy-books/galaxy-book-flex/galaxy-book-flex-15-6-qled-512gb-storage-s-pen-included-np950qcg-k01us
Cc: <stable@vger.kernel.org>
Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
Link: https://patch.msgid.link/20260222122609.281191-1-qkrwngud825@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index beff91f122c61..df5c64b7d1f9e 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7312,7 +7312,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_AMP),
-	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Flex Book (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_AMP),
+	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Book Flex (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc18a, "Samsung Galaxy Book Ion (NP930XCJ-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc1a3, "Samsung Galaxy Book Pro (NP935XDB-KC1SE)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc1a4, "Samsung Galaxy Book Pro 360 (NT935QBD)", ALC298_FIXUP_SAMSUNG_AMP),
-- 
2.51.0


