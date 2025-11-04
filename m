Return-Path: <stable+bounces-192349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12D9C306B1
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 11:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723CB3BEBE1
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 10:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E402D2391;
	Tue,  4 Nov 2025 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5tN53Oa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792227E04C
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250561; cv=none; b=tACRAnSwYCNR5DNvW1v3iyVDxjHLdHLTMhofX8zLSYntrINjlXgloiU55Cse16IG3sfHy3GrzFUjaKMyqVHoaJu1crd44hDaQfblYOx+aQ9ZbQoYU+u81tjuTg+FpMS0AbRhtsNMxxogtX4htjHUWANp5ffwNRsn34niXu2u3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250561; c=relaxed/simple;
	bh=yCNhQ4a0Nk0Atx6Dr4wxtJ0ZtyqyLGT9ZWpCeh0ba7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iazkNzbTryZ3I2FuiJvhO1Wf5MsrLI89H8DL5pLFjKlPY6FH1UgxfBXRdL6PpvGkOujvX9fvqOfmKE1+F0pAuPwqS4Msh5JXv3ldgy8MPBZsbIaaRNYy3JleWyUdUmXp1+VehBqp552dhJj+6bmQIGpA36f6uzwYXhPfBFlZvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5tN53Oa; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781257bd4e2so527631b3a.3
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762250560; x=1762855360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKUczaa/kE48HAcaJ5lE+YSGWpwTs3a+tEo/Ya98+Oc=;
        b=D5tN53OaRuyeglcFxL5EUp9JH5+woey2uNXC69Y9bCUXJKHlY+yoJTnqRRkxqxG8OE
         iAD8moga/VOQHOB+GG/HdmilyBf5yF6rKgbSPSpNTB6xFH+XQtn0dXbVml5Q6pI7pnLF
         f3GuSYRJz4Lz5KIX6sNuVNaw+w0Ir3omZrg0a0z6xBo5Ha7iBzBdthBkuGd/L+++RYSZ
         AQG7ydVa5zFRGjwlWhkFHy+8T+KXThIzaN/wl+xbtLiuhmGEawR8aE4h3D0xcMEIPmIO
         wjaJEMcdrN+SpB0i05iJVOGsP87qZm7EUH0hyWLpm9qGIkzJZeiaLVZVVkUJ8J5l+yeK
         CcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250560; x=1762855360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKUczaa/kE48HAcaJ5lE+YSGWpwTs3a+tEo/Ya98+Oc=;
        b=vb7GA3RHmoLQOn98D8E12Fiy9ItbPCQpCEawfw7xfBmakeITY4b4PNAztrEDGo55Ui
         ecOparGjEEu6uwOg9L1lVuc7YJNyF0BFMARTzPss2vRSn80K38v+HhfyhwacUmUiUtr5
         cIKn59Trj5FKkmz6RX9jkhr0crn+eMKL0UMnGVT/2XqFzuNq7kp+xjIXxFbpStus97ok
         OjfA7SlN4nMKLWlBp8c+3YFjsL19W0w8hXz8l7Ql2qRVsPaPYPzSojPLxh1FopfGwfIq
         4ejt/q0bBQR6uTrd6ADgj+ZeBfxb0ZuG1HvPTONhkBurfUPPk1tCC0DTHttfv+0lgaem
         NoXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCuJwapbw9d8SGOOt1BtLHueLDS7tGuP6uSb5JEyF7eYD2wyZ+EkJzm3Fvd2EwP9Xt5uK7iAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHF6XrLf7+3DmP08wpqBLxlvziToPa/DmP8oAFVAEiPXUYMVSA
	bfJUxT+Vlhj2fWyHXnw33/AMwAJHtT0mfw8YYxzMAJOHV0Q1Ydcv6dAo
X-Gm-Gg: ASbGncvY6A1TLf5NCW2zPY54JS6dX99clRL+3lRhp4dUOWBRxWUnGmBXzE8ISo5H9gm
	RbkgfKGKAPVqVv/mm8GW2gNLwPTbVH2vPCmEyTU5wRbS34kSwBNDbTYMO8ZFhEcF8GbhzKJYcvv
	ZA0t/QDeMMfc5e/s1iSIaHP34NDPlsEEHEylC69hdMXkKPrr2tFjhX7dqqLPI9VOPLwoWyk5Axi
	u/0lvrHWUVFAUOor4GcKptmZrkt8onhf442dWACa0Jnrf8iARVxLSElM3rvDsBa7Y/6ZfbQ8FuE
	94LQjpzopmVfYKYuxbzj1/p4xMWLbnBtZ4MTfinQH36+0hSg7201VbM95ZI+XAgOuKx9rGmNRJ9
	xBVTnvxfKnoct3K6odmSuFafn2Cibyw4SmrhYDWIBFMSI/ytLY/9oE50r5DfAKuBfOq8zQ8XFK+
	aCJTjLXv1K1gFsbcQbelKqmwZ7XSmt9QefoacQCzmFUaN0Ctth8//+73aVk1rU4A==
X-Google-Smtp-Source: AGHT+IHzZl8VphinmdMmMvPC0WokEYLtw7S69vIs4r7/r21McshU2hbf8BusSI4N7lrxKocgxktcKg==
X-Received: by 2002:a05:6a00:bd81:b0:7a2:86c0:d620 with SMTP id d2e1a72fcca58-7a776aa9755mr9961731b3a.1.1762250559692;
        Tue, 04 Nov 2025 02:02:39 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd682163csm2319057b3a.61.2025.11.04.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:02:39 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: harm0niakwer@gmail.com
Cc: Qianchang Zhao <pioooooooooip@gmail.com>,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix leak of transform buffer on encrypt_resp() failure
Date: Tue,  4 Nov 2025 19:02:20 +0900
Message-Id: <20251104100220.343844-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When encrypt_resp() fails at the send path, we only set
STATUS_DATA_ERROR but leave the transform buffer allocated (work->tr_buf
in this tree). Repeating this path leaks kernel memory and can lead to
OOM (DoS) when encryption is required.

Reproduced on: Linux v6.18-rc2 (self-built test kernel)

Fix by freeing the transform buffer and forcing plaintext error reply.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/server.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 7b01c7589..15dd13e76 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -246,11 +246,11 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 		rc = conn->ops->encrypt_resp(work);
 		if (rc < 0) {
 			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
-			 work->encrypted = false;
-    			 	if (work->tr_buf) {
-            				kvfree(work->tr_buf);
-            				work->tr_buf = NULL;
-       			   	}
+			work->encrypted = false;
+			if (work->tr_buf) {
+				kvfree(work->tr_buf);
+				work->tr_buf = NULL;
+			}
 		}
 	}
 	if (work->sess)
-- 
2.34.1


