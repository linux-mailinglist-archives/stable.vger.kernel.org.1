Return-Path: <stable+bounces-169142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD92B2386E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A783A73BB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBE729BDB7;
	Tue, 12 Aug 2025 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CF23DwOI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6121ABD0;
	Tue, 12 Aug 2025 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026518; cv=none; b=ks72kxfrpT13O+xvjFLSyFuzDiTl98H48JVcPB26vTWTdHKm/kgRDkPHnfmpfr4JTUtWRHNaSod2TCb/iqKmKOIvOF1jagSk+nsfg9Ttfz77DmWNv2eahIUOoMN2TlWF5WXo5p2zpvQLb8eaSf+nTEJqiKF2UO9k7IoMooYHlUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026518; c=relaxed/simple;
	bh=wDCNcSj+SD4AWX6d0tPjX6CMVnpi3JFwU4SS/hHDAIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8M7KNSfQbiedP+shoUt5eNChA9k8MWNP6mYzeFBd0hqpWmCfBuHOyJgaNYq4Fd8X0PJZUpkq+vrGK52zQ8vNs4KRu17bn0O6liOstusm66voxLmnLttFLRi33Vn/9tmhcwcdfXenp86v1JXzVjn/DofN/iQm059LUUyXh9hYtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CF23DwOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B56C4CEF0;
	Tue, 12 Aug 2025 19:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026518;
	bh=wDCNcSj+SD4AWX6d0tPjX6CMVnpi3JFwU4SS/hHDAIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CF23DwOIv0JccuQqGWQaB6hSA5FuxGvQLF8f1+VWTv6l0Cet9RIp6j5tOe4i4wL3y
	 /xiJAhUGhGe8/wi6jQHpmP053MOs+WcfhxkpnfSmQwVcSasTnOlQSrpuRnsJ98FFFE
	 ypnRLziloTkXqr596ILHsGTiw7dtOOG2PaerZHfo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhengxu Zhang <zhengxu.zhang@unisoc.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 360/480] exfat: fdatasync flag should be same like generic_write_sync()
Date: Tue, 12 Aug 2025 19:49:28 +0200
Message-ID: <20250812174412.279143282@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengxu Zhang <zhengxu.zhang@unisoc.com>

[ Upstream commit 2f2d42a17b5a6711378d39df74f1f69a831c5d4e ]

Test: androbench by default setting, use 64GB sdcard.
 the random write speed:
	without this patch 3.5MB/s
	with this patch 7MB/s

After patch "11a347fb6cef", the random write speed decreased significantly.
the .write_iter() interface had been modified, and check the differences
with generic_file_write_iter(), when calling generic_write_sync() and
exfat_file_write_iter() to call vfs_fsync_range(), the fdatasync flag is
wrong, and make not use the fdatasync mode, and make random write speed
decreased. So use generic_write_sync() instead of vfs_fsync_range().

Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
Signed-off-by: Zhengxu Zhang <zhengxu.zhang@unisoc.com>
Acked-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 841a5b18e3df..7ac5126aa4f1 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -623,9 +623,8 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (pos > valid_size)
 		pos = valid_size;
 
-	if (iocb_is_dsync(iocb) && iocb->ki_pos > pos) {
-		ssize_t err = vfs_fsync_range(file, pos, iocb->ki_pos - 1,
-				iocb->ki_flags & IOCB_SYNC);
+	if (iocb->ki_pos > pos) {
+		ssize_t err = generic_write_sync(iocb, iocb->ki_pos - pos);
 		if (err < 0)
 			return err;
 	}
-- 
2.39.5




