Return-Path: <stable+bounces-103752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311CD9EF996
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442B4189A20F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B7822968D;
	Thu, 12 Dec 2024 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qsVPzRvR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F937222D72;
	Thu, 12 Dec 2024 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025500; cv=none; b=DgwCJQHue6osurT8S9uXV7nXLndYZZTYNiH6pIs2JTb7gPd4SCij/ZZgoQLzME3SLIRY5Nt77ehC0AVyvzlGWJ1v1zCyr+0s+9XLwqolHoGdL0Yrqn+51o3vvVgkDT29qEN8YrOvv/D1Z9pt0CPVnxeDAx9SUM5Fc7xbGTW/J4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025500; c=relaxed/simple;
	bh=lrn+WvuXcCwAs6ez2zr+OYVA+Rh/JqR8goTYwPz0xWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKxCaQdfa+YpPhfgxUgmNP8g+p7vWpkQQO98Qqonx2mAKOT90cyVI9vKY2DWj5viWfVpWVJokCEFsHdQyntKfPNa53x61iecRg2auJucAQ+TdquXirRG9GGEVjbktFvifLUsy4YR3GMESzcpWxndKoQlwWUeY3tMjO6/5qLcuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qsVPzRvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D841AC4CECE;
	Thu, 12 Dec 2024 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025500;
	bh=lrn+WvuXcCwAs6ez2zr+OYVA+Rh/JqR8goTYwPz0xWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsVPzRvR3EODPQGO/LGuWI8PlCPQLW5U4w6QiovFaFyK3cvTLJuyuhg8ldCBXYEqD
	 XD+AzKLbc9ijdmRPD7IifSYLqfQD50dwEw7b1/mrfWmjyY1YGzvZV0VEDPXSET4VuE
	 vZpJbOE18enGBuNgqGkpfclaank5D+LTfkxMXqEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qingfang Deng <qingfang.deng@siflower.com.cn>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 191/321] jffs2: fix use of uninitialized variable
Date: Thu, 12 Dec 2024 16:01:49 +0100
Message-ID: <20241212144237.530494009@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

[ Upstream commit 3ba44ee966bc3c41dd8a944f963466c8fcc60dc8 ]

When building the kernel with -Wmaybe-uninitialized, the compiler
reports this warning:

In function 'jffs2_mark_erased_block',
    inlined from 'jffs2_erase_pending_blocks' at fs/jffs2/erase.c:116:4:
fs/jffs2/erase.c:474:9: warning: 'bad_offset' may be used uninitialized [-Wmaybe-uninitialized]
  474 |         jffs2_erase_failed(c, jeb, bad_offset);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/jffs2/erase.c: In function 'jffs2_erase_pending_blocks':
fs/jffs2/erase.c:402:18: note: 'bad_offset' was declared here
  402 |         uint32_t bad_offset;
      |                  ^~~~~~~~~~

When mtd->point() is used, jffs2_erase_pending_blocks can return -EIO
without initializing bad_offset, which is later used at the filebad
label in jffs2_mark_erased_block.
Fix it by initializing this variable.

Fixes: 8a0f572397ca ("[JFFS2] Return values of jffs2_block_check_erase error paths")
Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jffs2/erase.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index 7e9abdb897122..5fbaf6ab9f482 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -340,10 +340,9 @@ static int jffs2_block_check_erase(struct jffs2_sb_info *c, struct jffs2_erasebl
 		} while(--retlen);
 		mtd_unpoint(c->mtd, jeb->offset, c->sector_size);
 		if (retlen) {
-			pr_warn("Newly-erased block contained word 0x%lx at offset 0x%08tx\n",
-				*wordebuf,
-				jeb->offset +
-				c->sector_size-retlen * sizeof(*wordebuf));
+			*bad_offset = jeb->offset + c->sector_size - retlen * sizeof(*wordebuf);
+			pr_warn("Newly-erased block contained word 0x%lx at offset 0x%08x\n",
+				*wordebuf, *bad_offset);
 			return -EIO;
 		}
 		return 0;
-- 
2.43.0




