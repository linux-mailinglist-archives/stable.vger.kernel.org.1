Return-Path: <stable+bounces-7669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4E28175B1
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD4D1C234F3
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8073C4FF88;
	Mon, 18 Dec 2023 15:37:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B44FF7B
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28b3dd5b242so1234835a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913851; x=1703518651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kk+3PVMukCCMFpnJmYozjWMqwdLAxYlwVR9Xl0F4cEg=;
        b=VPjUGuUc5W6aL+f/uCbQ+HmyX9biI2vwY97hknurj99MdO0/m1+426rGDdbjC3kFh7
         EGeOL5LnUb9nR6JHOE4kKbwf9DM5iw6WWjVqVuJasMFbZ2XWXeY6fnJTeV9nl6Ik8JLo
         8HIkSknHVs+92eQ/kVaTqKMeC/gv30r/U0nxkjCPC1MGYY1o5i7/ULcO3qK4Hc+211+p
         Hc7E7GsYQl5Os39KDJBfiHWWd8Ch5j+gjhyr7T6ENnsP2OqC+ccvPBcGSa3NKpHyGWLw
         YQxxLcwZn0OqwNhRDWpZ3Nytq9TPL/32B8femfbHuu/drfdlnZHRGXHLbWBfen871K0s
         M/3g==
X-Gm-Message-State: AOJu0YwaxEv+Cjy+9KCTblY5IXzZ+jfmhdzo+I/MZYzvNLy+soeEq2TC
	F7T188Ovv9ZJLuPEXNrzGQc=
X-Google-Smtp-Source: AGHT+IFDfw7nIH+h0uwMEFCrnpiSutG91h2YNAqw9CjpixuIaNQWYt3HpT8tIJXjxvHik2jQEr0efg==
X-Received: by 2002:a17:90a:a785:b0:28a:d063:3051 with SMTP id f5-20020a17090aa78500b0028ad0633051mr4716968pjq.92.1702913850887;
        Mon, 18 Dec 2023 07:37:30 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:30 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Yufan Chen <wiz.chen@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 040/154] ksmbd: smbd: fix connection dropped issue
Date: Tue, 19 Dec 2023 00:33:00 +0900
Message-Id: <20231218153454.8090-41-linkinjeon@kernel.org>
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

[ Upstream commit 5366afc4065075a4456941fbd51c33604d631ee5 ]

When there are bursty connection requests,
RDMA connection event handler is deferred and
Negotiation requests are received even if
connection status is NEW.

To handle it, set the status to CONNECTED
if Negotiation requests are received.

Reported-by: Yufan Chen <wiz.chen@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Tested-by: Yufan Chen <wiz.chen@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index f36c7626af0c..6c127fabdc56 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -576,6 +576,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		}
 		t->negotiation_requested = true;
 		t->full_packet_received = true;
+		t->status = SMB_DIRECT_CS_CONNECTED;
 		enqueue_reassembly(t, recvmsg, 0);
 		wake_up_interruptible(&t->wait_status);
 		break;
-- 
2.25.1


