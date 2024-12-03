Return-Path: <stable+bounces-97282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 788F99E23D1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251181600C5
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B99E1F8ADF;
	Tue,  3 Dec 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iccdhsap"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734F1F7584;
	Tue,  3 Dec 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240036; cv=none; b=VM7cUwRamzoCHV2ach8VkSLpI09JRWgwJKJV21lb/GhzDa7YH8zT8EFNFLy9HjwW05XTcFxZqS+1YPEr8QjZd8aeHtvZMtBm36xm5NVqYCSAR/LgkO1HwHAjiTELRy0yYxOoujrd+Bba9jwLPM8QsT3Lrzopk13USwyXBL85pEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240036; c=relaxed/simple;
	bh=famLKMmmULrNwF4kQLQh29iTI6ty2QOe9dB39G6mjyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNLZxAy+5KMbvuigW8q9ifhExwVGQzRH0k1qACkhk4Rm/H9EIlYjOAmN6iKJLGz6Gudc2/yvqWEpC24t6F7G+3WMyeZH4mmS7CsIvEsNppmiHFr3SUq2Jt9g/g0YZ6BXcBKf+x/N6ufxo1cb3kp8cGCRRUEYc1hcfAGZ8D99l80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iccdhsap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D5EC4CECF;
	Tue,  3 Dec 2024 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240035;
	bh=famLKMmmULrNwF4kQLQh29iTI6ty2QOe9dB39G6mjyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iccdhsapx7D/ON9ALK8PGyj6oCPil96jkePlhhCqIP1lykma/RRLWXT6PruGX9dNP
	 WASg5WlBGEikh9DlkWUzb8ceyz4kz+i1fvO5NyHNcyjtvh9JisOmJb5nrnmlRCaDTc
	 fgPFtMUGvHO3GnLyk8eIszETHIUNwcp9IFyICtNE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qingfang Deng <qingfang.deng@siflower.com.cn>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 778/817] jffs2: fix use of uninitialized variable
Date: Tue,  3 Dec 2024 15:45:50 +0100
Message-ID: <20241203144026.380957167@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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
index acd32f05b5198..ef3a1e1b6cb06 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -338,10 +338,9 @@ static int jffs2_block_check_erase(struct jffs2_sb_info *c, struct jffs2_erasebl
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




