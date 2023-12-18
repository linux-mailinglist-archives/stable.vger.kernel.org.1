Return-Path: <stable+bounces-7784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5E681764D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07AF1C239F7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B23A1D4;
	Mon, 18 Dec 2023 15:48:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4943D545
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5918f11099dso2234086eaf.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914492; x=1703519292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1U3CSXQf9qkb23vvdhLDGdeM4Fzvx/XLSFSHMr5SEoo=;
        b=nUeR08ZJzEYhcAMv7it7uoQNbp5G49tKQ177eR1HSwfjKKeRCyN7Lq98sdKSmIJgfy
         6ILb4FwMonvYbGUCCKsJ2cFHbLF7U+S1mT20MlZX1I1wB2NNdqXM/Qg3r1aRhIa7+HBN
         cQUTYcxIbpEXp9Uzv61XHtXjIGy4fakAhNk87g/6xnW0Ac84QrIdEK8TtUGAJ6l0hbam
         cK8unryfJyqoQfCjuFwRzRHwzYY5nCsBYMCRYqX55VQwkIL0tgODhZhB1CwTAC3QvI8A
         HMkueX9uy7uQLmN23/xwNZbSmSk7G6SH/4eZvbjww6uoYznkdFdlQf1Zl7vb2bLfzEkC
         z7Pw==
X-Gm-Message-State: AOJu0YxHiJmEEPHRy4jUewHEwFPajur/dla6Sm9jq+IL3RlRCfY0q3qt
	AQECU8sV79+YwzcP9rMi4XSwyIWLjjs=
X-Google-Smtp-Source: AGHT+IF1iglVUHnF7Gqrp+bI+RqcKq9iX37ukAMTWgsnqtTlRpZ2m9At86fcklV8Rol6KaNkzVj4yA==
X-Received: by 2002:a17:90a:3043:b0:28b:79b8:7fe with SMTP id q3-20020a17090a304300b0028b79b807femr1118980pjl.27.1702914009980;
        Mon, 18 Dec 2023 07:40:09 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:09 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 090/154] ksmbd: block asynchronous requests when making a delay on session setup
Date: Tue, 19 Dec 2023 00:33:50 +0900
Message-Id: <20231218153454.8090-91-linkinjeon@kernel.org>
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

[ Upstream commit b096d97f47326b1e2dbdef1c91fab69ffda54d17 ]

ksmbd make a delay of 5 seconds on session setup to avoid dictionary
attacks. But the 5 seconds delay can be bypassed by using asynchronous
requests. This patch block all requests on current connection when
making a delay on sesstion setup failure.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-20482
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 2ebd252894de..29c951c29279 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1877,8 +1877,11 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 			sess->last_active = jiffies;
 			sess->state = SMB2_SESSION_EXPIRED;
-			if (try_delay)
+			if (try_delay) {
+				ksmbd_conn_set_need_reconnect(conn);
 				ssleep(5);
+				ksmbd_conn_set_need_negotiate(conn);
+			}
 		}
 	}
 
-- 
2.25.1


