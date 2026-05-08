Return-Path: <stable+bounces-244844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HFyLRBq/mmIqQAAu9opvQ
	(envelope-from <stable+bounces-244844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 00:56:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD614FC88A
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 00:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D69CF3053DDD
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 22:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C23A3E88;
	Fri,  8 May 2026 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzTOJtdf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8374139D6CF
	for <stable@vger.kernel.org>; Fri,  8 May 2026 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280916; cv=none; b=H2zz3xNU0Jf+fZ7Ndtxe4e1lgUmAmU4pvF971FslRwxUJyhFnut6aRRB3HdGu9p27PygvY2EzKndhh3LmQs1NWbGnGpAUQkvv6+xRJWP+yZg2RyQjvpSAyqsSGu19z3xSJLsSYQDhgTgUYykwCZTFJWigkOwL302t/z26f/eV90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280916; c=relaxed/simple;
	bh=QSX7YN2Kkqt0mJt8UgVJ6i9GbnwZDdxdNDd4zHflDnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=je+d9Vv36tH1bhmEogB5Jxwmkme78CmMzLnq/evBGpAWFB7bmzqmrUsGGfEO+7em/womf56f5RO0gjpol/egj7TQCC7PgPbE+enHbq1I0nyV3D8br1rSmTut7gQrScOkhE+zwpaJ0OLAGwt9pf0OBiaXs7ytvKiS1Z6PBPyJtyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzTOJtdf; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8dbbc6c16b2so337449885a.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778280914; x=1778885714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtE+YuXWqKSidY4VGGV6JauwPm/5vzq7+5m3m3uoYkQ=;
        b=kzTOJtdfvfqHvy60iKa1A12p74a8OEsPBEgXlM8KdhaRikkZgaf5IHbPCXS8XIhr0m
         O4DDQVs4/RwvZfdtIoGzcREUO4CuR8Ky8o8I2eJpkTXf4KZcbZvwjZsF8SOl48DQpLPx
         AfnZEiBuLMPkCMn4aXXc72v4w4bd2Ll0xn0LYcf7RiQuxWMSqHi+1M3bMUO/U4VqSgQp
         wUXnvZEZ1Pl3tJ8sSkWILdtrAKe4BqW2HKifk/jNsKs6qz+L0BSpkLUCRZ6SARFung1J
         5x/zmfY2lwh8bmFjIQnvE5efUDE5fdec+21LZxE2tFMqnUmfpk1m5Z55/Aelw+Ecw9km
         cfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778280914; x=1778885714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtE+YuXWqKSidY4VGGV6JauwPm/5vzq7+5m3m3uoYkQ=;
        b=DoYGcmDDDw7/xwcCIsl9G+6gU28SW1eZSXzjaRoKRj2Iz10ynEiWDJHYE7CYTeqGI3
         enkbqeUr77ARoWu4N3YIna3NVkSVaOyE1s9g2geURhvbjeQz75kGQDW4A6RQuR8hvWCP
         ufy+afSM1XDPURAZAyNPVc1YKzLbAgnNcR1NH9KcWWYorT9CaDPFG9znkODfmXgiqSr+
         22bhhsoSp4JhGICOdGWkRqJN/vE6XEYtEYmsh/Nhge2Z6QRorMdOnspqS4hzGb/6YQgG
         ieQ3H8+21YXb4htaN2//hdyLWH+WvKnMZJJEXHqKW47qzZQ7p4BSWAg4ftkKAYtip+/I
         CJXg==
X-Forwarded-Encrypted: i=1; AFNElJ+dXULrHK2rqChjRxA7XwHDg8sab3n1CUWmeip2XNIx+fowCsOXBwMbeonAOZL7pRN5bIvaM5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLfMd6OdnSc1Lu0GCDiGbZO89ifOMOMa1BrxAfgqJXWqdmrF2
	/+T4eGr9FeTIOJ63jldRFCExtk+/pogxnem2Hb/5q55xKYx8moHcxjUz
X-Gm-Gg: AeBDievCJHE+mW0A2gIvFQkchf2cQOeB/whXFHR6EwHjOB6uYL3NV9pE3y47RI1jmdd
	mBIlAcLHngwLttm3v7O7cMe81tBkd91KCj6pAnZkdBd8L2I+Ee4PRA6LW0jeI9J7oi4Sedztk5V
	WNRBSrO3qleB8KBUfV6Ye0mOc5Zv0OFstx7u8l54DRCPp/6avYHOWtSTa3X2+FOoNFARlhq9dlW
	YcYf9/P6+Sk4EozIBjbPR6atBe+c7KUlJJ0Du0queJwmWsYEyCYwB6eNqPPgumAaylPC5tjJWXV
	jfJuRCojXVOpKi7KlZoyupKTQjxEjyQA1DejhxPR5obHiwn5ywhUb5UZSo8HRNA8r2a/7F3j+Hw
	Y3zld53Hvqs7BhftEQ0sg1EpogmMrebDNCIVGumpH9wuxEtvlHAZCZWTN1Oa6Wqilj21F7L2eiV
	H+NWku4RnfuF3gDSEqhONwwVnxOi4xZrZJeFdOAkhBKDbTaja6/3xq7SnQvSDo3T5lx9yjogje2
	8+ayh+M4ZsJt4ot/0Rcr9Wx4dB9
X-Received: by 2002:a05:620a:472c:b0:8ca:3715:eea5 with SMTP id af79cd13be357-9065091a471mr1294812185a.14.1778280914383;
        Fri, 08 May 2026 15:55:14 -0700 (PDT)
Received: from nick-lenovolegion-16ithg6.tailf3aaf.ts.net (dyn-pppoe-142-51-228-191.vianet.ca. [142.51.228.191])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8bae450sm332652985a.21.2026.05.08.15.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 15:55:13 -0700 (PDT)
From: Nicholas Bonello <hadobedo@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicholas Bonello <hadobedo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix Legion 7 16ITHG6 speaker amp binding
Date: Fri,  8 May 2026 18:55:07 -0400
Message-ID: <20260508225507.47667-1-hadobedo@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2FD614FC88A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244844-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hadobedo@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The Lenovo Legion 7 16ITHG6 uses codec SSID 17aa:3855, but its PCI
SSID is 17aa:3811.  The latter is now also used by the Legion S7 15IMH05
quirk, which is matched before codec SSID fallback and incorrectly
routes Legion 7 16ITHG6 machines to ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS.

That fixup does not bind the CLSA0101 CS35L41 companion amplifiers,
making the built-in speakers silent even though playback appears to be
active.

Add a codec SSID quirk for 17aa:3855 before the conflicting PCI SSID
quirk so that the Legion 7 16ITHG6 uses ALC287_FIXUP_LEGION_16ITHG6.
This restores CS35L41 firmware loading and binds both speaker
amplifiers.

Fixes: 67f4c61a73e9 ("ALSA: hda/realtek: Add quirk for Legion S7 15IMH")
Cc: stable@vger.kernel.org
Tested-by: Nicholas Bonello <hadobedo@gmail.com>
Assisted-by: Codex:GPT-5
Signed-off-by: Nicholas Bonello <hadobedo@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 11d0ea8ed859..16993f8cf978 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7675,10 +7675,11 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	HDA_CODEC_QUIRK(0x17aa, 0x3802, "DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8", ALC287_FIXUP_TAS2781_I2C),
-	/* Yoga Pro 9 16IMH9 shares PCI SSID 17aa:3811 with Legion S7 15IMH05;
-	 * use codec SSID to distinguish them
+	/* Yoga Pro 9 16IMH9 and Legion 7 16ITHG6 share PCI SSID 17aa:3811
+	 * with Legion S7 15IMH05; use codec SSID to distinguish them
 	 */
 	HDA_CODEC_QUIRK(0x17aa, 0x38d6, "Lenovo Yoga Pro 9 16IMH9", ALC287_FIXUP_TAS2781_I2C),
+	HDA_CODEC_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3811, "Legion S7 15IMH05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
-- 
2.54.0


