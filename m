Return-Path: <stable+bounces-8151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5281A4C1
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356FE1F26523
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766EC4C3AF;
	Wed, 20 Dec 2023 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VPg5dVh3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA44A98E;
	Wed, 20 Dec 2023 16:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42A3C433C7;
	Wed, 20 Dec 2023 16:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703089056;
	bh=fpqsSt1zPQvAOpcKlyerlYT/TcO5ZfFnnq16/J+NamY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPg5dVh3DMoGsJEZJEb22thLWm+5lM5KFq1/wLfSNDGrjnl3RcXOBJNajWu+7qWVj
	 1vH2x+Aa4lqexVZ+4vXV6mZcuXYnwPhI7ZlBSnQII5c0Li/1SApY3b2VOUC7Dcnroc
	 6rr2eUS6DYv8MINH8xSZXR4m/h3tD3kQm2tTbXMM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 126/159] ksmbd: remove experimental warning
Date: Wed, 20 Dec 2023 17:09:51 +0100
Message-ID: <20231220160937.198120607@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit f5069159f32c8c943e047f22731317463c8e9b84 ]

ksmbd has made significant improvements over the past two
years and is regularly tested and used.  Remove the experimental
warning.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/Kconfig  |    2 +-
 fs/ksmbd/server.c |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

--- a/fs/ksmbd/Kconfig
+++ b/fs/ksmbd/Kconfig
@@ -1,5 +1,5 @@
 config SMB_SERVER
-	tristate "SMB3 server support (EXPERIMENTAL)"
+	tristate "SMB3 server support"
 	depends on INET
 	depends on MULTIUSER
 	depends on FILE_LOCKING
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -591,8 +591,6 @@ static int __init ksmbd_server_init(void
 	if (ret)
 		goto err_crypto_destroy;
 
-	pr_warn_once("The ksmbd server is experimental\n");
-
 	return 0;
 
 err_crypto_destroy:



