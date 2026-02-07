Return-Path: <stable+bounces-214810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCVSLKRzh2nkYAQAu9opvQ
	(envelope-from <stable+bounces-214810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 18:17:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E596106A53
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 18:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD73630191B8
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 17:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DC427F73A;
	Sat,  7 Feb 2026 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnfJKKHb"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8590914A8B
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770484610; cv=none; b=TOGdUaaiZkNUIsyV7xiCoA9W++wlbUBJjkrhxzJFwoUgpYi7MheAMSHovpqGVhHe+LwJdp1NLsxA5LXHU+thhaybR4+qpuAcXhaGpPmTI+YZqD7zjJqU6pwlpvAlcnZYXUgomzHKZ2RRluHiPoWHcgQqBm8IyUssQeHENPC9sHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770484610; c=relaxed/simple;
	bh=0qn80RrvMd49Rd1AazoqaDvABBoAMl70AJysxwOin1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CucNG3y5WQWBUmDO+yTsm7/ByyLV2LAvKnTU3o3fZErAkGApjIr58ntV64KMm16vW8YYhxXe/vPNSK3bKEhtdPJNI6Peqk+KzDBQyh2kMaT/v/LpmdFJaTCwpxly5x3NonUrkIBGE3tAV+JQdnenh0w/vWKR9igXoiCAgue9yAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnfJKKHb; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5663601fe8bso2419324e0c.1
        for <stable@vger.kernel.org>; Sat, 07 Feb 2026 09:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770484609; x=1771089409; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha3Gbe9vIFbOcg4pmgQ5XVEUYBYzQJq7+aTnsh5eblM=;
        b=JnfJKKHbgwaxbNBJrxO/0pJHFTPuqck+aXNBQzlbL1LzlVpiWOqb0mpU2kHzjrAKuL
         GLd3eodrxHkNXOcfYT0DuV+1cTTyVcA+/wtApdxudtCKxJNBJGOfL5T4jE1chgzeJ9IE
         YpPZwgcASRjgku6C/MmQmupnZFqx8kdB38Uxur4mnPY+E20dJNStQiUNf7bwLToRGsps
         o1LOai6CN6Kd/J3vtXxV31MpEENkIY4AMAmc0DzbrvzKILPKy0QgUGGWWMs/g5Ybpiy7
         p3IdNItMj6/7dl3NMSaV4n0va7FVGi+0j3VyiGBxj3QA1hNLEqXxm4p042wOHKy7ySZg
         /BUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770484609; x=1771089409;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ha3Gbe9vIFbOcg4pmgQ5XVEUYBYzQJq7+aTnsh5eblM=;
        b=evhWeRgOVMK5LZ521sRzRy/VBQa2r3jOSEWR499VR31mmbH1JB+3q4fKgzDFN3/BFn
         97FrvhGJ2u1/lS2gpa3pQD+mbCrE7nRZFiLnBmJ7unuW4xf+fi5v53CAJ0SLrH/TUkTG
         KjvClA1fIavdMQFe4k6lIzUb+RIEvBw+OCCnzkIPjVqQSwPpH5Z4Ui/SARwc8TUYf919
         MRiLifV8xNExFtmbNL4NhW1IOxbDX+04pxmBBZzlY2azqG+EmpJtfVWq4o15M3IqVdwf
         qnAETS2pT+YjdYOJPnSLL1wpmFhkiNL06diYMuAR12sOHJw/DGAXPvUtdndbE4vriZ2m
         Ak1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuuCSUUApewv72rk55Hz6RKT5LIxAs1UjmYRWq/Xsrk7UxI3Z4M9VDvXf7uJrJFyuGICecBVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLj5EfpvSLfUZXte2WHGjR+v0HpAFxQ4Q+Rl3x/jiXDUXi31el
	l0nxwdrvpxfVnwu3/ywcvUZMmevu71Al+RRMPXxBeTN6H3tZH6yc8JHG
X-Gm-Gg: AZuq6aJw1xspTdZYRFWbiCF6fm49egbXtzbeFhOe60edPbcCc/o+xqfggFg7fLsZgUv
	lbHatxv+ixaIGfW36hV3q9+Lwk96Hk8LgQeY6qYw0E/vuZWB6lDsRUc7gkgFx5LTxTg6QYAZHjp
	NHqBKNY0zLkQ49cwp3KFIxO8dPW2VQ3PWx9JJCufch9V6PJeT1rg9BIfuHVNoNjlxfjulnZJuVa
	9mfce+qj1/Q8As/Xjw6S+iC4OqtCa2fxnOC8Icyfdt4SUXybupq+asnQAm4xUxVTs/iQBqBkrnI
	Jj6HGS197TNYpVQBv9BX43qzph9GdZPTXrOggX8LHiO+VVP6dles/1wtGT2WcbV1Ghf2RNmteVF
	tpC7g2nz2Ks2Edln0pGxKZokp7srz0jwnyhC0eELmHZBIyANYU1pKJmBGDaKaPpbJWLZ6Yzk8nR
	Et6A8/LE6gfV8+
X-Received: by 2002:ac5:c013:0:10b0:567:1660:13d1 with SMTP id 71dfb90a1353d-5671660192emr458295e0c.6.1770484609420;
        Sat, 07 Feb 2026 09:16:49 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-567074019ccsm2010770e0c.11.2026.02.07.09.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 09:16:48 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 07 Feb 2026 12:16:34 -0500
Subject: [PATCH v2] platform/x86: dell-wmi: Add audio/mic mute key codes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260207-mute-keys-v2-1-c55e5471c9c1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03MQQ6CMBCF4auQWVvDDLElrrwHYUHKFCZaMC02E
 sLdrbhx+b+8fBtEDsIRrsUGgZNEmaccdCrAjt00sJI+N1BJukTSyr8WVndeozKu7sjYvkLjIP+
 fgZ28D6tpc48SlzmsB53wu/4UKvFPSahQ1XRhU2tTkbO3wXfyONvZQ7vv+wfBPE1TogAAAA==
X-Change-ID: 20260126-mute-keys-7f8a27cd317f
To: Matthew Garrett <mjg59@srcf.ucam.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com, stable@vger.kernel.org, 
 Olexa Bilaniuk <obilaniu@gmail.com>, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=0qn80RrvMd49Rd1AazoqaDvABBoAMl70AJysxwOin1s=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJntxZVPP8rYnfx04X/lift220y+tczYZ7TW05fb5osOu
 +WcQg7tjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjIrzOMDLPSjn38dSpuc9nZ
 5QKLqra/VX61XmqdVoxYefuDG/v1ZwozMuywmvd+jd3S61WXDLif/0hYZ6Z1Towz9PcF24Vf7zs
 dusYHAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,dell.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-214810-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuurtb@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E596106A53
X-Rspamd-Action: no action

Add audio/mic mute key codes found in Alienware m18 r1 AMD.

Cc: stable@vger.kernel.org
Tested-by: Olexa Bilaniuk <obilaniu@gmail.com>
Suggested-by: Olexa Bilaniuk <obilaniu@gmail.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v2:
  - Put the codes in the correct order
  - Add comment above keycodes
  - Mention the specific model that uses these keycodes in commit
    message

v1: https://lore.kernel.org/r/20260201-mute-keys-v1-1-825e786732fc@gmail.com
---
 drivers/platform/x86/dell/dell-wmi-base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index 28076929d6af..907f1da01c8d 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -80,6 +80,12 @@ static const struct dmi_system_id dell_wmi_smbios_list[] __initconst = {
 static const struct key_entry dell_wmi_keymap_type_0000[] = {
 	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
 
+	/* Audio mute toggle */
+	{ KE_KEY,    0x0109, { KEY_MUTE } },
+
+	/* Mic mute toggle */
+	{ KE_KEY,    0x0150, { KEY_MICMUTE } },
+
 	/* Meta key lock */
 	{ KE_IGNORE, 0xe000, { KEY_RIGHTMETA } },
 

---
base-commit: 008bec8ffe6e7746588d1e12c5b3865fa478fc91
change-id: 20260126-mute-keys-7f8a27cd317f

-- 
Thanks, 
 ~ Kurt


