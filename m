Return-Path: <stable+bounces-240151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG7jHKJ152nf9AEAu9opvQ
	(envelope-from <stable+bounces-240151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:03:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443743B11D
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 446A03003BFF
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6FE3D6477;
	Tue, 21 Apr 2026 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4So+Sjq"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02729B764
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776602; cv=none; b=r0PMox8nEkCaMlDQh8UE1A+ciPc6QAe5sG7/I3VbWwlL4agS4qkRkCv/XbZPuswjVFizm2pIkfzMErcoWxipddePAM28k6wlJf8D+y1RT8a0OYGrp63etZAsl+aNuwB55SetcsCopLYvUbrnXJ2ewEMomz+ecnakx6NOAEjPuSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776602; c=relaxed/simple;
	bh=iJiUvbReoT4x4uCETYAX16I6NQD1wIABfCHxzjQCt34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lCr5lfzJonBCpvNQNcwn8gaCxEIXpx5Kbp9QgPcBw9CDnGAyNB3agWI+1sBSb5H5fkb0fRbqjUUqvdTj5VUUIp2oZTsCPQX50+Ov+aoBAPGV07tjzmt+WXPMSErRx+TyIjWa3Wb4bZUce/+EsTk5ZAwiiE2XCcFdumVX7Q12NgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4So+Sjq; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2de831d2b20so8088443eec.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776776601; x=1777381401; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RrlnIkmfaLavUxMwyP8T54KIMpBamxkwMLXcyq5lim0=;
        b=D4So+SjqZnw7/g2fr5xcJd3ABQpQHi1kHM+R2b6VqW0xSYYhf00Pl0/s8ojaVNMkoo
         +x1t1RiJt0BL/OnJbfx+06tbqQrSWx5mSZQfN9XMBO/8hrTA3tgMFwPmX8HpiDOCCV7E
         rJfybKhvVAdRXLHaEuPK7FB7NZ7wxc5jeeAQk+HtHekcltCGuQQ/1sTo4H5esvapWmAR
         09S3W4RpdE675hk0AZfxwCuZ03ljgJiX56ut5jBE31NO1hl8JtpvxUppqMvFdHWZ/dvj
         5/v7M/RE0x/pKmm4fEMCW2O0b4PgJfm6P6/1D8aIOvnOOMxmEx6IERsDZ8pXJMhZ3hkm
         j+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776776601; x=1777381401;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrlnIkmfaLavUxMwyP8T54KIMpBamxkwMLXcyq5lim0=;
        b=jAEr7ZIf6+e+6q7SfJcv4HVZ8MyU3Lb4H/TBhdCuXjjm08QNJlolKFyZArbrSIAI6U
         SCR2KFS9DObSkPPvZQ7YSWa0xtaCDK6+GKELT1OLYs6475t21soh/12ElUsDEEOM8S7T
         K5T3eJJ8hEI1ADAosz4WLeSml9UJGSOi5frBVPgnbQvqvy2xlrbG8Yf8pFvN4FRpnSuj
         wbRwcsNPxZtok4tZwniWLGmaaXbwZxfUtWWUsGBtTqZA+5FWwuyoJRxCaBbxIflCE/lA
         5jz+jtpxtUOjF1zHyTJ4Vur5afSU4gWp+UKd6/ehRPYaiMyV6SyGz0nrKl1SAmM+e6iT
         tTWg==
X-Forwarded-Encrypted: i=1; AFNElJ8BFK2j6Y6GmciIq0rvVff29LxUjvrdFt/U7mmH3QqgsVa7zLg55sViet9ZhgoQQq8bAM7xO5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLjeqBXBI8ANePErS897ydAQ7m8JRCzOk5xB90EdiisAHdy/Q
	iv1I2S3JdqVWCJkKrQObcLLo8Ouno9oL7rcZTF3upzMZxvsIxVAH/46W
X-Gm-Gg: AeBDiesXDT19W1WU6h5bSMXU0OyZaQCZw7ZZoHMB07xJTD+Wi65Q1h22c0CnQXlO+Fi
	YdCtH0JWHqUYz14Pd63nvIkb5VZbh34RLzSuoxZtkqFr+SZZ6uDcA0mbsgNsRBtIPLf8PnLu3rb
	xXRjrMek3e3CJeZP0ae9qDjhVYs7Ouwavi8BbQ/XCnRqjWGqlBdjmhK9JtUFYoXKcG1ZSoBpKKz
	YZVOc9QEx2vxxCUGTngrnYOVn05k4fVcnaUzKZD4L0/xlEFMBwR/8q/0R7Q0O09lCI3x9zqUfka
	RbYqdUurnVg0CgsrJs686jpnGthO6umPwmSyyZvTcqB7XrQGbdpGWBrP+l6R8q3Z+ilY9bYm02f
	jYdh5bIbGa9DXjTlP9rKtKcUSbWXOIV0S4Pr0jdGZtreVkBip5lzFctH7NjhTyK2oJA2qjqL+wE
	6NPXclYWedaYLmXYTPGgVmhMpemoeklc0pygcF1jgjwyoAj0fdFGAFNG0miWOo7ICoKJt30hwnk
	kiq4g+WYLz3
X-Received: by 2002:a05:7300:2d15:b0:2e7:5737:8364 with SMTP id 5a478bee46e88-2e75746d9c9mr7148510eec.15.1776776599207;
        Tue, 21 Apr 2026 06:03:19 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfc1dsm18294986eec.22.2026.04.21.06.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:03:18 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 21 Apr 2026 10:03:06 -0300
Subject: [PATCH] ALSA: pcmtest: Fix resource leaks in module init error
 paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-alsa-pcmtest-init-unwind-v1-1-03fe0c423dbb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZORtoq0z0VcRD18QtonE03RTG3
 t3qjt/h/xcwzsIG52aBzLOYvLTC7xpIQ9SeUagaggutO/gTxodFHNOzsBUUlYKTvkUJj8l15B1
 R2BPUfMx8k89/fblutqm7cyq/H6zrF3njQXB8AAAA
X-Change-ID: 20260419-alsa-pcmtest-init-unwind-7c0bd10dd23d
To: Ivan Orlov <ivan.orlov0322@gmail.com>, Takashi Iwai <tiwai@suse.com>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=iJiUvbReoT4x4uCETYAX16I6NQD1wIABfCHxzjQCt34=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJnPSydf0ytp2nGW4dzbD1Mu39Xof/5ujeldHWsp1/OHt
 ldsuaP7sKOUhUGMi0FWTJFlddIiyz1dD67Wx63wgJnDygQyhIGLUwAmoujFyLAmo0Fg3mNPqReV
 f5j/X9WJPxE5l8X6hKpeSXCnsemSlwcZ/sfrpew5oPbg5TGX44LaMxKjzjIvc7M4f71vZ+BBO+V
 mbQYA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-240151-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,perex.cz];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5443743B11D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pcmtest allocates its pattern buffers and creates its debugfs tree
before registering the platform device and driver, but mod_init()
does not release those resources when a later init step fails.

As a result, a debugfs directory creation failure leaks the pattern
buffers, while platform_device_register() and
platform_driver_register() failures leave both the pattern buffers
and the debugfs tree behind. The recent fix for failed device
registration only dropped the embedded device reference.

Add the missing cleanup for the debugfs tree and pattern buffers in
the remaining module init error paths.

Fixes: 315a3d57c64c ("ALSA: Implement the new Virtual PCM Test Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/drivers/pcmtest.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index 20ceb9082fa9..fe31ff1e5b3c 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -754,15 +754,24 @@ static int __init mod_init(void)
 
 	err = init_debug_files(buf_allocated);
 	if (err)
-		return err;
+		goto err_free_patterns;
 	err = platform_device_register(&pcmtst_pdev);
 	if (err) {
 		platform_device_put(&pcmtst_pdev);
-		return err;
+		goto err_clear_debug;
 	}
 	err = platform_driver_register(&pcmtst_pdrv);
-	if (err)
+	if (err) {
 		platform_device_unregister(&pcmtst_pdev);
+		goto err_clear_debug;
+	}
+
+	return 0;
+
+err_clear_debug:
+	clear_debug_files();
+err_free_patterns:
+	free_pattern_buffers();
 	return err;
 }
 

---
base-commit: 0396822571d079e2f275cca8446f653e6ac0e9f2
change-id: 20260419-alsa-pcmtest-init-unwind-7c0bd10dd23d

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


