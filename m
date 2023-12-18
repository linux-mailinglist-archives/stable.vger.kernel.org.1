Return-Path: <stable+bounces-7644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3279D817577
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574931C2484F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768543D540;
	Mon, 18 Dec 2023 15:36:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB013D566
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28abb389323so1223205a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913767; x=1703518567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErJnLM8vEOxyZwmk0smnakioT0Ug3HWM7bvuILbfi9w=;
        b=kdpiUEUUG+7Yk3hGuJtx6DYwW14wm7wJH+y+Eac/Bn7NAOl1uXs9UYktGJB19/umhd
         s+3AlYWYn6iKuEOktwjJCsyX569XBizHb8t4gFyQWIyUnxzNh5/S7KfqLBhFqmfI8OJ8
         F/QYkSwJI1jj2vKf9N3XizZfPWIE1ROw6jCGhpZua23kxq0VghkMEO0GljkPhjnKdvaL
         y9tHU+PvawV6aKuk2F6ES2FkVE0vLDJWhFLl6IacnjJ8PjeLF5mjjQD9DYG+RGN7oFng
         sQP44IrPTWgsnSLWmupg3dFwlsZZg4Z87M4rRpb2OL3PplGiiPUZjmR+OC29XP4W2uZ3
         oeAg==
X-Gm-Message-State: AOJu0Yx4luB0IyA88j55uo6AsQcL5Q5Rx3Lz6ZrU+G6mHXaDKlgjf6Es
	pR2+l5I63CX8hgBYKgx0tXQ=
X-Google-Smtp-Source: AGHT+IHu4tAGQooN3U79IBno9BbUf0fuSA5WJq753gYi46wnJDTAwyhfmfxyc7A6BAu0sMuzpByM+A==
X-Received: by 2002:a17:90a:34c8:b0:28b:328a:3b36 with SMTP id m8-20020a17090a34c800b0028b328a3b36mr1801164pjf.25.1702913766975;
        Mon, 18 Dec 2023 07:36:06 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:06 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 015/154] ksmbd: Fix smb2_get_name() kernel-doc comment
Date: Tue, 19 Dec 2023 00:32:35 +0900
Message-Id: <20231218153454.8090-16-linkinjeon@kernel.org>
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

[ Upstream commit d4eeb82674acadf789277b577986e8e7d3faf695 ]

Remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.
fs/ksmbd/smb2pdu.c:623: warning: Function parameter or member
'local_nls' not described in 'smb2_get_name'
fs/ksmbd/smb2pdu.c:623: warning: Excess function parameter 'nls_table'
description in 'smb2_get_name'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 5980b625a0f9..7b7b620d2d66 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -653,7 +653,7 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
  * smb2_get_name() - get filename string from on the wire smb format
  * @src:	source buffer
  * @maxlen:	maxlen of source string
- * @nls_table:	nls_table pointer
+ * @local_nls:	nls_table pointer
  *
  * Return:      matching converted filename on success, otherwise error ptr
  */
-- 
2.25.1


