Return-Path: <stable+bounces-168754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF55DB2366A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D112058522E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DFF279DB6;
	Tue, 12 Aug 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwyqOOvS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CBB27604E
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025226; cv=none; b=hnvkqCug+NKMplcxKCfK58B+FKy+D8o8gB1gzzA9sQ4u2fZnKW6/WbFUX/de4Y3zjPoGO8wrL66+QwjPEBGeQm09lYU6I6fyccwHeZo32673qXvSj+y8hHeImuI8Xx/EWiPxhFreGoLxXW/gVeLhaFmQM2970YNdpr8d6PQGWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025226; c=relaxed/simple;
	bh=ffdE4p+WVXExBTr5VYCtVuhKLk0rGm0gGa9p7M+JA1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EsCWzi96IhCcYrvieQwS7o7Tfjun/gWNopgMpt81VE1Qt6/fpOP2ABhmHQUX23owxmIQtbqHJGdZ8UqGp1LKzGDlEanfbDfCFtOgLGfXZHyqSp4rax1Ogm0XyB8QLgr5Zrga7sPSV4APQD1g2nnlPos98bEcZE67lXQD35bALK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwyqOOvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB97AC4CEF1;
	Tue, 12 Aug 2025 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755025226;
	bh=ffdE4p+WVXExBTr5VYCtVuhKLk0rGm0gGa9p7M+JA1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwyqOOvSi0S7jbHPxkmRhVYYRipxBOLkVoZu1JE44hX1L9ezs/sfFhWYnfaiuXX7K
	 a/DSnifATwnkn0uOyhGBajEXsG9Xa07BKVYQVOECSI7ZWvs3fPpC2P4WfFVMyKcLdy
	 8oysyCg/F3oX/PmWytyKxzHxJ110tuFkEqCtY0hs0rMsu28csc0Ub7XqVRh5zFhARS
	 PkEAiaTO98kbcTFO32Vk5aqGVylsybVL9e1tGp2RqjI+bMOp98BoMRyL1k4Seeo5XO
	 bDfa0oh3rjrQv8bWpVst+aA1oVouYQdBbBxT4918wLcRGQn9e5Idux7RpNDGhdTG1G
	 CCCvxwS6RdAyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: server: Fix extension string in ksmbd_extract_shortname()
Date: Tue, 12 Aug 2025 15:00:21 -0400
Message-Id: <20250812190021.2029804-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081246-wasting-private-5dd8@gregkh>
References: <2025081246-wasting-private-5dd8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 8e7d178d06e8937454b6d2f2811fa6a15656a214 ]

In ksmbd_extract_shortname(), strscpy() is incorrectly called with the
length of the source string (excluding the NUL terminator) rather than
the size of the destination buffer. This results in "__" being copied
to 'extension' rather than "___" (two underscores instead of three).

Use the destination buffer size instead to ensure that the string "___"
(three underscores) is copied correctly.

Cc: stable@vger.kernel.org
Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 23537e1b3468..2839c704110c 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -515,7 +515,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn, const char *longname,
 
 	p = strrchr(longname, '.');
 	if (p == longname) { /*name starts with a dot*/
-		strscpy(extension, "___", strlen("___"));
+		strscpy(extension, "___", sizeof(extension));
 	} else {
 		if (p) {
 			p++;
-- 
2.39.5


