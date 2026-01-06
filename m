Return-Path: <stable+bounces-205257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CA4CF9B9E
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 18:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFC33303D36A
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EC326E6F3;
	Tue,  6 Jan 2026 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hpZbGpvG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CD05695;
	Tue,  6 Jan 2026 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720094; cv=none; b=OV/eeMx6CQ9MRcXNmzlAHDKlolemL/VTq1XVGUE1YVM49HphI0yf4Tilzx3u9peHDInmHSEQdxuaPYob8eeP8rkgUEBoU/3BS1MILz7hqm5B5RIbSLqW5Nfuprdllr7LyOI4VXLAV1AY6855KPSZe2WuIwFSPZ0uMOui9UHJrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720094; c=relaxed/simple;
	bh=VStiWvXOD/rc5G22zIGjZVIbVYi00ErqO0pCRMzsGyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSRUAXa8wa8Gv588UPxf3MXusMKzNSBTwKxiI5NJbolOuIdo+NhnHn0EslVFQoHo2u4YkcbSoCbq8LpmQ3H5dsmVs5CiSljJBEKLKu37KuVuhvXHV0SsS72K/IknI5RDHEDbBqBTEObt0s4fl/hkQGL4wzv4nInlm2JoqHmQi5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hpZbGpvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B4BC116C6;
	Tue,  6 Jan 2026 17:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767720094;
	bh=VStiWvXOD/rc5G22zIGjZVIbVYi00ErqO0pCRMzsGyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hpZbGpvGjxfs/FI8kIvew6P7Q9W3n2r0wEgZ+L7Gsc2vf8msd5gP1PIcP4u/khXgr
	 nF/I3nijKZQ6x4F335Fj7DM7g29cIb6+i7YliE7MWz7BMhDhYc+5fIwDmwWRYvFUIF
	 xMeqDwKg4X/H8zz+Y8sOzgtrczFjkk2Hew/a+qxA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bernd Schubert <bschubert@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 131/567] fuse: Invalidate the page cache after FOPEN_DIRECT_IO write
Date: Tue,  6 Jan 2026 17:58:33 +0100
Message-ID: <20260106170456.174372885@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Bernd Schubert <bschubert@ddn.com>

[ Upstream commit b359af8275a982a458e8df6c6beab1415be1f795 ]

generic_file_direct_write() also does this and has a large
comment about.

Reproducer here is xfstest's generic/209, which is exactly to
have competing DIO write and cached IO read.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ec1b235df91d..4c5cf2d116d2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1656,6 +1656,15 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	if (res > 0)
 		*ppos = pos;
 
+	if (res > 0 && write && fopen_direct_io) {
+		/*
+		 * As in generic_file_direct_write(), invalidate after the
+		 * write, to invalidate read-ahead cache that may have competed
+		 * with the write.
+		 */
+		invalidate_inode_pages2_range(mapping, idx_from, idx_to);
+	}
+
 	return res > 0 ? res : err;
 }
 EXPORT_SYMBOL_GPL(fuse_direct_io);
-- 
2.51.0




