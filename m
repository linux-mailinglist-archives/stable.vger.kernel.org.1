Return-Path: <stable+bounces-165371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C8FB15CE6
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8009E169CAB
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C7D293462;
	Wed, 30 Jul 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TOA74C4R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE8277CBA;
	Wed, 30 Jul 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868860; cv=none; b=lNQzqboEEg42n4wV45rW3ctl8r5XsKyrwVvhMYSrkBs5JJPJrRYa/Qfe1V+RAb0tWlX9KUdAqjj8D3pYex+HvLQ3EvwV5bT8ulzsxG/LYQsw4ItQ7gU82vLngYppVZ1vf7o/NuwRJsGfOxTNnsxmdeIEM28+Y46W4FNQa8FtVmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868860; c=relaxed/simple;
	bh=ZMZbMk8w6mYf5NySIfEH+JHqry24vZRydenO5yXWQhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzxBXbfoSWwrHFF/dgeVgaeWNyHXolz7B7A+6B2ZNKEdH1LPjgXKlqOKiHiiPBCZtVmck4YBDC6dfwA933cEL++jYlWmpbya44D6gg3ofdms1qbvu6YRfgz0/F780ZDXHy4vpTiYqhHUTkdvQT9tA1nker/z9sIoiW2nKloBIiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TOA74C4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A419C4CEF5;
	Wed, 30 Jul 2025 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868859;
	bh=ZMZbMk8w6mYf5NySIfEH+JHqry24vZRydenO5yXWQhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOA74C4RyXL7z6bK+OFgfG9it530LoXdNCwzx8mpysikiQagtoVwIjfT9xPIrBV6n
	 lnm/DyAqUgKFjS5wjaBg9sWwsgvH/JeO8Mm3FY0itnI4U/FKGCaTzGm0b9+55dl6RD
	 n5FQqd+UVEsKY3sXMlR3iPmjAMIaNLw+0wkMT9sA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 094/117] ext4: correct the error handle in ext4_fallocate()
Date: Wed, 30 Jul 2025 11:36:03 +0200
Message-ID: <20250730093237.449923308@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
References: <20250730093233.592541778@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 129245cfbd6d79c6d603f357f428010ccc0f0ee7 ]

The error out label of file_modified() should be out_inode_lock in
ext4_fallocate().

Fixes: 2890e5e0f49e ("ext4: move out common parts into ext4_fallocate()")
Reported-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Link: https://patch.msgid.link/20250319023557.2785018-1-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/extents.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4745,7 +4745,7 @@ long ext4_fallocate(struct file *file, i
 
 	ret = file_modified(file);
 	if (ret)
-		return ret;
+		goto out_inode_lock;
 
 	if ((mode & FALLOC_FL_MODE_MASK) == FALLOC_FL_ALLOCATE_RANGE) {
 		ret = ext4_do_fallocate(file, offset, len, mode);



