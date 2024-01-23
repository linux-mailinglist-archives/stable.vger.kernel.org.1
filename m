Return-Path: <stable+bounces-15515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47189838DB1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37AE28A85B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3815A114;
	Tue, 23 Jan 2024 11:42:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E872D5D8E7
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010177; cv=none; b=iOujV/7R/7k9S84IV+e2oJIu4/zkT/phmqXrKhM8hr70OsQ5NtloQ54EIQTR+I3G7052ioIfE8anWTtG1/gn9Q6/50gyt9Og1O+zI4wJbXQn2OCxqeik6Yw8+etNKTxFUy12HDGm6JH1k0bUZSzIbAzbj2ZifHaeystX8zREbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010177; c=relaxed/simple;
	bh=tK6v9aORzX4ixcv0LSWjDn1VygpILM01+OlKHVyuh/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nLwgfN6UQonGDfWRPqFES6aHKqB6J/pMEHfmR3emFqKe1BEa5B12DA4VThpeGp4c3KUHrAZ+MlpVDbqJ1gJrcNBMIRdum1APpLgebIUIf5iCQK9G+wK9qMIdKyqZzyi2123Uq9oPBl28AamUnFBOd8WJAyyrU6Zv9qUydbS+4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6db9e52bbccso2418350b3a.3
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010175; x=1706614975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20gUQOJAZW0kG7Ci1YYJ0HN2QiW6jLcyMlXsRmSf2b8=;
        b=qqAB7B7AVhmxxhQF93ujy5vnTdaVzr/bwqlTpabhgE05fyjzFsSozCFz+FDycCn8Px
         twVHEEXTqUFwBwALO+bdMIn5XxWI8CNdUNTP0jhxfJuTzUZZ3fnZonyVE229ke7jvmvE
         FkqWyiJf3gXIrlE0IrQczBWqQaLOFYNDhOHa823Kr3tioUxyHle+EbwGaO/iR0M1pU+c
         8QnWfCtnRSryOLWgRuxH6V0OCTWwUSy1BHtH7wodCzVMJDin90LSfFD+8gCZMcaRz6yD
         2Io0LOteSK2IZeIU8TpgIf+JsXvI4LJPeSWtjQXoOW0ArVwZ6C8zUXeH3POdwD1iMrtJ
         ZLbw==
X-Gm-Message-State: AOJu0YwUji6k7c0JpNFGBiDzLSYd+ephY+6nENNzHa7tTLMve8rL7Rc9
	hJxYfxnA+FIGm4c1fN8YEgtbkgWzZBw+uVbBH81EzTfe6BQCFIo6
X-Google-Smtp-Source: AGHT+IG2kAYSn/dnlMQ765t4y0CUmcIvwdL36vi62lVoreZEJ+8XYwlSTfEznc1GJVpJy04X7eoDeg==
X-Received: by 2002:a05:6a00:4612:b0:6db:c6a6:c9eb with SMTP id ko18-20020a056a00461200b006dbc6a6c9ebmr4409157pfb.1.1706010175173;
        Tue, 23 Jan 2024 03:42:55 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id c20-20020aa781d4000000b006d9a6a9992dsm11405182pfn.123.2024.01.23.03.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:42:54 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Kevin Hao <haokexin@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.7.y 5/5] ksmbd: Add missing set_freezable() for freezable kthread
Date: Tue, 23 Jan 2024 20:42:28 +0900
Message-Id: <20240123114228.205260-6-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123114228.205260-1-linkinjeon@kernel.org>
References: <20240123114228.205260-1-linkinjeon@kernel.org>
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
 fs/smb/server/connection.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 7977827c6541..09e1e7771592 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -284,6 +284,7 @@ int ksmbd_conn_handler_loop(void *p)
 		goto out;
 
 	conn->last_active = jiffies;
+	set_freezable();
 	while (ksmbd_conn_alive(conn)) {
 		if (try_to_freeze())
 			continue;
-- 
2.25.1


