Return-Path: <stable+bounces-15509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76A1838DA8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7E71F231F5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB435EE7A;
	Tue, 23 Jan 2024 11:41:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB695D91B
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010064; cv=none; b=nLtXeGc0KipOyUo9Kpxho/JXJpTLgCtWougTeNNPrYzV+VnaKKp90Kdw1i1VB9eO1JIt1ZNqg+8p8kDaDBIviAuDgP7Jwdf5XggQUQ0+prWORYVr1ohj/MbIhzBCocQMjDxSPN566V4WReMXaIFo0UmyOTileI8H09gCBv99n7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010064; c=relaxed/simple;
	bh=tK6v9aORzX4ixcv0LSWjDn1VygpILM01+OlKHVyuh/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PtrM8+IDcLiIhaBMSogneJ+NXyjXhHXWka6GujO9lIoi0JHV6XzHtLazOT9T4ORW3dWmYVUppao2itajnPCY5lvhlTJwUshXbjksfzbJUgjMPBG8+zX5J+F1apfAD0sxf5W53S0/8y3P0Nj7rVZLLIh4pkPxEHGMn1lkiYfqUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bade847536so166599939f.0
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010059; x=1706614859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20gUQOJAZW0kG7Ci1YYJ0HN2QiW6jLcyMlXsRmSf2b8=;
        b=tCpzPnM/CJ81GT1mW1UZpEIeFtNLBYOhzmDdoKxPE8Fu/YbxyjC8kDE9bIeb9mjuEm
         krHk4G9BfCH75VbjxW+by1ayT7z1eXB4yw69h7kNftgfFP+e0VD8s09SX0WymZEMuVpD
         ontY2qqyjHr/r1kdEOndFqQrxtTTnE2p+IzDFSCk6yU/xvmaA/SfM7B/UFTiG+jR5GPD
         1orQPq0KF3T7+oJqkHmBPlDFCJmXDTIHaUsLeprpx2gU9SZO3ZZllJeJN5jCgy+efW2f
         Grc3G6gm2n86d5FMWj+RZFpK1tosRGq66uWmfuW/Q8AtSY2/Z58fzcLPI+IN5CfK0v4u
         HEwQ==
X-Gm-Message-State: AOJu0YwzLhY205O2DCFZrs24YN/FuD62/a/IHRmOdtc4acKpRxYH+cn6
	bBLedLs76CaSqnaB6KJaKXsIK02Vkse1etQJeq4HujvjcI1M6UJs
X-Google-Smtp-Source: AGHT+IHlkwLR/1joJJc7jFUyeuQUco5oe/S9Io0SAaC6l7WdPVOohh638Cl7RQG0nH/AE1cZP581tw==
X-Received: by 2002:a5e:dc43:0:b0:7bf:a59b:a69c with SMTP id s3-20020a5edc43000000b007bfa59ba69cmr806546iop.32.1706010059014;
        Tue, 23 Jan 2024 03:40:59 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id p15-20020a63c14f000000b005cfb6e7b0c7sm7543359pgi.39.2024.01.23.03.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:40:58 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Kevin Hao <haokexin@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 5/5] ksmbd: Add missing set_freezable() for freezable kthread
Date: Tue, 23 Jan 2024 20:40:31 +0900
Message-Id: <20240123114031.199004-6-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123114031.199004-1-linkinjeon@kernel.org>
References: <20240123114031.199004-1-linkinjeon@kernel.org>
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


