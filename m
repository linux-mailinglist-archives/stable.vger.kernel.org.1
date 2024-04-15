Return-Path: <stable+bounces-39506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F088A51E9
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7E91F2392E
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0846E84047;
	Mon, 15 Apr 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuhLvi2S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4A78C6A
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188327; cv=none; b=ORFaEydCwDue/Gp1II8V1GKiA8Z0AH3VrRQGOrc9jsGM5kydQaSgwKpeAl21F8u0VAkC7+KbDSdfIA2aPlWJwe71CCMEZtTbpdxuW5hjE7rcL/n0hu2YObfyaqnRlisRykVu39mlrX7z3HRKKj5bBf+Eah9MUdxfwf4WAtnqeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188327; c=relaxed/simple;
	bh=p0jWJKrYYUpGo3bcxnF13SHr10L+9unfhu8mxuHwpfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHRyhdPq5ByIsJz2a1KKdJNlcljNmu6Q8UNYSCU8ffnhpywsG1sFqj4drzNRaQ6cIrW0p08sZxfPmw5eoqwhtaLaKzTUkHAvXXZ8RpHVMhPy9yxD6tpQ/1aIWJSXpZX9qZFIbSqKw8TuQkEqryZNr5DOEKpNsmmDnca67K4QusQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuhLvi2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E3AC113CC;
	Mon, 15 Apr 2024 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188327;
	bh=p0jWJKrYYUpGo3bcxnF13SHr10L+9unfhu8mxuHwpfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GuhLvi2SkLVRgZMuRJ36HgnAoLfeZGxgTfAwzEW6q0WpfshDXjWOTTwlSJ16FLRh3
	 ONqSn3zjquh6QM/fXipB9lKMg71Z6DFggFu4FdOA7IjX+zOwxFxlWkkgORg8xUCKVf
	 HtE+TVBaJd+dpshc+Sjf5ziqmyp4iXdg6LVEShPjADBj+DEC5ZD/xqIfqKMYinz2bI
	 nAik3lZ56VCYfIzktjWUAclQKiiSoEej+8/G7Hon+QvDl90RiOxKC0NieYQp8tusBj
	 8eNCxy/pDxVziloI0SvWNhMHAHNjK3RYTpQRKFqpRGBpjaUJ9uDtN+1V2YLn7zIWC8
	 Q1OnjCqGIzPkg==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Martin Michaelis <code@mgjm.de>,
	stable@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 028/190] btrfs: do not allow non subvolume root targets for snapshot
Date: Mon, 15 Apr 2024 06:49:18 -0400
Message-ID: <20240415105208.3137874-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit a8892fd71933126ebae3d60aec5918d4dceaae76 ]

Our btrfs subvolume snapshot <source> <destination> utility enforces
that <source> is the root of the subvolume, however this isn't enforced
in the kernel.  Update the kernel to also enforce this limitation to
avoid problems with other users of this ioctl that don't have the
appropriate checks in place.

Reported-by: Martin Michaelis <code@mgjm.de>
CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c8bc8cf5a41f2..61ab4bc3ca1b5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1695,6 +1695,15 @@ static noinline int btrfs_ioctl_snap_create_transid(struct file *file,
 			 * are limited to own subvolumes only
 			 */
 			ret = -EPERM;
+		} else if (btrfs_ino(BTRFS_I(src_inode)) != BTRFS_FIRST_FREE_OBJECTID) {
+			/*
+			 * Snapshots must be made with the src_inode referring
+			 * to the subvolume inode, otherwise the permission
+			 * checking above is useless because we may have
+			 * permission on a lower directory but not the subvol
+			 * itself.
+			 */
+			ret = -EINVAL;
 		} else {
 			ret = btrfs_mksubvol(&file->f_path, name, namelen,
 					     BTRFS_I(src_inode)->root,
-- 
2.43.0


