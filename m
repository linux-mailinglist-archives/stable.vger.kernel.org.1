Return-Path: <stable+bounces-72301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944D0967A17
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5101C280CFB
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AA717DFE7;
	Sun,  1 Sep 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F7m4WVoM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9744C93;
	Sun,  1 Sep 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209480; cv=none; b=qFYZ2ms7Z47Mz1jDVoY9v9oZWKrN0WpKI7shDmjSlqnDC73YTvkMH2D8Mow2TsiNakQdPND1zGDFtmscyUGE3mHXge32G4hGm9Oml/BRi5MoTOYF+F2ESAN9p1rOs1L5Auqi26cnfJcfhWNlHtzMEhbQCpoz8TUaCzk+SNBxxtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209480; c=relaxed/simple;
	bh=6Un70EX/BNZI+TP2prUeQRPrAoW1ZrDLQF9hxaSlyTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjYJXHEekikbcEZ+2vz3xJ/zXLBdwBVGxA04c/9cHE7F03ncxwjzboXFuPkzeRFUde52SkES5ASf1rm0G+2C0Bbs2WgqinHm9vHSsu9a/FgeWDjZg3KA53wCs2GNHBIgT0J5qDtHJrSXAgtoP/ae4yeIZnkF7jrolplKXRJtmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F7m4WVoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E173C4CEC3;
	Sun,  1 Sep 2024 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209480;
	bh=6Un70EX/BNZI+TP2prUeQRPrAoW1ZrDLQF9hxaSlyTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7m4WVoMjtLjIPr6KH9kBkTiZ93ldfAQxguWEP1yTPDCE0ts4RsnlvQh35fAGH7Ov
	 6idj1Ci9cny0RCTkb32Q3F4pOnntRwILMIr/CJhIMoJB6x+4vLMFbCQvD2ATk0NRbV
	 y1W8ZhBakxvLqst1xOCcyXYZdw8AlzxheIsncq+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 049/151] ext4: do not trim the group with corrupted block bitmap
Date: Sun,  1 Sep 2024 18:16:49 +0200
Message-ID: <20240901160815.963581385@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>
References: <20240901160814.090297276@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 172202152a125955367393956acf5f4ffd092e0d ]

Otherwise operating on an incorrupted block bitmap can lead to all sorts
of unknown problems.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240104142040.2835097-3-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index bc5db22df9fe7..7cbbcee225ddd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5955,6 +5955,9 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 	bool set_trimmed = false;
 	void *bitmap;
 
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		return 0;
+
 	last = ext4_last_grp_cluster(sb, e4b->bd_group);
 	bitmap = e4b->bd_bitmap;
 	if (start == 0 && max >= last)
-- 
2.43.0




