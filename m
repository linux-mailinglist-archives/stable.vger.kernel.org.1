Return-Path: <stable+bounces-107594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94592A02CA0
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6ABE164569
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBEF156237;
	Mon,  6 Jan 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GrMUZ88b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24013B59A;
	Mon,  6 Jan 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178941; cv=none; b=dZbbnlqPJuP2FUZQoYYfl3p6qTTBfmYMa1crvfZ3V7HaVTPfIaD8bFME70VhhKjgtcTp9D4mM+7ptY+8jPqcQSL1jdEGlYC8h8fQSL2k74IE/0F+oQsVWWXhZ6uMBAG6eZPTK+FxOXOIi/0qN5DO5MvcKEss4cGAUyHf5sSPYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178941; c=relaxed/simple;
	bh=vZcG2qUVvpil5sqQnqGomtdB3/poxVF1rcBhy5jP3UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxDUZXt7pszI/WrCqKUckcAZUB8N5E3uLOfm33PW508MjZkqOr4pluiKeFNw8Z0BnnNOm3M2skYz56zDLSLVj6yi7dOhSyGLS2jFr+0SBqsNVGf4u++XZk3dKnW6Q+2uaIuowxeCXYewaMib3Rwdv/xKFZR3ZRTyG2pQcjr3bdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GrMUZ88b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EFDC4CED2;
	Mon,  6 Jan 2025 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178941;
	bh=vZcG2qUVvpil5sqQnqGomtdB3/poxVF1rcBhy5jP3UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GrMUZ88bHSlrEXAXlj0+UxGgXmE9vZeZhv/UMlU+wuAAE7vIgi3Y3hsFMUkKnmGbK
	 e5I2FsyfPIIyx+/tbqtKxqSNjjFACPDRGQQ9Htf3nBHkZO+aiBQKBdJKgFA4VRcOrA
	 1Ibo5xwvetcc8ArqK24vGnakq5qtCKNG332H9Mr8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15 101/168] btrfs: avoid monopolizing a core when activating a swap file
Date: Mon,  6 Jan 2025 16:16:49 +0100
Message-ID: <20250106151142.276177407@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 2c8507c63f5498d4ee4af404a8e44ceae4345056 upstream.

During swap activation we iterate over the extents of a file and we can
have many thousands of them, so we can end up in a busy loop monopolizing
a core. Avoid this by doing a voluntary reschedule after processing each
extent.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7698,6 +7698,8 @@ noinline int can_nocow_extent(struct ino
 			ret = -EAGAIN;
 			goto out;
 		}
+
+		cond_resched();
 	}
 
 	btrfs_release_path(path);



