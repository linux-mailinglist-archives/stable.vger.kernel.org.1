Return-Path: <stable+bounces-106274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812C09FE3D4
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 09:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A453A1F47
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57241A0B0E;
	Mon, 30 Dec 2024 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D3KpuZpk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9537E19F406
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735548100; cv=none; b=ig+7k/76iQcvi5wmbW0mL2T297mdlFVpSU0A0DIM90M1cCWpe4wlQnIsiYEthciSvH0xpMGY/9UKZZuryhc+CmKxjCkdSGgQnWnqDtF0xCElYQ41dL+Mnj/jm8Tl98Yo0BqpHXkbN4ogw+IcUWMaFervPlKRPglzSDOaVTXPASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735548100; c=relaxed/simple;
	bh=hM8iGlDry3dwaN1RN4c8EinIS5mddmNHhFej00SHb18=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kIeSGftvQBPnfGte/0EW/aZ5S4IyeMBvhaY5HNjC+yG8rZAmtWaZ7aZFhEgPIrn6m8FkjGhHzxuEJAEdRiBgvBKXk4BCUd/4H4AJ5/PUecwhgCeC89VylR93hNKVFO0ll6wJVy+DGPZabZTI/PcpPFBXv0FZq0FOr0DtKPaGMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D3KpuZpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C729C4CED0;
	Mon, 30 Dec 2024 08:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735548100;
	bh=hM8iGlDry3dwaN1RN4c8EinIS5mddmNHhFej00SHb18=;
	h=Subject:To:Cc:From:Date:From;
	b=D3KpuZpkj07hTYfmVQ3xrWdUgk7yi7/ZItk5j1jXTggqfjIA6LhNyyZw9mZffVelW
	 /CGb65kiEkG7L/HBHkV3Z6lH8ezouKw+ALk+Wddcw+f6Kj/3AN6rxK8hu5M2bLgI6c
	 PBkDUGctvO2pg/bfMP+OLV4lPaSGZsu6fWK57CBU=
Subject: FAILED: patch "[PATCH] btrfs: allow swap activation to be interruptible" failed to apply to 6.12-stable tree
To: fdmanana@suse.com,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Dec 2024 09:41:36 +0100
Message-ID: <2024123036-grout-exposure-3af8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9a45022a0efadd99bcc58f7f1cc2b6fb3b808c40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024123036-grout-exposure-3af8@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


