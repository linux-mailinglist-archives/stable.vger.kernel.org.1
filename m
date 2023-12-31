Return-Path: <stable+bounces-9100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19032820A36
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9511DB216D1
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E66C17C2;
	Sun, 31 Dec 2023 07:17:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E2817C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so3085701b3a.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007052; x=1704611852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM8RvxhNJQrXlefgQVgUNSlRNlYXu9tbhyk4flqYdmU=;
        b=Erv1q2VeiznWvAbNXplMn1YJgKwEkOu2CQHXBCuw8TT9LnyKaUHo3D0aEaQ6fpIs+D
         mYMPfmEIlXOazLSnz0zfrY5cc0pFyQGzsicT5B7USja/Ema6Q7Ug2Sw7QUbAjPdUYsXt
         MTvJrOC+rasls4grnyLBnr4W49gtVj1rlZo8R7wjia/Cz7czrGfji1H5FfrzE7VOIzFj
         46LnHto16Q7z00uaVokXlW7xFqEuw8FhiGOqTl0U6HCiSwzCm00ZBGJldlfNpBHTZv86
         jwbVRdaJ1mDkr4m7uA+JT3FJrFghwdGAE+q044knEKiZhKB6/eW5EhDDIMdFfQ7jc9nV
         +x0Q==
X-Gm-Message-State: AOJu0YxIamu2jD1Neh4qidun3RWOgoF2dSfV0kDB8ektZuxkDbgyfLgU
	25/6cWzKzwGl7KYfHJzw3rU=
X-Google-Smtp-Source: AGHT+IEg4T5qDms8SswGKpeb8nyQT2TZ7GvnyWrd/0wPH2s8YKrQYfXoAH8PhoWv4ZeVr7XsmQ8thg==
X-Received: by 2002:a05:6a20:f391:b0:194:ecb2:e78a with SMTP id qr17-20020a056a20f39100b00194ecb2e78amr15473604pzb.25.1704007052344;
        Sat, 30 Dec 2023 23:17:32 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:31 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 66/73] ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error
Date: Sun, 31 Dec 2023 16:13:25 +0900
Message-Id: <20231231071332.31724-67-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit cd80ce7e68f1624ac29cd0a6b057789d1236641e ]

ksmbd set ->op_state as OPLOCK_STATE_NONE on lease break ack error.
op_state of lease should not be updated because client can send lease
break ack again. This patch fix smb2.lease.breaking2 test failure.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ee2e921e6571..dbdb380e994e 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8235,7 +8235,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 		return;
 
 err_out:
-	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
 	atomic_dec(&opinfo->breaking_cnt);
 	wake_up_interruptible_all(&opinfo->oplock_brk);
-- 
2.25.1


