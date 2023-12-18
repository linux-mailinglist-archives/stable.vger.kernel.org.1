Return-Path: <stable+bounces-7673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE28175B5
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EAD1F22184
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3634FF80;
	Mon, 18 Dec 2023 15:37:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DB498AE
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28b09aeca73so2276299a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913864; x=1703518664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXjTfNv1HiqtFivpA+/E+Tt3Z4vPKRCuMrFMYscrLBw=;
        b=Ncxjf7xxylnRAG4t8agVsBPny9M0K3t0v24wNDyz8BNvfrVUAp/1FT8A7HFMOZMcCL
         2ZFof4u2Yu0uRmaxhFgbRMlHv06J3JGWlEBzCkjJN7lyclgrNzIV4cmU2jpU5eyYFi8L
         1rwxC3zujPgNol4+Lfgh2QUg4ZuT6MHvcAgt6jZQzzYH06MYNpwSYp1CUvrIEaMKKWyf
         Tb6AGa/5jzS80rQIVsU7d1pdomTN2hE937QMG4K29P9jOXpMFKaWopww/9NSzclO4Uhf
         QXL9/9U0IITEOPXV9uV7dApseP1ldOUnzgZvCAwiH1PSj5fSSk1s7BdhgD/8d+pXILxY
         0o8A==
X-Gm-Message-State: AOJu0Yz2fRYwjGuCVuSNx9Gc4l/hklOBqPG+ERWgE2361VY3O8eaSOkp
	ZncActCwMG/ReSvEcJE/dAM=
X-Google-Smtp-Source: AGHT+IFWpi2du3vLgxZ305KflQfYC295ma9cccnXzBxoWiQvwkGRB6V88RYgCpiay9tWdH9/EUCFvg==
X-Received: by 2002:a17:90a:1305:b0:28b:2f14:5bc1 with SMTP id h5-20020a17090a130500b0028b2f145bc1mr7009308pja.7.1702913864033;
        Mon, 18 Dec 2023 07:37:44 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:43 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 044/154] ksmbd: remove unused ksmbd_share_configs_cleanup function
Date: Tue, 19 Dec 2023 00:33:04 +0900
Message-Id: <20231218153454.8090-45-linkinjeon@kernel.org>
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

[ Upstream commit 1c90b54718fdea4f89e7e0c2415803f33f6d0b00 ]

remove unused ksmbd_share_configs_cleanup function.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/mgmt/share_config.c | 14 --------------
 fs/ksmbd/mgmt/share_config.h |  2 --
 2 files changed, 16 deletions(-)

diff --git a/fs/ksmbd/mgmt/share_config.c b/fs/ksmbd/mgmt/share_config.c
index cb72d30f5b71..70655af93b44 100644
--- a/fs/ksmbd/mgmt/share_config.c
+++ b/fs/ksmbd/mgmt/share_config.c
@@ -222,17 +222,3 @@ bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
 	}
 	return false;
 }
-
-void ksmbd_share_configs_cleanup(void)
-{
-	struct ksmbd_share_config *share;
-	struct hlist_node *tmp;
-	int i;
-
-	down_write(&shares_table_lock);
-	hash_for_each_safe(shares_table, i, tmp, share, hlist) {
-		hash_del(&share->hlist);
-		kill_share(share);
-	}
-	up_write(&shares_table_lock);
-}
diff --git a/fs/ksmbd/mgmt/share_config.h b/fs/ksmbd/mgmt/share_config.h
index 953befc94e84..28bf3511763f 100644
--- a/fs/ksmbd/mgmt/share_config.h
+++ b/fs/ksmbd/mgmt/share_config.h
@@ -76,6 +76,4 @@ static inline void ksmbd_share_config_put(struct ksmbd_share_config *share)
 struct ksmbd_share_config *ksmbd_share_config_get(char *name);
 bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
 			       const char *filename);
-void ksmbd_share_configs_cleanup(void);
-
 #endif /* __SHARE_CONFIG_MANAGEMENT_H__ */
-- 
2.25.1


