Return-Path: <stable+bounces-15511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3C838DAD
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C8028A80F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AC15D75A;
	Tue, 23 Jan 2024 11:42:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9C4BAA8
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010165; cv=none; b=m9aoYfcWzjXjYM5nmQ7KeuAs0gtS1pe9vK+1G6tTB7hd9oNOeE4+DMO/96cPNQTppun9UsGwG9j1AhupkAObDaupn0N6Jm7O1M/hCFBx9yXxFabjSuaW/HttQYEoCpCekJCdmjij6U+40MuoSD+xWuiu40LD3SPUzAJ68csUNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010165; c=relaxed/simple;
	bh=1xlsO42Sv49UYC2FsbXKbaKfgSPOJfTr9mtfJZytU+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyBGWOmLBRHRfTOgj4BSiaW8BQTGuQIloQKOVuUdlJm2VG3VW0J0DtYg+aDpN4cty8M5SB6xXL34ShLGz879v4v98oatXdnDd7YgGYI/cqIRp36zloJ3ptdWfNp3/Wnis+i83fJk4TZ7wkAv4F2MvK+c3Lx/xnpF3ho2Jrua5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dd7c194bb2so285437b3a.0
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010163; x=1706614963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs7b96pUhLUlWK/njbc6LkFPrK5r0FYyDa2xtvOmctw=;
        b=rvbKBzMcJXlZbxKC0UK5jxqXsyoUyTdWOCYGLabt+qfM7+gRh7U3cV+cYqlJKyDzPR
         FI1FvDt2fgmEtHepAsn+Acmmvz1HU+JeR0N8kmOyIk1QexXfYG+m64T9iq0F6gWbZuta
         DDaml389BhGsFx4mZ7mxi3DXFyTOakbyb1pyG3Ea2hMX04E1PXhug1W8GDyavoj0FDck
         dwdNAyYVQuPSE/Yocr97lZQWkCSy7G2i1XQOaOn8Zi8GvuENAGtjbUuxCAHW0zWN3pdT
         l6+f98t+1imrYxOfRFOY7mqMMEYVQzlzMGZXEGzzQQ8dga6hzO9fNyctAiKwarBIMEkS
         LSXA==
X-Gm-Message-State: AOJu0YzKBNDg/BzxY7uwzpfiK2bFAgXJxOlCIgEGfDIDtTYkktmsIhsf
	5Q8KQehksICRTRqSuLdNJcb6VCieUAsIq1T/uG7Gd19ZTC9RWrbb
X-Google-Smtp-Source: AGHT+IH8z5GCvfg+D7WUb3sRr1O8GOhCmS1mKiPHGZfp5nfJkq8X8jomQcBLK4NIBKWaYe3md/5XTA==
X-Received: by 2002:a05:6a00:1ace:b0:6db:c577:67d6 with SMTP id f14-20020a056a001ace00b006dbc57767d6mr6872682pfv.0.1706010163320;
        Tue, 23 Jan 2024 03:42:43 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id c20-20020aa781d4000000b006d9a6a9992dsm11405182pfn.123.2024.01.23.03.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:42:42 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.7.y 1/5] ksmbd: set v2 lease version on lease upgrade
Date: Tue, 23 Jan 2024 20:42:24 +0900
Message-Id: <20240123114228.205260-2-linkinjeon@kernel.org>
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

[ Upstream commit bb05367a66a9990d2c561282f5620bb1dbe40c28 ]

If file opened with v2 lease is upgraded with v1 lease, smb server
should response v2 lease create context to client.
This patch fix smb2.lease.v2_epoch2 test failure.

This test case assumes the following scenario:
 1. smb2 create with v2 lease(R, LEASE1 key)
 2. smb server return smb2 create response with v2 lease context(R,
LEASE1 key, epoch + 1)
 3. smb2 create with v1 lease(RH, LEASE1 key)
 4. smb server return smb2 create response with v2 lease context(RH,
LEASE1 key, epoch + 2)

i.e. If same client(same lease key) try to open a file that is being
opened with v2 lease with v1 lease, smb server should return v2 lease.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/oplock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index e0eb7cb2a525..c58ff61cf7fd 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1036,6 +1036,7 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
 	lease2->duration = lease1->duration;
 	lease2->flags = lease1->flags;
 	lease2->epoch = lease1->epoch++;
+	lease2->version = lease1->version;
 }
 
 static int add_lease_global_list(struct oplock_info *opinfo)
-- 
2.25.1


