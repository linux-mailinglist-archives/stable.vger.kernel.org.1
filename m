Return-Path: <stable+bounces-84841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749BE99D257
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209B21F25065
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03151B85E1;
	Mon, 14 Oct 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zhbi3zCK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4CF3B298;
	Mon, 14 Oct 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919393; cv=none; b=j2uelpAyt0qVZbazoysTxtg2Pv8EwgOpzBtgtXn2zNNZqsVhBmlNRk6VInKc3Om8bjvhfeVbHbjXw3Vlt9IrFagCYjcIg99z82942Pgrn85PXtVjvvH1KtqyvZuPtjXIQy1bpoYajJhvlUq8o2nYnxct6fARkgmErwhey2wU4CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919393; c=relaxed/simple;
	bh=yiqICCVPovMdV2hH/CkWvE50qX6k3EUozm6RHCL8GWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lbu03etNOR844KB7zbsjjopIn7gznUoaFiCqIRwOKRZdS6PR0/EhFq6s9vorDimo8dMwZhJspCyFmitX16KOMxutLn1c8HKtVTkLCJR5hLwQDE8uDPgUH8c5Dxuy8pAufeHtdB174HAzZMC6gr933BcaaTEoCSOLFxmAp2rUTno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zhbi3zCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC118C4CEC3;
	Mon, 14 Oct 2024 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728919393;
	bh=yiqICCVPovMdV2hH/CkWvE50qX6k3EUozm6RHCL8GWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zhbi3zCKrfboBCwkM5T+LdAsIs/KGqbmPffoPGBo+q8iDB31dtTYvzLHIwEtE32f8
	 gwHS6VyO5UI68gR+FRsJW3QBE7XWCp8nSzoPpLJTKUFQ844coia3gRkYcnRhNdb4Zg
	 opd+PYo0+fhHgra6p1gQlGUEZOshWp59S0tQC5ks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heming Zhao <heming.zhao@suse.com>,
	Su Yue <glass.su@suse.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Gang He <ghe@suse.com>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 566/798] ocfs2: fix the la space leak when unmounting an ocfs2 volume
Date: Mon, 14 Oct 2024 16:18:40 +0200
Message-ID: <20241014141240.233700633@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

From: Heming Zhao <heming.zhao@suse.com>

commit dfe6c5692fb525e5e90cefe306ee0dffae13d35f upstream.

This bug has existed since the initial OCFS2 code.  The code logic in
ocfs2_sync_local_to_main() is wrong, as it ignores the last contiguous
free bits, which causes an OCFS2 volume to lose the last free clusters of
LA window on each umount command.

Link: https://lkml.kernel.org/r/20240719114310.14245-1-heming.zhao@suse.com
Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Reviewed-by: Su Yue <glass.su@suse.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/localalloc.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -1008,6 +1008,25 @@ static int ocfs2_sync_local_to_main(stru
 		start = bit_off + 1;
 	}
 
+	/* clear the contiguous bits until the end boundary */
+	if (count) {
+		blkno = la_start_blk +
+			ocfs2_clusters_to_blocks(osb->sb,
+					start - count);
+
+		trace_ocfs2_sync_local_to_main_free(
+				count, start - count,
+				(unsigned long long)la_start_blk,
+				(unsigned long long)blkno);
+
+		status = ocfs2_release_clusters(handle,
+				main_bm_inode,
+				main_bm_bh, blkno,
+				count);
+		if (status < 0)
+			mlog_errno(status);
+	}
+
 bail:
 	if (status)
 		mlog_errno(status);



