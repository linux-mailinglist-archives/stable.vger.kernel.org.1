Return-Path: <stable+bounces-48701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE98FEA1E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C871F25106
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC070196C93;
	Thu,  6 Jun 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n4E4nCoF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1519E7D1;
	Thu,  6 Jun 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683104; cv=none; b=LItR9GXtGhTT6/GGecKs8IUINU5CSdWRMHZToGOYVp4tYk/D2gec14X5/r4YwVSVNFdvOjhruDJPtj6bLNmtxyydYmgTggQNBozq3EyPzbln6n9OgPxYX2+1DCBDC/j65CcFtz6urQSg2sTcV47MC33lMYNHqtNcLM4P6FRAoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683104; c=relaxed/simple;
	bh=x6i3AWPKmOmfcEqwv5iULAadGLM7SxHxnKIOUlEBFsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tb2hHRsbHA0An8BdXXwO63AchsU9PizBjQ7gFYQlpOMnQq3mclmEWEcNXUoRPN7NE/89k5T3VP7jhigx83aMOOV1NqeNeaZa3ccJFctuhOeHjdzW3MW1pO4+rAQh7YC7ue4JEJ+LBHzBEYq6EUxHs92BTqDiCgQx0LcaqiU5XeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n4E4nCoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C685C2BD10;
	Thu,  6 Jun 2024 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683104;
	bh=x6i3AWPKmOmfcEqwv5iULAadGLM7SxHxnKIOUlEBFsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4E4nCoFEY8F7bV91ZS5Y6+9x5WTPbP7d3r5AXuVfTAVsPBA8EHRQ/JuFllshLuwN
	 3viLLDJb0To7x3jfjuLgcz7iLJRc2sxpGpxkZaBbAxyjH5OkMYe6ggfm620DgMMk8m
	 Nrmr3UygB0UOZx3KHnOhse6e3fSzwewowYZTo4UI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 6.6 026/744] fs/ntfs3: Break dir enumeration if directory contents error
Date: Thu,  6 Jun 2024 15:54:58 +0200
Message-ID: <20240606131733.276080004@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit 302e9dca8428979c9c99f2dbb44dc1783f5011c3 upstream.

If we somehow attempt to read beyond the directory size, an error
is supposed to be returned.

However, in some cases, read requests do not stop and instead enter
into a loop.

To avoid this, we set the position in the directory to the end.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/dir.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -475,6 +475,7 @@ static int ntfs_readdir(struct file *fil
 		vbo = (u64)bit << index_bits;
 		if (vbo >= i_size) {
 			ntfs_inode_err(dir, "Looks like your dir is corrupt");
+			ctx->pos = eod;
 			err = -EINVAL;
 			goto out;
 		}



