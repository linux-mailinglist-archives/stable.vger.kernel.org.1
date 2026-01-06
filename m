Return-Path: <stable+bounces-205268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10068CF9D4F
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 18:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C89A030E4A15
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EF1350A34;
	Tue,  6 Jan 2026 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uE5GKBMs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5F350A30;
	Tue,  6 Jan 2026 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720132; cv=none; b=TeXsf90B8P6OAynD/0NruBTiA8xmVapjycsyBfABdimEZfJMC+RPYv5rEziDFIB1a+APWDVViKDQMhF7+MmrtgPvfmzQ2cnAfjvj88qbMt1uvFufsNerY1cP3/GNFurRZDOxiULiNOlMITUX978vlzS8CxM3WVtK0n0yuawooq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720132; c=relaxed/simple;
	bh=HMsbp7ukdJtTE/8th+CXtJFrvdtGeX3NvVFgmlreZpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmODLTYmg+xsBYkz4JocLrN+t44gu7l9DK/B7YQz+SObbpZBiAFrx1Z3ikEXY9qiliXxvOd9pJ0GkjaNV5z4kmFLRitTEZr7Ndls85taJtUUGvmWjvYnPjVdQYhmZp/HFgL3T8RLg1plp16e+fGIl2zLvGzPOKVU4a55werhYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uE5GKBMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6BBC19424;
	Tue,  6 Jan 2026 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767720131;
	bh=HMsbp7ukdJtTE/8th+CXtJFrvdtGeX3NvVFgmlreZpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uE5GKBMs4DH6G9yvZUiqVoD7CPlFdHbnjbAw57IxpLk96I9GcB9a3+lhAJwa0g1sH
	 WspEF6pu25++BgFIYAkFlfiIUjTzZN1gBvcyWlN6CsG52yKQyN4omuomxlefgEiQDC
	 tYOaakoKtNiFzwMgVkRtHK/6haK5l5v8oiMoWslc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.12 101/567] xfs: dont leak a locked dquot when xfs_dquot_attach_buf fails
Date: Tue,  6 Jan 2026 17:58:03 +0100
Message-ID: <20260106170455.064209851@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 204c8f77e8d4a3006f8abe40331f221a597ce608 upstream.

xfs_qm_quotacheck_dqadjust acquired the dquot through xfs_qm_dqget,
which means it owns a reference and holds q_qlock.  Both need to
be dropped on an error exit.

Cc: <stable@vger.kernel.org> # v6.13
Fixes: ca378189fdfa ("xfs: convert quotacheck to attach dquot buffers")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_qm.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -1134,7 +1134,7 @@ xfs_qm_quotacheck_dqadjust(
 
 	error = xfs_dquot_attach_buf(NULL, dqp);
 	if (error)
-		return error;
+		goto out_unlock;
 
 	trace_xfs_dqadjust(dqp);
 
@@ -1164,8 +1164,9 @@ xfs_qm_quotacheck_dqadjust(
 	}
 
 	dqp->q_flags |= XFS_DQFLAG_DIRTY;
+out_unlock:
 	xfs_qm_dqput(dqp);
-	return 0;
+	return error;
 }
 
 /*



