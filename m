Return-Path: <stable+bounces-191691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE3C1E6A2
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 06:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD9334E2992
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 05:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E25132D0EC;
	Thu, 30 Oct 2025 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljlp6zzo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D58260587
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 05:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761802133; cv=none; b=lJKA2AtgPi1Dfad6h39HBBNdJ5YRZjFvvuPSTrLu47WYzLEplXFdnQr4Mv5UpTZSXd3CMT5J0gg7ZHYfUfp8BmKxIMzKj9D5SBrpF5BtmRgOJBZqh838tTD8ohva0TMf2aBVPDkm/BLFwuoG6iyZD0CeCwJnjq91wNIc+hs7/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761802133; c=relaxed/simple;
	bh=f1kCG5TcAfbrPxtCZoUNFHaApQsksHuvWbM7GauKnp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dQ9sJ/zRV4uv+7ZTKFn/QaFTX55KdY986S+7eTnS/OwmyFCrkE8pEyd44lnVRMDenb8J107gvyvvS6nHyj5YO6AJ6FdprH+Gur2cQ9fkjub0EIbZnAFxx8CwKsU95R06i13LT56WG+mKaWfbgqYZcgU7e1L5j085G3Ghnzuk60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljlp6zzo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-79af647cef2so675522b3a.3
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 22:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761802131; x=1762406931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FSKUHSinYJjKvjZWn7Ylkm232SOv2kasPBkc5nSYgqk=;
        b=ljlp6zzo/P5KFGBvyInGtKCmUS98ZmUtLqjFpX929KKyy0jI409obG/VNv1gdyNDZ0
         YuMjN+x+aMQ33vgWtUPeR0zVStbYyQWyqC5E80af3T/UaiMjRSSuQHTTN3dowIiV6ryd
         wp81olkl+oQfAsQJLO9kvluxMmiY/5jzdjAd0XjWFfvaBRnYvFE3f2+9uvAplw9h1gkP
         shvA5NbFbT0BGaZfwL7eDNRiujLfJyAh6YpLsfOowLYCFnAN+JZo3tDhv01Zgtn0dSpw
         mRlrqAQl/uMRrS2txkL3YKVeqEZ+9vN0frU6dt5qsREk0XyqO65ZCuEfcne46p1TtWKF
         8TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761802131; x=1762406931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSKUHSinYJjKvjZWn7Ylkm232SOv2kasPBkc5nSYgqk=;
        b=wHwJAQc5hNBO2jCUq+wqwRUUQFewW0wJkT6RrwMUG8hE3UhrKsmomdSyisLFS8LIL1
         H3dweKOp3Cai7fA0TMm9TwEP5Hir5fzWobyVt9Uym7lugDiCf6C7W5sUy7v9ZURwD24F
         Y4GPuOfPdAqSNJg0+5XAS/f73avnSxi33DUE+ZugvXyP3JgfzsAfn2JXtvib6dGAWQwE
         C3uF6DyuVkphGAkKid75rP4vMF48XoZrwBm2DdL1Mf7b0ZdJtFnWCSS8A1Y4ht9wHRO9
         RaBD/rd4zvi/t5bLGrCGktAmD0jSdO7xPMmtCC67HrMFYDTp5cvUW41q10xNJA6TFUgL
         lgLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJiwtO3GyDJLZCywZGSYbe9SIJA85Lp6EIRlC0J7NbilKXcZ0wgjQekj0K61SRCU88c3iWm0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvZrpiIcbMYMZmb1FgWacpFSbKZTv5eIImEySusCP0qVb31GiZ
	yFUM+q5ro5pVHXB4lTgPbQeHsfpcBL55ieBnt2SPb7KIEOpjevLzbIKz9dQfv6xsQxPXmw==
X-Gm-Gg: ASbGncsBzBTzmKopmbE1xMMFwXm5mDh0Tpd+FPcUY2x6Xqn2virAlMuY6VUR25Jle4R
	B9IZOzbpUa77gC81yz3bbFI/zi3GKAddT7Vzm593Jag1+uuX8yPXg32wyYFdYdZOI7mHxG0tLm7
	QiyUzd41amAkL0SHmSrnUfmkWzsb1vzpMxxYrwZc4Nf7iAVPRYibFU72q6dgmW9Bade+Yoip2D/
	5uy7WryuHgDzqJXjf5aEogBISZKPCOMGlWWWVYrlI08Wrbp4NAQX4Uu3dI9WOC/sW50PUF0u7IR
	CesLJf8qbpcplgFoN2LdDiiaS1C8fLYEBRcWP9JVtTEkGE6S130o3lyQUvbqlxs9XU9uh8coWAJ
	CcC+RFYcXqLLtbKjDSd6AjWbLx297A5Nh1lD1v9QSvXIzfxNPqXDTBX2pdUfGoF/IpAPhV5Vbmx
	tgYVhR5vPf54on6Xi/uzwSgG9kV2JMpZpxkadgqKnwhS0=
X-Google-Smtp-Source: AGHT+IHX4O7EKdx50iJVWLjggzkcWZLDrobpQhA0LDtO34kiExl+IAjGVhwdQR+ULIc3k6u6F/FiaA==
X-Received: by 2002:a05:6a00:244e:b0:781:19e1:c4c8 with SMTP id d2e1a72fcca58-7a62a940ab5mr1870941b3a.9.1761802131220;
        Wed, 29 Oct 2025 22:28:51 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a414066d0esm17479391b3a.43.2025.10.29.22.28.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 22:28:50 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] misc: eeprom/idt_89hpesx: prevent bad user input in idt_dbgfs_csr_write()
Date: Thu, 30 Oct 2025 13:28:30 +0800
Message-Id: <20251030052834.97991-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A malicious user could pass an arbitrarily bad value
to memdup_user_nul(), potentially causing kernel crash.

This follows the same pattern as commit ee76746387f6
("netdevsim: prevent bad user input in nsim_dev_health_break_write()")
and commit 7ef4c19d245f
("smackfs: restrict bytes count in smackfs write functions")

Found via static analysis and code review.

Fixes: 183238ffb886 ("misc: eeprom/idt_89hpesx: Switch to memdup_user_nul() helper")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/misc/eeprom/idt_89hpesx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 60c42170d147..b2e771bfc6da 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -907,6 +907,9 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
 	if (*offp)
 		return 0;
 
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
+
 	/* Copy data from User-space */
 	buf = memdup_user_nul(ubuf, count);
 	if (IS_ERR(buf))
-- 
2.39.5 (Apple Git-154)


