Return-Path: <stable+bounces-92614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707419C5665
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B332DB370C0
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2904230986;
	Tue, 12 Nov 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JOnW8+h7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708982309AD;
	Tue, 12 Nov 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408022; cv=none; b=i/Jx31TLfO622G2BLIlZPvPSURoUJLqkn/xNDJi2+vxM35mgPgJhKMK3GyhnDRnPNyzObJXBSd1WbEfXQb09cimqLUIVXoQ2rL95EJOh2zQD5cedPrzyIucH1J1FyvWLmOvLdrOX8Oe0oesB3QDZqCxH77Osw8XVM00T1qt4a1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408022; c=relaxed/simple;
	bh=wmCKnafu2h7MDbP3w4wVZg5AkLPmB6uiP6QOo+00j0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=si+gxTyd432WcAazJT3HR6XNGG3W4JBkDEFacBtfxVktnNErrNmmYrA4S4fzhRGldpJiPVn7i6EbLs8F8y0JwTb6DBUExtgZk0AlYNaYBHRsqp5zj4GWaMHo8THMl4Rh+t7ckMmtBCJ3P0vkZyStVQ1N2Z/JQwCu5M8mwtyQnco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JOnW8+h7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB6FC4CECD;
	Tue, 12 Nov 2024 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408022;
	bh=wmCKnafu2h7MDbP3w4wVZg5AkLPmB6uiP6QOo+00j0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOnW8+h7JtHimygUiks0Rp+EozxiqBuK+LeHiwSND7EFM1jKE11BjWqKBtf1wMHJb
	 9QCTcUQj07IFIvUXZJq63uOB7tqGp8i6hn2E1DUq4u7pW5QyzevBiRFpdXPHHKeITM
	 0pnGGg8rGczLHUlZa91wgkXaUA+BPp8Qmjmd5WfY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 036/184] NFS: Fix attribute delegation behaviour on exclusive create
Date: Tue, 12 Nov 2024 11:19:54 +0100
Message-ID: <20241112101902.253198387@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit d054c5eb2890633935c23c371f45fb2d6b3b4b64 ]

When the client does an exclusive create and the server decides to store
the verifier in the timestamps, a SETATTR is subsequently sent to fix up
those timestamps. When that is the case, suppress the exceptions for
attribute delegations in nfs4_bitmap_copy_adjust().

Fixes: 32215c1f893a ("NFSv4: Don't request atime/mtime/size if they are delegated to us")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index cd2fbde2e6d72..9d40319e063de 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3452,6 +3452,10 @@ static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 		adjust_flags |= NFS_INO_INVALID_MODE;
 	if (sattr->ia_valid & (ATTR_UID | ATTR_GID))
 		adjust_flags |= NFS_INO_INVALID_OTHER;
+	if (sattr->ia_valid & ATTR_ATIME)
+		adjust_flags |= NFS_INO_INVALID_ATIME;
+	if (sattr->ia_valid & ATTR_MTIME)
+		adjust_flags |= NFS_INO_INVALID_MTIME;
 
 	do {
 		nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, fattr->label),
-- 
2.43.0




