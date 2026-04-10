Return-Path: <stable+bounces-235566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qND0Ms2D2GmMeQgAu9opvQ
	(envelope-from <stable+bounces-235566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:59:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C3D3D2324
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 679B93035D6D
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 04:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ADE332614;
	Fri, 10 Apr 2026 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZvzEtel"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32A1330646
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 04:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775797166; cv=none; b=TyOm6o5TsCOHssVjqkXvaQjkNW4J2h5z0oSkxvkrx33F5ELS7Uwucc28fMSuFSBYdUwSA7rXCoQYJqisHypOYu6q+BOfbIkltDBPsHwhRwOEz11H7cx5o2Y2pKg7Ri07mIPn+vt1FV5+xLFwKCFosm4b4cd39WYd/bNkDoBeN/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775797166; c=relaxed/simple;
	bh=H+oGYEs5fchtX3azG4HOYAIJ+1ETOf5iY3TXTfGXYE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWUGbeaaM186uM0JPjTB21Di8Z8wAJMKKJmdjk2R/Tl2agwtq4A9M6rjYgoqbHbyYXJaT8e+LfH7HTZ2ZghUisx0mer10+y2b6mEvgKVLKWX+XcYHqroPuweQ8N4XFpyVsS9/Tl82kTAs+wMWxn4MK42KzmlkLTkrn0pnk0ZkMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZvzEtel; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b24fdac394so15425865ad.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 21:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775797164; x=1776401964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+ccZUVsgwP9j2EfpM2Pvt6St6Icoqel5xtWnUPnC3w=;
        b=FZvzEtelhytr4ZFllvCfAddtReGWJ7kkeaXF49aV9jCvgYnoPZgWiJaHNnCppJ5W2i
         FdPIzNtE2Z0pmjTO7JU4oHOHrwPUnK9p2Nujfclb5jE6YNhWhm+AnI+Jr7rCTKM5Iv16
         +gZjTTPwicrLJFQ8AzeJo70ExjPztxr5HsAFGSBbSFiWcC354GV9g7QGkEWSsV5LduPm
         Dc4LLMgCwHe6eF/WE0LEEaL54PcRduH9bJi1EubaS6csdf6ehFpF5y93lenagpKG7tFb
         NJT0/Xt+d4fdTQBmcBAjEF8YTrL6+ZhV8DE+XMn/IkegoySwRATaT5t+JFdu1/6GT1vp
         Xg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775797164; x=1776401964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4+ccZUVsgwP9j2EfpM2Pvt6St6Icoqel5xtWnUPnC3w=;
        b=K6mxCCGS1+Eb98rulc0wobSdZ4aqCRdZf2Xo7xaD+CqU64SgL+njGIb7X+vcmzrrM6
         nLpstbRxSgstJLS5jplu3XPAl6CUliGzD5Hb2nShrurzD1D8dSXuTWV8WrYzS/fUHKEu
         TgbkVImeqvLd8YdgOmsUJYXIyTjZ3CWK6y8edOLnMLDjfBm4yXmauwFE6vVbyzkl7YPS
         9t/J9GpANV3buaLoboqqPFJVnpMuOsol9lpQA5nTTkiToyGtHcq3BtGMqf6ChfkUM8Nk
         tHvXOUjB+rbOLLkaymDJbBXtL0PGqok7j6vLv0DEg7hosO8uiB/08EteMGFr/qIrbh3X
         +7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUdL9yCZqlRWb2XkQps3fa4cwTaE8D9Ar+PvLtWy90y9oQabOLAtpXgyCaFTQpAKg3m0qNf2wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmVaIXifd+pk612CX/4rbAC0SJCyNchso+H694dAJ4/Rdgk+yL
	WitwCxKECq8kQp0aEaX7DYHH6YbT45mC38+IbXtnSume8BRLfEEsV7H3
X-Gm-Gg: AeBDiesU/2Iyj7FDeLSRhF0Zt3MBjEsxcO0QyBAlE2w9oAdGCWpaKVSmPEU1L+HSILX
	U1Joxn4BG2BkGwdMqdpp6iye0g30xKIdDTgtBaqo83DskVOZ/n4xzR87xLXaId9ckG7a5k4vfrp
	LYYc/xhC3NKe5Cr0h4qaceqO/TX3ym9GTluxVdM8ti70V2Ji3amppJA9VDw/5+4X5dw84+9Iq9X
	2iYjBMdUR8PHBjV6sTv8Gz7V12DDgi6budPCnsoYe3Dw6U31qGICQn0YC7qy/p4t2ml/K6gKn55
	sPBwNkXP1HnXuR0oUVL0kqWeLvyjKZcK2qiyooWReBX+PHpq7sQAaiCsTMP9y5re359Nla0H2hx
	dpsAMAN25EZMtWt/ueTwBuGnUgKs8Za8d9OzKaFnE0xWtGztiKRoCKalsGCLKuEMvqL9c+osf9S
	32isSNIytFI2gLCiCPgRaVutYE6zpI+nDRKP23pASHBXnEWwYO4i3lGZdE2uC3so5Y7J+HT3dOf
	Mr7xO+J5ciesdMUfoVPOpitY9H13My9zw==
X-Received: by 2002:a17:902:be03:b0:2b2:71b4:a3cf with SMTP id d9443c01a7336-2b2d59d398emr13488835ad.19.1775797163940;
        Thu, 09 Apr 2026 21:59:23 -0700 (PDT)
Received: from localhost.localdomain (59-190-207-251f1.hyg2.eonet.ne.jp. [59.190.207.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f2af90sm13532835ad.64.2026.04.09.21.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 21:59:23 -0700 (PDT)
From: Berk Cem Goksel <berkcgoksel@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Berk Cem Goksel <berkcgoksel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ALSA: caiaq: fix use-after-free and double-free in setup_card()
Date: Fri, 10 Apr 2026 07:59:03 +0300
Message-Id: <20260410045904.1064020-2-berkcgoksel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410045904.1064020-1-berkcgoksel@gmail.com>
References: <20260410045904.1064020-1-berkcgoksel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-235566-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[berkcgoksel@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27C3D3D2324
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When snd_card_register() fails in setup_card(), snd_card_free() is
called on the card, but there is no return statement afterwards.
Execution falls through to snd_usb_caiaq_control_init(cdev), which
dereferences members of the just-freed card, resulting in a
use-after-free.

setup_card() is void and init_card() still returns 0 on this path,
so snd_probe() leaves the freed card pointer in the USB interface's
private data via usb_set_intfdata(). When the device is later
disconnected, snd_usb_caiaq_disconnect() calls
snd_card_free_when_closed() on that same pointer, producing a
double-free and slab corruption.

Add the missing return so a failed snd_card_register() cleanly
aborts setup without touching freed memory.

The issue is reachable by any caiaq-compatible USB device whose
descriptors cause snd_card_register() to fail. It was reproduced
with raw-gadget + dummy_hcd on 7.0.0-rc5 (arm64, KASAN).

Fixes: 523f1dce7096 ("ALSA: snd-usb-caiaq: add support for NI Audio Kontrol 1")
Cc: stable@vger.kernel.org
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>
---
 sound/usb/caiaq/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -369,6 +369,7 @@
 	if (ret < 0) {
 		dev_err(dev, "snd_card_register() returned %d\n", ret);
 		snd_card_free(cdev->chip.card);
+		return;
 	}

 	ret = snd_usb_caiaq_control_init(cdev);

