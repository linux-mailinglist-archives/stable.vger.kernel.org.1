Return-Path: <stable+bounces-110990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C04A20F3B
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948E016502D
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAB91B0F34;
	Tue, 28 Jan 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVT5godw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBFB1ACEC7;
	Tue, 28 Jan 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083267; cv=none; b=FjDpgQHha78KvIt6Go6knsXFvsbrBDYmVYwC8T9nTVj76fBM8LXyrBC7s/TlShWrGLPsy2O1I+9kLQuWbT2Gr/npmRkImMQjPdXNhEsip+Kne+n+DGBsjOjsffoFsDcpI57fqLARpSP8khnU1rYx0zS97Bk7TCOh/N3JyhvYvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083267; c=relaxed/simple;
	bh=zIKA5Lnu+AAJK1GF7f7fcAkWa5s/nONDNBIBGD5M4xg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jljM2U87ja3d0L/C+Ea862Sh4NeA8o4AUt2Hnp8THIrho+dT5KHTibTGjkF/f+leh0nyqhKzpKOJ0KxgIPsgQNEFRL4LMw3mpflGEVoavHKHurQyggDOj5zgATypsvQoBNd1VsVMXlGdn99zHknuX/cECFFs+cfNN28MFiHadwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVT5godw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so9198861a91.0;
        Tue, 28 Jan 2025 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738083265; x=1738688065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pklG817fp6sHKwwzZTujJQWYc/HiXl0PHhO5kJwA80E=;
        b=WVT5godwbuhwpX4VvH17YN1OChglXM1LjJ7aUheD1yajgt3kLksXG7s5ul/cjI1Bpb
         ZlCziWrxaoEd3EErd+IcmFaV3Y5E1nQDI/+VudUoxG/gLOqCaWa1qCeAQD3BJ/u33hsQ
         VsrzIWR9crRiC9vKWdl3IhaWv4iZUAHnUaveCETaXlW4RDr+8YxxR3nQVuMBr+/Rl7oq
         hWV0zq/nZyfM62Rb+cxjttdSt0rW+qMjwXjs3mo4LI94WuaR3dZGHC1GY15SwR+15aVl
         rK1cLcV2GXrUzkQq2N6/Jyn/UrNZxO7UH68p1JJBbLqzMCGwrBUJBORjmMPtrLgif8rF
         CFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738083265; x=1738688065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pklG817fp6sHKwwzZTujJQWYc/HiXl0PHhO5kJwA80E=;
        b=vfTTL2M+5TPpbDsaC62JGSx3TDD2s/2gEKEY8o/CUuhkpVPeyoEgm94D1VYcnWEKGz
         PvshZ/5nPpa8TmxYZIiVZvcZtxitCPnUXxDYdf2Z9r4jeBD7w0VRolDxLnbw7mhHyKu0
         1IIOFJSLbxS1wadOcQxuqQd1EbvKLME6RmsD8WJlnL8rSZne4BxYT5Bg8lSOYl1D0xzk
         pJxVssov/lZrcsUi3U5+EPjWvSeIGZJEVnBC3Xv+KoHqO/vaqYesC2+DljeOoLy2w44i
         1IsyD0/16GlKBcWAs3PQqC4MSB4hAWEg/3hftmttC7VuQjqcsqCqp0rp9Vm6QV1fc1N6
         H+FA==
X-Forwarded-Encrypted: i=1; AJvYcCUemPKRBGG0bO0zlnuSd3DJF6Kiluy+fFWSeLcTPgJw3RhkvlQ5esral7XAjx09MTYqVny0NOhO@vger.kernel.org, AJvYcCUfX/yxSqo37jHaHhPqGhl3RrU15r+Rj399PLP+C7n8AmVJIKs8HOf07zgkKHZ+9vQ4uZUmsAOG6pMdSQs=@vger.kernel.org, AJvYcCVogi5BIWNIPLrjKIasWzAi+LFZ0qyYrUyf/hemG7QBY/kbyoROds7xdBFvKODLrSCjaDzcwXFdjaezmZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPH1/YIY0auwp5/OLeJovqZActWcszU1CetXrGzkUPcLc6YAa9
	falk3TRBtofUuZ1HZj+1hrz2A4zbfP3JpGE8JBubrtkGplyIQnHW
X-Gm-Gg: ASbGnctvTRqfgCPqHgqa0wSjXbNlfgAYLYlKWiApJ+pmKntLg/OIXaA0oUrR1yHI1cO
	1H3nizNlIcaEg1E8+ooA+kbh1BWawtnPK+y4BkvriPXE29KusaXpbYajZhbH7Ti5KT+3oGegar5
	UWeR5Dj26JaP31BLLpMeIA3whhNCfadpjQvaXGA/q9mBXyFJbEHYSzixSNZhGIeuYiN/10vndxy
	OtmrAjGcvU9+1g02RTx/V5C90k3BSOLeRghNAVQrQ0RmZo2ZoeKXrnOISoeesoMlm9+kXxjKEgI
	5wUjEK9k38PSzSCxKOmXYOkWS3fr63II0U3JJArac8c95Q==
X-Google-Smtp-Source: AGHT+IFM2slnJ4cIIibqQwxt2drJeuuyoame4N+ZQnwddz7PiCam0uqREuO19yxO+bXp3DVEIKX9gw==
X-Received: by 2002:a17:90b:53c4:b0:2ee:9661:eafb with SMTP id 98e67ed59e1d1-2f82c04a174mr6047406a91.12.1738083265264;
        Tue, 28 Jan 2025 08:54:25 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa6acd0sm10600316a91.28.2025.01.28.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:54:24 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: gio.spacedev@pm.me,
	austrum.lab@gmail.com,
	luke@ljones.dev,
	akpm@linux-foundation.org,
	jserv@ccns.ncku.edu.tw,
	chuang@cs.nycu.edu.tw,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda: Fix headset detection failure due to unstable sort
Date: Wed, 29 Jan 2025 00:54:15 +0800
Message-Id: <20250128165415.643223-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The auto_parser assumed sort() was stable, but the kernel's sort() uses
heapsort, which has never been stable. After commit 0e02ca29a563
("lib/sort: optimize heapsort with double-pop variation"), the order of
equal elements changed, causing the headset to fail to work.

Fix the issue by recording the original order of elements before
sorting and using it as a tiebreaker for equal elements in the
comparison function.

Fixes: b9030a005d58 ("ALSA: hda - Use standard sort function in hda_auto_parser.c")
Reported-by: Austrum <austrum.lab@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219158
Tested-by: Austrum <austrum.lab@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 sound/pci/hda/hda_auto_parser.c | 8 +++++++-
 sound/pci/hda/hda_auto_parser.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 84393f4f429d..8923813ce424 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -80,7 +80,11 @@ static int compare_input_type(const void *ap, const void *bp)
 
 	/* In case one has boost and the other one has not,
 	   pick the one with boost first. */
-	return (int)(b->has_boost_on_pin - a->has_boost_on_pin);
+	if (a->has_boost_on_pin != b->has_boost_on_pin)
+		return (int)(b->has_boost_on_pin - a->has_boost_on_pin);
+
+	/* Keep the original order */
+	return a->order - b->order;
 }
 
 /* Reorder the surround channels
@@ -400,6 +404,8 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 	reorder_outputs(cfg->speaker_outs, cfg->speaker_pins);
 
 	/* sort inputs in the order of AUTO_PIN_* type */
+	for (i = 0; i < cfg->num_inputs; i++)
+		cfg->inputs[i].order = i;
 	sort(cfg->inputs, cfg->num_inputs, sizeof(cfg->inputs[0]),
 	     compare_input_type, NULL);
 
diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index 579b11beac71..87af3d8c02f7 100644
--- a/sound/pci/hda/hda_auto_parser.h
+++ b/sound/pci/hda/hda_auto_parser.h
@@ -37,6 +37,7 @@ struct auto_pin_cfg_item {
 	unsigned int is_headset_mic:1;
 	unsigned int is_headphone_mic:1; /* Mic-only in headphone jack */
 	unsigned int has_boost_on_pin:1;
+	int order;
 };
 
 struct auto_pin_cfg;
-- 
2.34.1


