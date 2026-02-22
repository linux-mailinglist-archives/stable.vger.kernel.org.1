Return-Path: <stable+bounces-217661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lwowItL1mmmnoQMAu9opvQ
	(envelope-from <stable+bounces-217661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 13:25:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC73A16F06F
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 13:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 228E0300C832
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD271D88B4;
	Sun, 22 Feb 2026 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqlyXUQQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C614F9FB
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771763149; cv=none; b=hqwHL64ThMId6T/GbPJIikT4WtAg1TA//Nfru+upi8TVnUalkoVr7uAfYgambi5Aj8bNTBYvzt7Z/WFVE4v2qy85SS0QJf0SvCmZ+YL3nLbUBuSNoSNS5yKyhA9x/dEqpj4sucPxOOeS48oO1ega1EvyonUIJPbkJjNwRUMSJQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771763149; c=relaxed/simple;
	bh=hGd8RjJcLkhxXpiwAbyrgRWvswqH7r+T9SscVabbvo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OayTYotR12zGg37HN7GN3jONHM8/wdWdS2MFHCYBKE9znJTRw9jzxk5yU6jQOtmt1tW+C6YaFCU/J/rFXHFbeqYdk9Q0wdPvbV3zk9nJ9UudaBFuauEvgOQR+JLdkCHFJvhfW7ooOD4PpTMA+UoesEWVcpUKTbwUDmWOwTCx7ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqlyXUQQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a962230847so34294715ad.3
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 04:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771763147; x=1772367947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jab/06e1zia4iBapr6aB3V9FEmhexkRh2fXXZsF5Egw=;
        b=YqlyXUQQhbEh71hBWI42REg8C1ERosXc7u2U67n2g3maQxLeOlWZryKdeFZ3IjZTKx
         87nXJC8if2TA1orJjZRLgqK0yK/E2Xrh0wNVnDOOCAT2huq8JKUY3khX6/BQWB+N3zaA
         kF8Z01qDTMBDz59rbcQ0YVw1riOZ5sbyN3evZ1ZtiyVJIUzqihf+ytIbiZKqtebHLQs3
         Fgp3ycHoHmEPj+hTsi4h/k4JNTCcI93Mrd25rpdls4Tf8ndJZf7baip4fPWuy7pcqNz/
         N9xX7vNiREwaJI0JBi9qwnlSQ2bcCLN+PZYu+wMIakUjt5JjVRUeiMfRmqM/x9Q4BogJ
         xw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771763147; x=1772367947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jab/06e1zia4iBapr6aB3V9FEmhexkRh2fXXZsF5Egw=;
        b=UVuXPAxDGJoD86LDuBwM3gu3DCjwMgJDUaraEHYHYxIXOyDKru67wR3uddX0nnWB0W
         5AE6EvMiglPY5lxIWm4AFWmU6Q6Olga/xXIOHJ7nB1vdIEqGZukPwJHBgE+W1TCsI/vR
         zEiMhTpIg3F1mKu6fhx0bLAghX3VoaWKDFvuleDl8P4u7QRgdWTQY9Ps66UOnEnYmdFm
         j9h8imTdp/glxPH1Jp+hKijrlUgnxlfpdGnO8UBsDBmuUX7uRiUFsPcDcEVWP4AgotFN
         Z3bmBxx9Rnb+mJwU5wyPz4JexQy3Lj2F4d8PLTX2MN9iEy/ux9xZJPhO1Q+2mvAP9U6y
         VKSQ==
X-Gm-Message-State: AOJu0YxRvg8VkoZUG93IH/wJHl1a58RcgUwvvgWbJCZcXV5ILveZe4VX
	DSYaprsrys+LJMnzf4x0jC5yLS7qx9sknEiF6IzXnUyzMBm6CZilkqAIwQgdjyQVLJA=
X-Gm-Gg: AZuq6aIXsXfx21xysXKnD8KrUZRoUJr4Z0P/YMGhSE0AnwZHeNWrmcZumMc0O7ay7mO
	v0ZTrElns37akGj6So45OBFB9ZXtgI0Wwg10MEsoRARO1Fk8AoyijTfOZloOIKFefu5qnQoKST7
	eG3CKd7XKLo93/JFeo0/w9qEepWRlANQg/M5ynBs/4yqCxviQdUhlMnW8mIz2LLelR0cfRczPRi
	l5aV/2iNqLSItnZrnhMYTJiTGEZKrUXwT3s4UrlF8niWLL7doZiewFjgtHfNXzmPksFmnwfmY2/
	On1TKR+N2qVTVFaKJ+CL51eROV9DqEaGk5WzwsD5cbQU4dJ4002CF4zju5U/gtYMUXwn9pQwU2K
	Wu5HhH7ID337lOEHhONMEZksLOc+13DUhgNZSdd710MMtdCTrW4Hyt9pq/pc8enkzRsdoqVrPqU
	oeTyiZvLSi2x8JT9mXO+RS6pTpmkQVXXx1IHyvTz2GGVGN6GBDQq6lyzw6hG9er59bsDU=
X-Received: by 2002:a17:902:f683:b0:2a9:30d4:2b07 with SMTP id d9443c01a7336-2ad744ea70amr59440225ad.32.1771763147412;
        Sun, 22 Feb 2026 04:25:47 -0800 (PST)
Received: from arter97-x1 ([58.124.177.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34fe7sm43851675ad.2.2026.02.22.04.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 04:25:46 -0800 (PST)
From: Juhyung Park <qkrwngud825@gmail.com>
To: Juhyung Park <qkrwngud825@gmail.com>
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hda/realtek: fix model name typo for Samsung Galaxy Book Flex (NT950QCG-X716)
Date: Sun, 22 Feb 2026 21:25:42 +0900
Message-ID: <20260222122543.281017-1-qkrwngud825@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217661-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qkrwngud825@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:url]
X-Rspamd-Queue-Id: DC73A16F06F
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


