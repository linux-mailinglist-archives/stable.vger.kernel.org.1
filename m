Return-Path: <stable+bounces-83385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486F998EB4
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 19:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1674B27E30
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 17:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BDB1CBEA8;
	Thu, 10 Oct 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3vpkT8D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354753D3B8;
	Thu, 10 Oct 2024 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582392; cv=none; b=ABqt/SzFGufC77cDtlg5V5YkmqcP7nr8B3L2NlCaGbDoUACWHx3Uf4E/BD8JrH2mdRBVP2ovo2azFm4tNIQC+GKDVgm2P8WdXK40n4yisFrZnE5Tt3cMj4K1RPJVTIi53ma2a6f8bywZI3XijG72Zfiix3ctacqUhDiMSh5X+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582392; c=relaxed/simple;
	bh=mn/ZPOf2DDxL/uHo6xPSIFgWMJvXHVeziNYrO1fVmWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rODi9/r6ayB7+h48M+pz/zeRSygDFVL7FeP57+nyAWGuZVdfjHMQZ/7cJe74ZyhnT5D3XXuibFNP1s7CjRGAGwerKJ1vOcukWNOk/rOVzc/PYrCkt8KoZyHVEMV9B5ag313fWhXy8sJR6y5KH8PqqWWOGfTlY2rAwcpsR0NGwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3vpkT8D; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso388110a91.2;
        Thu, 10 Oct 2024 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728582390; x=1729187190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fodw2y9RXjh33ztN0s4LLH7quAMnnnuBtbSFabngXnU=;
        b=D3vpkT8DU4ujH5v6B1uAXlCGJT/5Z+LS7XWaRy4QcUkTNePUMEji9s2RS/X62ms+vC
         ZfL4WKtOjjC/MSL2+h1Z447yK663v4RORyBvemribQyAU8iTXgwtqEVyAbcxfU/MlbMg
         zSKVE9HjNbmdkPlC3LlzkQMVjaGyfxsQQlLBZOrECc60k0uE8Ti5QtfwurK/2otCtzCh
         zBHWoW3M7AT8BkYRwyIaEJ5HVj6vOEejCr+77GkukHXSEn6Qzcm1JL/J/h3iYVc8aG+e
         5ISbDE69tK2InB+EXfOJPEc0h1RdmgXHFp/urwOC7UnjrNsT68TdXVB/UTrTJbEbrEj5
         SZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582390; x=1729187190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fodw2y9RXjh33ztN0s4LLH7quAMnnnuBtbSFabngXnU=;
        b=MAOCX+0c08sIN375Wj9fBc7PlK3PuG2gSqePc56mhWWQJpcrO+roh7eJsKUmFfloK3
         mDnUAPw1GvnViZdZBV5+MU+ZTKk9bka1u284NRp2TSricQkt6h/UwYsHFIMQUPKEYSYa
         2ZmuinPus9AtkLvD6tGVyQFF9DgMaUvVhjPMoQCrU35mYX7QxPCbVycgF1wRlyN3c5pl
         0h7h05suH77Q+Bf8ieDcmuarh6XISd8frQ41DyM4ZZ7HNxFkoxAzyBz5RiQOoHpdTdiO
         vcL6lOKPab7o8dqhvAuzxYXoMhZ3P9qvUKauNxyfmMv0R8A3c3eG5gxQ/Z+98YSaA4dp
         ZakA==
X-Forwarded-Encrypted: i=1; AJvYcCWuPvlcYJSej9tGkVhz7RsOCAtAd8u5+/RFTWCzcwTxWPUf/rdO/6288n0CB1SGDLTHtfxBzY8+9R4JeMjI@vger.kernel.org, AJvYcCX+zM2sEA60TkekAHwi866gM4GDLBlKKgZCoiVhi5hEXtOGvm7JClvDWYIjQSttBH+JGfjIHkjFdIfNlXo=@vger.kernel.org, AJvYcCXsOBgVyEETVoSPVtXKyBEdgc+VW0/YnIyy+AM1IalfZ8RrNSdRifmn2M9XZt96DNByw5dD0Um0@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwYTflSP4v11e30F5vjF2qIuWp07NdCQWBS2ryvf6w9tdbzak
	UzdMUwB0q4Ji8vJPfHefZcTao/LPncbieFzWisMmB/9uxwyHvtL8
X-Google-Smtp-Source: AGHT+IG2UOEz7aX30q4xZnAkGlmF8olOXxivWfzqq9oco5P2NO3C5dX05PT0Jpd4+OrBTJ8rLpEuTQ==
X-Received: by 2002:a17:90a:688c:b0:2e0:894f:198e with SMTP id 98e67ed59e1d1-2e2a2525180mr8536555a91.30.1728582390270;
        Thu, 10 Oct 2024 10:46:30 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5df0ce8sm1629325a91.14.2024.10.10.10.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:46:29 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+955da2d57931604ee691@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] vt: prevent kernel-infoleak in con_font_get()
Date: Fri, 11 Oct 2024 02:46:19 +0900
Message-Id: <20241010174619.59662-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

font.data may not initialize all memory spaces depending on the implementation
of vc->vc_sw->con_font_get. This may cause info-leak, so to prevent this, it
is safest to modify it to initialize the allocated memory space to 0, and it
generally does not affect the overall performance of the system.

Cc: stable@vger.kernel.org
Reported-by: syzbot+955da2d57931604ee691@syzkaller.appspotmail.com
Fixes: 05e2600cb0a4 ("VT: Bump font size limitation to 64x128 pixels")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index cd87e3d1291e..96842ce817af 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4726,7 +4726,7 @@ static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 		return -EINVAL;
 
 	if (op->data) {
-		font.data = kvmalloc(max_font_size, GFP_KERNEL);
+		font.data = kvzalloc(max_font_size, GFP_KERNEL);
 		if (!font.data)
 			return -ENOMEM;
 	} else
--

