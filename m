Return-Path: <stable+bounces-80601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C04698E3B1
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 21:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED301C2104A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 19:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6F5215F77;
	Wed,  2 Oct 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="VsJEua+5"
X-Original-To: stable@vger.kernel.org
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE84212F11;
	Wed,  2 Oct 2024 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.224.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898451; cv=none; b=USLVzG7TMoYTP/RMaapNNXbS0knHjkSbyn4DaMJtm3X0OFKrsCLvA6s0UXznWZnA1XntNK+5FNyOJ1PWiAMEqnug4NRaMX9d/KB1Z0hnN2UwJ/qW1ZsnRj9QOtHgQUm4lKbd/avGL7eANl25S0dnbNVXxw2HDVU1EG1hTfLACkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898451; c=relaxed/simple;
	bh=xhIFKx/Rm8gePB1jFjZajV0yAyHEMq0/GsqiYf/7suw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oONhGcK6s4EU1DP/j5oT0iYJSOZvoUZ1gSei+geyR7jdhXnaLFEy5qKzu6UYbB2EwA+27oNyhHKBb4vjH6xxCqrHaf3w9S8jJbIhmch4CZ2uE4MqqMlfCo4Iw567x2OQEICcTI4U7t5KZNVv3rjsfcQFrD9GHfRc3opUqr1gGMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz; spf=pass smtp.mailfrom=perex.cz; dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b=VsJEua+5; arc=none smtp.client-ip=77.48.224.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perex.cz
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D39B54484;
	Wed,  2 Oct 2024 21:47:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D39B54484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1727898442; bh=e7m9WypdoKbYnXQvxkh+6Tqrg4ZaxLQTqcDhZCcfmG8=;
	h=From:To:Cc:Subject:Date:From;
	b=VsJEua+522DdJqnpdC661JohOIzuBaL17nuBwL3LeCALaemn9jsOSN03kT4Rvbsdh
	 Fq0bgJZaUHIrSuKmaf6Y0c+Q2e9XrhKHgu1OPzixKrerylXk48+W0Im08NcvKSgwkZ
	 pVrM7bDpY7zyJE34awJBer26dE4UY+cOY/ENB+/c=
Received: from p1gen4.perex-int.cz (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Wed,  2 Oct 2024 21:47:17 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: Linux Sound ML <linux-sound@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	stable@vger.kernel.org,
	=?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>
Subject: [PATCH] ALSA: core: add isascii() check to card ID generator
Date: Wed,  2 Oct 2024 21:46:49 +0200
Message-ID: <20241002194649.1944696-1-perex@perex.cz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The card identifier should contain only safe ASCII characters. The isalnum()
returns true also for characters for non-ASCII characters.

Buglink: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4135
Link: https://lore.kernel.org/linux-sound/yk3WTvKkwheOon_LzZlJ43PPInz6byYfBzpKkbasww1yzuiMRqn7n6Y8vZcXB-xwFCu_vb8hoNjv7DTNwH5TWjpEuiVsyn9HPCEXqwF4120=@protonmail.com/
Cc: stable@vger.kernel.org
Reported-by: Barnabás Pőcze <pobrn@protonmail.com>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/core/init.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index b92aa7103589..114fb87de990 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -654,13 +654,19 @@ void snd_card_free(struct snd_card *card)
 }
 EXPORT_SYMBOL(snd_card_free);
 
+/* check, if the character is in the valid ASCII range */
+static inline bool safe_ascii_char(char c)
+{
+	return isascii(c) && isalnum(c);
+}
+
 /* retrieve the last word of shortname or longname */
 static const char *retrieve_id_from_card_name(const char *name)
 {
 	const char *spos = name;
 
 	while (*name) {
-		if (isspace(*name) && isalnum(name[1]))
+		if (isspace(*name) && safe_ascii_char(name[1]))
 			spos = name + 1;
 		name++;
 	}
@@ -687,12 +693,12 @@ static void copy_valid_id_string(struct snd_card *card, const char *src,
 {
 	char *id = card->id;
 
-	while (*nid && !isalnum(*nid))
+	while (*nid && !safe_ascii_char(*nid))
 		nid++;
 	if (isdigit(*nid))
 		*id++ = isalpha(*src) ? *src : 'D';
 	while (*nid && (size_t)(id - card->id) < sizeof(card->id) - 1) {
-		if (isalnum(*nid))
+		if (safe_ascii_char(*nid))
 			*id++ = *nid;
 		nid++;
 	}
@@ -787,7 +793,7 @@ static ssize_t id_store(struct device *dev, struct device_attribute *attr,
 
 	for (idx = 0; idx < copy; idx++) {
 		c = buf[idx];
-		if (!isalnum(c) && c != '_' && c != '-')
+		if (!safe_ascii_char(c) && c != '_' && c != '-')
 			return -EINVAL;
 	}
 	memcpy(buf1, buf, copy);
-- 
2.46.0


