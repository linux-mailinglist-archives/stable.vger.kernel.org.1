Return-Path: <stable+bounces-171444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2D8B2AA09
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F266A5851D2
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ECA322C95;
	Mon, 18 Aug 2025 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jP+M66ie"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51625350847;
	Mon, 18 Aug 2025 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525944; cv=none; b=CX9uU5pbyd2NjkZB7jZIfynP0bzj63WhzF0JuOTIgUi4OI9bAT2KCcVqaWxlhfPAVolLBVUVY5nP+ZyZ3USHzyhG4RR6n4faJVyEydhcychbKKRheJxDCo7yNLBeDEVgBDQ9XnH8zwxFkU1AGWK/ze/ngZriVs3XeVZz16+mCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525944; c=relaxed/simple;
	bh=BPSQ4DjvlUGtCAnx/w5O7VIj9ySMPBEEhsC+BOhCy8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0kPid8nVQCG7RWTtBOSuPlTc08SUxzpXy2HmmSCZp/nQIm262g5zXe865GqrA4y2N6pFGoJgnl/B+ugOPpYahyfSc6m+3r7RehbIt9mRFrmBZcJVInnoTfKDwYgdv6CpbHYBQk8yAAm7+5/SLN79gWMTs8LOn+L6ahtL1x5lLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jP+M66ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C80C4CEEB;
	Mon, 18 Aug 2025 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525944;
	bh=BPSQ4DjvlUGtCAnx/w5O7VIj9ySMPBEEhsC+BOhCy8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jP+M66ienXoGVVkUDjfkzaPwOKaOgE9g8EAdqAcUfbWCh5/upVX9hvTeWQPErsOpF
	 vKIUXs0XQr2FQFungj5k6AZS9Ry6RIxg2w0jnFwtAfh0XC9PyUrW/o2xNCT8Ei54Eb
	 dyu7Fbcf/elr+2OCS6z/CLV+eR8rmfMXjszpOCZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+6e516bb515d93230bc7b@syzkaller.appspotmail.com,
	Lizhi Xu <lizhi.xu@windriver.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 379/570] jfs: truncate good inode pages when hard link is 0
Date: Mon, 18 Aug 2025 14:46:06 +0200
Message-ID: <20250818124520.454238893@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Xu <lizhi.xu@windriver.com>

[ Upstream commit 2d91b3765cd05016335cd5df5e5c6a29708ec058 ]

The fileset value of the inode copy from the disk by the reproducer is
AGGR_RESERVED_I. When executing evict, its hard link number is 0, so its
inode pages are not truncated. This causes the bugon to be triggered when
executing clear_inode() because nrpages is greater than 0.

Reported-by: syzbot+6e516bb515d93230bc7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6e516bb515d93230bc7b
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 60fc92dee24d..81e6b18e81e1 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -145,9 +145,9 @@ void jfs_evict_inode(struct inode *inode)
 	if (!inode->i_nlink && !is_bad_inode(inode)) {
 		dquot_initialize(inode);
 
+		truncate_inode_pages_final(&inode->i_data);
 		if (JFS_IP(inode)->fileset == FILESYSTEM_I) {
 			struct inode *ipimap = JFS_SBI(inode->i_sb)->ipimap;
-			truncate_inode_pages_final(&inode->i_data);
 
 			if (test_cflag(COMMIT_Freewmap, inode))
 				jfs_free_zero_link(inode);
-- 
2.39.5




