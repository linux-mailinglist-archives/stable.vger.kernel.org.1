Return-Path: <stable+bounces-102206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFEB9EF1C4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DBB18986D3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33551223E99;
	Thu, 12 Dec 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zxzzmIRh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373B222D68;
	Thu, 12 Dec 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020373; cv=none; b=JhV7Lfyk/rL/RLOuhoAyq3ucxHh7l6gQ0LI7JqNOwTyKJThYfqdkFwfl9Q8srGy82opZik4u92mRqB29i7CDBQeh6wNevRgqTLrwDqVftSlsXxDG3aQQsxP6YqBn4NsaJ59jk3jJaptkLcydfuJJ6tTP4vHwi8rtmoT3mZvlHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020373; c=relaxed/simple;
	bh=qgJhTaSHitTXg6R9sRhf9d6NokqnWG2O8cf5QGDvdic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWHtvx9OtbNWbAAr/ArDv/nPhUVj+AVljU6tIyB/dtfLQwBgoFT4mUCLbzhz3lz1n40AZiBBC8OBDcvS4TgsA0soZquPsv1ezf9vaujhL1foKZT8xYrJtSl3BnlqCc4ujZdXEWhkQ4U4oV01kRhyzXqqIHMfqQxhMGhz87qJj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zxzzmIRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD5FC4CECE;
	Thu, 12 Dec 2024 16:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020372;
	bh=qgJhTaSHitTXg6R9sRhf9d6NokqnWG2O8cf5QGDvdic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zxzzmIRhWeKcnMsTQW0MS0YhJB0jkvXs9rF13PW5LU7NSey6sJFnrU/4U30W2aNLc
	 Oa8/D17Wqb2RzivLuWemarP47a/cw2wiPBlhmR8cm1ugeRLjLDVYuVnR4z/riNZWHp
	 YtX8MoCQ0Ri2zc0/NbNv5xvo7BUZO64yx+ITvlrE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 449/772] xfs: remove unknown compat feature check in superblock write validation
Date: Thu, 12 Dec 2024 15:56:34 +0100
Message-ID: <20241212144408.479440854@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit 652f03db897ba24f9c4b269e254ccc6cc01ff1b7 ]

Compat features are new features that older kernels can safely ignore,
allowing read-write mounts without issues. The current sb write validation
implementation returns -EFSCORRUPTED for unknown compat features,
preventing filesystem write operations and contradicting the feature's
definition.

Additionally, if the mounted image is unclean, the log recovery may need
to write to the superblock. Returning an error for unknown compat features
during sb write validation can cause mount failures.

Although XFS currently does not use compat feature flags, this issue
affects current kernels' ability to mount images that may use compat
feature flags in the future.

Since superblock read validation already warns about unknown compat
features, it's unnecessary to repeat this warning during write validation.
Therefore, the relevant code in write validation is being removed.

Fixes: 9e037cb7972f ("xfs: check for unknown v5 feature bits in superblock write verifier")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_sb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index c24a38272cb7c..d214233ef532f 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -259,13 +259,6 @@ xfs_validate_sb_write(
 	 * the kernel cannot support since we checked for unsupported bits in
 	 * the read verifier, which means that memory is corrupt.
 	 */
-	if (xfs_sb_has_compat_feature(sbp, XFS_SB_FEAT_COMPAT_UNKNOWN)) {
-		xfs_warn(mp,
-"Corruption detected in superblock compatible features (0x%x)!",
-			(sbp->sb_features_compat & XFS_SB_FEAT_COMPAT_UNKNOWN));
-		return -EFSCORRUPTED;
-	}
-
 	if (!xfs_is_readonly(mp) &&
 	    xfs_sb_has_ro_compat_feature(sbp, XFS_SB_FEAT_RO_COMPAT_UNKNOWN)) {
 		xfs_alert(mp,
-- 
2.43.0




