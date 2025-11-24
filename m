Return-Path: <stable+bounces-196778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B58C81FD1
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 18:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 050B94E641D
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725FC3019C2;
	Mon, 24 Nov 2025 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGGlZ3rF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322822C0F91
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006970; cv=none; b=gMaJy0DVflT6oRAOs3YUoIep1X/N94zO80Jfs5NuebK+umfF13tGwYAoWNoHTBUj6PgWEP4Xekm0A9WtC56HngGmPCvS3EMDw4knNjuNlq9G5kTZQEwc+7lz+tO+jPaM3QxvolOjDM0s26AecFc6R6MNHiD53l1cb8UnmaZiNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006970; c=relaxed/simple;
	bh=RTiXMRbYvF9Qka4oYV3R9/MZFOwCgGadKAdJrIqjOek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9i9/WGFflp4YkA17VHEda8Qzt8JS1Q8s30p2PGy88fKSkyfgibjuuPLZURqNpeTP6AEXfroC+OyScqfTAiYBHfw/hKlmUYrYS7uk1R1Ndlly0iJNfPAFHuEep2ykdzFUsqERJ0leOYcbuGwLRoVkSqN8qdpH/pWobVjJhStBOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGGlZ3rF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0909DC4CEF1;
	Mon, 24 Nov 2025 17:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764006968;
	bh=RTiXMRbYvF9Qka4oYV3R9/MZFOwCgGadKAdJrIqjOek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGGlZ3rFkABSK0iO8U47cDpPcuYcQBRyRiYfcwa/wAGFqSjglxEa+/JEXhO4twf7L
	 8yy4ND43WHb80R65xDcibdDrmprelViS5VQ1dUMI2ABow2ZDrYIrMo8ak2684IQ+GD
	 D1Ugaf9vSSPuxeBdeMhoIhye5teiJuwir8wtFA+NTVo3RN6EOUXYYhYVTVzA8MSIak
	 TPUyH/06avXxpDgz0rHpwVdzaRjm+kbjCHRw4RTh4yZr/ob8xKIiNpGBw/toIvM5Jg
	 Ho3Qkk84oYJQ/4+F1Y3kdqpTR9xC9m4+N4Yz5NYHYOQxRh5C6ROCt8s5EgQ9oxWgmg
	 vOsgB66oVWJTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marcelo Moreira <marcelomoreira1905@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] xfs: Replace strncpy with memcpy
Date: Mon, 24 Nov 2025 12:56:05 -0500
Message-ID: <20251124175606.4173445-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112403-evaluate-bogged-d093@gregkh>
References: <2025112403-evaluate-bogged-d093@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcelo Moreira <marcelomoreira1905@gmail.com>

[ Upstream commit 33ddc796ecbd50cd6211aa9e9eddbf4567038b49 ]

The changes modernizes the code by aligning it with current kernel best
practices. It improves code clarity and consistency, as strncpy is deprecated
as explained in Documentation/process/deprecated.rst. This change does
not alter the functionality or introduce any behavioral changes.

Suggested-by: Dave Chinner <david@fromorbit.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 678e1cc2f482 ("xfs: fix out of bounds memory read error in symlink repair")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/symlink_repair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/symlink_repair.c b/fs/xfs/scrub/symlink_repair.c
index 953ce7be78dc2..5902398185a89 100644
--- a/fs/xfs/scrub/symlink_repair.c
+++ b/fs/xfs/scrub/symlink_repair.c
@@ -185,7 +185,7 @@ xrep_symlink_salvage_inline(
 		return 0;
 
 	nr = min(XFS_SYMLINK_MAXLEN, xfs_inode_data_fork_size(ip));
-	strncpy(target_buf, ifp->if_data, nr);
+	memcpy(target_buf, ifp->if_data, nr);
 	return nr;
 }
 
-- 
2.51.0


