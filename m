Return-Path: <stable+bounces-101741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971109EEE69
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365C31652DC
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CACF223E77;
	Thu, 12 Dec 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LLAMAzgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB170223E71;
	Thu, 12 Dec 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018636; cv=none; b=uqgw86UaGxupXR83KydSo7kAHkn2H+WuLX95+160/nmbBw5KlVRu/SBWPe+gnCxnLnk5JZpyYFeaRyIQf+wqz/9D1uTnLnvRPIhb1WmgWzQIMuC4XYA/GzZwWhqiIDxdRl6rlpI1BM3lI5Y1Wy3K5vvbFVSSPytAz9vphG2Pdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018636; c=relaxed/simple;
	bh=ODsubUYMWhTZcXcLb++rNHgIw1G0b6BByKJhfefe7fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQqTdvnnk3fAXyjvp1/7q8eC2svE+bo/uHPawiCvMqdgstjyDkeqEJDjFGoCnJd8GRGEWYWTrHu7Fyx7AJkt494gV0uzRgYg190WHcyTjC/h/LyMH+PHHPCXWVTdlVmlZZugvKLleukjkEz17sAs3A7lspb34/7asXm51wuJM/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LLAMAzgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD153C4CECE;
	Thu, 12 Dec 2024 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734018636;
	bh=ODsubUYMWhTZcXcLb++rNHgIw1G0b6BByKJhfefe7fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLAMAzggYYTm0MXVjj6fs8ntODGccM8/QYADmEjuU+SIRuEU0LYJHJFIDUoBfGiFf
	 cEsByE+NDeJQc6UzaGwFZwAMHZdVenLugfSMbbJsrxIjx1onvPuDpksBCJyUdwAgWi
	 uwRF6cmF/egAGYBKf6ncuiOJlYigqXtDrAMLhzh0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heming Zhao <heming.zhao@suse.com>
Subject: [PATCH 6.6 346/356] ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2 volume"
Date: Thu, 12 Dec 2024 16:01:05 +0100
Message-ID: <20241212144258.236801729@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heming Zhao <heming.zhao@suse.com>

This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
unmounting an ocfs2 volume").

In commit dfe6c5692fb5, the commit log "This bug has existed since the
initial OCFS2 code." is wrong. The correct introduction commit is
30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").

The influence of commit dfe6c5692fb5 is that it provides a correct
fix for the latest kernel. however, it shouldn't be pushed to stable
branches. Let's use this commit to revert all branches that include
dfe6c5692fb5 and use a new fix method to fix commit 30dd3478c3cd.

Fixes: dfe6c5692fb5 ("ocfs2: fix the la space leak when unmounting an ocfs2 volume")
Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/localalloc.c |   19 -------------------
 1 file changed, 19 deletions(-)

--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -1008,25 +1008,6 @@ static int ocfs2_sync_local_to_main(stru
 		start = bit_off + 1;
 	}
 
-	/* clear the contiguous bits until the end boundary */
-	if (count) {
-		blkno = la_start_blk +
-			ocfs2_clusters_to_blocks(osb->sb,
-					start - count);
-
-		trace_ocfs2_sync_local_to_main_free(
-				count, start - count,
-				(unsigned long long)la_start_blk,
-				(unsigned long long)blkno);
-
-		status = ocfs2_release_clusters(handle,
-				main_bm_inode,
-				main_bm_bh, blkno,
-				count);
-		if (status < 0)
-			mlog_errno(status);
-	}
-
 bail:
 	if (status)
 		mlog_errno(status);



