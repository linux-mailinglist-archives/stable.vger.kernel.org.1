Return-Path: <stable+bounces-131513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3800FA80A93
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2EA1BA6E69
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A39426FDB3;
	Tue,  8 Apr 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zRZI96Ds"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C626F460;
	Tue,  8 Apr 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116602; cv=none; b=mn77OZuDTOUC/2esrLcjyXiO3BM3e2yBDbzjo2IU2kUnK8GSpJe2yMmQRM9VwPKTggVezPK2Dc5felV5vtG61iskuCUtcxUisww5AIvpywV8GjOSmJvvlPvP8vio1hRiWSb+W2RZAIkE+fc73/urMdcEVjjfYcDua/v3VU4chW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116602; c=relaxed/simple;
	bh=2LHF7wr4sR8ge2Ppjc8m1FZpfHcCNE7OFDNrnpsNLqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3Q0Hsv3SfToMESGla05IU8flTN1mlBUpj2gG/wstURjG9uyVkIkx/wOZKfij0JBtm5JREHfcYpBw8jYoaAKJsjNJO2C5jm8Td09jMohI5EDByaJPJgYyWpWLIRq9CjO9wHgdiva9RfA8gdl+51dgpJUf7rgnZW/MQ+GlFD82/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zRZI96Ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FD9C4CEE5;
	Tue,  8 Apr 2025 12:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116602;
	bh=2LHF7wr4sR8ge2Ppjc8m1FZpfHcCNE7OFDNrnpsNLqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zRZI96DssWFIvE7uqG0U71XaB4qDtNQJk7G1ODdJHNfbrASggmOfs+wBNcjB3vJ+u
	 fmrxRjBMXQ+6s9SXI9rRqpMTsUotpXzRMTqnnJPdD1ePvuiKh5NHXrMhmi6W3EDmi7
	 PtsfzX8UnM0Q0fny5KQOemry3TsG4CTfpd+manlo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 200/423] NFSv4: Dont trigger uneccessary scans for return-on-close delegations
Date: Tue,  8 Apr 2025 12:48:46 +0200
Message-ID: <20250408104850.393084318@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 47acca884f714f41d95dc654f802845544554784 ]

The amount of looping through the list of delegations is occasionally
leading to soft lockups. Avoid at least some loops by not requiring the
NFSv4 state manager to scan for delegations that are marked for
return-on-close. Instead, either mark them for immediate return (if
possible) or else leave it up to nfs4_inode_return_delegation_on_close()
to return them once the file is closed by the application.

Fixes: b757144fd77c ("NFSv4: Be less aggressive about returning delegations for open files")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/delegation.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 4db912f562305..df77d68d9ff99 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -590,17 +590,6 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
 
 	if (test_and_clear_bit(NFS_DELEGATION_RETURN, &delegation->flags))
 		ret = true;
-	else if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags)) {
-		struct inode *inode;
-
-		spin_lock(&delegation->lock);
-		inode = delegation->inode;
-		if (inode && list_empty(&NFS_I(inode)->open_files))
-			ret = true;
-		spin_unlock(&delegation->lock);
-	}
-	if (ret)
-		clear_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
 	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags) ||
 	    test_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags) ||
 	    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
@@ -878,11 +867,25 @@ int nfs4_inode_make_writeable(struct inode *inode)
 	return nfs4_inode_return_delegation(inode);
 }
 
-static void nfs_mark_return_if_closed_delegation(struct nfs_server *server,
-		struct nfs_delegation *delegation)
+static void
+nfs_mark_return_if_closed_delegation(struct nfs_server *server,
+				     struct nfs_delegation *delegation)
 {
-	set_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
-	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
+	struct inode *inode;
+
+	if (test_bit(NFS_DELEGATION_RETURN, &delegation->flags) ||
+	    test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags))
+		return;
+	spin_lock(&delegation->lock);
+	inode = delegation->inode;
+	if (!inode)
+		goto out;
+	if (list_empty(&NFS_I(inode)->open_files))
+		nfs_mark_return_delegation(server, delegation);
+	else
+		set_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
+out:
+	spin_unlock(&delegation->lock);
 }
 
 static bool nfs_server_mark_return_all_delegations(struct nfs_server *server)
-- 
2.39.5




