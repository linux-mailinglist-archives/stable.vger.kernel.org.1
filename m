Return-Path: <stable+bounces-9309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490098231C5
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A966FB23A00
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBE91C292;
	Wed,  3 Jan 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PB546HL0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B111C294;
	Wed,  3 Jan 2024 16:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09803C433C7;
	Wed,  3 Jan 2024 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301105;
	bh=Jh1/QiPkcAUJWsL4UmG6W3ZVVqU8fPmULzrT1SsFc24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PB546HL04PeMDszhLkibY8jEm1OIKdC+itcBvnA1uIe0dfv8a8sC2RYeIdrz8cRrr
	 BXIhjZ0ZbpFgxUOCYgm7wqrkpT7qMJFveZ0wwhj9qwrAiJgiuYBc1toYrxlj/5Y+2X
	 lFSsR4V5ZHjIqEQgSkvVQwhT894RBry3ZdIsftrI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Atte=20Heikkil=C3=A4?= <atteh.mailbox@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 037/100] ksmbd: fix `force create mode and `force directory mode
Date: Wed,  3 Jan 2024 17:54:26 +0100
Message-ID: <20240103164901.640075671@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
References: <20240103164856.169912722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Atte Heikkilä <atteh.mailbox@gmail.com>

[ Upstream commit 65656f5242e500dcfeffa6a0a1519eae14724f86 ]

`force create mode' and `force directory mode' should be bitwise ORed
with the perms after `create mask' and `directory mask' have been
applied, respectively.

Signed-off-by: Atte Heikkilä <atteh.mailbox@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/mgmt/share_config.h | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/smb/server/mgmt/share_config.h b/fs/smb/server/mgmt/share_config.h
index 3fd3382939421..5f591751b9236 100644
--- a/fs/smb/server/mgmt/share_config.h
+++ b/fs/smb/server/mgmt/share_config.h
@@ -34,29 +34,22 @@ struct ksmbd_share_config {
 #define KSMBD_SHARE_INVALID_UID	((__u16)-1)
 #define KSMBD_SHARE_INVALID_GID	((__u16)-1)
 
-static inline int share_config_create_mode(struct ksmbd_share_config *share,
-					   umode_t posix_mode)
+static inline umode_t
+share_config_create_mode(struct ksmbd_share_config *share,
+			 umode_t posix_mode)
 {
-	if (!share->force_create_mode) {
-		if (!posix_mode)
-			return share->create_mask;
-		else
-			return posix_mode & share->create_mask;
-	}
-	return share->force_create_mode & share->create_mask;
+	umode_t mode = (posix_mode ?: (umode_t)-1) & share->create_mask;
+
+	return mode | share->force_create_mode;
 }
 
-static inline int share_config_directory_mode(struct ksmbd_share_config *share,
-					      umode_t posix_mode)
+static inline umode_t
+share_config_directory_mode(struct ksmbd_share_config *share,
+			    umode_t posix_mode)
 {
-	if (!share->force_directory_mode) {
-		if (!posix_mode)
-			return share->directory_mask;
-		else
-			return posix_mode & share->directory_mask;
-	}
+	umode_t mode = (posix_mode ?: (umode_t)-1) & share->directory_mask;
 
-	return share->force_directory_mode & share->directory_mask;
+	return mode | share->force_directory_mode;
 }
 
 static inline int test_share_config_flag(struct ksmbd_share_config *share,
-- 
2.43.0




