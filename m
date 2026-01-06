Return-Path: <stable+bounces-205949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B434FCFB23E
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 22:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B754301F5F6
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 21:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A20636D514;
	Tue,  6 Jan 2026 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WVtYAD9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45720376BD1;
	Tue,  6 Jan 2026 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722398; cv=none; b=PIyjNrrTNOJxm+yVpjjARmGcrTz/Y7DTklDDVPX4OqGRAWp+d989G/iMrNgUZz3Uldh9uhQ+EzD+4ovsOrHvs944OUhhC1Bq38njecaf0lWYKLN04Qcx+ci6bPkd1lrXT6qD4zJAkiMVdqcOkUDvyW8O4v/IDGqWgNEEMVk/7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722398; c=relaxed/simple;
	bh=HO7AUNFlXGCc2s00oiQaqkK7Tegrmauf+bclUc16fWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhrrMaJkBn0NMlp8JE0bWTacq+Rt7vqZeBxxtH77z3droyyz2rlW1bYPOO+ynaboesPL9Q5HAQxwL05gX4JeKtTFGMdTPiMq8Fo2LJ+AyStkNmU/37CRluOaeISluaHiYTADoaHAI3m5dZUjU2nqjgD4deyaKHBypFzAfE3FFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WVtYAD9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F98C116C6;
	Tue,  6 Jan 2026 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767722398;
	bh=HO7AUNFlXGCc2s00oiQaqkK7Tegrmauf+bclUc16fWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVtYAD9dVYo8qsvRpYW/uF+wzWcfjB1y7q852tyK4LezrfgukhyH5hDzB3WD5mS9D
	 MOdvMLXg+OLvy+LSGlyFA3KC2hSkyVKKKx9R0WkdAU+qFrmYt8o1pM9aoNWepmBlik
	 AFG/9uplvGtVuWTPJwxfYNkgnm7Vxl4pMd0wB8Zk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.18 252/312] nfsd: use ATTR_DELEG in nfsd4_finalize_deleg_timestamps()
Date: Tue,  6 Jan 2026 18:05:26 +0100
Message-ID: <20260106170556.965107370@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
References: <20260106170547.832845344@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

commit 8f9e967830ff32ab7756f530a36adf74a9f12b76 upstream.

When finalizing timestamps that have never been updated and preparing to
release the delegation lease, the notify_change() call can trigger a
delegation break, and fail to update the timestamps. When this happens,
there will be messages like this in dmesg:

    [ 2709.375785] Unable to update timestamps on inode 00:39:263: -11

Since this code is going to release the lease just after updating the
timestamps, breaking the delegation is undesirable. Fix this by setting
ATTR_DELEG in ia_valid, in order to avoid the delegation break.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Cc: stable@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1226,7 +1226,7 @@ static void put_deleg_file(struct nfs4_f
 
 static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct file *f)
 {
-	struct iattr ia = { .ia_valid = ATTR_ATIME | ATTR_CTIME | ATTR_MTIME };
+	struct iattr ia = { .ia_valid = ATTR_ATIME | ATTR_CTIME | ATTR_MTIME | ATTR_DELEG };
 	struct inode *inode = file_inode(f);
 	int ret;
 



