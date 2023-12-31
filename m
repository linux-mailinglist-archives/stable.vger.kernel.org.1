Return-Path: <stable+bounces-9127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F576820A51
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3955A28329E
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09D17C2;
	Sun, 31 Dec 2023 07:20:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5C417C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso6269773a12.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007243; x=1704612043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+r253Gtj87RIJRdPVPpTpI4YhJdVLydtc1MRAyRd11Q=;
        b=iJ6rd9oPTSSOxSP8JQ/5EKwIr6tb/XuNKum6drBLnch5kTBAt1m3A1FQrJVaOGtJ6A
         Y2PMSaHuJCRKrMupiB5IpoVTeC7ZKVXx+ICq7JojYnOEF62DCE/Uwci0K6NtlF9IrHzZ
         IDSShe/VFhfbHJaxjqmZePWYwvRwrSoU6ocsxNFUNoynMPLSoWAzy7gdC25QBEWTjzQh
         O+ankQAM40ttAmBaIK12iqjaR1yz2ITZSnxARovUfGqMuCTnfNpPV5QWlTE72TVRyTzG
         FOjHLfqwIx7/ei2lRr4hlmZIcrIWE0k5zlWSMviw8pWyzqahGm8Cpoxh3gf27BZZcxpM
         WJCw==
X-Gm-Message-State: AOJu0YxyQ1lhONIqPkhTSyVdpXfcy7UjZqFCeLSO72xSrlb8TeI74N+5
	5PKwawikx4mvQ1XCEgA77UVQCcHoa8A=
X-Google-Smtp-Source: AGHT+IHdZCsPfOJqxkbIFeNa22BFGH9MvzniBbGcPI4s7xh33fwYWnmknzzhDQNwP/jeHh/B/10BnQ==
X-Received: by 2002:a05:6a20:2448:b0:196:c7fb:fc4b with SMTP id t8-20020a056a20244800b00196c7fbfc4bmr1807426pzc.14.1704007243252;
        Sat, 30 Dec 2023 23:20:43 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:20:42 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 19/19] ksmbd: avoid duplicate opinfo_put() call on error of smb21_lease_break_ack()
Date: Sun, 31 Dec 2023 16:19:19 +0900
Message-Id: <20231231071919.32103-20-linkinjeon@kernel.org>
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

[ Upstream commit 658609d9a618d8881bf549b5893c0ba8fcff4526 ]

opinfo_put() could be called twice on error of smb21_lease_break_ack().
It will cause UAF issue if opinfo is referenced on other places.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index cbd5c5572217..fbd708bb4a5b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8219,6 +8219,11 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 			    le32_to_cpu(req->LeaseState));
 	}
 
+	if (ret < 0) {
+		rsp->hdr.Status = err;
+		goto err_out;
+	}
+
 	lease_state = lease->state;
 	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
@@ -8226,11 +8231,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	wake_up_interruptible_all(&opinfo->oplock_brk);
 	opinfo_put(opinfo);
 
-	if (ret < 0) {
-		rsp->hdr.Status = err;
-		goto err_out;
-	}
-
 	rsp->StructureSize = cpu_to_le16(36);
 	rsp->Reserved = 0;
 	rsp->Flags = 0;
-- 
2.25.1


