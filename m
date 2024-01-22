Return-Path: <stable+bounces-12973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC5837A0B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811EA1F28450
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6613129A68;
	Tue, 23 Jan 2024 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tohswGW5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65B129A63;
	Tue, 23 Jan 2024 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968714; cv=none; b=XNB8y45/qglulgo2B6iB2cl6JJGuMXvxaAI3XHp5K4UGndlkeIEQuc2gR8BScBFWT5mPEw7RNrY+ovqNS+2IvYgcxUoR0+dMBiSScZnY4gL+VEFvGjMU15qhC3sYBcTJOO5Xj4HIrbkMEDargekLFnUr8esGbv9YuOJdI+984R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968714; c=relaxed/simple;
	bh=u/RrR95zsnr6cY+1QuIjIDgWHSUK5mTyG0yFFIKR1SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFx1a69qnHCSNK8YPjrK6z7WVZ9Ch0QhVxsF/Tj9uMOaHNGPun8LIPlGt4KhJWPNfHliY4n6WNCy4ZkoESMBFKujuDV/MgWYRu5RZakSSk9zcCIkW7jTNe/xQ1A/EjK2LwchWMU2o3ljRTSgO8rfhS3GL8r1Q5Qzhv7S3umSJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tohswGW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40917C433F1;
	Tue, 23 Jan 2024 00:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968714;
	bh=u/RrR95zsnr6cY+1QuIjIDgWHSUK5mTyG0yFFIKR1SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tohswGW5u+8jYPtlc+YYaTH7ZndxxBr63S31/stGBihUO+urWv1Gxu5Ziz6UeiDeq
	 TqJUKFQeQzzLI2OPP0zZwEQC91OOCe+N6c7mLgesVrQST7yOtH9BfuMUGz+3QwoCMo
	 ofKZO/NjCMcTuKZTMllLx61ghe+9zeAmjkTuQ4T0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Biggers <ebiggers@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5.4 001/194] f2fs: explicitly null-terminate the xattr list
Date: Mon, 22 Jan 2024 15:55:31 -0800
Message-ID: <20240122235719.270962582@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

commit e26b6d39270f5eab0087453d9b544189a38c8564 upstream.

When setting an xattr, explicitly null-terminate the xattr list.  This
eliminates the fragile assumption that the unused xattr space is always
zeroed.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/xattr.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -722,6 +722,12 @@ static int __f2fs_setxattr(struct inode
 		memcpy(pval, value, size);
 		last->e_value_size = cpu_to_le16(size);
 		new_hsize += newsize;
+		/*
+		 * Explicitly add the null terminator.  The unused xattr space
+		 * is supposed to always be zeroed, which would make this
+		 * unnecessary, but don't depend on that.
+		 */
+		*(u32 *)((u8 *)last + newsize) = 0;
 	}
 
 	error = write_all_xattrs(inode, new_hsize, base_addr, ipage);



