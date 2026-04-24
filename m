Return-Path: <stable+bounces-240711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPKjGqNy62nmMwAAu9opvQ
	(envelope-from <stable+bounces-240711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:39:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B6345F590
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E94D3037148
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7C3D6CDF;
	Fri, 24 Apr 2026 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P5aAwLts"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E119A288;
	Fri, 24 Apr 2026 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037640; cv=none; b=KciIkaMY7wU2REhrf862lI6Xm+cmNE5yA+wdavTw93Zqp0SespQ/y2p64+arhg8491/rsjJ7xr/VmMj9HcpZKdDGwubTYRVkTtR0d0nOtwT6UuX2h+xW+s6YKlJl3Hx6iTTj8wFaxXSBBjiilHTi+pZDUxCzXvPHYzfkv6YDl/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037640; c=relaxed/simple;
	bh=fgrVV+wvHwXAuX25Y1SaP6u6n27M5xO3q2xUeERdVIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMhMk4X7t4aFrx57BBGoxyHieNlPic41tDjatx6bp7dwBTCpGNAPzR616ExtvlIoFrr/HJqc0WA0TBxVUwVETiRgPINpkikn0xhuwZIEmqvjQk/+z6xu4HEvUAEB8NNXKx9RSrjmxh0q9NpRVaMZPysGNowz6HzMDj3BgcxacAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P5aAwLts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E415EC19425;
	Fri, 24 Apr 2026 13:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037639;
	bh=fgrVV+wvHwXAuX25Y1SaP6u6n27M5xO3q2xUeERdVIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5aAwLtsfmMwK4NSMfHfVewmiJzXVdcXyKuLtufiIehDGKSnoScT2PZJQt8KwGGoI
	 PsTEmEThsjaBrXrE1KTuHuvs8ETa6lITy1cTq6mS4g6aZTNOzbr6TGJ0TbmR7JxgeS
	 dSC910t0Sgiy8SaJk9I7E5y21S6G3J1JPj1GPYBk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 004/166] ALSA: hda/realtek: Add quirk for ASUS ROG Flow Z13-KJP GZ302EAC
Date: Fri, 24 Apr 2026 15:28:38 +0200
Message-ID: <20260424132533.736892140@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: A7B6345F590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240711-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Schwartz <matthew.schwartz@linux.dev>

[ Upstream commit 59f68dc1d8df3142cb58fd2568966a9bb7b0ed8a ]

Fixes lack of audio output on the ASUS ROG Flow Z13-KJP GZ302EAC model,
similar to the ASUS ROG Flow Z13 GZ302EA.

Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Link: https://patch.msgid.link/20260313172503.285846-1-matthew.schwartz@linux.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a3def674103b3..cd30f749c79b4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10290,6 +10290,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x14e3, "ASUS G513PI/PU/PV", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x14f2, "ASUS VivoBook X515JA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1503, "ASUS G733PY/PZ/PZV/PYV", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x1514, "ASUS ROG Flow Z13 GZ302EAC", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1533, "ASUS GV302XA/XJ/XQ/XU/XV/XI", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1573, "ASUS GZ301VV/VQ/VU/VJ/VA/VC/VE/VVC/VQC/VUC/VJC/VEC/VCC", ALC285_FIXUP_ASUS_HEADSET_MIC),
-- 
2.53.0




