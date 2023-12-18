Return-Path: <stable+bounces-7708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAA08175E4
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBD7283EF1
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473385D750;
	Mon, 18 Dec 2023 15:39:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA63D549
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d2f1cecf89so10596055ad.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913975; x=1703518775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu6/jy6w/oDNbmSfRTEIKX/qSDDFVtr/UJzsduzgbio=;
        b=tmzhZpmLkZVLP01tmlf1k2o3VxBwRgnwoQYYnyaciqM4Nd8cKG50JpjhjspE/L0zpg
         InxxfPJIbTyn/6BcSNImV3X9EiwR0noTtjrC4+gFG2Y2703LKNkN+k1gNnrm9M4sD2H9
         +R50/21M9ti8dUEtHL6pmDb7HZ70cdXpdeA3E/ZzQuhZxTCEYHSy8bblPHUgqK9jPjTs
         6co85svmTq/AkT7DPmErOzLuMENPaqqAB4KJvAaf4Pt0qKnWDl2lnKxSFuHt6Uq3PWbX
         +amcf7D8wXU4jqX1D+r+qqOzPHAsW/2a0OZQtClkYVgMP5Od3Rw9GKVxxoDHv/U0sOQF
         nZPA==
X-Gm-Message-State: AOJu0YyOIzvIme6J1YX4540O6xp9Uu6+jCm9egS+uNmDpeBNktvohd7A
	90KO+eY5AjiSTCQVmtmtJHw=
X-Google-Smtp-Source: AGHT+IEw5ntMow3INS0feoxcfyAhRuIq54LhqxBfYfrr2Tk2M8eMIx4xd1Ie8uwYnHR5G0oG2Z9X8w==
X-Received: by 2002:a17:90a:aa17:b0:28a:b3d2:a63d with SMTP id k23-20020a17090aaa1700b0028ab3d2a63dmr4347132pjq.7.1702913975318;
        Mon, 18 Dec 2023 07:39:35 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:34 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Tom Rix <trix@redhat.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 079/154] ksmbd: remove unused is_char_allowed function
Date: Tue, 19 Dec 2023 00:33:39 +0900
Message-Id: <20231218153454.8090-80-linkinjeon@kernel.org>
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
 fs/ksmbd/unicode.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/fs/ksmbd/unicode.c b/fs/ksmbd/unicode.c
index a0db699ddafd..9ae676906ed3 100644
--- a/fs/ksmbd/unicode.c
+++ b/fs/ksmbd/unicode.c
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


