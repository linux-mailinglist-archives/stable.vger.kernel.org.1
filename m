Return-Path: <stable+bounces-6948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DC681673A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 08:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16B21F2236C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4932579E2;
	Mon, 18 Dec 2023 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lv4Nd+DC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A179E1
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33169C433C9;
	Mon, 18 Dec 2023 07:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702883847;
	bh=ZFdKZ2hAEySlJGmik6XjN4jr98QC5HBldFxZh+1WK5c=;
	h=Subject:To:Cc:From:Date:From;
	b=Lv4Nd+DCawb0+OD81GOx8QeOBNKzPR3mnnHPMo1va4plhPsdUsr5ZCj4StAxw0qTM
	 GjI/x0aZ3jjxzJyRhOSZmTMKHOt6BXeC4gGGGlsMCcXjnfunuBMsUqy+Kt+nZA7ADO
	 x2lPZqPDIJ2rf5Va1bN3Mux49sli+vrH7Iu10lnQ=
Subject: FAILED: patch "[PATCH] btrfs: don't clear qgroup reserved bit in release_folio" failed to apply to 5.15-stable tree
To: boris@bur.io,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Dec 2023 08:17:24 +0100
Message-ID: <2023121824-lesser-shrug-8e87@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a86805504b88f636a6458520d85afdf0634e3c6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121824-lesser-shrug-8e87@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a86805504b88 ("btrfs: don't clear qgroup reserved bit in release_folio")
b71fb16b2f41 ("btrfs: don't clear CTL bits when trying to release extent state")
dbbf49928f2e ("btrfs: remove the wake argument from clear_extent_bits")
e3974c669472 ("btrfs: move core extent_io_tree functions to extent-io-tree.c")
38830018387e ("btrfs: move a few exported extent_io_tree helpers to extent-io-tree.c")
04eba8932392 ("btrfs: temporarily export and then move extent state helpers")
91af24e48474 ("btrfs: temporarily export and move core extent_io_tree tree functions")
6962541e964f ("btrfs: move btrfs_debug_check_extent_io_range into extent-io-tree.c")
ec39e39bbf97 ("btrfs: export wait_extent_bit")
a66318872c41 ("btrfs: move simple extent bit helpers out of extent_io.c")
ad795329574c ("btrfs: convert BUG_ON(EXTENT_BIT_LOCKED) checks to ASSERT's")
83cf709a89fb ("btrfs: move extent state init and alloc functions to their own file")
c45379a20fbc ("btrfs: temporarily export alloc_extent_state helpers")
a40246e8afc0 ("btrfs: separate out the eb and extent state leak helpers")
a62a3bd9546b ("btrfs: separate out the extent state and extent buffer init code")
87c11705cc94 ("btrfs: convert the io_failure_tree to a plain rb_tree")
a2061748052c ("btrfs: unexport internal failrec functions")
0d0a762c419a ("btrfs: rename clean_io_failure and remove extraneous args")
917f32a23501 ("btrfs: give struct btrfs_bio a real end_io handler")
f1c2937976be ("btrfs: properly abstract the parity raid bio handling")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a86805504b88f636a6458520d85afdf0634e3c6b Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Fri, 1 Dec 2023 13:00:12 -0800
Subject: [PATCH] btrfs: don't clear qgroup reserved bit in release_folio

The EXTENT_QGROUP_RESERVED bit is used to "lock" regions of the file for
duplicate reservations. That is two writes to that range in one
transaction shouldn't create two reservations, as the reservation will
only be freed once when the write finally goes down. Therefore, it is
never OK to clear that bit without freeing the associated qgroup
reserve. At this point, we don't want to be freeing the reserve, so mask
off the bit.

CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e6230a6ffa98..8f724c54fc8e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2302,7 +2302,8 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 		ret = 0;
 	} else {
 		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
-				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);
+				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS |
+				   EXTENT_QGROUP_RESERVED);
 
 		/*
 		 * At this point we can safely clear everything except the


