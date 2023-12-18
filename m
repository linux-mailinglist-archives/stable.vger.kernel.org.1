Return-Path: <stable+bounces-7642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F207817569
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B6C1F24B10
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA0A42378;
	Mon, 18 Dec 2023 15:36:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF283D54D
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28abb389323so1222999a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913760; x=1703518560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9WSeyQ+k1+ckl2mxUz6Az/thabrbly21F9J8GRtlgc=;
        b=rh6wYVHAe1Z9h7AH1G0gynaDQSUujSzcLeMq/uYkRaEtO17EhpvihmVWwjrnej6ydO
         Y/SmKDR9JbFKXLvYap+FL0DGPsbL+vBs0OMRJLqZ/nVHOY59AR/1HovueyRxgl4N8DNv
         6wd7ug6QGLw6DqvGxTX6qPA5kv5WhsMcoUP13e039Gu1eawmPKRo+iPhptmhaz7Ah8pJ
         rWqb5LAG5prRR8GjlDlEjiUplEeQ/ySsty1pDFzgrcYhR7+JneM/hQ3twWoP88AOQFor
         zzcNR0kL3vcSxKAWAd8S+2ftdzLb4acCDjtvQPrP1yPf8Ndx0zGpwOi/2BAwEDN11tvX
         Rcgg==
X-Gm-Message-State: AOJu0YxVXSwzDDmS0159UXyQ1vYHtz7aO+THcWbJ7s1gUlWy2VzrFjKj
	FITwR8PmOP+OjpUaFzPHsbs=
X-Google-Smtp-Source: AGHT+IHel8zLCST+zPboUptCgocE+bAQB4IOvy3Ja7oaEXvOIhpbLMG7HhC4wkMyzO9KV0GA5CvvyA==
X-Received: by 2002:a17:90a:d102:b0:28a:fc:5cda with SMTP id l2-20020a17090ad10200b0028a00fc5cdamr7003365pju.89.1702913760122;
        Mon, 18 Dec 2023 07:36:00 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:59 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 013/154] ksmbd: Fix smb2_set_info_file() kernel-doc comment
Date: Tue, 19 Dec 2023 00:32:33 +0900
Message-Id: <20231218153454.8090-14-linkinjeon@kernel.org>
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

[ Upstream commit 4bfd9eed15e163969156e976c62db5ef423e5b0f ]

Fix argument list that the kdoc format and script verified in
smb2_set_info_file().

The warnings were found by running scripts/kernel-doc, which is
caused by using 'make W=1'.
fs/ksmbd/smb2pdu.c:5862: warning: Function parameter or member 'req' not
described in 'smb2_set_info_file'
fs/ksmbd/smb2pdu.c:5862: warning: Excess function parameter 'info_class'
description in 'smb2_set_info_file'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 9496e268e3af ("ksmbd: add request buffer validation in smb2_set_info")
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 0edb0a96766d..3118ef0aae50 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5932,7 +5932,7 @@ static int set_file_mode_info(struct ksmbd_file *fp,
  * smb2_set_info_file() - handler for smb2 set info command
  * @work:	smb work containing set info command buffer
  * @fp:		ksmbd_file pointer
- * @info_class:	smb2 set info class
+ * @req:	request buffer pointer
  * @share:	ksmbd_share_config pointer
  *
  * Return:	0 on success, otherwise error
-- 
2.25.1


