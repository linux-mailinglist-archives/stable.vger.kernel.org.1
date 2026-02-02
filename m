Return-Path: <stable+bounces-213023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBbIHD4qgGl73gIAu9opvQ
	(envelope-from <stable+bounces-213023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 05:38:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE8C8301
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 05:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5FB4300EAAF
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 04:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718D2BEFE8;
	Mon,  2 Feb 2026 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqs5rDBA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E82882B7
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770007071; cv=none; b=goQ2ODEuczqB1JWIeUPgnERam1o0YwkcQTtGFQKqHbbQm4CrfBE6a2OagzOjv5a9rdKwIDyUeP7rb9V5L/ARwhDG8xx3/6mYBOtVghdQ5+qFAbe+oI8f16F9UFoJqE04F8bf7xR35Qo0EybDCn0kG74PALBkc+yKk9qVoPTbf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770007071; c=relaxed/simple;
	bh=SMul7Ue7pVJUIaVvSQDUhube/LVKiEJKTatjF53Wseg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VLpkuq23gvA+yCEhwoyeSL3mjvp4/NedZRm4UEBkKN9KC/hryTkEE2AV1ipdq666e1TGX5G7Gb4Y0s1ek7ZDA+5dLT1izCNtz4X4dHU6aL30x2rV8motr/WNMNw9TRwVuxYlWugJKzDu7Y8+7RdE5W+VtB4AfUoXmSvMPSQ8dUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqs5rDBA; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9489a15fc74so1362268241.3
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 20:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770007068; x=1770611868; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIbmx9IfBuJ7bRGyJfUQEL9l0O2sIDuG9wDyiySCy8o=;
        b=dqs5rDBA3M291lCrpQ2lwFNAWobtX9W4Igi3npnBccHmti7OpEsvdbujLy/SKgFEpn
         Lv8JBAU03CSzl3E2NLocAxFVUpVtbYhrNwuN1MAdRn9RKFdnM5jYPqegJHFNYBEdphzf
         bT9708WnYVyL8/bhJn9a7dMAVSFc/8IqQ8SP++R5xc9wLSMAUpuioVeL5hQm6NNTQyzZ
         Fsasa9TkeLA3KX8FkVqrHZIoiAdeHzI4krPl8G5oX8S3uf/AT+1yDobm0lnAoKAif9M1
         KArmBhiN/QBkT580TkStO2nD6d/VAiWTB7fo1NwL+AlQ+KFaI13ZqO0v1OxqylL1T/tu
         35wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770007068; x=1770611868;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIbmx9IfBuJ7bRGyJfUQEL9l0O2sIDuG9wDyiySCy8o=;
        b=CJbVN4oA3lbmoew5yTnClv0JuAWzCE5IXKacH3NRHNNQNO1J8WdLUcmR0ikOg00ess
         E2zXd99im5Fj5fydmMDixir5or+OwGp6wMqZ7uwCCvDjYsxQ5aWtsGlDfb3XJIJp9+Ei
         nJPlCRsEazJtSMkRp5gQr94CmaYnh5x8sYNSuye0ia8zdKfOLDT3qd47svMvHqenmo5H
         yCnJCgxDD6HHXpbS5uvaT0qIf+gbq9HVXoHseK5Xd5Z7+xnwDDiWv2raCf5HZAwvgtFm
         6D2pw9BZAeRhuofyE6iX5qOXtYNLtAa+7cSfLiuPEdMsD/f2uyIs9ouPus6tD/BF2dNm
         cRcw==
X-Forwarded-Encrypted: i=1; AJvYcCVkuV6KxQ3JNfAqjdnH3t8dlFfgC7JXWwgsA0PgtMlwv2op/UCUGFaw8wNVDLvUxNWlDCw97Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT05yK+0U3emDcNdSmGAqF1JvRhw3P33whaSS1Dkl2eWmUMN7K
	Eri1+J3ZuMAQe8olNsKbDKmcqz/Lo+ghc/6ja4C7PdBkECTpvZJ1O1jS
X-Gm-Gg: AZuq6aJtM295YNC3FdaBQ80F4WS2Hzc7ffr3rpl/hH2EnXqO+EjPIP2GQGGic35FCmh
	smjPBZYM9D6tct6/mWqVlWF7ZdocRyzeNPuIb2Q2+6e3JYwrK4r4gNP4K5vv9A5KiN/wi1LZB7u
	eBIpDWQm3NUFXoUijZxhx9lr6yPuoteErfl4biphrj7MMOjjYPPPMa+5mXv823ONuPHK23kcscd
	J4zGfgMoQyIHGFti8lxbt67wgkE+fqrNQXoaCojHBICHp+AUwRKaa3wPSwqmi7D9As16WS8mQE1
	KMkI1eZRFQQ0+QieqH78rVryZTILZHdxQ+3wk+8DV6InduAKXpfxrn4CPiDL7dvi8TfQdcUMKQb
	a4p4Am5zlQZmI8dRAcqdmBkX8aTRc+yMmS7xIA//lWTZtL6L8qnuQEGCDY5NV9x3wllALY0Cudo
	JHI7IhgcPR/6qlNvZkXKJlh0Q=
X-Received: by 2002:a05:6102:6c5:b0:5f5:11d5:70fc with SMTP id ada2fe7eead31-5f8e2471030mr4401133137.2.1770007068610;
        Sun, 01 Feb 2026 20:37:48 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9487241762fsm4379654241.7.2026.02.01.20.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 20:37:48 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 01 Feb 2026 23:37:37 -0500
Subject: [PATCH] platform/x86: dell-wmi: Add audio/mic mute key codes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-mute-keys-v1-1-825e786732fc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyMz3dzSklTd7NTKYl3zNItEI/PkFGND8zQloPqCotS0zAqwWdGxtbU
 ASQoXkFsAAAA=
X-Change-ID: 20260126-mute-keys-7f8a27cd317f
To: Matthew Garrett <mjg59@srcf.ucam.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Olexa Bilaniuk <obilaniu@gmail.com>, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=SMul7Ue7pVJUIaVvSQDUhube/LVKiEJKTatjF53Wseg=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkNWuIGtn/2qPTNatBnn6CS9bmC7+w9/doJx4Q/vwqr2
 J6+3eVvRykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAEzEzIOR4cuRL05HzdnWXEuv
 5o9nbbKYvu1NYda2g2oFAl/03M7Ps2Rk+O945uFrR7lW7vPNFSLeN1eu3cIXxqi7Rb382SfXze+
 T+QA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-213023-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuurtb@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEFE8C8301
X-Rspamd-Action: no action

Add audio/mic mute key codes found in some Alienware devices.

Cc: stable@vger.kernel.org
Tested-by: Olexa Bilaniuk <obilaniu@gmail.com>
Suggested-by: Olexa Bilaniuk <obilaniu@gmail.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/dell-wmi-base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index 28076929d6af..62cf28d1fe19 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -86,6 +86,9 @@ static const struct key_entry dell_wmi_keymap_type_0000[] = {
 	/* Meta key unlock */
 	{ KE_IGNORE, 0xe001, { KEY_RIGHTMETA } },
 
+	{ KE_KEY,    0x0109, { KEY_MUTE } },
+	{ KE_KEY,    0x0150, { KEY_MICMUTE } },
+
 	/* Key code is followed by brightness level */
 	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },

---
base-commit: 008bec8ffe6e7746588d1e12c5b3865fa478fc91
change-id: 20260126-mute-keys-7f8a27cd317f

-- 
 ~ Kurt


