Return-Path: <stable+bounces-37197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9019989C3C5
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C113B1C21BBB
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764AE4D5AB;
	Mon,  8 Apr 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0AQPCPDG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4F7F46C;
	Mon,  8 Apr 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583532; cv=none; b=S36ybsLdrqqAuUZUiXsA5gWn9dzm1FPJBLlj+vL/Gxy5oXrBRey3PcDSv+hPezcyh+WQ9YOJT60/u1HrF9OhNjFipiso0vcNeNt8d5Z5S7/uzVYeektG8jE1yP9xHCwv1tCuw4teRIzOXfnZcc6ukuiVVUlDulXc8HNOOW65KOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583532; c=relaxed/simple;
	bh=1In+65lKRZ26DXn5ujnZyFEnGMvF2wbUIOPKhz2/n2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVn5v72wLtdOhL3Vjh+tPZRvWCrXRZvFQECIsxO+8pbwvyYtLkR6gEQncjoTLN14wk6wCjNesRNX5VNUH5wpBr+wNmkeDV8AjsGc4o2+VEKrrtleLd+lG+W0KaM2M/DuuQNk9TiPmcwNOF8nAQTQ3Oodz+HmjtMOe42SIBRglNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0AQPCPDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B034AC433F1;
	Mon,  8 Apr 2024 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583532;
	bh=1In+65lKRZ26DXn5ujnZyFEnGMvF2wbUIOPKhz2/n2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0AQPCPDGJd6TgVDDSV+diXYDzgg6cUiqJiuF45aHRlnJjkOSKm6j0NwrYfnA6xLwJ
	 2n4SDYEm/6BqS6sn/3PXBUe1IZ80LFckfvXpe2VG3eLm8SHu1YH91tecnLx85gEA8t
	 h5qSreGSY/wAM8xn9UVJgKx5dizCD+AN/8SP/4uI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 257/690] NFSD: Clean up nfsd_vfs_write()
Date: Mon,  8 Apr 2024 14:52:03 +0200
Message-ID: <20240408125408.924797990@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 33388b3aefefd4d83764dab8038cb54068161a44 ]

The RWF_SYNC and !RWF_SYNC arms are now exactly alike except that
the RWF_SYNC arm resets the boot verifier twice in a row. Fix that
redundancy and de-duplicate the code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index bc025fe5a595b..98d370dcca867 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1009,22 +1009,11 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 
 	iov_iter_kvec(&iter, WRITE, vec, vlen, *cnt);
 	since = READ_ONCE(file->f_wb_err);
-	if (flags & RWF_SYNC) {
-		if (verf)
-			nfsd_copy_boot_verifier(verf,
-					net_generic(SVC_NET(rqstp),
-					nfsd_net_id));
-		host_err = vfs_iter_write(file, &iter, &pos, flags);
-		if (host_err < 0)
-			nfsd_reset_boot_verifier(net_generic(SVC_NET(rqstp),
-						 nfsd_net_id));
-	} else {
-		if (verf)
-			nfsd_copy_boot_verifier(verf,
-					net_generic(SVC_NET(rqstp),
-					nfsd_net_id));
-		host_err = vfs_iter_write(file, &iter, &pos, flags);
-	}
+	if (verf)
+		nfsd_copy_boot_verifier(verf,
+				net_generic(SVC_NET(rqstp),
+				nfsd_net_id));
+	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	if (host_err < 0) {
 		nfsd_reset_boot_verifier(net_generic(SVC_NET(rqstp),
 					 nfsd_net_id));
-- 
2.43.0




