Return-Path: <stable+bounces-209828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A97A8D274A7
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61ACB30FE636
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6533A3D6F27;
	Thu, 15 Jan 2026 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ogD3UNNF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB383D6F21;
	Thu, 15 Jan 2026 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499807; cv=none; b=ET8vlXWkmK6n0WPgRgHJ23gjp7xhkDy5LuHpHXyubsusgGvHr/u7PMOa8LwSqx1qLvV5Vk6p6y3dqzkEYk4AAY1Q/LLY9e3fSlQ1G0ZXWv0pi3emGf3vWGXdxFvIN2S4kIHuD3+XanNbwTEO6HbM2UwQv+4ms8uF2DvvnCnkk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499807; c=relaxed/simple;
	bh=HhDQHgIxW3qfezcdA0njxrw9wg1nE7o93V1BPwAFOaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nc3MQ2jnQoyyGNCiobDhFfXNHK66SCWWo0ByOCE5+auxpVs8Z/mKK1W7lnV4f0bWO9R6ugeHAppnpR4wVQgISM6/wa/6VvhRIquWTjo80GPh4sc8WEq5TQy3uQEsCMsA0FMtqqgzeF4RS6Rk+xT/v/aKlFeE6031QfHRdz1C+/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ogD3UNNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578A9C116D0;
	Thu, 15 Jan 2026 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768499806;
	bh=HhDQHgIxW3qfezcdA0njxrw9wg1nE7o93V1BPwAFOaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogD3UNNFis2pIg+CVbuz1AqsQcDznbche95ND8skEKpm3RcGwuOxiZEpIDXcsd3Ow
	 eE12pyrnSMqg0IuWQlSxa/TsLzglWXpvGtdqg5DjwYL73SShzy52V6JDoSZjr/Kyfd
	 zJJ3ioxhD+SgoaieaMq6LSmnzBT8xftR1gocgmkw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 357/451] btrfs: dont rewrite ret from inode_permission
Date: Thu, 15 Jan 2026 17:49:18 +0100
Message-ID: <20260115164243.817123112@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
References: <20260115164230.864985076@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 0185c2292c600993199bc6b1f342ad47a9e8c678 ]

In our user safe ino resolve ioctl we'll just turn any ret into -EACCES
from inode_permission().  This is redundant, and could potentially be
wrong if we had an ENOMEM in the security layer or some such other
error, so simply return the actual return value.

Note: The patch was taken from v5 of fscrypt patchset
(https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/)
which was handled over time by various people: Omar Sandoval, Sweet Tea
Dorminy, Josef Bacik.

Fixes: 23d0b79dfaed ("btrfs: Add unprivileged version of ino_lookup ioctl")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Daniel Vacek <neelx@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add note ]
Signed-off-by: David Sterba <dsterba@suse.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ioctl.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2573,10 +2573,8 @@ static int btrfs_search_path_in_tree_use
 			}
 			ret = inode_permission(temp_inode, MAY_READ | MAY_EXEC);
 			iput(temp_inode);
-			if (ret) {
-				ret = -EACCES;
+			if (ret)
 				goto out_put;
-			}
 
 			if (key.offset == upper_limit.objectid)
 				break;



