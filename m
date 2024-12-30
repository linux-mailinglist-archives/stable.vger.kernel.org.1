Return-Path: <stable+bounces-106275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3D09FE3D5
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 09:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7DF161EFC
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9841A0B15;
	Mon, 30 Dec 2024 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VSRP5Ls5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7319F406
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735548104; cv=none; b=sVtpzwEPhTAa4tpkkti84/ukbq29vdj6fZd4flGWNVVlxrfcr+O9wVH1P5ogMwLZ5jLDqDatp2aPzdxiOx625YXyvs7hl0SVBtXrlpHjWAXAh7J6hk4/C8SrEA5AbuBLQJc3+H37RijLe489XzkaU25i0b1iIMVhLh0mP02SOqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735548104; c=relaxed/simple;
	bh=Ddl1oLvLFCKn1ACUtjGs0Fca0vSrLRY/0UG/EktNxzs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DAdL8UYWB0DEPWmwB+TXC8Fo4+AxVG5ow6WK5kQ9XaEBb5sSwiEmJ3CXzMh38I2YOFy5I/ZZH/KDPZuaS6oUU90bO8j7epyx/M0OFfSGuS6hlNn6RbzlABmhXHLF2ehZoYGijeR5MYUJXtXBFXhHvhstwjZT0QAZufIkYxkN1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VSRP5Ls5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753B4C4CED0;
	Mon, 30 Dec 2024 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735548103;
	bh=Ddl1oLvLFCKn1ACUtjGs0Fca0vSrLRY/0UG/EktNxzs=;
	h=Subject:To:Cc:From:Date:From;
	b=VSRP5Ls5vLmS1JLuVQhW6+eUBmOeHVb0e8JLRfYU1iJmYcR4CULkh/Z+qGZW89c9h
	 R2yHIp0wU70IBWj2FLKuC9yBW39JCzZpZqo+aOmSqr1+VCIGw7Vy0TxKhybfuctoQY
	 e+12llxcZDJM+D313+KB8jJcaD65iGqM5ehvJxxQ=
Subject: FAILED: patch "[PATCH] btrfs: allow swap activation to be interruptible" failed to apply to 6.6-stable tree
To: fdmanana@suse.com,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Dec 2024 09:41:37 +0100
Message-ID: <2024123037-theology-zookeeper-1b67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9a45022a0efadd99bcc58f7f1cc2b6fb3b808c40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024123037-theology-zookeeper-1b67@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9a45022a0efadd99bcc58f7f1cc2b6fb3b808c40 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Mon, 9 Dec 2024 16:31:41 +0000
Subject: [PATCH] btrfs: allow swap activation to be interruptible

During swap activation we iterate over the extents of a file, then do
several checks for each extent, some of which may take some significant
time such as checking if an extent is shared. Since a file can have
many thousands of extents, this can be a very slow operation and it's
currently not interruptible. I had a bug during development of a previous
patch that resulted in an infinite loop when iterating the extents, so
a core was busy looping and I couldn't cancel the operation, which is very
annoying and requires a reboot. So make the loop interruptible by checking
for fatal signals at the end of each iteration and stopping immediately if
there is one.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b87f19630b00..c4675f4345fd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10073,6 +10073,11 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			bsi.block_start = physical_block_start;
 			bsi.block_len = len;
 		}
+
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			goto out;
+		}
 	}
 
 	if (bsi.block_len)


