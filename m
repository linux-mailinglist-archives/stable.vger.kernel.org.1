Return-Path: <stable+bounces-7752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E0F81761B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542341F227AD
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB83740BC;
	Mon, 18 Dec 2023 15:41:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5737A74E0E
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c68da9d639so1293883a12.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914116; x=1703518916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93XB00lP/aVTboqr0CNft2oxcLDX92mBxA7mYMFoRYo=;
        b=U9xAu/ly7cldkZxCv80RXyoyyzJQYCbqKGrpyAQNb9YqoTMlUexkE+dFBsmx560lds
         F89hQ0TOvtYx6zVW7oqohpigeds461ZnrZ19Fd4l1Zi2szNPOrCsUYlpYs8INVHBUZyB
         KBYrJ8awuOC78BgaYEOIhVYkxb8ThbqvwCuSb964EUHaLHQyCOFMPEbxQZYZNdpc7uJw
         EXoSgDHcIeNi4ItI9Mm33RvFqWm/bJ+R0NbXvFZ7WGxmAd+kDWJ4BGN/RSfPY+L+zw0j
         1DYqg9hdPd4oZDGyQS2qxEt7eU+JjUGbBdDcG4rSJo1Se4RbcBULFJtGs3/j9vnAf/Ck
         2UEg==
X-Gm-Message-State: AOJu0YyGlfky/WyTLXq2VEJ85Br0F1qI8XtivOUjA7bR47YHDxmYccqm
	91kid09oXPcLaRuRArnX09o=
X-Google-Smtp-Source: AGHT+IHVHz6mvXdjfTgQ3bnlHHRoUkQMkQbftfzjcWOmB9HlR7eFzwjnd4WVZuGRCF4JLMYnuPS7MA==
X-Received: by 2002:a17:90a:9bc9:b0:28b:7f34:6b65 with SMTP id b9-20020a17090a9bc900b0028b7f346b65mr674567pjw.1.1702914116364;
        Mon, 18 Dec 2023 07:41:56 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:55 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Yang Li <yang.lee@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 123/154] ksmbd: Fix one kernel-doc comment
Date: Tue, 19 Dec 2023 00:34:23 +0900
Message-Id: <20231218153454.8090-124-linkinjeon@kernel.org>
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

[ Upstream commit bf26f1b4e0918f017775edfeacf6d867204b680b ]

Fix one kernel-doc comment to silence the warning:
fs/smb/server/smb2pdu.c:4160: warning: Excess function parameter 'infoclass_size' description in 'buffer_check_err'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 3eede04bdcb2..67eb41255903 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4154,7 +4154,6 @@ int smb2_query_dir(struct ksmbd_work *work)
  * @reqOutputBufferLength:	max buffer length expected in command response
  * @rsp:		query info response buffer contains output buffer length
  * @rsp_org:		base response buffer pointer in case of chained response
- * @infoclass_size:	query info class response buffer size
  *
  * Return:	0 on success, otherwise error
  */
-- 
2.25.1


