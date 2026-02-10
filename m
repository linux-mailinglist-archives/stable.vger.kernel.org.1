Return-Path: <stable+bounces-215699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DLcsHru7i2k6aAAAu9opvQ
	(envelope-from <stable+bounces-215699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 00:14:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E9B11FE4A
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 00:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC9F3300A248
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 23:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23DF314D03;
	Tue, 10 Feb 2026 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3jtm16p"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B3314B6F
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770765236; cv=none; b=BKR0OLnC/aUJxJgTpoLQNufqcIi6svm23bwaKTj9exhuw6vC9pbiVW1a8ulOqWGyWjxY9XEdl2z0PWk8HfYVxORB1YmtLJpMjs/maKL59b38K+HLjF3mgPmpSanRyxSGhpg/fYIDYYy42MN5km+a1J0xnnLJpbtxReYVY3ukTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770765236; c=relaxed/simple;
	bh=qMqaPEKoWyjXmYfAH/4rFVHq2BLU9FWeOfW6jUzTfto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HY6yuUHY9Tk8XFOcRyF8LpU5yK8/OsHtFl8pCHHLloGLcCZeGCquoMEiHe10oLUSZLtQmWN0tR6NavCn+JdCo2v0Reb6ptAv5rPs8vUSLynDN9VQoF7gpM7U3bSp2mdHU/VBiftgudF62FfKKXLljfmZoi2Zqtau7eTyKxJpgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3jtm16p; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43284ed32a0so4205493f8f.3
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 15:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770765234; x=1771370034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6bD4A8iLkPT86OVNtKue5n8u7ZlVzU2MVeKWEyFIN18=;
        b=J3jtm16pugWt+krb61JLBFjfYJZDTVqfPSyBoOEWtWTKMN78KAb628+5T0pe5RgN4J
         Y9LmkeYMtQrWW8tJlAVDbrlKgF1QtVMahKruvugR8TrO8rkcGoLIxHD0yNxDa+4pDlLH
         +voU/Psy9hh5uSU+cVDZh04Bim0SmtUhybz7KOcqSVxyN+0YgfEmIaLmaxPMnrdXNfnR
         EQdD5dPqss2H+3gC684Yn8r3N6RDaP157DP4i7blRt66CAgzhaRJQE9XVbBK2X5eGj2t
         urKLvysB0mnjpDxTrqm181sCO/6Jmp3NCx+nNLhTVRNc1Q1BJuMRi619O84Z0D3niWef
         R4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770765234; x=1771370034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bD4A8iLkPT86OVNtKue5n8u7ZlVzU2MVeKWEyFIN18=;
        b=UItwor6XFXcCH9vAuj5wZZ2Cn5zBNvdcg56mCl3fV9QB+a7EPz5gVy+r6dw4p9U0s/
         jG45DzXw9mxpHFL9cVlwT3rfFNzJc4OfvUrXZguod2Bq9lhoqMRZkeKvZEJdrjsA7/YH
         Midu0tnIZ+D9jFMuaMP7+LONB5wSikBDm7lRilGvUqtosoJarV7JxyhNqw810GEU0VAv
         in/DXTkbuEBfoHsNDg0Qt3yDrcTIqk3tMOn+ALseC4o0FOkoyN1CNSz5Iq6AIMzIjj6v
         4GdO+k0usWIDFq/eHJUtuI5mEJDnl8XJI8YUKuEFglCdl8N202hfw5Fjr8lszYeXZ7Hu
         fg3A==
X-Forwarded-Encrypted: i=1; AJvYcCXyxRICPzmB52dmdm8aG1qLmxIU5Df+Vi7EpvoOi3OiF6hE9/ity3Nn9S9XEXAilkSD3hDJCfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+5AL7UQxBOMD7zgDJSt3Z6TszeNA6Z+uMjA770wxRVUC4Xbo
	qY7oIyRb/gUeL04XkdBkhgO711OBeNUcPn2ZAtF+nYy4DKdyyX6S5C4I
X-Gm-Gg: AZuq6aJ+wfYYvqqtRBulaShrl44oJ2Y28AHkcw77ON/979fhGirWkaFxXj/WMQp94BV
	c4TMQxUNa2GcMJlz3NtsOjR9RZBxhfCqGfLFGIs1BzJpmJCeGTNMoVBO71q+bIYcIZaSJIweE5m
	vOABPrgWtOPDR8l4rWFbP+dR14DejEvkMN9Y7iMcxUciyCK8ywVjYC2MVtLWOvwxiYyIuHYflju
	CYkQAzcdVPiR4d8Io9WxDs24cITmH4HPUhBhmSQCTfTF4OiqQU3C8ac49MCjAqz2pNb1scAQr6u
	5/p3GNHam1Yn/DwqvUyJ5dsVChIeN9HcGVsDSrBduP2N8EB3NqZ/laj6M+9wK60Sxi201IicGee
	sA8tGq0Di5bAwMRI9dcWR/avC193b/7LxHgqiZFiMdaXfwyD+A8GaFcvNcOWmcPkoHPn9V1jdcS
	F7hWtEE7SzWyKm41nUX4Hnc5AlqJNxDmmnQSuS/uiZqydFqn/4yxLJGxHVFp/Ejre9y/I1yxisY
	mi0d8cz
X-Received: by 2002:a05:6000:230c:b0:435:9d70:f2a2 with SMTP id ffacd0b85a97d-4378455b876mr12695f8f.25.1770765233786;
        Tue, 10 Feb 2026 15:13:53 -0800 (PST)
Received: from lewis-s360.localdomain (static-193-237-220-23.vodafonexdsl.co.uk. [193.237.220.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e39c6asm262034f8f.28.2026.02.10.15.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 15:13:52 -0800 (PST)
From: Lewis Mason <mason8110@gmail.com>
X-Google-Original-From: Lewis Mason <lewis@ocuru.co.uk>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	stable@vger.kernel.org,
	Lewis Mason <lewis@ocuru.co.uk>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book3 Pro 360 (NP965QFG)
Date: Tue, 10 Feb 2026 23:13:37 +0000
Message-ID: <20260210231337.7265-1-lewis@ocuru.co.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-215699-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mason8110@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ocuru.co.uk:mid,ocuru.co.uk:email]
X-Rspamd-Queue-Id: 91E9B11FE4A
X-Rspamd-Action: no action

The Samsung Galaxy Book3 Pro 360 NP965QFG (subsystem ID 0x144d:0xc1cb)
uses the same Realtek ALC298 codec and amplifier configuration as the
NP960QFG (0x144d:0xc1ca). Apply the same ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS
fixup to enable the internal speakers.

Cc: stable@vger.kernel.org
Signed-off-by: Lewis Mason <lewis@ocuru.co.uk>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 80f0be13b..1a98ad9b1 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7318,6 +7318,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc872, "Samsung Galaxy Book2 Pro (NP950XEE)", ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc886, "Samsung Galaxy Book3 Pro (NP964XFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1ca, "Samsung Galaxy Book3 Pro 360 (NP960QFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
+	SND_PCI_QUIRK(0x144d, 0xc1cb, "Samsung Galaxy Book3 Pro 360 (NP965QFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1cc, "Samsung Galaxy Book3 Ultra (NT960XFH)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
-- 
2.43.0


