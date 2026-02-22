Return-Path: <stable+bounces-217664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDL5H+/1mmmnoQMAu9opvQ
	(envelope-from <stable+bounces-217664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 13:26:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1237E16F08C
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 13:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1827300D9FD
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667A414F9FB;
	Sun, 22 Feb 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMdVTT0L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65723D288
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771763177; cv=none; b=TnabKyKYjjSYtYVjPyvJXPPkRG/aSKCzoULc6Xs3vh8ZC4b9WOuq1naBxHYpLe0BaOhVSuZTfwRTxNFwB7rqQ6buR2wEczN93L0Tits6WrUmDQFpGb0FDtl+xU7OlNTx+mTCFkGkqLhMAUDuXOblHTAp17uOBUb8GM2ip0leRfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771763177; c=relaxed/simple;
	bh=r8qtfrRZ+a9tDUEL52UyAQXfb+IQdTBvTcDT180+jDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVI5WUlzJlAqtoiRrSvTOX2C3SCUz4QqPiAaccyrQwVrOxDx3Te+N7zZNi/GroMKjwv11B34RJxoRy8kxd1uKVggigZInYGhLideSQP2h/Tu+tW0kIv/j3qO2fkzy2X9fFuFR0NryuTeW0cjZ510eKOeBqmnsy2h1aksvfdVan4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMdVTT0L; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8217f2ad01eso3513228b3a.2
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 04:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771763175; x=1772367975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7Yy+PNSGZ+0k2NhhJxCl7Lu7PtCSNFAVWFUv+fEbH8=;
        b=DMdVTT0LP05G7XVeZuvKCbycOC0vInnXnsNHeV8mLsTdsrEcqugAccDDKaY6wHvXl6
         wcjWsmLvrdvuSOfvm3zQHEfadDBOtNf62GrgLlfRwqLloDgOQVPOxrvXtPt3oT+SEy2N
         7q6mP9GiuxneZIZdM2No+PzknuT9oOqdVpz5VE6BVymsjFliu8Gks2LpFAXUU8hsCz0E
         CNgZVkqRLvPQHriTLcnVJ4l2779xSM8/k8rjJV2RUHJWIKPLSVbYFvLu6rrl6C2UJ7ms
         t1YOUEjk2OHhHLilpZYshccR0JKH6e0X1AjxW2g92UzZb74Yj2qiik7+mKrJIEXebqDQ
         sVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771763175; x=1772367975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7Yy+PNSGZ+0k2NhhJxCl7Lu7PtCSNFAVWFUv+fEbH8=;
        b=dSDnAmwkfDO/QkRzCJNV0hBCJGQiC879DDnmTPIf9TZiNAooz7CdjeTcOu1C9xsfFd
         pDR3wlhtYeSBwgrq0BOLtjfExmG88TLyuk1rhrzbLk1nNNE+A/NAIVizJErSyISJcY58
         RM3QIvkL/3FqEKXFk2bsTjLADit96wosU776mGwxUAat7/ovtGA4R2jrsEwfAPNvxZIg
         ekiGMOoR1dZqZWyl8L4jvkFOO7Z+SbQ68YeEgyxV0OgliE257YbOh/L6fCUtS3ydTDXp
         ycaGz6rdWXjP4UBzJ207tHJelwmWk1CClIYxYee7fnwV8F58bwQY1Vv03EC8Ntrd9cbw
         DKiw==
X-Forwarded-Encrypted: i=1; AJvYcCWBymaAbggZJUDi215T0tvCp1G3DXf3khLTYQCEPPp0qBZLK171jwIHrybbLyv6foBc0YZ9Bek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFyeYqkm5q4qKQGHQYTsYvIC0dNUlsbXKc0arWofjyO7e56FBE
	XEdHEJ2txJrWVETFlzr/2BGnE6Vm9Zvy+3y+Rt3wDTRVQeozgiOat3I5
X-Gm-Gg: AZuq6aK//Sx+3IC/aPqq/U2K1WNhaydmtXHNi5QdW1FEl3wavgEZrxdqzGRv4qH3/Nl
	mW4Vp+KRJCauEanGU02FAs/9itbhKrZofF28yR5ttyuajWAwFCjPY8xAcbORoAfQ0L2fkbfZjM0
	BuldVdFu8pdUoSPt14d9wcooPzlXp4f8C6n02atDQot3u/LFz70N/+zYsCa0UJvdIPDiX+gXYEy
	oBPZSXRjVfnLiqynaCUz5FEUklYtry2aM4q55gFs48oQPoZ2ziIG2EnhgH7V6lrKAPIE04lfGUO
	yMf+EIItCiJ5d5EQEOm5EA9Q3awhXzra4AItch/D4nJm2sl3yHaGvsO8mIoAMnCW8ZD7FJzSV/S
	qsF0Q0EYw4vbBaaKvMixP8wuqUZPCXl4WOk2q8wRMbhBh+G9EjGKediccDVu0Ye6lsf+R3BQptg
	7RPBk+xSx8VD3AgUEgqw5DoHZ8U/Ws1L5yI8wjONZaprafVkAjDWYJRGKN
X-Received: by 2002:a05:6a20:748b:b0:36a:dbc6:2572 with SMTP id adf61e73a8af0-39545eba4d3mr4701634637.18.1771763175425;
        Sun, 22 Feb 2026 04:26:15 -0800 (PST)
Received: from arter97-x1 ([58.124.177.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7180613sm4408021a12.3.2026.02.22.04.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 04:26:14 -0800 (PST)
From: Juhyung Park <qkrwngud825@gmail.com>
To: linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>
Cc: Juhyung Park <qkrwngud825@gmail.com>
Subject: [PATCH 2/2] ALSA: hda/realtek: add quirk for Samsung Galaxy Book Flex (NT950QCT-A38A)
Date: Sun, 22 Feb 2026 21:26:09 +0900
Message-ID: <20260222122609.281191-2-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222122609.281191-1-qkrwngud825@gmail.com>
References: <20260222122609.281191-1-qkrwngud825@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217664-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qkrwngud825@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1237E16F08C
X-Rspamd-Action: no action

Similar to other Samsung laptops, NT950QCT also requires the
ALC298_FIXUP_SAMSUNG_AMP quirk applied.

Cc: <stable@vger.kernel.org>
Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 421a84b9fb44..22b182fd6129 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7311,6 +7311,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_AMP),
+	SND_PCI_QUIRK(0x144d, 0xc188, "Samsung Galaxy Book Flex (NT950QCT-A38A)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Book Flex (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc18a, "Samsung Galaxy Book Ion (NP930XCJ-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc1a3, "Samsung Galaxy Book Pro (NP935XDB-KC1SE)", ALC298_FIXUP_SAMSUNG_AMP),
-- 
2.53.0


