Return-Path: <stable+bounces-170081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39083B2A27F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F6F1787E6
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2681431E0F4;
	Mon, 18 Aug 2025 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QMFde/9w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D519731E0EE;
	Mon, 18 Aug 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521453; cv=none; b=RD0jsns38qrAJrD6Inzewnqs3xzPXYanJtw1rCVpB0OAJNI9ogyGNOrZRVXTl6ikTPf5rxLMlcAqKKi7QCZYkEWGmX7lQnnd4dWRQKD+3ohFiFl79YYhRAyPNm0iEKGIiFs6rkhRldfuWAyp2CX1Inf5pKtZnccRFIiEuaDfqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521453; c=relaxed/simple;
	bh=AANuWKGRQLHGmfXLN3YXsGI6HF0F9Ux8JEkEIxB03XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiRWZMSQLhou/IiUd0V5nRmU3sBCSIsoKr4LRph64S/Is2qHwRveqMB1fCS77LnmTqmXqQO86bKdBiky1HUuMtyWsYhkMMPeVrbZRwVU7x1ytaitZvaY7TNH2C2Kzfd0V19ydZDV27Z1li95V7lUP5zUPhN8T1ACBSs/5ru0CSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QMFde/9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C2FC4CEEB;
	Mon, 18 Aug 2025 12:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521453;
	bh=AANuWKGRQLHGmfXLN3YXsGI6HF0F9Ux8JEkEIxB03XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QMFde/9wEKhN68dJ6nGXVl5rkcFN7wBPsg3xeWw2UGaEJRqD5EUr33R/4+F5aFK9c
	 IRXShqM3oa5DC0bnakGgoMlY6vp3vQvGOgbaAd1qHtutKF8CSwRitsj1cd2n0bSSqF
	 BJcn3sr/I4Oqu9v9/Vwz25BkvT74H3QJadIUbdCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petro Pavlov <petro.pavlov@vastdata.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.12 024/444] NFSD: detect mismatch of file handle and delegation stateid in OPEN op
Date: Mon, 18 Aug 2025 14:40:50 +0200
Message-ID: <20250818124449.837685135@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

From: Dai Ngo <dai.ngo@oracle.com>

commit 9c65001c57164033ad08b654c8b5ae35512ddf4a upstream.

When the client sends an OPEN with claim type CLAIM_DELEG_CUR_FH or
CLAIM_DELEGATION_CUR, the delegation stateid and the file handle
must belong to the same file, otherwise return NFS4ERR_INVAL.

Note that RFC8881, section 8.2.4, mandates the server to return
NFS4ERR_BAD_STATEID if the selected table entry does not match the
current filehandle. However returning NFS4ERR_BAD_STATEID in the
OPEN causes the client to retry the operation and therefor get the
client into a loop. To avoid this situation we return NFS4ERR_INVAL
instead.

Reported-by: Petro Pavlov <petro.pavlov@vastdata.com>
Fixes: c44c5eeb2c02 ("[PATCH] nfsd4: add open state code for CLAIM_DELEGATE_CUR")
Cc: stable@vger.kernel.org
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6150,6 +6150,20 @@ nfsd4_process_open2(struct svc_rqst *rqs
 		status = nfs4_check_deleg(cl, open, &dp);
 		if (status)
 			goto out;
+		if (dp && nfsd4_is_deleg_cur(open) &&
+				(dp->dl_stid.sc_file != fp)) {
+			/*
+			 * RFC8881 section 8.2.4 mandates the server to return
+			 * NFS4ERR_BAD_STATEID if the selected table entry does
+			 * not match the current filehandle. However returning
+			 * NFS4ERR_BAD_STATEID in the OPEN can cause the client
+			 * to repeatedly retry the operation with the same
+			 * stateid, since the stateid itself is valid. To avoid
+			 * this situation NFSD returns NFS4ERR_INVAL instead.
+			 */
+			status = nfserr_inval;
+			goto out;
+		}
 		stp = nfsd4_find_and_lock_existing_open(fp, open);
 	} else {
 		open->op_file = NULL;



