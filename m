Return-Path: <stable+bounces-9121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C92820A4B
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE991F221D8
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582EC17C2;
	Sun, 31 Dec 2023 07:20:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4BF185D
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6bcc78so3614653b6e.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007223; x=1704612023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swn25nqulvJeCX4oF16qdxlHyLNh/FVFz1Sh71v5MEY=;
        b=llYFBnTNvg7UKtWqBEQFxdB0UBL4mH8MOiId4F+SEhS01t+ys2ERwlMgSBN46EKpnW
         CW43vIZdA4YBPvaB9cNwU7Yvje/I57RUhpKrK5bsCDNVuxUSlxdqrJg45MCwRCUuAZRI
         tx8q3816d20+YFmhUXpx+A/jEhYM41g7ytaaWjMy0z0M8bBI0haj96Kbie6BhDJPmPX4
         h113WgCYXQyZaR4dY6jlJDCa7Nt0cCuogNOfg5fz0AwKA1bnbx9nk/NPG30k5Z7P0w23
         p45hHGDw148Xk/8Om50KEWChzLo7b+k4uKqyEDBSLZYUiERvcfIChHmPh5tk4IkorYp3
         nr1g==
X-Gm-Message-State: AOJu0YzCHyVgfuRs7iYGf5GtcstaGbfjqa6VrZ8SsY0NZm2FcyGgxwiS
	DlJ6OFkWxCfD+tIgk0Z65v8=
X-Google-Smtp-Source: AGHT+IHB0uFVh4mtJ8bZzxzZw4m1gztXwI2vUBNcFVZnYhXYYwepEDq3iZqV8CNJm1og5mMuxpqnFg==
X-Received: by 2002:a05:6808:150d:b0:3bb:e00c:2376 with SMTP id u13-20020a056808150d00b003bbe00c2376mr4722763oiw.7.1704007223240;
        Sat, 30 Dec 2023 23:20:23 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:20:22 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 13/19] ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error
Date: Sun, 31 Dec 2023 16:19:13 +0900
Message-Id: <20231231071919.32103-14-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071919.32103-1-linkinjeon@kernel.org>
References: <20231231071919.32103-1-linkinjeon@kernel.org>
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
index de71532651d9..5bff6746234d 100644
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


