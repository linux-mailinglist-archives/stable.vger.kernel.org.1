Return-Path: <stable+bounces-8119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6086881A49B
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38171F21417
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59447A6F;
	Wed, 20 Dec 2023 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="di6UEvt9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4247A6B;
	Wed, 20 Dec 2023 16:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29705C433C7;
	Wed, 20 Dec 2023 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088961;
	bh=A7S1nWTBbJSqRnsPGrZmVKG160nofOpk5yWO8nwYfuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=di6UEvt9PefwOPeI6xn3HJimadJtLx/opf3Ccdrk+grYo3whOfCgtYXkMxZI/NYDS
	 xhnTuvtMivJ6S2HuKThpxl30XlQWTIJeViCTpcEuJSrM2Gx+JS0/k6ToJbGxWgYOOP
	 1J7iMI1qnKfsYu82ebH6+qPqecqMdmgMDisoEh+0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Coverity Scan <scan-admin@coverity.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 094/159] ksmbd: fix uninitialized pointer read in smb2_create_link()
Date: Wed, 20 Dec 2023 17:09:19 +0100
Message-ID: <20231220160935.741476415@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit df14afeed2e6c1bbadef7d2f9c46887bbd6d8d94 ]

There is a case that file_present is true and path is uninitialized.
This patch change file_present is set to false by default and set to
true when patch is initialized.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Reported-by: Coverity Scan <scan-admin@coverity.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5529,7 +5529,7 @@ static int smb2_create_link(struct ksmbd
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
 	struct path path;
-	bool file_present = true;
+	bool file_present = false;
 	int rc;
 
 	if (buf_len < (u64)sizeof(struct smb2_file_link_info) +
@@ -5562,8 +5562,8 @@ static int smb2_create_link(struct ksmbd
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
-		file_present = false;
-	}
+	} else
+		file_present = true;
 
 	if (file_info->ReplaceIfExists) {
 		if (file_present) {



