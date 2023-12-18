Return-Path: <stable+bounces-7742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57163817611
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A156B2417B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3002B740A0;
	Mon, 18 Dec 2023 15:41:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5C49899
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cda24a77e0so453853a12.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914085; x=1703518885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9XRZ9UpJml0bjq7Jm6A1tz7gEr1BkH711U2PVBGxq8=;
        b=pvuFwzdJAB1H9WWwriOnhxTiv7WOLmHjgwR1kom4vCsP225q3QkuBXo2DQ928E/dDi
         U12kqYaLhpYN0bY8649E4Uy7uqUtrmuoC1iVOnXeoQBuVRjGvq1dD8ZLhlwab3p/dY40
         uUHM287AlIXUXgnNkRNRkEdh9lQAZ2qKO0O/zWd4eIMRnl6eNpE5bqWMxMSX8cEN/Fa7
         hwTb7R2jgVMT5SgRdT6s0SwD9iiYCbHruz0fFPc/YHoCbeCZQp/JIOi22i0fcmv9rVXr
         kq5whGGvBrvEx55E9qy+y7YC0rJfrfcEDtzuSiKnlepDChZSkcE7eCM4yyyb6pWRq3Jk
         CRGQ==
X-Gm-Message-State: AOJu0YwvpT+B4A5GfbXZFJvV+lr9cT/aG5qeaNpFLIHPCu1bsZq31dOP
	c2FflZfDY2USJ+/HGPdv1ZVrfkn3dxwjqA==
X-Google-Smtp-Source: AGHT+IHmhlJD6LT70nPUVBhvjySWn0t++cpxAG72oC+rMxKW1tNhW4au/BpzrMtzIGBp1MYgMKnlFg==
X-Received: by 2002:a17:90b:4a41:b0:28b:228b:9bb1 with SMTP id lb1-20020a17090b4a4100b0028b228b9bb1mr2366112pjb.16.1702914084661;
        Mon, 18 Dec 2023 07:41:24 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:23 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 113/154] ksmbd: Replace one-element array with flexible-array member
Date: Tue, 19 Dec 2023 00:34:13 +0900
Message-Id: <20231218153454.8090-114-linkinjeon@kernel.org>
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

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit 11d5e2061e973a8d4ff2b95a114b4b8ef8652633 ]

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element array with flexible-array
member in struct smb_negotiate_req.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/317
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index e4a1eb6f8da3..1db027e730e9 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -247,7 +247,7 @@ struct smb_hdr {
 struct smb_negotiate_req {
 	struct smb_hdr hdr;     /* wct = 0 */
 	__le16 ByteCount;
-	unsigned char DialectsArray[1];
+	unsigned char DialectsArray[];
 } __packed;
 
 struct smb_negotiate_rsp {
-- 
2.25.1


