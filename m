Return-Path: <stable+bounces-8609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED8C81EE30
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790BD283895
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03D52C872;
	Wed, 27 Dec 2023 10:26:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2E2C878
	for <stable@vger.kernel.org>; Wed, 27 Dec 2023 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9b3a967dbso1929939b3a.1
        for <stable@vger.kernel.org>; Wed, 27 Dec 2023 02:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703672810; x=1704277610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTrI2LjaUmQpkhFvm46MUGMAd34wpXMPUGLlvRFc5Cs=;
        b=Ym8UhlZPSmaZu2QY/zq3zsqyuBQ7i+pZTTB93aloK6QdIf/2amrm0GoewO5DAySJyn
         GU+gSMd/fKPWy4NuGQgf0bR06PWsim+3X2ov3Xf27WAIJ9uqd7Nmi2CGdtpaq5lMQMdT
         9o8Tq5OTTMXNjxooMzB/xKlsSXDRRojqU+Rt+wi7xw4/CtIqiB8cwy+akl/s5jQ7WvjY
         QxJNfDu7WNhfTVc/M2PfUKHBrsOS7N+lwuoOn8DivRaUZuzGN5+s8PZVbMNW+BcdK4dl
         91+F4jIxAEeEpIrl5IQXR/msiJEIb86Peu9oP79PuK+li69XRSV6EkT1uVTY1Z0rfJyb
         GOIw==
X-Gm-Message-State: AOJu0YweCNKaJp3U/aKNszGRBBljcLvhJn/RiDWRIYsmHhEm1FlSzJ+0
	3KoOQ8RW8t5Ia14LidWnv3Y=
X-Google-Smtp-Source: AGHT+IHtMxiCLi4xZznV+2HIg2wwelGv7c9TMnn2hRcmI8A9lCBeJ8i4LnObnwvJRB6L39kfffVMEg==
X-Received: by 2002:a05:6a00:8e01:b0:6d9:b1da:6632 with SMTP id io1-20020a056a008e0100b006d9b1da6632mr6427621pfb.3.1703672809896;
        Wed, 27 Dec 2023 02:26:49 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id v21-20020a056a00149500b006d9cf4b56edsm3588419pfu.175.2023.12.27.02.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:26:49 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 5.15.y 7/8] ksmbd: avoid duplicate opinfo_put() call on error of smb21_lease_break_ack()
Date: Wed, 27 Dec 2023 19:26:04 +0900
Message-Id: <20231227102605.4766-8-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227102605.4766-1-linkinjeon@kernel.org>
References: <20231227102605.4766-1-linkinjeon@kernel.org>
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
 fs/ksmbd/smb2pdu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index c1dde4204366..e1c640ed7acc 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -8221,6 +8221,11 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
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
@@ -8228,11 +8233,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
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


