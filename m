Return-Path: <stable+bounces-116258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496D0A3475C
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 932BF7A1443
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C85153828;
	Thu, 13 Feb 2025 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lI4dyHQZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6E470805;
	Thu, 13 Feb 2025 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460863; cv=none; b=H8JUKN15z7JtI/dijmFhMRaz4zE0BT4mDLmFOeIVB/ZtEXhzQ3O+AlnwyRwXRx16m1lh/xH8Vn1xSqH2GuvSrcYUeTtcEOJ1OUFOtMG35KRdZ/6tSr7x0WFFtJKFd59vHl6qwhko7tdTuwyojih+ejGf0BR9stz95FGjkhTQmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460863; c=relaxed/simple;
	bh=yq/GRJItluuu4MI5tyF3AiKOtlYMYciQ3EfcRlO31mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6AF/WksndWrJtsCQO43whCkEITGZQ3OLSpHxj1JUWpYPqJsSYipvvmD92cDCSO9rR/Tx/HmHDo+QC8Awma1R/k6uJfavZjPxmi4BeYCXCwY3SygVU50swh9wDSZlh31ui8HZQfTAImD1DJzYHmt4SLn0euHGt6mKfrPZgAsHeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lI4dyHQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C28CC4CED1;
	Thu, 13 Feb 2025 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739460863;
	bh=yq/GRJItluuu4MI5tyF3AiKOtlYMYciQ3EfcRlO31mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lI4dyHQZF/tK4TAi9e8Pm+8v9ny/FQMy54qnmZQWQUI8fL8eFPXnsrLpB0FrctfQk
	 gO2D583xM4RV9LQq9j4ipCNGl2piWnWpT48spV9MdppFbVR/ko2Pi+JYL4SkoCjCBO
	 TEQUFvODnVJsTU76fNhUHHKQkfqeGQD/+GSgBjzI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heming Zhao <heming.zhao@suse.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 233/273] ocfs2: fix incorrect CPU endianness conversion causing mount failure
Date: Thu, 13 Feb 2025 15:30:05 +0100
Message-ID: <20250213142416.642831765@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142407.354217048@linuxfoundation.org>
References: <20250213142407.354217048@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heming Zhao <heming.zhao@suse.com>

commit f921da2c34692dfec5f72b5ae347b1bea22bb369 upstream.

Commit 23aab037106d ("ocfs2: fix UBSAN warning in ocfs2_verify_volume()")
introduced a regression bug.  The blksz_bits value is already converted to
CPU endian in the previous code; therefore, the code shouldn't use
le32_to_cpu() anymore.

Link: https://lkml.kernel.org/r/20250121112204.12834-1-heming.zhao@suse.com
Fixes: 23aab037106d ("ocfs2: fix UBSAN warning in ocfs2_verify_volume()")
Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2343,7 +2343,7 @@ static int ocfs2_verify_volume(struct oc
 			mlog(ML_ERROR, "found superblock with incorrect block "
 			     "size bits: found %u, should be 9, 10, 11, or 12\n",
 			     blksz_bits);
-		} else if ((1 << le32_to_cpu(blksz_bits)) != blksz) {
+		} else if ((1 << blksz_bits) != blksz) {
 			mlog(ML_ERROR, "found superblock with incorrect block "
 			     "size: found %u, should be %u\n", 1 << blksz_bits, blksz);
 		} else if (le16_to_cpu(di->id2.i_super.s_major_rev_level) !=



