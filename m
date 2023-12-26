Return-Path: <stable+bounces-8577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9F81E6FA
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 11:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C631C21E89
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC074E1A1;
	Tue, 26 Dec 2023 10:54:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D694E1B3
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3521129a12.0
        for <stable@vger.kernel.org>; Tue, 26 Dec 2023 02:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703588046; x=1704192846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eC+8wvIcjEOaG7fzZOvflUgkYQts86DpFbp4HTqsdJ8=;
        b=eFF00y/uHn86Ee+AOrV+NjWnyL4GMoZoBNwPr5EJO8oLh1MNRcm5kiFGWbdoWE0yq/
         B/FFpvWIUxcPYhGyK33ytwJTdL7boomMXcULbYVLNuGz4+rnBpkHPFHHWF2VmQOj7SFM
         awJD+XlQys6LYRwyNxcSBOKUZK5FmudstXpW+GFvZYi7pTFNxpZwWGxlYBQVGyphffAA
         I+/+2jhjTRW5goqYCeAV1xwA26YGYYjFYnhXi06OL0tPqt11Ngov33HEC2LcMlztUk+p
         B4X8ddzFv+V+k1dsmspT6Lf7SuZrm3r7eTSC4Sk1odjWFhrb05FzG8J7+w+6ao6xFuhp
         lUBA==
X-Gm-Message-State: AOJu0YwnEVbf4a3nAc7dg4drKxpV+105E7VlNExK8LOmBffM91qxDPND
	UqUVVO0SCAJrV+i8l0RjBWc=
X-Google-Smtp-Source: AGHT+IHplhF6UNb85cxNX6zFBf71mpohWqgd7V4sNXo3AmTnc/geDGsmsNryiSG8jgVLQvqcSTQbiA==
X-Received: by 2002:a17:90a:c10b:b0:28b:f18e:11f3 with SMTP id q11-20020a17090ac10b00b0028bf18e11f3mr8993123pjt.7.1703588046137;
        Tue, 26 Dec 2023 02:54:06 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id sg4-20020a17090b520400b0028be1050020sm10874972pjb.29.2023.12.26.02.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:54:05 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 2/8] ksmbd: set epoch in create context v2 lease
Date: Tue, 26 Dec 2023 19:53:27 +0900
Message-Id: <20231226105333.5150-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226105333.5150-1-linkinjeon@kernel.org>
References: <20231226105333.5150-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit d045850b628aaf931fc776c90feaf824dca5a1cf ]

To support v2 lease(directory lease), ksmbd set epoch in create context
v2 lease response.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c | 5 ++++-
 fs/ksmbd/oplock.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 1cf2d2a3746a..ed639b7b6509 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -104,7 +104,7 @@ static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
 	lease->duration = lctx->duration;
 	memcpy(lease->parent_lease_key, lctx->parent_lease_key, SMB2_LEASE_KEY_SIZE);
 	lease->version = lctx->version;
-	lease->epoch = 0;
+	lease->epoch = le16_to_cpu(lctx->epoch);
 	INIT_LIST_HEAD(&opinfo->lease_entry);
 	opinfo->o_lease = lease;
 
@@ -1032,6 +1032,7 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
 	       SMB2_LEASE_KEY_SIZE);
 	lease2->duration = lease1->duration;
 	lease2->flags = lease1->flags;
+	lease2->epoch = lease1->epoch++;
 }
 
 static int add_lease_global_list(struct oplock_info *opinfo)
@@ -1364,6 +1365,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 		memcpy(buf->lcontext.LeaseKey, lease->lease_key,
 		       SMB2_LEASE_KEY_SIZE);
 		buf->lcontext.LeaseFlags = lease->flags;
+		buf->lcontext.Epoch = cpu_to_le16(++lease->epoch);
 		buf->lcontext.LeaseState = lease->state;
 		memcpy(buf->lcontext.ParentLeaseKey, lease->parent_lease_key,
 		       SMB2_LEASE_KEY_SIZE);
@@ -1423,6 +1425,7 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
 		lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->epoch = lc->lcontext.Epoch;
 		lreq->duration = lc->lcontext.LeaseDuration;
 		memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
 				SMB2_LEASE_KEY_SIZE);
diff --git a/fs/ksmbd/oplock.h b/fs/ksmbd/oplock.h
index 4b0fe6da7694..ad31439c61fe 100644
--- a/fs/ksmbd/oplock.h
+++ b/fs/ksmbd/oplock.h
@@ -34,6 +34,7 @@ struct lease_ctx_info {
 	__le32			flags;
 	__le64			duration;
 	__u8			parent_lease_key[SMB2_LEASE_KEY_SIZE];
+	__le16			epoch;
 	int			version;
 };
 
-- 
2.25.1


