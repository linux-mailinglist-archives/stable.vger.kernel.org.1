Return-Path: <stable+bounces-7688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D68175CA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244751C22CF9
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3967442396;
	Mon, 18 Dec 2023 15:38:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A35BF84
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so2610848a12.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913913; x=1703518713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLa+1OwL1+Q6+SovD872EqK6LzeLnCWXezcr3EToZhQ=;
        b=iyQUFGBITB831C+MgqYIsiDK5pReXs17V+A/dlrWSsxqiW15TlU16FZoZAa0pDcMGP
         b5sPwCLaDJ2Ntp64MvrVOPcMFSatuDD89MNGgRKPtr1/tXWBjmymeG3Mr5r+TEbw3umv
         sgL3pEVROmXEu3xX6xuukk8XkUT505wEiQVrZi06IhneiNgHGVUmvovsP8GWngAeszfr
         t0Y6Lvn5jJQhQKhSr47l3z+eSroI2sxPPLEtLmgUlNOzHxx6+/PmT3bZKpUNahmvktS1
         j6AWM+X+dd+HBggvpMELZqR26zGlaJ1IkGnDQgEeQ7LWHC4SDGZt5Q34NexPE8UTc8wS
         hteA==
X-Gm-Message-State: AOJu0YxbtpZfCEHNfczqLsuC/C/tRmiYLYQb3ZmlyO3hNXnHParW8C6x
	fhW37BEFNkcEdf4mxbBw8RMg1T57Tjw=
X-Google-Smtp-Source: AGHT+IEiSWmEscDPbRNX3dwM5TnJGhxIXy792mNTGCwl7w3lZ2l9bdV7ifDsNPAZqcpCgwScpUYkhg==
X-Received: by 2002:a17:90a:c20b:b0:28b:9662:e849 with SMTP id e11-20020a17090ac20b00b0028b9662e849mr799779pjt.86.1702913913302;
        Mon, 18 Dec 2023 07:38:33 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:32 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Tom Talpey <tom@talpey.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 059/154] ksmbd: reduce server smbdirect max send/receive segment sizes
Date: Tue, 19 Dec 2023 00:33:19 +0900
Message-Id: <20231218153454.8090-60-linkinjeon@kernel.org>
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

From: Tom Talpey <tom@talpey.com>

[ Upstream commit 78af146e109bef5b3c411964141c6f8adbccd3b0 ]

Reduce ksmbd smbdirect max segment send and receive size to 1364
to match protocol norms. Larger buffers are unnecessary and add
significant memory overhead.

Signed-off-by: Tom Talpey <tom@talpey.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index ef4891b54447..652391aee733 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -62,13 +62,13 @@ static int smb_direct_receive_credit_max = 255;
 static int smb_direct_send_credit_target = 255;
 
 /* The maximum single message size can be sent to remote peer */
-static int smb_direct_max_send_size = 8192;
+static int smb_direct_max_send_size = 1364;
 
 /*  The maximum fragmented upper-layer payload receive size supported */
 static int smb_direct_max_fragmented_recv_size = 1024 * 1024;
 
 /*  The maximum single-message size which can be received */
-static int smb_direct_max_receive_size = 8192;
+static int smb_direct_max_receive_size = 1364;
 
 static int smb_direct_max_read_write_size = SMBD_DEFAULT_IOSIZE;
 
-- 
2.25.1


