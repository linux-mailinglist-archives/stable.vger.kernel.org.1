Return-Path: <stable+bounces-230682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMHzGGOoxmk4NQUAu9opvQ
	(envelope-from <stable+bounces-230682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:55:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6929B3470C6
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C98D5302067C
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E350B333729;
	Fri, 27 Mar 2026 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howett.net header.i=@howett.net header.b="XJRUhUJ3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BEF1DE3DB
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626885; cv=none; b=YMeq1zL/0hVjavSbVCW+GZiYK5c5RUhnZusQ+8N1B71gnQDRn5GLaSBMbzPp4Slw9CBqt2FW1F7td2u1Vl0rRpA4GVUpXR57I/+pL125efjAjq1UL84hz6OFx58aN+HcV6Ywth8cVPMp2B99UNzLWYQZogOvSmBlwVkrkVe0iz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626885; c=relaxed/simple;
	bh=zzSbOPoClVKbq60acpFDjMOaP4mxFzAvxme1wcNBow4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g9sz7YmpGgjykrJoapGW1AZ4QiiYv3Ne177tespyicC7t+21zwUdZTHJBQkPzy7wqCj2ZmLkEJ9noh1XjgSALTN6zLtxQj/hGg8Y0YhioP92WI4bfTUbOlD6KX0LcR6aiWXwzTAurh11g7DkGaWo9UtNviXNVDkgOb925XYHriQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net; spf=none smtp.mailfrom=howett.net; dkim=pass (2048-bit key) header.d=howett.net header.i=@howett.net header.b=XJRUhUJ3; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=howett.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d00cf835b7so296966285a.1
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett.net; s=google; t=1774626882; x=1775231682; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xY2jDKFYAAR/eXhSEi5E6NaTu0+5uZXyKvR3JmnzjdU=;
        b=XJRUhUJ3xWY0axuukUozveJ7/v6Rykri1os2jR1/0kTCZiQu3Pnn9znH2g/yQUx2JI
         Pq4+l/z9f+D3UVOCLLOAvEw+kN1ygYQ5qyBjV+a0n1r/vobCbk5qFy+tGb3uspQ40Ay+
         eifh71x9aQpZmHft/hjfINn+fQmzBK3y6K5Vq7/ylEjxb1YmxUKPCxhH0vfLfe4VErXU
         0JJCQaMYIqcVgLCbcj7Kr38BmHkY4uWKHUPXNdLfe3GHNHzx9m5Xv3WxzWTVh67BYbKl
         oDSqNS1jxlgz70QFOzMo8tC8dCBlCKGlnOggLuevj58Q5onhwE3QiR+KMDF0nJmB1/SU
         0H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774626882; x=1775231682;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY2jDKFYAAR/eXhSEi5E6NaTu0+5uZXyKvR3JmnzjdU=;
        b=fcrDTVoKeaEarF8VaB1XyaFquctsx5VpDv/+cgwjd1WgFsN2F6SkmYzwgxvKD842IV
         2ZpY647ApiUccDij9Tv+2CSyCqYVI86ZuN9B+870uwruyI8hhOzPAq6f+fa00hWYanMu
         j+ftgfBPN65Nve5EQXaoh6+N7eK5nOKlb/Oo0B7JirXiyFFfDVZ1g3UXTlYfgTXY0Sw7
         cd1GuooYMzcbEQbKgIVkRwJJY0a660TCoapPfvglTB18/sKmmwO+HrvmTU9/s3cqOMgr
         UpJu/EwriTLCfC4icKcRCwzvyIMFf5yzFzYZK7pzGceSbpRcnOFyCSHg43P7HRs2egRW
         t0NA==
X-Forwarded-Encrypted: i=1; AJvYcCWdlXYYh9kWXTHWcizDWcQfS+ZTRGUhm8cXZq2wqv9FaZuJ7h4W+dO9NZDGn33n2m50zr8T1OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyQMc5fJM7krdN14f3tmDch2RrjySKoZ607w3eTm0zo/FWiU23
	Zglii21cfSDw2b0ZCcCI/P5vfXYQ2Y8b9pBMvpfCdKr8V7fcsa2usTDyzc0aTJJYrg==
X-Gm-Gg: ATEYQzxAxxa17OWmuRY4cn88BM+qpoQ5I9pmxt2KqeEkVG3QPLXnDhUKRrPNU5Jacr8
	s9VcH2tOLhN5oMsZeG9baB0QJTVgU8Y6LgM8iEJIC9q+ORDrLMRrkF7m1efJIkH1lIITD0yg9WQ
	Bm6mofND9FqYzovacg+IuxkzxdMyeraFXIVeLG44odGSQcVw06E2AHH4Fi9lzLgwDmPia7PFRUF
	21q7gC2OX/f04v87qLgbQdrCanyXfFKa1vpnf66wcFk8QpJ0Ag9TDNlTyQP82n5Awdiwhuchqm6
	kGrm9FyFS0OEjr5gfX9JcDa8nis9gv8b4SMAHFapNNmEqrauC9hWZYJZPORvY3Tk7eToxxX4tOM
	64ulyHi84sOx0ZkWoWYdyhXfy+gzPOfza/8MZz3jYZz3TamqZVfiVW/5YVbkGX+yqyGQUwlGzEu
	0J0RPvemgUrhO6Tw7sO2FSiC079FMkEoZw7Q==
X-Received: by 2002:a05:620a:450b:b0:8cf:d62a:c820 with SMTP id af79cd13be357-8d01c5e9d40mr383059085a.20.1774626882176;
        Fri, 27 Mar 2026 08:54:42 -0700 (PDT)
Received: from [127.0.0.1] ([2600:1702:5e30:4f11:3862:ebf:9f6d:8784])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-8d00e52cd45sm557470585a.42.2026.03.27.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 08:54:41 -0700 (PDT)
From: "Dustin L. Howett" <dustin@howett.net>
Date: Fri, 27 Mar 2026 10:54:40 -0500
Subject: [PATCH] ALSA: hda/realtek: add quirk for Framework F111:000F
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-framework-alsa-000f-v1-1-74013aba1c00@howett.net>
X-B4-Tracking: v=1; b=H4sIAD+oxmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMz3bSixNzU8vyibN3EnOJEXQMDgzRdi5QUS0PT1DSDNDMTJaDOgqL
 UtMwKsKnRsbW1APzmAZxlAAAA
X-Change-ID: 20260326-framework-alsa-000f-8dd915ef0f64
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Daniel Schaefer <dhs@frame.work>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux@frame.work, 
 "Dustin L. Howett" <dustin@howett.net>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[howett.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[howett.net:+];
	TAGGED_FROM(0.00)[bounces-230682-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[howett.net];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dustin@howett.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6929B3470C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to commit 7b509910b3ad ("ALSA hda/realtek: Add quirk for
Framework F111:000C") and previous quirks for Framework systems with
Realtek codecs.

000F is another new platform with an ALC285 which needs the same quirk.

---
Signed-off-by: Dustin L. Howett <dustin@howett.net>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index ab4b22fcb72e..2cce0a79cee9 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7698,6 +7698,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0xf111, 0x0009, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x000b, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x000c, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0xf111, 0x000f, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 
 #if 0
 	/* Below is a quirk table taken from the old code.

---
base-commit: 46b513250491a7bfc97d98791dbe6a10bcc8129d
change-id: 20260326-framework-alsa-000f-8dd915ef0f64

Best regards,
-- 
Dustin L. Howett <dustin@howett.net>


