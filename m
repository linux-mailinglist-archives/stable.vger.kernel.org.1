Return-Path: <stable+bounces-217663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEfuIez1mmmnoQMAu9opvQ
	(envelope-from <stable+bounces-217663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 13:26:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2517816F085
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 13:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29040300C82D
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAECA225788;
	Sun, 22 Feb 2026 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd+FjGYb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44B1F03D2
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771763176; cv=none; b=k4UOgXyybBdBWcub/IpoRivN/nSDj3n3Zidr7TkUJRopbWe0ZIvtJIxuVfVXNo6r0a0pv5b7LUC+JqQ3hi+x4rzab17y0ROMjc/ApmpBzqYdogVuvjR0sn19dRqW2TFPR8XI5UpURVCBUyQz9ESGlgJU5zTFUP45RLy0CD2A1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771763176; c=relaxed/simple;
	bh=hGd8RjJcLkhxXpiwAbyrgRWvswqH7r+T9SscVabbvo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1Kq1fcHI3n3YmcvsCXQNYvkqLyQezWwlvVCOjzhdtbgH5vjY6S+htohT2S02C+zoD3udIj6mluf9CMJbXkLy6ULskd0Ie3UcJSv/4YnvXHMvGB5vGvD7/mnXzp+Za/sOLK461PUjZwwMK/1xm7RteQTclpodNv3yoxl35Axv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd+FjGYb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-824a3509a12so1851622b3a.2
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 04:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771763174; x=1772367974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jab/06e1zia4iBapr6aB3V9FEmhexkRh2fXXZsF5Egw=;
        b=jd+FjGYbQ1AD9plbwpprA2n+b0JtvWMFuFh38PhvupZasAm8lf0enhLdJqMM9wPXUH
         P2dXPR3Epoca4E6L3IxPSdpM72rZuu/Uy6AxDRfFSclxkTnG33udJ4jcKWJoynoSkTg7
         Ye4Vvu0MC2ZLM5j+2Kv1ZupioZjgfIhWj9Tg636r3s0BFDl2z9ZdAO8/YfQhLFRlMHES
         b8/qCyEcVfRgHEh/FLd+bXXKaPdu0kKu754z0bcokUovEgEHQ6+doHRjJ5UovwJSI8du
         g4ECuhaK35TEG1iurhdhKgMfxGaGmtePLF6w8xrP2cyLbbFfcPpPMc6ton2w6Kv4MiHl
         mdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771763174; x=1772367974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jab/06e1zia4iBapr6aB3V9FEmhexkRh2fXXZsF5Egw=;
        b=v2Y0pcW0SbVzxBbfALO9ktNsDzExTiFezh9zSpGC9InOTJQURGYlADH/Yj+ryNgb8U
         r9cDPLUTESkTEIGbbZSdN2Nej0oNc/AkdQN1BzuCuHHN4KoOZoP253spPqB14IGVH9MV
         jTjVEa+c/qOrnAJaExIAcdyPvxAUzNVJ21FNbd3sR4baQNNFzsCe0+IMq3S0UP94C3tI
         /1PI4rYSHrKa44Sqis39Mg4bOHanqyqej6s4MmqBev4QszEKjKHqq54wwJMsNbwa7mzG
         qZG8Lw/E41YOIhp1kxmgACAXDy2uUQf2n6IbfEz7YMLyZaSohPsTFWJj/JrBDhM2Erew
         VHUw==
X-Forwarded-Encrypted: i=1; AJvYcCXIytmgOTr+gWZkUV9gY2aX6sNvyqIJfWOsMHHKNfFSz7p2vWqu1eIVOk0h+LatM5OdGjwzjr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOevCNhXfE5BnADLAGjj4wt1EbKjyZU+/fr8750IVNeJpsyRTS
	88NtQd8+PuaJby+xic6bDwZ96IG5vz8UfjGARb5ai6Fz5PYZi4cSmMkF
X-Gm-Gg: AZuq6aI0YFWvRt9+vVgqR6K99rdSuzCIHfJaBToH47jQlQXmKsLP/e8f5Cnjvh5I5Oj
	oXOsIau/cvk1EGYQMm/V4eABW50bF/0CTnAexGv7psOlW0M/KP1vECPxxK/oddaIGwLNIPv72t1
	Hjs/roHorEiLbSKtHdT48iDmYvqGob2j7Zb4K6yb/uhgfklqJjkeTT4VwO1fqEZr5lFbO39IwU9
	/XtSyIQaJcvOhKcPQutqW6Qd9pJ8rGGiikRUK8zH75CbUIIUCkNUOGIs/nPF+dTkAyxgA/MYEWT
	MZQ2RvanJpPBYT8+uJ8w+TmBlzLV2lK8T7+cTl1jrAFe/qHaW36mYsL7s+PP3RZ7Ae/N4UMe3JI
	ULhHzM1luFCeKuC3huMwE5UrSKoABAdgwvcM7krOWrG/C1E5Xx55/OkqHCmXpl+pmPtXARJPTQD
	1v62pmY+Eq1XV1uzXVvszt5VMOqEoeTUFmWPATxR5yH3O4wkQAYekmMIjf
X-Received: by 2002:a05:6a20:3943:b0:394:f6b5:3998 with SMTP id adf61e73a8af0-39545f495dbmr4944705637.45.1771763173717;
        Sun, 22 Feb 2026 04:26:13 -0800 (PST)
Received: from arter97-x1 ([58.124.177.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7180613sm4408021a12.3.2026.02.22.04.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 04:26:13 -0800 (PST)
From: Juhyung Park <qkrwngud825@gmail.com>
To: linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>
Cc: Juhyung Park <qkrwngud825@gmail.com>
Subject: [PATCH 1/2] ALSA: hda/realtek: fix model name typo for Samsung Galaxy Book Flex (NT950QCG-X716)
Date: Sun, 22 Feb 2026 21:26:08 +0900
Message-ID: <20260222122609.281191-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	TAGGED_FROM(0.00)[bounces-217663-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:url]
X-Rspamd-Queue-Id: 2517816F085
X-Rspamd-Action: no action

There's no product named "Samsung Galaxy Flex Book".
Use the correct "Samsung Galaxy Book Flex" name.

Link: https://www.samsung.com/sec/support/model/NT950QCG-X716
Link: https://www.samsung.com/us/computing/galaxy-books/galaxy-book-flex/galaxy-book-flex-15-6-qled-512gb-storage-s-pen-included-np950qcg-k01us
Cc: <stable@vger.kernel.org>
Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 36053042ca77..421a84b9fb44 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7311,7 +7311,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_AMP),
-	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Flex Book (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_AMP),
+	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Book Flex (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc18a, "Samsung Galaxy Book Ion (NP930XCJ-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc1a3, "Samsung Galaxy Book Pro (NP935XDB-KC1SE)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc1a4, "Samsung Galaxy Book Pro 360 (NT935QBD)", ALC298_FIXUP_SAMSUNG_AMP),
-- 
2.53.0


