Return-Path: <stable+bounces-7783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A981763F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7041F2586F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AF042396;
	Mon, 18 Dec 2023 15:43:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771D5A84D
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28b4d7bf8bdso635040a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914220; x=1703519020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7U7pOlN+IJGSVFD3h/xelAeLHurxzyIq6k4XHLSYhI8=;
        b=CqD9By6Al19vlgvvJai4Yh4Yquy8xHNSxELxrtHhSyFpWsRmA7HAl6ENqHdhco3Fd2
         enaQkAEppl3RemCicEsknHa67SeyoP62+GHiJ/DL7rB9rD0uLR+xUuxBM5zCvOWFuLE0
         KahLaK4YXGZRQCn082rbrJ4fw5QSHR+Tp4LHGibskSESIC1iSc6Z0P3zU9nxM0HnpJxz
         xU3uUxbWa/+BG8jz4Byrt0CGxpiUTVfCMuVEY53yy0/pNXYIyngcQWOC8zCfTjFfzvNu
         GtGYxcxSYq3RpiHDAbqMKJO/FSM8Qza5iCC7H5iFqVzokVCJ3vTuMzW+Ygfn2wkN4gvG
         iMvA==
X-Gm-Message-State: AOJu0YzHNsVwGOxEbsaU4/CqocifK9Ib9QHXcwOEPN+HKXLiSZCf0HGl
	av//S3b+nG2Xtr7r/0e9fyI=
X-Google-Smtp-Source: AGHT+IFm13L3rljf6k5U4PenC1owQT0ISdnpiCJ1g2wuJqfXPmOXAjsaxS61Gq8inkaMYRSmIi4W3g==
X-Received: by 2002:a17:90a:bb06:b0:28b:94f3:39cb with SMTP id u6-20020a17090abb0600b0028b94f339cbmr664104pjr.45.1702914220700;
        Mon, 18 Dec 2023 07:43:40 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:43:40 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 154/154] ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error
Date: Tue, 19 Dec 2023 00:34:54 +0900
Message-Id: <20231218153454.8090-155-linkinjeon@kernel.org>
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

[ Upstream commit cd80ce7e68f1624ac29cd0a6b057789d1236641e ]

ksmbd set ->op_state as OPLOCK_STATE_NONE on lease break ack error.
op_state of lease should not be updated because client can send lease
break ack again. This patch fix smb2.lease.breaking2 test failure.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 2b990ed35fde..6db18a109022 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -8236,7 +8236,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 		return;
 
 err_out:
-	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
 	atomic_dec(&opinfo->breaking_cnt);
 	wake_up_interruptible_all(&opinfo->oplock_brk);
-- 
2.25.1


