Return-Path: <stable+bounces-53563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA790D260
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD601284995
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9513A877;
	Tue, 18 Jun 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wg1ftchd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62C015A846;
	Tue, 18 Jun 2024 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716701; cv=none; b=gMZboK1s4JVC6TXiJlj214R/l5MwkNsChjzr30aMFCDh6BTjBAYH47sg11B7wy9Dhkv3Md8WuaCmQ/MeGS604ZUJSwF/7WxFUETu1QJZUi4Hk10npzzoifxF555ZY1Gf0xjdbBNV6QMVCLcn0iieTSm6/Dos1yBoJxTeDxxCH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716701; c=relaxed/simple;
	bh=ho4LTk+qjsA4vddtKNEOe8Ji/CUyAgbn/baNnqQXa8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ts2jYwEAi1bipIpEBKZCpqFupYKSy5wy8+KYyEOdFAL6GTwfiHlvOR0+z7g2glc7fakUQYkTrenLcRvU4mXXA+yuiO4VsYyT+aPpCzn/ejdjatgwYdLQm33v9PWob/R0bCpnEkbXvjRXckExWh2TATjVxhGfaxExB/E/Wcy0CnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wg1ftchd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB75C3277B;
	Tue, 18 Jun 2024 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716700;
	bh=ho4LTk+qjsA4vddtKNEOe8Ji/CUyAgbn/baNnqQXa8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wg1ftchdw8T8BkzutPFcrI+36/oyx1WYT1hls7U8w6qCzBro/yCOV/w6Ynecro9GF
	 aGcscGWurhdWHuqJqM5F2n0+DGVuy/hvI5oDdKNH8r3wa903imAp1Wt5PrpxrPhaII
	 G5oMslB9B/3KDgKBez/sCIayH12T/cNn4kN2/GVI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boyang Xue <bxue@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 734/770] nfsd: dont hand out delegation on setuid files being opened for write
Date: Tue, 18 Jun 2024 14:39:47 +0200
Message-ID: <20240618123435.598972907@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 826b67e6376c2a788e3a62c4860dcd79500a27d5 ]

We had a bug report that xfstest generic/355 was failing on NFSv4.0.
This test sets various combinations of setuid/setgid modes and tests
whether DIO writes will cause them to be stripped.

What I found was that the server did properly strip those bits, but
the client didn't notice because it held a delegation that was not
recalled. The recall didn't occur because the client itself was the
one generating the activity and we avoid recalls in that case.

Clearing setuid bits is an "implicit" activity. The client didn't
specifically request that we do that, so we need the server to issue a
CB_RECALL, or avoid the situation entirely by not issuing a delegation.

The easiest fix here is to simply not give out a delegation if the file
is being opened for write, and the mode has the setuid and/or setgid bit
set. Note that there is a potential race between the mode and lease
being set, so we test for this condition both before and after setting
the lease.

This patch fixes generic/355, generic/683 and generic/684 for me. (Note
that 355 fails only on v4.0, and 683 and 684 require NFSv4.2 to run and
fail).

Reported-by: Boyang Xue <bxue@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2733eb33d5df2..f57137ef306bd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5435,6 +5435,23 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *open, struct nfs4_file *fp,
 	return 0;
 }
 
+/*
+ * We avoid breaking delegations held by a client due to its own activity, but
+ * clearing setuid/setgid bits on a write is an implicit activity and the client
+ * may not notice and continue using the old mode. Avoid giving out a delegation
+ * on setuid/setgid files when the client is requesting an open for write.
+ */
+static int
+nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_file *nf)
+{
+	struct inode *inode = file_inode(nf->nf_file);
+
+	if ((open->op_share_access & NFS4_SHARE_ACCESS_WRITE) &&
+	    (inode->i_mode & (S_ISUID|S_ISGID)))
+		return -EAGAIN;
+	return 0;
+}
+
 static struct nfs4_delegation *
 nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		    struct svc_fh *parent)
@@ -5468,6 +5485,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	spin_lock(&fp->fi_lock);
 	if (nfs4_delegation_exists(clp, fp))
 		status = -EAGAIN;
+	else if (nfsd4_verify_setuid_write(open, nf))
+		status = -EAGAIN;
 	else if (!fp->fi_deleg_file) {
 		fp->fi_deleg_file = nf;
 		/* increment early to prevent fi_deleg_file from being
@@ -5508,6 +5527,14 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (status)
 		goto out_unlock;
 
+	/*
+	 * Now that the deleg is set, check again to ensure that nothing
+	 * raced in and changed the mode while we weren't lookng.
+	 */
+	status = nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
+	if (status)
+		goto out_unlock;
+
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
 	if (fp->fi_had_conflict)
-- 
2.43.0




