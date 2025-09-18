Return-Path: <stable+bounces-170541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83336B2A4C2
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD0B7A9AC9
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8EC221F15;
	Mon, 18 Aug 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VMNGmsDF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC2821FF4B;
	Mon, 18 Aug 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522973; cv=none; b=pyUPNOeozqFHdKtWNS5cfZ4u0K3/DKuEU8oe+3jsrl1QSvUjlW43EICE6tVcrsKZT1Jq38vAFN83dhaxOY0o+uVYKue212jQ6GH8j6yVWqWDxEZwl3lqm4CMr5Vm9TV142Ko5ovd3Jb2aSEQn48PhJdqL0YqfUcLccswXlbwMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522973; c=relaxed/simple;
	bh=CEWYjcqaaHr5F1tNBs+pXXT2WpyzT+qsDzgXThu+jCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/fwwrxoAj2gwN+9USOr1dvKG5GyE5xPcF3DsfVE/gjibZFso3uqHMfzF+zLzqjiNz5MgpfB1bHyPznkQOU83NckRRoQMJ4HpYclsc0iX//kgyyOmmnQenpfS4DAfrEcolEYyxh8mdEuLx4ZM4Fblu2qRTPOufwkmblqiONOpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VMNGmsDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A261DC116B1;
	Mon, 18 Aug 2025 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522973;
	bh=CEWYjcqaaHr5F1tNBs+pXXT2WpyzT+qsDzgXThu+jCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMNGmsDF4QSVhvh+O74lEO3y+Ml9OTKCcmLhxiwqHzn1fCAL7SRNc5QQheHM4loap
	 ayeUgUjbdhyfDPlxq+g0ztB/JB882z+7pPKMizgh7un7JBP9ywUedz3Rhcoo7yWrRs
	 CQEaMecS18YQYEpUhqaV7l8rShMkvgV3DNm7NH0U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petro Pavlov <petro.pavlov@vastdata.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.15 031/515] NFSD: detect mismatch of file handle and delegation stateid in OPEN op
Date: Mon, 18 Aug 2025 14:40:17 +0200
Message-ID: <20250818124459.652685176@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6328,6 +6328,20 @@ nfsd4_process_open2(struct svc_rqst *rqs
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



