Return-Path: <stable+bounces-7657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97638175A5
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6731F21D8F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580D9760A4;
	Mon, 18 Dec 2023 15:36:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18177608F
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3536cd414so27060835ad.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913813; x=1703518613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zArVK97BwVbRkiyJCVVYYAnFvzjSELGdSTsQYMrRzVo=;
        b=BzQx5CNMb7F5BAJiRVgeQdGzVgfegjJ5kIxfKCkO4InVbFUN8l0r7SlGDKGtd6+iIN
         ABi4J6a+GondH2XwLEQ3hgfOkc413PBf+SRNDJjIRoUR7KtHeVcWoR44YV5PXuO2lfD/
         1+d8CWCZ5lpP9+XXLMOeRzvuyhKy7SaP7gd0cou+8GFiVCFIeAMZ64bWqR9FMbMnCmdY
         G1BMUciz93sjPTXZLphxZC79yfWxUxpI0Reh4lzpJMXuy6NAVXy4yg0ta89p5pzT8Kya
         rDj7zfZR/uLu35AfqtJBFeiSMuyQeNMQ8l2XsS7CG0OsJ4TaPNKgBxUY33300U27fq5D
         RT3Q==
X-Gm-Message-State: AOJu0Ywx5ICcXb/P5HRz1LIsAZ9dm0U5upnuX+zCrm7XX7gF5Z+fdY6N
	gppJWJKRf88A1QjAlMU0OMw=
X-Google-Smtp-Source: AGHT+IHJBdCR3UdDNTgv1AZcxYBWXIM1KZkNHhB8lZmRde41NHJlEJP9o6ssBv1Gq4X/yurxRWU8/w==
X-Received: by 2002:a17:90a:df8b:b0:28b:ab4d:6fd with SMTP id p11-20020a17090adf8b00b0028bab4d06fdmr305233pjv.46.1702913813022;
        Mon, 18 Dec 2023 07:36:53 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:52 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 028/154] ksmbd: Remove a redundant zeroing of memory
Date: Tue, 19 Dec 2023 00:32:48 +0900
Message-Id: <20231218153454.8090-29-linkinjeon@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 56b401fb0c506120f25c1b4feeb96d9117efe171 ]

fill_transform_hdr() has only one caller that already clears tr_buf (it is
kzalloc'ed).

So there is no need to clear it another time here.

Remove the superfluous memset() and add a comment to remind that the caller
must clear the buffer.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 2b32e90742e0..a5fc7b7fd590 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -8601,7 +8601,7 @@ static void fill_transform_hdr(void *tr_buf, char *old_buf, __le16 cipher_type)
 	struct smb2_hdr *hdr = smb2_get_msg(old_buf);
 	unsigned int orig_len = get_rfc1002_len(old_buf);
 
-	memset(tr_buf, 0, sizeof(struct smb2_transform_hdr) + 4);
+	/* tr_buf must be cleared by the caller */
 	tr_hdr->ProtocolId = SMB2_TRANSFORM_PROTO_NUM;
 	tr_hdr->OriginalMessageSize = cpu_to_le32(orig_len);
 	tr_hdr->Flags = cpu_to_le16(0x01);
-- 
2.25.1


