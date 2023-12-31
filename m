Return-Path: <stable+bounces-9046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112598209FF
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C332B282F32
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005617C7;
	Sun, 31 Dec 2023 07:14:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35C17D3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso5819665a12.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006867; x=1704611667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxeGwPlyuyJ9qSPFl7hzKFKA+0/SIFNuGv5XQnPmYpc=;
        b=FAGGDYHwsPAHHNXvDcInSHI1mlHZoHZdufe3Gdln3PYiVHQNY04g5ZkxTpFkkvjKIu
         QiurMSj9g+c0rAI56gMmdMsw/s09Io4JDxiUjZboWNpvNqNv4DT2WE4DvgcZHRPj4Do6
         fJ+Yohot+Kmzwxyd3iT48nMgso/uwvhuo+F+yGAvwB8RDB4l5ryPsF9tIimA3iM7QENt
         yk+aOTJ+YXvsXggM1pJaRdJLM0ubW+l+/oVvQTID4zb5Ua8MYXqys3m9JOPwSc0JH1i9
         RX777G/f53xEAxKDXnwzGUayAum2KTHs0J+iaJ6zs3jc1T6z4DKaRJOq1vbb2AWi0Vtk
         Bs0Q==
X-Gm-Message-State: AOJu0Yw140we3Q0pqZu4Y82uEBn4gc/dLZYdWQREFvrL8l0z6JVmYxan
	TOLOZnO22DTCvL+xmOr1p1M=
X-Google-Smtp-Source: AGHT+IH4nhFPg1WlmN961GO29D29JXP/iWOcwDOcDgVXDbjUJ4zIRCueYngTzxWKiQiT6BlUzWUIcg==
X-Received: by 2002:a05:6a20:4e16:b0:196:52a5:e2c9 with SMTP id gk22-20020a056a204e1600b0019652a5e2c9mr4348969pzb.40.1704006866880;
        Sat, 30 Dec 2023 23:14:26 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:26 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Tom Rix <trix@redhat.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 12/73] ksmbd: remove unused is_char_allowed function
Date: Sun, 31 Dec 2023 16:12:31 +0900
Message-Id: <20231231071332.31724-13-linkinjeon@kernel.org>
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

From: Tom Rix <trix@redhat.com>

[ Upstream commit 2824861773eb512b37547516d81ef78108032cb2 ]

clang with W=1 reports
fs/ksmbd/unicode.c:122:19: error: unused function
  'is_char_allowed' [-Werror,-Wunused-function]
static inline int is_char_allowed(char *ch)
                  ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/unicode.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/fs/smb/server/unicode.c b/fs/smb/server/unicode.c
index a0db699ddafd..9ae676906ed3 100644
--- a/fs/smb/server/unicode.c
+++ b/fs/smb/server/unicode.c
@@ -113,24 +113,6 @@ cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
 	goto out;
 }
 
-/*
- * is_char_allowed() - check for valid character
- * @ch:		input character to be checked
- *
- * Return:	1 if char is allowed, otherwise 0
- */
-static inline int is_char_allowed(char *ch)
-{
-	/* check for control chars, wildcards etc. */
-	if (!(*ch & 0x80) &&
-	    (*ch <= 0x1f ||
-	     *ch == '?' || *ch == '"' || *ch == '<' ||
-	     *ch == '>' || *ch == '|'))
-		return 0;
-
-	return 1;
-}
-
 /*
  * smb_from_utf16() - convert utf16le string to local charset
  * @to:		destination buffer
-- 
2.25.1


