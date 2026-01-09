Return-Path: <stable+bounces-207840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE79D0A539
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 14:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DE2930B4124
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73593359FB5;
	Fri,  9 Jan 2026 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ajz1LU0F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F6A31A069;
	Fri,  9 Jan 2026 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963198; cv=none; b=DqYxvNgz0iO6C6QYIEAvTJsTE+G0m/SCrn1DVud+x3QtpJ8nqi5vk8JaB5wL7Yn4aU2Jcb+x9rIHsLNNWtg9ATVle41wY33xz6UJqGbbY5j1Mdj7h5AnM3Et6vNvt5UUMk++PjnIZbVR66F6vADy8TBHvbfKl+QQ7yYhYu2Zv9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963198; c=relaxed/simple;
	bh=fIFGy1FNW7KejSJC+hcKCPmXMul0v7VMCgAN2722edk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chBl6z1bSSih+ROHzVPG56amvNRF390EPKp4B5M92Z9k5SpqHt8/M5WJ40kkOIveEvgKEaLwGHwE0SmKCiHpLQKJWaO4RBIwHr6YXoonCBAjZFSCQXuuQ4VReD0ov/0wt5de2U5WVcsuzhxWLoimspZsrfqkWn+j6WXFTuI0EZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ajz1LU0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D72C19421;
	Fri,  9 Jan 2026 12:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767963198;
	bh=fIFGy1FNW7KejSJC+hcKCPmXMul0v7VMCgAN2722edk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajz1LU0Fm2SjGSNF17T/sReZQtIJ5xYJxFjqoYo1FVChxh8xFa3wEyl+jGE8ysT0T
	 //+xEP0RNOvEl20+xuMhjBnRMEQnhD1rKOZleINvGvf9eUD2bym7qThxLrRhhmtf5L
	 ej88296noSYQLxw8vj04wu9Z03ONeYyoabSAPFGk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aurelien Couderc <aurelien.couderc2002@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 599/634] NFSD: NFSv4 file creation neglects setting ACL
Date: Fri,  9 Jan 2026 12:44:37 +0100
Message-ID: <20260109112140.165693952@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 913f7cf77bf14c13cfea70e89bcb6d0b22239562 ]

An NFSv4 client that sets an ACL with a named principal during file
creation retrieves the ACL afterwards, and finds that it is only a
default ACL (based on the mode bits) and not the ACL that was
requested during file creation. This violates RFC 8881 section
6.4.1.3: "the ACL attribute is set as given".

The issue occurs in nfsd_create_setattr(). On 6.1.y, the check to
determine whether nfsd_setattr() should be called is simply
"iap->ia_valid", which only accounts for iattr changes. When only
an ACL is present (and no iattr fields are set), nfsd_setattr() is
skipped and the POSIX ACL is never applied to the inode.

Subsequently, when the client retrieves the ACL, the server finds
no POSIX ACL on the inode and returns one generated from the file's
mode bits rather than returning the originally-specified ACL.

Reported-by: Aurelien Couderc <aurelien.couderc2002@gmail.com>
Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
Cc: stable@vger.kernel.org
[ cel: Adjust nfsd_create_setattr() instead of nfsd_attrs_valid() ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/vfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1320,7 +1320,7 @@ nfsd_create_setattr(struct svc_rqst *rqs
 	 * Callers expect new file metadata to be committed even
 	 * if the attributes have not changed.
 	 */
-	if (iap->ia_valid)
+	if (iap->ia_valid || attrs->na_pacl || attrs->na_dpacl)
 		status = nfsd_setattr(rqstp, resfhp, attrs, 0, (time64_t)0);
 	else
 		status = nfserrno(commit_metadata(resfhp));



