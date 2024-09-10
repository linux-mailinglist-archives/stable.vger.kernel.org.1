Return-Path: <stable+bounces-75415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0C2973473
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334531C24FBB
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A95E19049E;
	Tue, 10 Sep 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sxrmAeqx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6014D280;
	Tue, 10 Sep 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964665; cv=none; b=cLknyUMfdu16cXwV8Yuz6JUrw4ywMA3ITYDiE5mX179auGQRzNoRP4DCJ+Zp3VK0bQDOalZFamjy3STu8LcyzMb/0GC1hD4intmxQc8ADDtJDCRuMROhbQ1CEnrVFsw5k2kj9hqqDlfZWSFnHo2vVvEJgZQIdm+H7a51DrkB4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964665; c=relaxed/simple;
	bh=DKuUKjR7WYzJO9j8odBywLkqySpFeDZGAbAq+I03Kks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMSEBGZU9vNYHfGGuDjjCMAwNqlNqtoigqJcLwQx3b0WaFB2OLY8L+oRsuPOujw7jhJDVxf2R03n81Ukma0exeTRApVhkvZv1JPUKfPokwpmLS6xNTa4/GhBRvKA0JX/RGjTnQdUj99sGXlcwBVyUNR8BVfDGX/nl771Y/C3uW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sxrmAeqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6431C4CEC3;
	Tue, 10 Sep 2024 10:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964665;
	bh=DKuUKjR7WYzJO9j8odBywLkqySpFeDZGAbAq+I03Kks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxrmAeqxFZgo/m0ioT+O782Wm42TtLDGRlbiFnl+Ru067l4i2u2DOA2SRZztfWVqR
	 zAhhGWlC7AMZpIKQJtnV2L66YJ0FToxJx7ineVKMGCBW5ihtTaVwmKVMRpv8ymjH/7
	 EULQ8JNtBpsX+vxL4VsRaBLcjoA4DKBhTNzdF77Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 259/269] smb: client: fix double put of @cfile in smb2_rename_path()
Date: Tue, 10 Sep 2024 11:34:06 +0200
Message-ID: <20240910092617.006952795@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 3523a3df03c6f04f7ea9c2e7050102657e331a4f ]

If smb2_set_path_attr() is called with a valid @cfile and returned
-EINVAL, we need to call cifs_get_writable_path() again as the
reference of @cfile was already dropped by previous smb2_compound_op()
call.

Fixes: 71f15c90e785 ("smb: client: retry compound request without reusing lease")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index fc82d5ebf923..dd8acd207752 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -1106,6 +1106,8 @@ int smb2_rename_path(const unsigned int xid,
 				  co, DELETE, SMB2_OP_RENAME, cfile, source_dentry);
 	if (rc == -EINVAL) {
 		cifs_dbg(FYI, "invalid lease key, resending request without lease");
+		cifs_get_writable_path(tcon, from_name,
+				       FIND_WR_WITH_DELETE, &cfile);
 		rc = smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
 				  co, DELETE, SMB2_OP_RENAME, cfile, NULL);
 	}
-- 
2.43.0




