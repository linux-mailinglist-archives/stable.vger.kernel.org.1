Return-Path: <stable+bounces-7781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C00B81763E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B131C226CC
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0664FF7E;
	Mon, 18 Dec 2023 15:43:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9794FF81
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28b012f93eeso1222524a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914214; x=1703519014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PILd+uCpoy5oX+Lhq3/YSbJi6oXRvS4wLXdRs79rkAo=;
        b=UBfLOnbMEKUB2NgUKEwGycsaQ0S8OKDoFMQKo35t1/qgpYyPaNwdXNGZiQzlrX2AuW
         DGrEZxJrbL3/s10wc3gH7+XFgkKRuJaW0Cyxtmo+JtyYzD4Za9qa0WnKtEUE8M3elCqs
         v4dXyblIyBHfhKrwTcBSAA1YSuWPD/Objl1mqV7y5FZiE9W6L/iwM6+9s7C23K64alkv
         3diuSEdgWIAuWx3X0QjMHDyUGnNDx6iTt3qRlncDHFqQ8bof16HEpSuhafvOCW05jB3z
         qf6wg88Ub1DWFwwihAU8vh29qIdJopowx7FEM317nBtwr5JnP/h0ZDK+mgbJND/R+sSU
         3xhA==
X-Gm-Message-State: AOJu0YySZtjJykBC0sYmEXGAh9gUK5d7XRWYH64NiIucrb/HXufeNSk7
	Fqgn5hg6qMANZmg8oxRPr+Q=
X-Google-Smtp-Source: AGHT+IHBfJr9Yk98cahJulnnaULtp0PcstLCzynQe1NPeVHllGCp4gZW/Yr1b+ZpAzGgigoPVpU+6w==
X-Received: by 2002:a17:90b:2356:b0:28b:729c:b9fb with SMTP id ms22-20020a17090b235600b0028b729cb9fbmr743900pjb.27.1702914214302;
        Mon, 18 Dec 2023 07:43:34 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:43:33 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 152/154] ksmbd: release interim response after sending status pending response
Date: Tue, 19 Dec 2023 00:34:52 +0900
Message-Id: <20231218153454.8090-153-linkinjeon@kernel.org>
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

[ Upstream commit 2a3f7857ec742e212d6cee7fbbf7b0e2ae7f5161 ]

Add missing release async id and delete interim response entry after
sending status pending response. This only cause when smb2 lease is enable.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/ksmbd_work.c | 3 +++
 fs/ksmbd/oplock.c     | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/ksmbd_work.c b/fs/ksmbd/ksmbd_work.c
index 2510b9f3c8c1..d7c676c151e2 100644
--- a/fs/ksmbd/ksmbd_work.c
+++ b/fs/ksmbd/ksmbd_work.c
@@ -56,6 +56,9 @@ void ksmbd_free_work_struct(struct ksmbd_work *work)
 	kfree(work->tr_buf);
 	kvfree(work->request_buf);
 	kfree(work->iov);
+	if (!list_empty(&work->interim_entry))
+		list_del(&work->interim_entry);
+
 	if (work->async_id)
 		ksmbd_release_id(&work->conn->async_ida, work->async_id);
 	kmem_cache_free(work_cache, work);
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 13185c74b912..1cf2d2a3746a 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -833,7 +833,8 @@ static int smb2_lease_break_noti(struct oplock_info *opinfo)
 					     interim_entry);
 			setup_async_work(in_work, NULL, NULL);
 			smb2_send_interim_resp(in_work, STATUS_PENDING);
-			list_del(&in_work->interim_entry);
+			list_del_init(&in_work->interim_entry);
+			release_async_work(in_work);
 		}
 		INIT_WORK(&work->work, __smb2_lease_break_noti);
 		ksmbd_queue_work(work);
-- 
2.25.1


