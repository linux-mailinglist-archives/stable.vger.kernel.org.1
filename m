Return-Path: <stable+bounces-222928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aORDGrQvp2mbfgAAu9opvQ
	(envelope-from <stable+bounces-222928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:00:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F421F5924
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 173BB3015BA0
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99CF372686;
	Tue,  3 Mar 2026 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="W3709tWX"
X-Original-To: stable@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6E372660
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564398; cv=none; b=bCl4D4qP6bb3GIyESrc1Bzh1QS0UpCjeJ23top/jTelBjns2aQ8ySQXcDhVgVAirv5U4UYlBZ7ETqwWO7GcNLuZjwUtkoTWCQbkYnre2dMrpIVhsc8y4HTUzmxy5CejcjM6o/DyoWjzhbX056hEucqljSr1DeG/iMu3AnL/5SQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564398; c=relaxed/simple;
	bh=BfFrU8BLbRUEeBUOMlyhEeh7so913/pxTD5+6n1SOvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lqlu8pCX6Wm1xvTPnZrSlticC1+MIxV3nqyYx1McUYJUpDrCfCUAqSGyh+1uqzZKSmVax+W6pF2GOJEJ/xl/9HjWmbSooPlKw+Wuc+cIXw00cIaRZDKRv1qnnMRoJh0QTkOk787OF6ETzQhBimRHVMpD/Che2r7glBIMM9GNkSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=W3709tWX; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (i5C75F679.versanet.de [92.117.246.121])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 7B6C72FC004D;
	Tue,  3 Mar 2026 19:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1772564386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bW42MD6vGYDjr/KZYupD2d9rhpFef+425fwIxaBxD2Y=;
	b=W3709tWX741d+wKnzuMTbiFAWGsb1pOIfOMByZo8iVNNQHBIJUGkJD8jnU0OkhoyaieJm7
	m1uY8HCjFYMakhavYF9r26eeQtZy6rR7xt7u1JRybrxjatmXefDf24nUO6jF+Kb7XkT7OH
	FG/7WFvjoU15wCdPj/snyezc/VijezU=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: stable@vger.kernel.org
Cc: Aaron Erhardt <aer@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH] ALSA: hda/hdmi: Add quirk for TUXEDO IBS14G6
Date: Tue,  3 Mar 2026 19:56:28 +0100
Message-ID: <20260303185944.48669-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 65F421F5924
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tuxedocomputers.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tuxedocomputers.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222928-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wse@tuxedocomputers.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tuxedocomputers.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,tuxedocomputers.com:dkim,tuxedocomputers.com:email,tuxedocomputers.com:mid]
X-Rspamd-Action: no action

From: Aaron Erhardt <aer@tuxedocomputers.com>

[ Upstream commit d649c58bcad8fb9b749e3837136a201632fa109d ]

Depending on the timing during boot, the BIOS might report wrong pin
capabilities, which can lead to HDMI audio being disabled. Therefore,
force HDMI audio connection on TUXEDO InfinityBook S 14 Gen6.

Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Link: https://patch.msgid.link/20260218213234.429686-1-wse@tuxedocomputers.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
Change from upstream commit: The file was renamed sometime after v6.12.
There is already a pending patch for 6.18.y and 6.19.y. This is for all
stable released including 6.12.y and before with the old filename.

 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 70a90117361c5..a5ebd2a9a1116 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1999,6 +1999,7 @@ static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x1043, 0x86ae, "ASUS", 1),  /* Z170 PRO */
 	SND_PCI_QUIRK(0x1043, 0x86c7, "ASUS", 1),  /* Z170M PLUS */
 	SND_PCI_QUIRK(0x1462, 0xec94, "MS-7C94", 1),
+	SND_PCI_QUIRK(0x1558, 0x14a1, "TUXEDO InfinityBook S 14 Gen6", 1),
 	SND_PCI_QUIRK(0x8086, 0x2060, "Intel NUC5CPYB", 1),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", 1),
 	{}
-- 
2.43.0


