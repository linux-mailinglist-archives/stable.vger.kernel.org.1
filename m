Return-Path: <stable+bounces-262289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q3mkJfwcKGrQ+AIAu9opvQ
	(envelope-from <stable+bounces-262289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 16:02:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C3660D17
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 16:02:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=clFDpMqG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262289-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262289-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0378F303FA22
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08013FFAD7;
	Tue,  9 Jun 2026 13:56:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BDE423175
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 13:56:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013411; cv=none; b=eqzx5HNVfOSymNQ3oL1uR5eQhSwqN9YhYf7JK25ivzcxvWXESD0E0Col8iD43bzB1I1aZDiNNXKIC6JP7vcGb4U3k/J2QzZiZ7uFWAoUMW2RqpFaarbOip9V+iRJtPvpC8ASr1cZLHasCtJEi3gvRgSLDsbYEB1R3qjnp5frt+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013411; c=relaxed/simple;
	bh=2c0HdTPmfgiYx0VZ9832KtelLqJIiFgIFRLUB2fSiY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OstU1plCahmv65oIvGxbuqu/1mrj814JirI8FJdQchh2/PWCKnvfWoBzO8JSpYWRUY1wlC/I+2loZSz3tcSFlPU63ug9r82rJp9oN3iCSn6m2ssSqdjhwVX4PJn75ltlJjhHXaAa+bxGdsVrtw0I4BNFXX/jlllxhn/YgHDtM6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clFDpMqG; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bec449cf976so773736466b.2
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781013409; x=1781618209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsGS2lh6BXhGcxqJg2vWNAdOVLmYnmyYBZj/jZXEY/E=;
        b=clFDpMqGt9l9Q6HOE7NkUjkMkfp8LgeB6EnFze6EQVu9SFzX7sHAhII0+F4AtUPoGb
         tOO9GcAlyocoiGoGcGRK23GoeS1ECzjoAY70zcsKI21FqTA98HXaqrLx5xvJzxlpm/lj
         xHCjowzktcotAzv+nE67vXN4Tkrm0S9VUgHP5o4PweWpkNS2NEnA4eXY74VHgw1YNOor
         D3DhHtwRurP4WsIZPNFxtvLoulHoEJ5X31A4dpRwFMnpTKFC7tmKBHYXDoL+bOYj2u9I
         JR1MGgQ6V3bmws6aEMi6cl/ZMkhirdC0O2HDIONA/uMwUui3tPGIiyaowyt1U8iby9Jn
         titg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013409; x=1781618209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VsGS2lh6BXhGcxqJg2vWNAdOVLmYnmyYBZj/jZXEY/E=;
        b=e5JqX8nNuKOoGaPC23qPiOA/BhcdfHKKYnsO4ZSA8tkHrF1bINIw7seBJWDbQukOuN
         GC5qS61zXQUfKY6H2fo9EGXi3wjxegwLgZjxZ/vBZvEdNrdAY9AMf0chBi7+tEIo8P/c
         ayoI3otOhKi+6I+ZNQcy0B1WomN7kd4+vXviqdbaNofdT1VEUi+km5MIsWZ9KyFNTm8h
         wRpvRN8Imvwr0myG2FlTuq3YqfFQrD3mGT4/CkyWa9s7EdI6t2xNEX5/IRG2CDGTaOAz
         iGwmJXP5t3HiBCPqtML9q+LQuyw62Ukg/JGQD5zNi1vE+e7qUFK6RdNV2LtlwpsEMjMA
         zKew==
X-Forwarded-Encrypted: i=1; AFNElJ9S0ORYKwklFPyquNN2XkSqFBf3rwfr3qmozmUnVkzwX/S4YlctXBWcJnMEi1+j1VFp1qaa9n0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyot+Koe4FePKQXm0KM+AasVALaQ1eeHFYs046TGTDoIBNuvOSu
	d2Mj24gYW4XOtlRryTSHzAcKlQgoZ9BHJ1cyFmDVidj3rdRZFIqL99xo
X-Gm-Gg: Acq92OERYjGkE7sU/LRjapH1emBF9HIZXeQ1P7arKCGbJFOs8tsPAgtdGAKyQku6XXn
	F8h6eqPc1sthY4sVP9kHsB2WBkMV0d2Kt46s/Dnug82UlzjZbNzhBbckVzON2stXJzCO2Ex/JCd
	buoRkwowRordU3pjqy1FRrJ7Xjm7WsXbqxhHSiIiQS851mH1fKsEpgit5qoyz1Ro7bFwvHwp5ar
	QF/m21UiQcVjZ3sRkP2Pq8Wrv7Xsdo+imAx6oofcnp9SJ76nEu4fhXZzfbyNhBF9M8pYWJPt/7S
	WTrc2jMSiXE6c2XxTMexgCNszFq5VMUy5hXDgeyiqS1EvOlyovrQ2HCy1d3r/8fzYyROT9nAxzw
	hmeUfu01J95ysKRFocHCwkn1KIBDQyj4dmDklAXUJu8zvCkc9BxE/Wy9nLeadSZ9BuwKreBFAlJ
	MlzgzgFLMrT4TbLkixchEwEL+zbCcxVG28Y+xlt+3ljqKhSAGWIe7B54zYSmy/PH7eqM3GvHfyf
	FZ67Q==
X-Received: by 2002:a17:907:da3:b0:bf1:6366:f8c4 with SMTP id a640c23a62f3a-bf370a629admr1009745566b.15.1781013408573;
        Tue, 09 Jun 2026 06:56:48 -0700 (PDT)
Received: from macbook (polaris.rmrf.org. [70.34.242.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf052097992sm1082867466b.26.2026.06.09.06.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:56:48 -0700 (PDT)
From: Denis Batishchev <ii343hbka@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	ii343hbka@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a
Date: Tue,  9 Jun 2026 15:56:07 +0200
Message-ID: <20260609135607.3960625-1-ii343hbka@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604131518.45993-1-ii343hbka@gmail.com>
References: <20260604131518.45993-1-ii343hbka@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tiwai@suse.com,m:perex@perex.cz,m:ii343hbka@gmail.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262289-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ii343hbka@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ii343hbka@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E88C3660D17

The HP EliteBook 6 G1a (SSID 103c:8e0d) uses a Realtek ALC236 codec.
Without a quirk no fixup is selected and the mic-mute LED stays off.
It needs the same ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk as the
already-supported 14" variant (SSID 103c:8dfb), so add it.

Signed-off-by: Denis Batishchev <ii343hbka@gmail.com>
Cc: <stable@vger.kernel.org>
---
v2: reword commit message as was required by Takashi Iwai

 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 78a865709635..8eebf91595d3 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7274,6 +7274,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8df1, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8df7, "HP Z66 G6", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfd, "HP EliteBook 6 G1a 16", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.53.0


