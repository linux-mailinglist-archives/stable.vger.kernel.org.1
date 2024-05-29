Return-Path: <stable+bounces-47614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2B58D2D72
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 08:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD62128AB3C
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 06:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022F31607A0;
	Wed, 29 May 2024 06:41:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9515B122;
	Wed, 29 May 2024 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964885; cv=none; b=CNBmiSGO/p51HyycJzSfmp9NZOKt9P2p+nxTFT1gsHBNp/N1DMMGBTgWrOep8fSZqeZhshpTfFLKDhvkZLFOpAo9z4c/BhvMfCpLV3tcjX/M3JJ+Bo0+3DiFw2YwzodPbmy2PCCv5xCpcqZ1L5w89SoTjrsDsNF0wcWG7+Itfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964885; c=relaxed/simple;
	bh=0r2mHDCnif4N/loTjLL5nW+YIJx3eDj/rTX/Zdpzf9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSRcMX4dr9ed1LeQBper8LjoG/CJPpgqnr8GvJM4LYQjZZxXzZgJoQui0CuZkScDUs7Wb47SFrZPlXJdBO+/6Gzehk+eko8SuxKclBaC1vG5pmIJMBhVb3+DdTBSNvtVjx46s/imE0fCdq+GxohQ9hZXnZJq96NoN6eE2tE2NrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7C0C2BD10;
	Wed, 29 May 2024 06:41:23 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] fs/ntfs3: Update log->page_{mask,bits} if log->page_size changed
Date: Wed, 29 May 2024 14:40:52 +0800
Message-ID: <20240529064053.2741996-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529064053.2741996-1-chenhuacai@loongson.cn>
References: <20240529064053.2741996-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an NTFS file system is mounted to another system with different
PAGE_SIZE from the original system, log->page_size will change in
log_replay(), but log->page_{mask,bits} don't change correspondingly.
This will cause a panic because "u32 bytes = log->page_size - page_off"
will get a negative value in the later read_log_page().

Cc: stable@vger.kernel.org
Fixes: b46acd6a6a627d876898e ("fs/ntfs3: Add NTFS journal")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 fs/ntfs3/fslog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 855519713bf7..19c448093df7 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3914,6 +3914,9 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		goto out;
 	}
 
+	log->page_mask = log->page_size - 1;
+	log->page_bits = blksize_bits(log->page_size);
+
 	/* If the file size has shrunk then we won't mount it. */
 	if (log->l_size < le64_to_cpu(ra2->l_size)) {
 		err = -EINVAL;
-- 
2.43.0


