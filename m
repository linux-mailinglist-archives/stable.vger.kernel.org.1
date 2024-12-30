Return-Path: <stable+bounces-106279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB74D9FE3D9
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 09:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F0E1613F3
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8D61A0BC3;
	Mon, 30 Dec 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CWforQOt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080719F406
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735548117; cv=none; b=pMfpBajHwr3BFYEbmAOGKdEp1xqkzhJdtaeYN4oBlwKMoHKXVOYCwNIJnK4k1/bSwLKw7Nxs3SkVfH0MdRG03z2LYunWPwiqlP9ODtb6KwdVwRd85TyL+5isL0HVc5jhKlb70tLv8mcs55yo32rDJPwrTVYvBBs+Jgxkm2KXqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735548117; c=relaxed/simple;
	bh=mfZ1Svm9Yaq3CIMiA8Q9LbmzJjt91RT+eSqpdqIZcv0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uePyKxceVB2yr8OuJoz3sGGdnYowavtBgejXF2WFywEg0XPJuereTNbDpP+18Ghc9D2Ew2HsCXCBaSJV60Ry94FdvXw05xrET46RFdXSIYFrK2iLIb7V8yQeMHrs01DTAiCjaFpoxTzgc0KvZT13vhN34cmPc4t0rZrNSD/86tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWforQOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEDAC4CED0;
	Mon, 30 Dec 2024 08:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735548116;
	bh=mfZ1Svm9Yaq3CIMiA8Q9LbmzJjt91RT+eSqpdqIZcv0=;
	h=Subject:To:Cc:From:Date:From;
	b=CWforQOteTSnnx8NiYyYM6RhOAtgsblnzZ/uMjD3bpac6tMgwLuYwX4OYKQksWus+
	 N7E9dDw/Gjzbd8qXNc/CC+IPsCzERzkNuwP9X7wwLxm0amSoHXouv8Pt4KTqlJbP3M
	 bW7hSvLQYIjSbU6gyKV57UctdodPlMDVjhIGP+5Q=
Subject: FAILED: patch "[PATCH] btrfs: allow swap activation to be interruptible" failed to apply to 5.10-stable tree
To: fdmanana@suse.com,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Dec 2024 09:41:40 +0100
Message-ID: <2024123039-broadside-tuesday-404a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9a45022a0efadd99bcc58f7f1cc2b6fb3b808c40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024123039-broadside-tuesday-404a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


