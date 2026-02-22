Return-Path: <stable+bounces-217662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCC4BdT1mmmnoQMAu9opvQ
	(envelope-from <stable+bounces-217662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 13:25:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4616F076
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 13:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13D09300D710
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 12:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941B205E25;
	Sun, 22 Feb 2026 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sq10hxL0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF81F03D2
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771763150; cv=none; b=JpXAF4rhajfsi15o6VFNY6qFX7DDYL0Z6aa6TZBRBHkCWFZTe59VS5lOYA+8g13roHzeA6kqUJ+GdVh8+0mF1BcjL+wAREevbx7MEtKnRgNKgyzbIVjHvNw5CVm8QTG9pfORsU68Qx1ivP3Tlto4Dq5LvTnVFxZQ326SHRm8Ybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771763150; c=relaxed/simple;
	bh=r8qtfrRZ+a9tDUEL52UyAQXfb+IQdTBvTcDT180+jDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+vmmE0PDYGkKMhpogRZkwQirtFwsjvLaoR4i6o3qUFqRQ467Qz1l81MIPuC8msYMu2J0+30n8TyldACAG2SnldWKst3JU1hxdu0ukP+B8sRvZk/YIh64h4NDgq5f8pu7XJy7KDmOHItRvtGshfZolhJhG06aS+GRUoyWZ7+eKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sq10hxL0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaf9191da3so22096205ad.2
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 04:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771763149; x=1772367949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7Yy+PNSGZ+0k2NhhJxCl7Lu7PtCSNFAVWFUv+fEbH8=;
        b=Sq10hxL029rW8ETRjh1bGK5ZnjKw4v2vi5clA/npl5LZONiIo6uLuXx1EFINwtcKw+
         BHjobIXBLpz7BDh0Z1q/Hoo863k3wXpqODqLmgLuASLIVq1/XT0fY8vStupUxyx9pahr
         7Le+/MdCpWki+eONoP31/KT4YphGlkalx+Hg/8UliyehTFs7FSzS+u6fyacDI/7hwdRE
         AwTFiiiReDQ/xcn2sZJ4hcQ2AwUZdNhVOMnGBih8dDBfSVQ6hzBpBBsNzPudv/H1SyLB
         JbuRaKBzQV9y3OtPOEWZLXzcdmPTNlGHsYKLn7FjQLtUtpDwZEGF9JTUz+oKZ5hNon14
         TNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771763149; x=1772367949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7Yy+PNSGZ+0k2NhhJxCl7Lu7PtCSNFAVWFUv+fEbH8=;
        b=N0U7KE92ddTiS9Fr380QRlxzLsJbvNvJ62nO/WX15czopm3lCI6ekEdbiagSm5ggbY
         m6DxKgf3IfVjNrcAmrBaUX02JPhaij/9sCK40d49vL3VgvuUwmn7o2etoxssxLYbBDDt
         75lTR2DJS3L60BJzDbwZZrMcpvyL9W5wa+nsYSFph2YES7LxewPNb1cGXgTJM3QahqGt
         4geiavG4TqvNAGiFGJqVRtA5rElf6JLHGOp4TvCgdI8C1VPntXC4DbEwJFo/xfEzjtil
         rDD6ksL8dUu5X6aDfn8lQhppVYdtuzopp/AXmwlJoNHYtHbt6KzEKZoIR8mvNPX9VWzz
         grfw==
X-Gm-Message-State: AOJu0YzRdeMiulK4tai76otm/UEbhA9dKEXsuH/pwljerpDnolfJsP4C
	rV6m32FH0qrw+vlPP0zuAzuiIoL7QCyN5C6qf+Fi4rTwsmYj1U7CEOjR1j9SvlGS/Gk=
X-Gm-Gg: AZuq6aL11hsTgYv/V3Lu3K3qmE+0mTzEROOYg1fXYeGhpbLoO2/rl7ty93O5Cm6rXFp
	soLrXYoOKeTol1RQD99FQmLH/+csqMiQnO94+LrbpqzGJoPZE2w7WHBDvGyJTC39LAoEnUM6vOA
	kIWRQUkTjV9jBQg033knSvbHZ6krDknJqEzmaH7XBLIuzYNPOOCpIE+W/oDhp8m5kOuyeMYQWSY
	vsv/59PCq/rvTcvgGM6SQd6lhs0I6Ufhw14eB7IaqtisPeh/olRBtj9666oq8LDLnEXcePNA/hq
	QOrsLgKhkbKc6RCsmQtKJrTVEleiKSh8pgi3da9U2/9BBU/yyNz5A/C5ipx/gZQlebzPLV7vroS
	7VHIZhGnS/7kYvqjaW/nzqp61wBt40WZB26reE0a/bu06OY9jgrzRts5DRbTNWNEaRE5VorlCaj
	wP14Uy46RERGG+4zbZeWrxezRwX4RClBlKStBU7Kltwy4vb30PCKmQ6ckC
X-Received: by 2002:a17:903:246:b0:2a2:d2e7:1601 with SMTP id d9443c01a7336-2ad74541768mr52404575ad.48.1771763149061;
        Sun, 22 Feb 2026 04:25:49 -0800 (PST)
Received: from arter97-x1 ([58.124.177.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34fe7sm43851675ad.2.2026.02.22.04.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 04:25:48 -0800 (PST)
From: Juhyung Park <qkrwngud825@gmail.com>
To: Juhyung Park <qkrwngud825@gmail.com>
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] ALSA: hda/realtek: add quirk for Samsung Galaxy Book Flex (NT950QCT-A38A)
Date: Sun, 22 Feb 2026 21:25:43 +0900
Message-ID: <20260222122543.281017-2-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222122543.281017-1-qkrwngud825@gmail.com>
References: <20260222122543.281017-1-qkrwngud825@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217662-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qkrwngud825@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C9B4616F076
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


