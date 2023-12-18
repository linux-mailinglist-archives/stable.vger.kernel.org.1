Return-Path: <stable+bounces-7704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED1D8175E0
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EA71C2420C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691E95BFAB;
	Mon, 18 Dec 2023 15:39:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E65D74E
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cda3e35b26so433150a12.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913962; x=1703518762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vloPmXnhSpFX6WXn/NAo2DqgJZyutUe3GClxk3ALTM=;
        b=L0qwenqrLN0g/LvVk1WMr9KMRf6LQJl8KEZwaiLM+uKLo1X9ue1lYkZJ0iwz5k/6Ah
         o7dMyM/5ZQx13Q3RqCScEEwp7BXgevnS6R90tjZslK7P5v60pt0KAIJGyfkcJk+igAML
         ArifoQqqzrpZ53drnOHoctOODjg3kp/PoeTBwJ6pgSPH4z3NF+6SzHztC5qvMNBAT1UA
         KERDZX12zbLIobU/+8Qij/hSW9iFM26Niasasd1fk/Hjw2eKC0Uqxww+GP76jwy+oiH8
         ewEB0Gb0Q6Lr5d1leNDMoaJatHfEWXs/BGc4JtzK41F5+CTDusCQukyU42H+oAGAXl2N
         J3+A==
X-Gm-Message-State: AOJu0YzBSGjUoRafr0+yLPwCFstuhUw+9UhgAVT+DwHUALulhcGNrQSl
	iWT4xpK3fQKjt39OKBWch+U=
X-Google-Smtp-Source: AGHT+IGQ107ql1H9fzzFvqKAXX4gvW9p0j4UO+3I9rdj+9nXNOQMZySwq88guvSLqfusCDPktoK61Q==
X-Received: by 2002:a17:90a:5ac4:b0:28b:7d4f:3109 with SMTP id n62-20020a17090a5ac400b0028b7d4f3109mr674102pji.66.1702913962372;
        Mon, 18 Dec 2023 07:39:22 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:21 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Colin Ian King <colin.i.king@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 075/154] ksmbd: Fix spelling mistake "excceed" -> "exceeded"
Date: Tue, 19 Dec 2023 00:33:35 +0900
Message-Id: <20231218153454.8090-76-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 7a17c61ee3b2683c40090179c273f4701fca9677 ]

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 9ed669d58742..ccb978f48e41 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -312,7 +312,7 @@ int ksmbd_conn_handler_loop(void *p)
 			max_allowed_pdu_size = SMB3_MAX_MSGSIZE;
 
 		if (pdu_size > max_allowed_pdu_size) {
-			pr_err_ratelimited("PDU length(%u) excceed maximum allowed pdu size(%u) on connection(%d)\n",
+			pr_err_ratelimited("PDU length(%u) exceeded maximum allowed pdu size(%u) on connection(%d)\n",
 					pdu_size, max_allowed_pdu_size,
 					conn->status);
 			break;
-- 
2.25.1


