Return-Path: <stable+bounces-37222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8116689C3E9
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2396C1F22FF0
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29837BB07;
	Mon,  8 Apr 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UoSfCQZK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145C79F0;
	Mon,  8 Apr 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583605; cv=none; b=XvaoRtMzBL8iPWFZAuYvjYqAR7zUPWxx10eV3gTxxhUfxZ+hnTg4byjGjoky3A4iZHHO+/FoHSeVvcpCSmee7pUUhgQigfl2K8SzjM1OwoRJtkb3BpMrXVxUIsf3P1mNveRWzJeOjNt1YZf3WBV0+AQthiAIS++1OuYvY3W0xqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583605; c=relaxed/simple;
	bh=Fg+8P4Bxb04RGK196v/C3FCNf/fGvrO8nhDbdCqa2l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjdWPiGGCg+8QCytmHYsSppBxMxIPb3DUG/vHyru5iPK5l47TvBBZ3u/xcCqaZIWPJi99SbV/44gVtjYPyDdsJ3C7kYGYELBTf3joHrRgyugpxCz57cYzP0OrXJ0uAmyZ0pwh4OXInLr6C8MjrEtwVpciz5H4M5lad3krlxAKzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UoSfCQZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED362C433C7;
	Mon,  8 Apr 2024 13:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583605;
	bh=Fg+8P4Bxb04RGK196v/C3FCNf/fGvrO8nhDbdCqa2l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UoSfCQZKMU/gx64vXwdOFmcfWTQNsornQzXC1JC2yREwJTewY4zWOZDOqPOeQ6fkH
	 ygreUQbtuq+c6+OMCyb7ptPQwnHgYq7c+lEqQYfgyxS3WIbdzpB3rSvLAqNV8IxZLz
	 4jpApJXmdOyidH4JXTey2+7hbxejtVU22NUtC21E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Christopher Adduono <jc@adduono.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.8 200/273] ksmbd: do not set SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1
Date: Mon,  8 Apr 2024 14:57:55 +0200
Message-ID: <20240408125315.534572770@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 5ed11af19e56f0434ce0959376d136005745a936 upstream.

SMB2_GLOBAL_CAP_ENCRYPTION flag should be used only for 3.0 and
3.0.2 dialects. This flags set cause compatibility problems with
other SMB clients.

Reported-by: James Christopher Adduono <jc@adduono.com>
Tested-by: James Christopher Adduono <jc@adduono.com>
Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2ops.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -228,6 +228,11 @@ void init_smb3_0_server(struct ksmbd_con
 	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
 
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
+	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
+	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 }
@@ -275,11 +280,6 @@ int init_smb3_11_server(struct ksmbd_con
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING |
 			SMB2_GLOBAL_CAP_DIRECTORY_LEASING;
 
-	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
-	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
-	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
-		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
-
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 



