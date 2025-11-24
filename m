Return-Path: <stable+bounces-196776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51770C81F59
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 18:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1B293490CE
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 17:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317D2C0F91;
	Mon, 24 Nov 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFycThkt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B12C3770
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006308; cv=none; b=UktNXztgbs/HVKxmqUgEhP7NapfHjBdrdkuOA2raVtz8aXPHFnISreQpppBE2OjEopfzRUyBlJrGFwPfihRSLe2SCR59UugXod8AXfyOYBcxxyFFW2kVnLDQNmY74fZVwyMgSGq3xzLZ/g55MuZtFdktQZpdK9GhGsEVYBk2stE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006308; c=relaxed/simple;
	bh=RTiXMRbYvF9Qka4oYV3R9/MZFOwCgGadKAdJrIqjOek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNbAzpTQAbyF5u49MraLaBbHTDkTQN2glYbJ1HQZbByKqCbg667bAXP1SeoR2wAShCoecVeoz859QUIfml0zkHMK0N7Txejj37VnwQGOo5f+VQg9XyKol8Wd8UqQXihhqRlGNIImGbH483IxMUsBJcPpKMLnSACmhNCNOvFrI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFycThkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E939C116C6;
	Mon, 24 Nov 2025 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764006306;
	bh=RTiXMRbYvF9Qka4oYV3R9/MZFOwCgGadKAdJrIqjOek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFycThktaEvBRGMct3BmcCMVXHDxK1A4uJgAy13wQv5yCDaIcpV0jGHOr0RPN6j/7
	 UDS57eDHYg8U2sopRU8VTypZgf4GaYtZR96x0OXpoWs+wfBM8fRkR3XLM/99ycMjid
	 Hk3NUqaEY+90g/u29aPuk0KEIL7tYW41GaIu5fh6/oNFBzCs5j7YH/fi1//6uXTVf7
	 8uhOu4FmaT9/MvIqKFReLxQNLbfNUj6z8/X4Fllny2/3fTPV4EkeCoTngzVI3V2ZJZ
	 M8uEHIdxZ7MLtf8cmgVfONnJwiWBJX9SBevCxLmgXz7G568EFwToXDpRinMJ9mRmR0
	 VtWLE3XZu8FDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marcelo Moreira <marcelomoreira1905@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] xfs: Replace strncpy with memcpy
Date: Mon, 24 Nov 2025 12:45:02 -0500
Message-ID: <20251124174503.4167383-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112457-shining-trough-db05@gregkh>
References: <2025112457-shining-trough-db05@gregkh>
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


