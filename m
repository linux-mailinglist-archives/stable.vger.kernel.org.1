Return-Path: <stable+bounces-7691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F5A8175CD
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FF51C24EB5
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDB45BFA5;
	Mon, 18 Dec 2023 15:38:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006425BF82
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28b6ea19368so1400147a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913922; x=1703518722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te4Gp0tAiSU/C0sdGelpPRB/XRJ/0rOzaK4MwZyHy+o=;
        b=LP20CYuR5EMLKKyvGC+SWVigre2dYEzfrHSmSZ3OSuFe5Yh9LD4XvCP+gL/iTPXHge
         /E73EwQtayh6a9coj1FrCA1kp8Z510H95yHpAiI+ifCEHwatttioKv55zQFY/jAPwBOV
         EcftWUVcsjEfBXVogDWWtNZnJgbhE5kChPc1piG2T17V3thuXO/DE+CCX4EuPU3EQHVF
         skEC4Y2XRoFD126RfS/tBgp46wR9MEm63s+erfiCRLe0yqFP6bmgs/6w2IqpyNGuNPei
         5DXB16hnOTHsLnS/TCV4KsevagMDA7P4RH/bLf8jaz2sfORF4ORDVsxw9PukjWNgC5q/
         31Qg==
X-Gm-Message-State: AOJu0YyoLNn9E3zoDCpLYNfzD4AGXcViD6z6AmuMD84PlC/G+74Esi7y
	nGLHCIKSL/bh+LaemEqMW7w=
X-Google-Smtp-Source: AGHT+IFPDYymOYrdldzhhficXNLLOHPr86EpgKcJCsbGuT716sxDARGSn5LPRhav70nGyYtPmmj1Nw==
X-Received: by 2002:a17:90a:880e:b0:286:9b25:1c66 with SMTP id s14-20020a17090a880e00b002869b251c66mr11977936pjn.24.1702913922418;
        Mon, 18 Dec 2023 07:38:42 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:42 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 062/154] ksmbd: call ib_drain_qp when disconnected
Date: Tue, 19 Dec 2023 00:33:22 +0900
Message-Id: <20231218153454.8090-63-linkinjeon@kernel.org>
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

[ Upstream commit 141fa9824c0fc11d44b2d5bb1266a33e95fa67fd ]

When disconnected, call ib_drain_qp to cancel all pending work requests
and prevent ksmbd_conn_handler_loop from waiting for a long time
for those work requests to compelete.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 652391aee733..68077150ad2f 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -1527,6 +1527,8 @@ static int smb_direct_cm_handler(struct rdma_cm_id *cm_id,
 	}
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 	case RDMA_CM_EVENT_DISCONNECTED: {
+		ib_drain_qp(t->qp);
+
 		t->status = SMB_DIRECT_CS_DISCONNECTED;
 		wake_up_interruptible(&t->wait_status);
 		wake_up_interruptible(&t->wait_reassembly_queue);
-- 
2.25.1


