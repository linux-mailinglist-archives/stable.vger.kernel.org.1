Return-Path: <stable+bounces-7649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A01817587
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB47AB20FC9
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170B71452;
	Mon, 18 Dec 2023 15:36:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6933D563
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3c394c1f4so4270305ad.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913785; x=1703518585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbsTuV6gpNdvfy+sLUEhpwcCRVdcXa4qkgHk+Gf97h8=;
        b=sHLu6+mtLxSDQke4fMmmp79ql0CVaU3B6wunnT32U3lj965zdfWV+2tU5eWsWg4lT9
         rvJ+QP29eylY/w2Fe3eAvzSgEe1wQAGwjHJI7TSTnIQ8PWtqNkwmE3Lyjbi/gLpTZyOx
         bHLYEEcRJSBgyhQwKOvcTztQrGSSN2VxFvh2FMiUv3hARwSnXM2pnNRK/2JaEJNh2ojj
         j7ZNg7RVQDQmqs6wIA9CAcLjDnZSswwxt7wpzB8rXLj3sPnuoy8CpJQ1ThLJLt1DLuaE
         eMPuaRyVrxt9vo/yJ8vavIOGKdPWcn/AyZ/sujXtFOesntPzr/OL9SZgkvRNSziHYmMD
         Sj1g==
X-Gm-Message-State: AOJu0Yzg9r9eQcrC6yVeE69GX/oYmmL2ZFlc8u2PkxE6aStNV1Kb2qG+
	e0Kg0nWDrnmr8t/sNNWI9kI=
X-Google-Smtp-Source: AGHT+IGQ0SORiSUJp/gbCwV1e7DCMQxxtHqI8BulyUWZxop8mOO2d0AcIvCyRemoOggP+xP0uehzwg==
X-Received: by 2002:a17:90a:7898:b0:28b:9ab8:a22c with SMTP id x24-20020a17090a789800b0028b9ab8a22cmr555597pjk.35.1702913784813;
        Mon, 18 Dec 2023 07:36:24 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:24 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 020/154] ksmbd: smbd: change the default maximum read/write, receive size
Date: Tue, 19 Dec 2023 00:32:40 +0900
Message-Id: <20231218153454.8090-21-linkinjeon@kernel.org>
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

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit 4d02c4fdc0e256b493f9a3b604c7ff18f0019f17 ]

Due to restriction that cannot handle multiple
buffer descriptor structures, decrease the maximum
read/write size for Windows clients.

And set the maximum fragmented receive size
in consideration of the receive queue size.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 5901c4a2ece1..7e85c2767cd0 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -1914,7 +1914,9 @@ static int smb_direct_prepare(struct ksmbd_transport *t)
 	st->max_send_size = min_t(int, st->max_send_size,
 				  le32_to_cpu(req->max_receive_size));
 	st->max_fragmented_send_size =
-			le32_to_cpu(req->max_fragmented_size);
+		le32_to_cpu(req->max_fragmented_size);
+	st->max_fragmented_recv_size =
+		(st->recv_credit_max * st->max_recv_size) / 2;
 
 	ret = smb_direct_send_negotiate_response(st, ret);
 out:
-- 
2.25.1


