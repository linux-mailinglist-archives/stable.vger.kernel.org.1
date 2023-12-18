Return-Path: <stable+bounces-7757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 462E4817620
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CEA21C21FC5
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705D474097;
	Mon, 18 Dec 2023 15:42:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D64574E11
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28b400f08a4so2110609a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914132; x=1703518932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSrp/9JT9TxjMEA4a6NajIUoLiRtbw5tmDZBJTwI/0E=;
        b=TU0Kqs7NIv4HZtICVRg6kxMQHsGu/reuJFC78urY2I1Imp9S3d2cORlqFiNhi4ADAs
         QyM97/GssJ/jdOCIGhHMNSF7PYzlKPCAsby9X3mPz3LYZRN/P0zg8v6jr2uXg0YtOivZ
         0u5y7Zca7am56n2x2QGXdZM5Of5J2Egp63coJOXSGpS+5UlUxSQwzEoSH+1RrFTZ7Ckq
         egXx+z+kNwGqAIU0speFOwi2siBLazx0dsYxmMQGhh6JUM7YrY4NFNTGP3h9o7sQ4sAh
         9BD93ybIQrxpFJuD7sA/itvTU/l2WQeExQPuR1vHIeq8suCfA3fo45qZUvnoPbZs919f
         q74Q==
X-Gm-Message-State: AOJu0YxW3Y5EqtWqtc1QP+VHgLJN72Z4uTTS4STEbUIi9k85lK933nq5
	wmuzRPxuMXqxCHXIbIwpKKw=
X-Google-Smtp-Source: AGHT+IE9cE/LRXypMUK6oZKPzBMmApKafi1NI2F+ZzwK/Im4AiATrflxhv5TBdINWFYkaEn7mv7M/Q==
X-Received: by 2002:a17:90a:c38e:b0:28b:8856:d983 with SMTP id h14-20020a17090ac38e00b0028b8856d983mr966589pjt.20.1702914132576;
        Mon, 18 Dec 2023 07:42:12 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:12 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 128/154] ksmbd: fix passing freed memory 'aux_payload_buf'
Date: Tue, 19 Dec 2023 00:34:28 +0900
Message-Id: <20231218153454.8090-129-linkinjeon@kernel.org>
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

[ Upstream commit 59d8d24f4610333560cf2e8fe3f44cafe30322eb ]

The patch e2b76ab8b5c9: "ksmbd: add support for read compound" leads
to the following Smatch static checker warning:

  fs/smb/server/smb2pdu.c:6329 smb2_read()
        warn: passing freed memory 'aux_payload_buf'

It doesn't matter that we're passing a freed variable because nbytes is
zero. This patch set "aux_payload_buf = NULL" to make smatch silence.

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index ef3878bb313b..26aa554a4f6c 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6314,7 +6314,7 @@ int smb2_read(struct ksmbd_work *work)
 						      aux_payload_buf,
 						      nbytes);
 		kvfree(aux_payload_buf);
-
+		aux_payload_buf = NULL;
 		nbytes = 0;
 		if (remain_bytes < 0) {
 			err = (int)remain_bytes;
-- 
2.25.1


