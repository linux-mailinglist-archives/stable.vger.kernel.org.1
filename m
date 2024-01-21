Return-Path: <stable+bounces-12333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FB8835616
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 15:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D8E1F22B4B
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B8736136;
	Sun, 21 Jan 2024 14:31:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7A34CDE
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847490; cv=none; b=MWXveHqlHrWVtgBy6Pj/x2d3UgBopnSRzvamrYpqexrELD3ksaLiLFQF7IYXG5VJgDXgcJvTbqpaND3vltw5CWcD74URI3+hQyvELScfDVYjCDhvvry0f98cEr/RyMqnO/ZoFGtFWQsaMakOMe5QEBWnAo4KZp0m9Txp8loI4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847490; c=relaxed/simple;
	bh=6elb48WX3pG3/XL8rD0KQ1l1JOB0YHwqUt2cBzHSlc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kke03KCKFxTFJSheMqtpOOIRE7OiHKK029sokXAFdzJpU8JY9nKwZw7o//IrHVDWm0L3dBQowelXGEkfxgOWN1ecBR7ho55Yg982WuhTo3IL9TMSPSBunhDtlEO876HNAh0jIPxoTjizx6rEpbFpshk01f1Yr4XkxY02TbxtKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d73066880eso6969975ad.3
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 06:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847488; x=1706452288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTcT6tHiGir8MijuYu2jj2AifKSC9P4FHsIKooJOX4I=;
        b=RnW9t2ZS4diQyT/UlzIYVr9KCSR571RTtBSSxCG7IyvKh5ta3eQJXk3IXUBnTYATwE
         udAqt9R+T4TCUA/Dx+tPbrH7eFBX9WSJIJHaag2MC2U0Mt0nTqH/8x1h8CjZjsKJfqRl
         8A1gckBOxgq8Gq4TpwLEta+AXG8G3wIa8dzA1qeD0hiOwYxzoqmTc2cIzFI6dXl/4ojQ
         4Y7SPwZnGUIKRSQ/9ZOnwTbr0OjM6wDio8LhTYdmYC6ot2u9us7sY9WD5//WIa4vD0fR
         FJK9+ZOeb9ElYsH8kWOxcI5ZlmkFHoDGeav9gv1osjiZ1P9b3Fti/g5Sgxjo3RdIi3aO
         51rw==
X-Gm-Message-State: AOJu0YwE3ycA+IY3ShUYkYsrjqW6us0KnKDbKs8S/LB6XVRiO62PtmQy
	xUmOCvGjgQOdzzBelyR41wjxRXtu6SHVdC1jqO91RT/ZfCrawE8f
X-Google-Smtp-Source: AGHT+IEb9SPmqK4Kt2X+Y2msdKa3aT4iJMcgNiuAAgZgUWc0mHcQ8kszOtqKSnzh+KIpu/ebinL+pw==
X-Received: by 2002:a17:903:246:b0:1d6:f879:435a with SMTP id j6-20020a170903024600b001d6f879435amr3904903plh.116.1705847488575;
        Sun, 21 Jan 2024 06:31:28 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d5dd98bf12sm5831027plc.49.2024.01.21.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 06:31:27 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Kevin Hao <haokexin@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 08/11] ksmbd: Add missing set_freezable() for freezable kthread
Date: Sun, 21 Jan 2024 23:30:35 +0900
Message-Id: <20240121143038.10589-9-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121143038.10589-1-linkinjeon@kernel.org>
References: <20240121143038.10589-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 8fb7b723924cc9306bc161f45496497aec733904 ]

The kernel thread function ksmbd_conn_handler_loop() invokes
the try_to_freeze() in its loop. But all the kernel threads are
non-freezable by default. So if we want to make a kernel thread to be
freezable, we have to invoke set_freezable() explicitly.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 0a7a30bd531f..f9fbde916a09 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -284,6 +284,7 @@ int ksmbd_conn_handler_loop(void *p)
 		goto out;
 
 	conn->last_active = jiffies;
+	set_freezable();
 	while (ksmbd_conn_alive(conn)) {
 		if (try_to_freeze())
 			continue;
-- 
2.25.1


