Return-Path: <stable+bounces-7668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE0E8175AF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE3F1F21873
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B36842373;
	Mon, 18 Dec 2023 15:37:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18A498A0
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c21e185df5so2675390a12.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913847; x=1703518647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMyURJSdaSi0dwhR3eCUHPRtyLgPQGARWZ5DeehCVA8=;
        b=Kfc1swLcXj/T/+IkGv3Q+PzMI1LcyB3B4mjUndgwj+jI7TN6Qglykrmglgg7ytoYqq
         2HtSVrbRw+FZWDuxZfTl5ktPjcVIrPddMASy4QkrbZspWHxJdSzU/QuDMYkco9GXtcuX
         uhPaRVne4M1CA+xULpEwnP7ehZ+ipcLvUY5jy5aGKpl227voFIRwNqmZhpOtJG1dfbN8
         tTYsLeSY0qquGVtYVbr7PuepZM8ONYE8KEROKV/f8TrMS28Was2Fa0ys/3gTny8n7Wkb
         VjwIshVWj2EFP/tGtTzmNxO1PJRFdZX81065Fglujkrr0QjNp0PKGRJjXNsXO5Umgpwa
         Fe1g==
X-Gm-Message-State: AOJu0YyiIaiqv1GI2boLUjcY7xzM9hHSecvKFFBjLXC60CYYNC0CzO1F
	d5otDP7EyGDxQo6xRH75VrU=
X-Google-Smtp-Source: AGHT+IG3Y+a4PyUKnoViTXciW4uy2rx23Elf5qxq328mESfEqX5wfaasswcxCUEZt4Mtxcy8TFX/jg==
X-Received: by 2002:a17:90a:17e4:b0:28b:7b89:c65f with SMTP id q91-20020a17090a17e400b0028b7b89c65fmr937660pja.96.1702913846609;
        Mon, 18 Dec 2023 07:37:26 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:26 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 039/154] ksmbd: Fix some kernel-doc comments
Date: Tue, 19 Dec 2023 00:32:59 +0900
Message-Id: <20231218153454.8090-40-linkinjeon@kernel.org>
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

From: Yang Li <yang.lee@linux.alibaba.com>

[ Upstream commit 7820c6ee029548290b318e522eb2578516d05393 ]

Remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

fs/ksmbd/misc.c:30: warning: Function parameter or member 'str' not
described in 'match_pattern'
fs/ksmbd/misc.c:30: warning: Excess function parameter 'string'
description in 'match_pattern'
fs/ksmbd/misc.c:163: warning: Function parameter or member 'share' not
described in 'convert_to_nt_pathname'
fs/ksmbd/misc.c:163: warning: Function parameter or member 'path' not
described in 'convert_to_nt_pathname'
fs/ksmbd/misc.c:163: warning: Excess function parameter 'filename'
description in 'convert_to_nt_pathname'
fs/ksmbd/misc.c:163: warning: Excess function parameter 'sharepath'
description in 'convert_to_nt_pathname'
fs/ksmbd/misc.c:259: warning: Function parameter or member 'share' not
described in 'convert_to_unix_name'
fs/ksmbd/misc.c:259: warning: Function parameter or member 'name' not
described in 'convert_to_unix_name'
fs/ksmbd/misc.c:259: warning: Excess function parameter 'path'
description in 'convert_to_unix_name'
fs/ksmbd/misc.c:259: warning: Excess function parameter 'tid'
description in 'convert_to_unix_name'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/misc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/misc.c b/fs/ksmbd/misc.c
index 1e2076a53bed..df991107ad2c 100644
--- a/fs/ksmbd/misc.c
+++ b/fs/ksmbd/misc.c
@@ -20,7 +20,7 @@
  * wildcard '*' and '?'
  * TODO : implement consideration about DOS_DOT, DOS_QM and DOS_STAR
  *
- * @string:	string to compare with a pattern
+ * @str:	string to compare with a pattern
  * @len:	string length
  * @pattern:	pattern string which might include wildcard '*' and '?'
  *
@@ -152,8 +152,8 @@ int parse_stream_name(char *filename, char **stream_name, int *s_type)
 /**
  * convert_to_nt_pathname() - extract and return windows path string
  *      whose share directory prefix was removed from file path
- * @filename : unix filename
- * @sharepath: share path string
+ * @share: ksmbd_share_config pointer
+ * @path: path to report
  *
  * Return : windows path string or error
  */
@@ -250,8 +250,8 @@ char *ksmbd_extract_sharename(char *treename)
 
 /**
  * convert_to_unix_name() - convert windows name to unix format
- * @path:	name to be converted
- * @tid:	tree id of mathing share
+ * @share:	ksmbd_share_config pointer
+ * @name:	file name that is relative to share
  *
  * Return:	converted name on success, otherwise NULL
  */
-- 
2.25.1


