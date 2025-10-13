Return-Path: <stable+bounces-184235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FFCBD3474
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF833C6058
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACBC207A22;
	Mon, 13 Oct 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io1hlNIi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700AE1F4C96
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363248; cv=none; b=sZ0JBDzFzoyzpS8MJ22nsJSUpsn5FnxyJU4JRDx9u05xV8f+LcCY/X0ov4Anvfsl7k7p+yqx95UBINUY+7SbyblADpV5F7HDwdc++yp5nR8o5swm/uKRQNgdMW1oXMGUzQEPnpXtHIPJeUb8aA8ZlAWMFErqVADc6K46ohPAaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363248; c=relaxed/simple;
	bh=Swp4+xHTqvgYr+z64DMuU57MVlL3j0v8jDSlSv8/1Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pEqDcC3MLD94YiBkbP6IV85ehn2DC8+2hM2TrCZyEQ88blCCOclfHoAm+PA5u3gBBDcHg13LH0ykF8T/SGuYmmKb6A5AkFsPFtGIZ8AiuOSZEvL7i+4H/2QP3OrHyCFh0S6P1YyOdI2QXwvqJ6qWDqXwNEd7njQauiiLS2c5y3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io1hlNIi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781db5068b8so3398476b3a.0
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760363247; x=1760968047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=teOPnCrlstkFyH9+vuIz1dE4A6eVshfJueJ5oAZ3QHs=;
        b=io1hlNIiVqXlc1wjOO1Rak6dG0PCmd87m6yKf7aSc0mEZV0nxR+OmHBUv4xbgPmchU
         UT+ohTXQGkOWgu7RQUvjFsuw3jx95XXtFJj20VylppMWy9L9VAsDDkBiNpYVMusvyQ3o
         5wjdI0ZxwK366brx/sQD+9O8TEEWQm7k3m7aFlh6Nc3UJ0aqRWHBeoXzgROm4kJ/VXaI
         3pp5GEfkHcyzG+rdmiiYdmYN4N9F+SvKTQaUK/x/f4/7Fajd7S3IkP6Zi9AcdDIoz+tV
         1+5p1fKcdPVgXYtm6+w3qn6va/Hm+qiv9MFZnQXvkRaD0TGc+zOt81ZvR423VgKgR1Xu
         jzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760363247; x=1760968047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teOPnCrlstkFyH9+vuIz1dE4A6eVshfJueJ5oAZ3QHs=;
        b=JMo5IDmc9Bp3GpSFbWukkWYV7Nl84ZpCYin7qNAr9wog2iBWHb4yrJcHcnRcrRRB8+
         qTkFijKds2lEJ1C2BB4sndhhXErsxDiAb2SvJUD9WDFCcsBZalzL3ABPdXgvmeDadQJl
         DCjJ1QE26O2yVBMxmVIZQzW6XLHzROwPsxmL1l97GnfkNMBp3rnqkObkNCA/gY9UxVSP
         3qt3Hp+4gi2Fr5U33bCZxCNw+yTeynUCiUtFFGdnjPEjgpE0PrHkRqLyip+UBfyBXARk
         zUwg0cE+1BTdioLajte6NabSBym1oBRivZKbcJtXmmR9cMwJAQMBKCCHkxsdBS2od7k4
         pjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6ILaZahlTKwX3WUzB53PXApyJ0VbO8aCvaIgI+5wUP1pz6hYB0AjkalS4rcQzvLgK7twiG+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6IqnLDujErucD7YhjNBnlZSOb/m9OgSdQy0zPX8Ga+755xSn9
	IojN3LwzcvwJcKpAHAUgY5/fcVkvZGRb89nO3pfXRPr4dBIViTYXwfAfLanLDMeg
X-Gm-Gg: ASbGncvz3pyIaI2jWREEVlNDh4djLyWbBCxnT7mSqlhp234B7IgWJknfasot4ZxR/G+
	eL7OQwCcGcnh95ncWq+iodIWiqhZzP3JUtnZtRizAWSW7/rRpZi+IhzZRiMDYMD85ckra9ArXY3
	p6j3oRMVI8aPJsMSOUysp+Ddkv4pe1hSnj2u2ZNgxuvCc+yn9HWfKZ0iuCXeARSVpSrUvszi/Vd
	ExtaT+jfiRnO41A4DiSlBYD4XlSjIV2BAGvKvQglJtUlMPQd8WjIh5ZX5Ls1IlkI3kf2C0YwUnM
	t7YWB2xYsyCjy+JnHIwSnUrFsIEghaNnJ6Diy6suJIl95yJ+l1fhiTQDCsMyXSdpcr7niKZ+Yhr
	MuddA7rkblkXR/xqC/9R5EQUPwZawURHnRzHaTBNKc1C6w80kcCMiCjtIE9r4OBxvIGgv
X-Google-Smtp-Source: AGHT+IFD9xM53HQ+bQQDPEQgAUdL3IwH91zz8prxo1co6ZEPN18n39S7OZmUBWp8Eqf4/zWeSLysJQ==
X-Received: by 2002:a17:90b:1d06:b0:32e:2c90:99a with SMTP id 98e67ed59e1d1-33b513b4b51mr31706554a91.35.1760363246720;
        Mon, 13 Oct 2025 06:47:26 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626d61aasm12295067a91.17.2025.10.13.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 06:47:26 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	pali@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v3] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Date: Mon, 13 Oct 2025 22:47:08 +0900
Message-Id: <20251013134708.1270704-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the len argument value passed to exfat_ioctl_set_volume_label()
from exfat_nls_to_utf16() is passed 1 too large, an out-of-bounds read
occurs when dereferencing p_cstring in exfat_nls_to_ucs2() later.

And because of the NLS_NAME_OVERLEN macro, another error occurs when
creating a file with a period at the end using utf8 and other iocharsets,
so the NLS_NAME_OVERLEN macro should be removed and the len argument value
should be passed as FSLABEL_MAX - 1.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
Fixes: 370e812b3ec1 ("exfat: add nls operations")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/exfat/file.c | 2 +-
 fs/exfat/nls.c  | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index f246cf439588..7ce0fb6f2564 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -521,7 +521,7 @@ static int exfat_ioctl_set_volume_label(struct super_block *sb,
 
 	memset(&uniname, 0, sizeof(uniname));
 	if (label[0]) {
-		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX,
+		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX - 1,
 					 &uniname, &lossy);
 		if (ret < 0)
 			return ret;
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 8243d94ceaf4..57db08a5271c 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -616,9 +616,6 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		unilen++;
 	}
 
-	if (p_cstring[i] != '\0')
-		lossy |= NLS_NAME_OVERLEN;
-
 	*uniname = '\0';
 	p_uniname->name_len = unilen;
 	p_uniname->name_hash = exfat_calc_chksum16(upname, unilen << 1, 0,
--

