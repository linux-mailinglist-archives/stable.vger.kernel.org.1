Return-Path: <stable+bounces-9076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA3F820A1D
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0791F21FB5
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C61D17C7;
	Sun, 31 Dec 2023 07:16:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1217C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28c7e30c83fso2094151a91.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006970; x=1704611770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40qIU5FLgZADy3JFmVpvJHKFWIbLQ+/Q6DOzUXFCLXk=;
        b=XxroA0bK7bWNyn/kpoVqpFXoM+ZBc27mOE1HgmHLZJoGe/VwTc18i81qiYV7Ac8uad
         6kILLyf7N0Et07RqEnuxhntQMUEw4WGnzDM2/e1r+mwXFD3yQ3l2vINgC7MyxOq4hjhn
         IWfWgDqI0oVH3LOP/nbHXors2e+MNJfD+0MSSyXDn2vJEQjt56T3duwA8MtdO25VmJFZ
         Jdx3jlBe0nq0wZtRBPEHPfndZ9oGRZoF5vs6P1zkqixoxFeSPoWRixJq9VfWhv6Syoeg
         wzq4nGTAkJDg6R7ZBiCrkkxY7gPuYFQnk24n8k3n43v8knFezo9voRtzJ9oeMig2wpSz
         FmwA==
X-Gm-Message-State: AOJu0YxSUdH3aB2KlRdVQFSh//wde4NGZYMsZwUI9smCiBnxrbkHdwn/
	84gJrFwT6qWVN8li0uOs6Hc=
X-Google-Smtp-Source: AGHT+IHqvzY/gZr4xBtK4TcIdPx+csEhMGV5BM+FGCVks5rV8lIXZA05POfMZUX4jx9S/uHVncopYw==
X-Received: by 2002:a05:6a00:23d6:b0:6d9:b75e:ddc3 with SMTP id g22-20020a056a0023d600b006d9b75eddc3mr4751632pfc.33.1704006970602;
        Sat, 30 Dec 2023 23:16:10 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:10 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 42/73] ksmbd: fix passing freed memory 'aux_payload_buf'
Date: Sun, 31 Dec 2023 16:13:01 +0900
Message-Id: <20231231071332.31724-43-linkinjeon@kernel.org>
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
 fs/smb/server/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f6055b1f1b1a..3c53f0e9b59a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6312,7 +6312,7 @@ int smb2_read(struct ksmbd_work *work)
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


