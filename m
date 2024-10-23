Return-Path: <stable+bounces-87933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44C29ACF50
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB821F25522
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 15:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23FD1CC165;
	Wed, 23 Oct 2024 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy1j9Bsm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7BD76034;
	Wed, 23 Oct 2024 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698429; cv=none; b=EO7Etsl6arP11OY3wNgTCaOOtVO9fSEycFpCgUDI8RkmmwSlyW7LpjZFlG8FBJtary4dbI+mvuaK/qOwWsQ3bgirxnyZlzt9BVRph8Fzl9WTTpwVA4gIsUkCGZRL/UzXTngT76ZpvoQjXyrr2AflfMB2k2sYHmKhGRO+iYcVxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698429; c=relaxed/simple;
	bh=CAynkxkgZHlUa3iBV6MdOjQ8ixX5rvv3bMYn8y2aviI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ga5Xk7gDQiGsNi2e3hao9TQ6gMoR2Ci0Gn5W9H9fw7ZoZOnqlmmNtsqdL/6M6uXnGeOkHUP6J+z1uj/thr19JNKF17Xe6Q7z8sqYtAZB07TUXCeBVZT2LgSh6CGvw2eWitn50zuyE3DzKqwaUbBhP3vKrSHxkJvgthxa/Gvtovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy1j9Bsm; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7eda47b7343so477880a12.0;
        Wed, 23 Oct 2024 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729698428; x=1730303228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cI4cpeSepZSBZvfkw52BvxBYqW20mMDwn4xsGYJ2Q4E=;
        b=Sy1j9BsmZ+Pqi1D3JdTXIwZyyRCkEahxsGGEHGZS/ZYz4qa2bG5XK1B6xc+achDBQQ
         7IZDPzQvLw7hbdnWhIimE6EBzs94f0GfL7s+Y/w+b6t2kD2Cet3Dv3htIIdj1ytZO0La
         w6OYOKUbLFdmQmkIxRdoCuhZQ8MqggqrlNRI/diYAXqDx9SOA5AQC4Tt25lp9mBQkJtM
         rsYj8rvrmFHXPH7xSPddEza412HQRBo7/37tbZK/1oXWQ9M7FBjZR/SSFIzLDQFrIWmh
         fE77IXT5dVuT8areIdLljI6sCjlN8/XNljKT4ZmRbBrRR75/bq/U0nbqVGEjs3LEzldZ
         WvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698428; x=1730303228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cI4cpeSepZSBZvfkw52BvxBYqW20mMDwn4xsGYJ2Q4E=;
        b=QT28qHhkZeK55Ok3IlE43FtTo8GPQEhqAYxlqUOz8DMaX+uqR1Xqfm4s11yGmvdqG1
         FQU0qkseEtoX6QBhP46HBAYAv5WkJIiEKs4vEtqO3zwqiM3kuWB3exObvCOSLTW7ownt
         XfhgoCFHGpycyKGlbqHqawsT6lIlfpqK39KxW/dlpXyZo9V2VsGEO7DQVYaoZzexSNTf
         HSZNwh/VSYblElLIPC2BaZtKGnpj6OcFq4yTcb4ejOw5gNk7rSN8L00INWAkzs84W/kD
         hHUb3+o7y3EFgPyuHD3GRkT2mFvAQZHoFU2ve0phzMWWRtqfoAxozQTDd3a/NsUP6zVK
         bgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZWKJLdjzDiyNYEycTYEgLqLjBeWuU4vqafJwSsEh0SLQecuxhi3b2m9i06+P7zST2Gl1/lT5w1oT0OVY=@vger.kernel.org, AJvYcCVTIRNvqnHcYscDpb2CrfMdQw/M6B5I2eSc9O2HC/DCfwQxjn1qIiA6Bh/YtDoCtVfhrUl/BAyF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4iqUb0EfcO7zuQFeBUBzfikPEaoWaq9m1Pekk1bRmFhcd8xSc
	t7Ga8sehZPfvo8eVBXDodNho3fYPwRImjUWihRnivfM+3svmEzUQ
X-Google-Smtp-Source: AGHT+IHqj1mvLDZ4Cwy8p6aQ9r53izjFv+NnZRFUPj6tOl/1H35DO9vszsolIcVfJJNiLuDuehnR/Q==
X-Received: by 2002:a05:6a20:e617:b0:1d5:2b7f:d2f8 with SMTP id adf61e73a8af0-1d978b242c6mr3700107637.13.1729698427518;
        Wed, 23 Oct 2024 08:47:07 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13355d5sm6436693b3a.60.2024.10.23.08.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:47:06 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+955da2d57931604ee691@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.1.y 5.15.y 5.10.y 5.4.y 4.19.y] vt: prevent kernel-infoleak in con_font_get()
Date: Thu, 24 Oct 2024 00:46:38 +0900
Message-Id: <20241023154638.79486-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f956052e00de211b5c9ebaa1958366c23f82ee9e upstream.

font.data may not initialize all memory spaces depending on the implementation
of vc->vc_sw->con_font_get. This may cause info-leak, so to prevent this, it
is safest to modify it to initialize the allocated memory space to 0, and it
generally does not affect the overall performance of the system.

Cc: stable@vger.kernel.org
Reported-by: syzbot+955da2d57931604ee691@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Link: https://lore.kernel.org/r/20241010174619.59662-1-aha310510@gmail.com
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5f1183b0b89d..800979e8d5b6 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4398,7 +4398,7 @@ static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 	int c;
 
 	if (op->data) {
-		font.data = kmalloc(max_font_size, GFP_KERNEL);
+		font.data = kzalloc(max_font_size, GFP_KERNEL);
 		if (!font.data)
 			return -ENOMEM;
 	} else
--

