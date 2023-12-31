Return-Path: <stable+bounces-9106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC978820A3C
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E791F221BB
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4D417D3;
	Sun, 31 Dec 2023 07:17:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A817C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35fe9a6609eso57750835ab.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007071; x=1704611871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtJJoqoODOrJ2SsqaQZNwwPDBIiy5rOe8Vgj5B9wBTk=;
        b=GHKGHxOvDe1FUKcMcK6hYahT8X/Oot2FvX4xUWByAMoG6JlqHnymEErQ9/HpuoT0ay
         i1yxiA7rsMPKwNQetfbVPzZ+4Bu+vgcJ39hzoSNbj9GVfEe9d1M/cL36DVRYC236Nm4C
         jxHvsy/zjcYgmG7WglAdeB4RguySc6wUVRPCi4VSfug5U6qg6Ijf07pMP2+sf32Kvv/s
         HTM/cMNPQRrupUIE8PqzQ4uxamc4Y6vE2Jof3JD5+onxCewtTN/KzmUj6ybb8bbEsOk+
         aBdcDpb0ILC2ZBV+WmJ3SSdFQxrROYAR4A2/nhtKxTrsbwMQ/u64KRIRiU+k0AyWfnmP
         3BCg==
X-Gm-Message-State: AOJu0Yx4oZgI+992hDBVmfKn+/aTlLHYFe5LZ9G2PkrAX9jyKSCmV36l
	ANjhAyYcGH/XJnYySKh52t8=
X-Google-Smtp-Source: AGHT+IEUjWEWUy3Bigp7A+1SLWEPeIMBqHEciHc1sR9XofbOWu2mgp2DYHojO6S4bc23WPs5S63yUA==
X-Received: by 2002:a05:6e02:1d0c:b0:35f:c538:8aa7 with SMTP id i12-20020a056e021d0c00b0035fc5388aa7mr24363816ila.91.1704007071709;
        Sat, 30 Dec 2023 23:17:51 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:51 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 72/73] ksmbd: avoid duplicate opinfo_put() call on error of smb21_lease_break_ack()
Date: Sun, 31 Dec 2023 16:13:31 +0900
Message-Id: <20231231071332.31724-73-linkinjeon@kernel.org>
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

[ Upstream commit 658609d9a618d8881bf549b5893c0ba8fcff4526 ]

opinfo_put() could be called twice on error of smb21_lease_break_ack().
It will cause UAF issue if opinfo is referenced on other places.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 589441ea5491..c7e1f5d6eec7 100644
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


