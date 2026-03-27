Return-Path: <stable+bounces-230648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBYnBhlzxmkCKgUAu9opvQ
	(envelope-from <stable+bounces-230648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:07:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE1B343F65
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F87304CCE6
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA943914E3;
	Fri, 27 Mar 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ9ABmnv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004EC382F33
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613028; cv=none; b=YzkQHrExiEVv7pXgp3n3m6YzstbbzZmcTvhBkawZCKsmZDFRJm2/GSzU1kPp7JPGvU5r68fvSpADStFIavHQkMWDKRKJH/Y8RBEX7t53WHbdS3v1/NVlMv8jknFccMHHWWc+gZiCIBCARNYC70iALsihoJ5XVFRriSc036TD1VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613028; c=relaxed/simple;
	bh=CkHDELe4J50i8dXIKMiT+Z+kOVrRvo46dLALSgDFRVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyaN2jbdfwgvxqVL1c8eenEO8GrrW+vHIycnHxM+l/a2OGZ9qZbuRAgt7CFA5N+ahPggNsCMnVPP6JOdSVMGliqXZmZcvYi+4FkfzZHe4lOK1UvzcnTFubk4MsYscWRH2BhnGaFCYKDx7TxXzVe1rss3aZTZmWyfuTynZAQitZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ9ABmnv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2adbfab4501so9948935ad.2
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774613026; x=1775217826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mHVhf8Q6uq8fezIA7XyRNQMSU52ljWmuoh597f5xe8=;
        b=IJ9ABmnv8ZQrcgzScItvRa3FVd4DyBa33ruXy9LlTuXs7rMkfSx5FFITEFF4/8cufQ
         mze//TUm00tadzUGkbno/3mkgOlBMMML4ULcP7psAwqVO47HBG8AvMveJlNemI7dr8oa
         dlt097E52eM5T/+oDCkzKdJdHXpBYGjgl5JgqJxyzyg5dj89RQeSgHHhjBkUfREYjXfs
         xvkaX/XgpqrezwWGs6q0GnhXWlEhcmO1fJNmDnY2qEvvTDZRjzZh8c7TxBaoEaBG4wNk
         Eq5feXsDl6hK1O5Ff6vapkHghV87pYVWy9vWcgMW+R9KbUw++1g5TLcPnnqWstBhp9bQ
         TAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774613026; x=1775217826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mHVhf8Q6uq8fezIA7XyRNQMSU52ljWmuoh597f5xe8=;
        b=gNVmcX0iwX50uUBsiBAPb92LbCTCvB5CaJVHZ2j7fPXxchcdrOJRoPbKmf1D9lrhvU
         Z+WPn2SBjk5BLgV83mkKtlA6CtBj2SkCDtEKEcNYYKa0QSRBlfPZrGDp5qVitZmbNheR
         PqVLHc2qheSitGVl46j2gJv9zTMzuG5v3r7OgAQOBNwKNrFTDn42uzokXVpMRpn9Qbjn
         Asuxa1ATGnP9egAGZolKENDB0iEMFv2hVRry3MQdv4ovx8PhFk6Dr7id1ZmnDLmXtQ8k
         hfSIIIHI5GNFYCNHu8xSeji4cAizhxn7KftBXvrrV8viBZdzqClwPwervRYBECfeO5AA
         i4kw==
X-Forwarded-Encrypted: i=1; AJvYcCWRLhdokMH672nGTEO4XdUuIGcoqon7CMamDdVwLByx9GtdoVT1R375mtqis2o02BoG0rZjtY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZT8SDBYa8lMQ737A9GI4m1j9xncCL9dE9JNELI+x32Y9vu1Ey
	v138s7Lygo1as0sUcz0JeyP5fULF8t5OVVkwyQwpgEPuhB08Byhcn3LEs0pSIA==
X-Gm-Gg: ATEYQzwQLodT1rXBG6eqEVpPUHhXXLMmbAQjncNrRGI16CZNCIM7nW99kphnCRh76Fp
	aRm4TZNlWIGZpwjH2GDy87RAe6aEXLrUnswtiosqbPGLRgGDtPB0mPn7jimQoNvOR5uLUsaSaxa
	LgF4DApnqhJHrUjOgL/n7hVd/nnIsxTyzOOQojrLSEClJop0aDzvnKmCAy0mnvTHbWdIzFAlGJ0
	xB+WMZU7oo2J+Ne8HNabiGqVWXkIl2mteE4z1EgRrHylEDwLkd9ihL1VeGa/REzHpCqaOb47dwU
	mkQ/ry95emJXbkMqo8yeRbBco7ECU9tdZP2rmSKek4Pxo50PYosAnX2M27t9QTdtMVV26VXYVoi
	M6W4xhVhYdOS6DahRi/QCG31i/d354nyHcDitlr2vzhoZ7me4EJqGWxQxOWIOMW+JUiwHQ1lC1e
	9FX8iyizZVQgm6lzyl37OwIL8q/h1bicTN5fBBcnnYpYQ=
X-Received: by 2002:a17:903:988:b0:2ae:4445:f39a with SMTP id d9443c01a7336-2b0cdbf7367mr23642195ad.7.1774613026220;
        Fri, 27 Mar 2026 05:03:46 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e2:15f:f2b5:1d1:fbe1:fe33:137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8f3b98sm55003615ad.70.2026.03.27.05.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 05:03:45 -0700 (PDT)
From: Sourav Nayak <nonameblank007@gmail.com>
To: tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	nonameblank007@gmail.com,
	stable@vger.kernel.org,
	tiwai@suse.com
Subject: [PATCH 1/1] ALSA: hda/realtek: add quirk for HP Victus 15-fb0xxx
Date: Fri, 27 Mar 2026 17:31:49 +0530
Message-ID: <20260327120149.18076-1-nonameblank007@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <877bqxsin3.wl-tiwai@suse.de>
References: <877bqxsin3.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230648-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,suse.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[nonameblank007@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FE1B343F65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: NonameBlank007 <nonameblank007@gmail.com>

This adds a mute led quirck for HP Victus 15-fb0xxx (103c:8a3d) model

- As it used 0x8(full bright)/0x7f(little dim) for mute led on and other values as 0ff (0x0, 0x4, ...)

- So, use ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT insted for safer approach

Cc: <stable@vger.kernel.org>
Signed-off-by: Sourav Nayak <nonameblank007@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index ab4b22fcb..7f3e88999 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6954,6 +6954,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a34, "HP Pavilion x360 2-in-1 Laptop 14-ek0xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8a3d, "HP Victus 15-fb0xxx (MB 8A3D)", ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a4f, "HP Victus 15-fa0xxx (MB 8A4F)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a6e, "HP EDNA 360", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x103c, 0x8a74, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.53.0


