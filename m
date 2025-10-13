Return-Path: <stable+bounces-184136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD619BD1DFE
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1ED94E9CFC
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 07:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D102EA464;
	Mon, 13 Oct 2025 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="REBuZRGl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C02EA486
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341774; cv=none; b=XGsYjhQkCbUbIUgxiPsRa3P5wcO88dmBzao8KomlQeT4k7efz3EPN0X58ZN/rMDaOwVLeVrel9kSIZFKDZT/pY78uQBm2ZgIjBRnLFx8JdHZ811Z6hECfwuD8B4xBqAfDv+XHi+TdKxaC9+mrubgyu2eNApIun/2sYbBrTRxd7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341774; c=relaxed/simple;
	bh=FHDn780+WdwfQuqXUSLNkJfeUFkQOHgy9JvTBRPaicw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=trAwd0H4rUc4pwglBToxzFFQcF/iw05D+rwW/HCaBsHvPqRYZDwVjKxccpEI9PVsuLf/2tFADAGyMlb5ZXtwZ8TUqfkJ/fECb/RyqwYOwdHqk2HtOSqUA0l0Tn5MDmf0HLmDfTMtQN/vrLmFrs+SlA7HDUDtj6GYyNKSdh6ziUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=REBuZRGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E790C4CEE7;
	Mon, 13 Oct 2025 07:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760341773;
	bh=FHDn780+WdwfQuqXUSLNkJfeUFkQOHgy9JvTBRPaicw=;
	h=Subject:To:Cc:From:Date:From;
	b=REBuZRGlgR62S7sRs/Y16er0XUpFl9UrvJ7103KAnG3qkHTv08e2lB6ie+DiEpois
	 QMDfHubaW1u2lZlntdzmSbQQliepLmA8tFubgQTayr1QCaTyBw/mJKTMCRLM1WqPcg
	 R29ke4SfzFUhSFN5+aSoe2XiKMcQJ9d5k/n7YE8U=
Subject: FAILED: patch "[PATCH] Squashfs: reject negative file sizes in squashfs_read_inode()" failed to apply to 5.10-stable tree
To: phillip@squashfs.org.uk,akpm@linux-foundation.org,amir73il@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 09:49:21 +0200
Message-ID: <2025101321-ripening-subscript-11b6@gregkh>
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
git cherry-pick -x 9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101321-ripening-subscript-11b6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b Mon Sep 17 00:00:00 2001
From: Phillip Lougher <phillip@squashfs.org.uk>
Date: Fri, 26 Sep 2025 22:59:35 +0100
Subject: [PATCH] Squashfs: reject negative file sizes in squashfs_read_inode()

Syskaller reports a "WARNING in ovl_copy_up_file" in overlayfs.

This warning is ultimately caused because the underlying Squashfs file
system returns a file with a negative file size.

This commit checks for a negative file size and returns EINVAL.

[phillip@squashfs.org.uk: only need to check 64 bit quantity]
  Link: https://lkml.kernel.org/r/20250926222305.110103-1-phillip@squashfs.org.uk
Link: https://lkml.kernel.org/r/20250926215935.107233-1-phillip@squashfs.org.uk
Fixes: 6545b246a2c8 ("Squashfs: inode operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d580e5.a00a0220.303701.0019.GAE@google.com/
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index ddc65d006063..cceae3b78698 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -197,6 +197,10 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 			goto failed_read;
 
 		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
+		if (inode->i_size < 0) {
+			err = -EINVAL;
+			goto failed_read;
+		}
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
 			/*


