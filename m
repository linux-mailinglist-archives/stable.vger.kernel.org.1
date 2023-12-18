Return-Path: <stable+bounces-7733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7594D817604
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC411C25135
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF137348C;
	Mon, 18 Dec 2023 15:40:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519F73476
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28ad7a26f4aso2900643a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914055; x=1703518855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Oee2Mt5WyDR3Vi0c0c6GkKqMq/XEvddDg1l4cnjtJI=;
        b=XHbyTtlyQCZrKFgzPEXxuU7g/a2uWIPx46S9PXUR1sJGFpDmGogvoOAII/GPZKpKfo
         +s52T0+msvXGCu5OjelsJdKCbX3pCNvnxEuT5nfq8RRMTTcuimfwlfUMFJ+PdjF3Id/f
         dHBrAtBJaoc6fcXJ1rgPIH8naNSzCiCl12X3WT/Eq2DFPrOvUXOUhOnH5i+UcvN7MJEM
         4Sk63F0Gtk2sWzQBIjiy3DKVmIEFtj5npEK5akFhv1fxUshVJRuGCmGczbj6eK4mlzLI
         T+ZKPCdhykTUNRx+iTyWL8B4ulQ3y3Lpv0hpOZsxByjHMSP09cCZjkvcc4BfmGEERLBo
         Y5Ug==
X-Gm-Message-State: AOJu0YySCQ6uA2MpRL75XbdOZUcDt6bCsKKA6av5WuT+YLS1XYcd7cMu
	2nZaJ7AlOPFYaLfsR3tTz7M=
X-Google-Smtp-Source: AGHT+IHhvUI7YESnF37pGdxnHsv7IwFahZR+CkE8x3ThktaNbSzcQbsVRDQz9OIsxLEtXy4X4QhiGw==
X-Received: by 2002:a17:90b:3585:b0:28b:8431:6cf with SMTP id mm5-20020a17090b358500b0028b843106cfmr1019341pjb.86.1702914054895;
        Mon, 18 Dec 2023 07:40:54 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:54 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 104/154] ksmbd: remove unused ksmbd_tree_conn_share function
Date: Tue, 19 Dec 2023 00:34:04 +0900
Message-Id: <20231218153454.8090-105-linkinjeon@kernel.org>
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

[ Upstream commit 7bd9f0876fdef00f4e155be35e6b304981a53f80 ]

Remove unused ksmbd_tree_conn_share function.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/mgmt/tree_connect.c | 11 -----------
 fs/ksmbd/mgmt/tree_connect.h |  3 ---
 2 files changed, 14 deletions(-)

diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
index f07a05f37651..408cddf2f094 100644
--- a/fs/ksmbd/mgmt/tree_connect.c
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -120,17 +120,6 @@ struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
 	return tcon;
 }
 
-struct ksmbd_share_config *ksmbd_tree_conn_share(struct ksmbd_session *sess,
-						 unsigned int id)
-{
-	struct ksmbd_tree_connect *tc;
-
-	tc = ksmbd_tree_conn_lookup(sess, id);
-	if (tc)
-		return tc->share_conf;
-	return NULL;
-}
-
 int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess)
 {
 	int ret = 0;
diff --git a/fs/ksmbd/mgmt/tree_connect.h b/fs/ksmbd/mgmt/tree_connect.h
index 700df36cf3e3..562d647ad9fa 100644
--- a/fs/ksmbd/mgmt/tree_connect.h
+++ b/fs/ksmbd/mgmt/tree_connect.h
@@ -53,9 +53,6 @@ int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
 						  unsigned int id);
 
-struct ksmbd_share_config *ksmbd_tree_conn_share(struct ksmbd_session *sess,
-						 unsigned int id);
-
 int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess);
 
 #endif /* __TREE_CONNECT_MANAGEMENT_H__ */
-- 
2.25.1


