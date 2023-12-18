Return-Path: <stable+bounces-7756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF5C81761F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2F31C251F5
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01AE74E18;
	Mon, 18 Dec 2023 15:42:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3174E19
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b79d1ebd6so587647a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914129; x=1703518929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLm9NafauEyGoH03tunWOKOfN1DHcwqHWlxBl9Mm0zY=;
        b=VquDz7NYRmphMixRdlmTVAJM3KbxOt+uJNNi03c5n9rZfUxMnsclv4Cv3LtKJwYJ8d
         HBN9rVxqTVcHxCoFzVbdVhMrdfLNKuB0w951lHqg9AfR5+uinneg+kVIDbE6Tv+fHQV2
         ZUAElEtY50E10UPIWxo+0w2EFFhkprWK3S3qs5S0uVp7y8LG2wqftBAgqf19daRtmWNG
         5Eo59GkDqo8eshmoieuC8lXMXYrqlqQwW/Cg9Q+SVOxby35njHbwmj9zj1fbGEcnDw6U
         Ta82+RhcPZvjIXJPG8Hci+vvT+4hL098RTMg0KJm1xgY9PpABkeSbAAjW1g6q2i0Lebc
         nbWg==
X-Gm-Message-State: AOJu0Yye1SL7oFLvHbXzUzKuzJk8gObrup9tDx8iDdLm44aDBaaErSAH
	48DXumh6+88PGAilL6+gxu4t2y1Q4BefwA==
X-Google-Smtp-Source: AGHT+IHic+ZxLx4EC6Px6cqKRDxu2bbJ40o1nuxs3FOfmzfjlRLMQH3RQNRoRQiH3h41HHBqESeZ/g==
X-Received: by 2002:a17:90b:35c6:b0:28b:755f:a865 with SMTP id nb6-20020a17090b35c600b0028b755fa865mr729604pjb.12.1702914129551;
        Mon, 18 Dec 2023 07:42:09 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:09 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 127/154] ksmbd: remove unneeded mark_inode_dirty in set_info_sec()
Date: Tue, 19 Dec 2023 00:34:27 +0900
Message-Id: <20231218153454.8090-128-linkinjeon@kernel.org>
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

[ Upstream commit e4e14095cc68a2efefba6f77d95efe1137e751d4 ]

mark_inode_dirty will be called in notify_change().
This patch remove unneeded mark_inode_dirty in set_info_sec().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smbacl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index a8b450e62825..d7fd5a15dac4 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1441,7 +1441,6 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 out:
 	posix_acl_release(fattr.cf_acls);
 	posix_acl_release(fattr.cf_dacls);
-	mark_inode_dirty(inode);
 	return rc;
 }
 
-- 
2.25.1


