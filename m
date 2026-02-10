Return-Path: <stable+bounces-215698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFSHM3i7i2kZaAAAu9opvQ
	(envelope-from <stable+bounces-215698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 00:12:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487411FE40
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 00:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7686B300B51C
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 23:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147EA314B93;
	Tue, 10 Feb 2026 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQWblAzf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B01314B6F
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770765169; cv=none; b=bCDdYKT7WjdKOOCPKvyj+OShLCgNrQBMqCtTWsDovHBwl1QUsGUWM17NUdvtikfjVoqJ/CaA+WpjbCbyD2sU6gmoS+M6jJJ6iGS/0Gnpm8iieuAB0IpE0ewhvgI/RdygaAHjVWz+7RdVce/iC3nY0RdVVIyAWWBVJ+GZGCid3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770765169; c=relaxed/simple;
	bh=qMqaPEKoWyjXmYfAH/4rFVHq2BLU9FWeOfW6jUzTfto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNemibBoyW5WoSgyNFPUn6np15yed2IIMUa6Srl00PUQV1Tch0xnipFjwJLwiQ5Fh4JNZLXv2CqFCZS1J+M6DOBsfikgoGqtY8xHyiWQPju+C+SN3X+pleERpUG3/24583JHY1fNl+tY/keyE1Ew606GnfxMAAXpfO8xu5gu9lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQWblAzf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43591b55727so4140560f8f.3
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 15:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770765167; x=1771369967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6bD4A8iLkPT86OVNtKue5n8u7ZlVzU2MVeKWEyFIN18=;
        b=DQWblAzfJwbr0GaveISGvAhInzA0uijBtFvYPDI9kDCST+Otht9LGJi+fEqaooVTCW
         yolMB9+V/rKyffdg5tTy06Om2VjbiLmwVnIBXZ6Ir6HY2YebnPAwWkwl3ZPqaWtTT94E
         qakKA1nddNcUasnXQ+PrxUlxHCHj4V1ZXLwo5hukNF2Z5etv6gGmYxg1h1k8g03mCrJq
         Co3/b1OO1SUgPGS7P6vKw1V2JcJQt9RZVuN0X3/vDgLKjL/ZH2tTucbNfj7uCwsCsdHt
         N0IuJRKRPH//iI1pZ57/NIvl8uinGT+znYhCsye8JWokhC3GQOjrvQ6CP8eM0rtiqTZe
         tWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770765167; x=1771369967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bD4A8iLkPT86OVNtKue5n8u7ZlVzU2MVeKWEyFIN18=;
        b=sXcTXy4e/BJ69khdORKro+WqHKPtxRzys9KIx0PZMgvUmPlMMBM8ipxhuF4arNMsCZ
         mo6Znp6ZirNvAR1Gjdx5XYD6b8kG5c4szLoisV5cg3DAj3agqAlBAoeX4Q5FUGxCvSIb
         cH2A7n2DTUi8oqh8HdN512IMB0oleMAN0BKQsrcfjLLsOp+R6m3HlPxPXRzQ9xwq/BUD
         8CzWlPixaDu2TbAI0+cOy7VFizg8nkECUMFiIMgTzjT8PzS1qxtvVtGwWesBjgxTzV9O
         MJ7O6FBgqzf/kjH7b+q6/xpET3JtFYcX8IPLQCGos20Olb4lRsiv0INExGE0DJ4HlJI7
         yvfA==
X-Gm-Message-State: AOJu0YyQwstklj5U9NGvCPnk4vBGah6DMG5Wa/oy0+mHsRJF8AGUXNt2
	uK4wyfBTfqr8O4CRGaj34ZUgtSz+GkVjYmeZtFX9Pz2GATUzrmHHUyllFYFdvpRgdNM=
X-Gm-Gg: AZuq6aIYXEpa94xNFTnKA1EVWdyHQ1qFdP5ZuBdryRXcPvxu+apGShRhsV4DkSuQZRj
	X2rAQn+2hi5kcx7l1KdLI0fUkIiGeNe5IcZ/wGuYf4/ig3XZ/fzIyc4Gy/yFFn5Y9++DzMSTSDB
	oqI28q4maBj/F5iFDyPQheksg9+7S7/9yIxhscVvup1t67/U2msDqWR3xebY8xVwjqg8WurQcL3
	XRA4oqhIil9/U0vCS69cFhl/KxfNB99SR6pRI5FBwQFVdJ61vFQ+rNHICRPTU7i1X6ja1VFds+C
	U1K4x+lDSrqAcb3dsW7Tj2zerMFeugg9APDE9shyxDlLzTqa2ymgHhGcCtjLE90hmUYhAiFrFKx
	c6N+qMTFC3r786yz4j3V+VGu7CBTE8UysQxVKQic9PCgjh3rjMURaqbwkC7sjyH/9sVxtrmQC0n
	+6AkzfId0JDG0+DdkZGqNLu2Hv2hqm7HD5e5YGUIv32h6fqPxbkP3MY5n6UGf3SCy2HK8kY5DF7
	GUwe/b9ZWEtmVqhdGk=
X-Received: by 2002:a05:6000:2008:b0:436:3563:49a2 with SMTP id ffacd0b85a97d-43782c9c020mr972193f8f.37.1770765166781;
        Tue, 10 Feb 2026 15:12:46 -0800 (PST)
Received: from lewis-s360.localdomain (static-193-237-220-23.vodafonexdsl.co.uk. [193.237.220.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc2b0sm307434f8f.21.2026.02.10.15.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 15:12:46 -0800 (PST)
From: Lewis Mason <mason8110@gmail.com>
X-Google-Original-From: Lewis Mason <lewis@ocuru.co.uk>
To: lewis@ocuru.co.uk
Cc: stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book3 Pro 360 (NP965QFG)
Date: Tue, 10 Feb 2026 23:12:24 +0000
Message-ID: <20260210231224.7233-1-lewis@ocuru.co.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215698-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mason8110@gmail.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ocuru.co.uk:mid,ocuru.co.uk:email]
X-Rspamd-Queue-Id: 0487411FE40
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


