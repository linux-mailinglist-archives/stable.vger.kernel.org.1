Return-Path: <stable+bounces-1658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 030E47F80C3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED7D1C215D1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3AF33CCA;
	Fri, 24 Nov 2023 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aAgS+nAO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1102321AD;
	Fri, 24 Nov 2023 18:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF100C433C8;
	Fri, 24 Nov 2023 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851951;
	bh=n7VKm/+9iCwNQy40BeEwu4YVRZLR37GpsmF3pIKJ6Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aAgS+nAO+FYYLswKx5eins3QuJ6qH56B2NOWNRX5spl/rqxFVGNj0LYEL5uBI8uCx
	 WQMo+vHdBVNd7java+tGFc0Pq4U58IsNu0LvHO93NJWJqUYhorGVugns7MP4HdSB8r
	 1E+6/IaZIkLn/G9VWKp3t1w6Egfd9SLF6DtZ8jhw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Ekaterina Esina <eesina@astralinux.ru>,
	Anastasia Belova <abelova@astralinux.ru>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 160/372] cifs: fix check of rc in function generate_smb3signingkey
Date: Fri, 24 Nov 2023 17:49:07 +0000
Message-ID: <20231124172015.816040771@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ekaterina Esina <eesina@astralinux.ru>

[ Upstream commit 181724fc72486dec2bec8803459be05b5162aaa8 ]

Remove extra check after condition, add check after generating key
for encryption. The check is needed to return non zero rc before
rewriting it with generating key for decryption.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Fixes: d70e9fa55884 ("cifs: try opening channels after mounting")
Signed-off-by: Ekaterina Esina <eesina@astralinux.ru>
Co-developed-by: Anastasia Belova <abelova@astralinux.ru>
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2transport.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 22954a9c7a6c7..69dbd08fd4419 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -451,6 +451,8 @@ generate_smb3signingkey(struct cifs_ses *ses,
 				  ptriplet->encryption.context,
 				  ses->smb3encryptionkey,
 				  SMB3_ENC_DEC_KEY_SIZE);
+		if (rc)
+			return rc;
 		rc = generate_key(ses, ptriplet->decryption.label,
 				  ptriplet->decryption.context,
 				  ses->smb3decryptionkey,
@@ -459,9 +461,6 @@ generate_smb3signingkey(struct cifs_ses *ses,
 			return rc;
 	}
 
-	if (rc)
-		return rc;
-
 #ifdef CONFIG_CIFS_DEBUG_DUMP_KEYS
 	cifs_dbg(VFS, "%s: dumping generated AES session keys\n", __func__);
 	/*
-- 
2.42.0




