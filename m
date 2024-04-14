Return-Path: <stable+bounces-39381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF318A42A7
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 15:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31368281AC3
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B4B446B2;
	Sun, 14 Apr 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QtTIAMk1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79344437C
	for <stable@vger.kernel.org>; Sun, 14 Apr 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713101753; cv=none; b=q0jY/ANsdQwMkHbK/yYQzWwCYTm6wwhfnKTet9bKruKs2UkWXh3+F2i2QsVyoSzaCSaP/E61Fighzc6GVfaQSttdfvW9nF1YWhtDxG+zUxyBNsDyr2hv6ki6y17oSRyXwyu36Fs2+9lwg5o9S8G2UhxZqYnPHPwXyPpdH0vT2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713101753; c=relaxed/simple;
	bh=bBM9m/vu7z/X0Rg+2ynZ/8nB14NMAAXqhofoVvs12FI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BhR39cI028HJ2ykaVUYFsdR6+VAC+FYWXH4tEnhaV2f5GBoJ34mfYNq0N+W6hFkT6R9BxBhFJ3HA/dYi4DYDzu4OcEOu3LfQQSEtqtAQFz0iK4akjfbsQowJzga43VhgnCBT3XMCzfNsGcUH1Dr8pZH5LH2ogbkgTafYDhquzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QtTIAMk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE622C072AA;
	Sun, 14 Apr 2024 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713101753;
	bh=bBM9m/vu7z/X0Rg+2ynZ/8nB14NMAAXqhofoVvs12FI=;
	h=Subject:To:Cc:From:Date:From;
	b=QtTIAMk1dTVtFW43cIQlRvbvxaYuhUVV6rHKLtHGiej+e0veKhQbO3Q5x+60CBeZW
	 K3bU8fIWFn9JGsJkRLSB8r2wNklg8fcH30DAj+JsO2vkZXNE/XG9U9bIfUS5dSMluB
	 iH/KQAJnA1736U4YuOCTknu0tn8aMLB/v+ecFkag=
Subject: FAILED: patch "[PATCH] ceph: redirty page before returning AOP_WRITEPAGE_ACTIVATE" failed to apply to 6.1-stable tree
To: neilb@suse.de,idryomov@gmail.com,jlayton@kernel.org,xiubli@redhat.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Apr 2024 15:35:42 +0200
Message-ID: <2024041442-grumble-saggy-01f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b372e96bd0a32729d55d27f613c8bc80708a82e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041442-grumble-saggy-01f0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b372e96bd0a32729d55d27f613c8bc80708a82e1 Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Mon, 25 Mar 2024 09:21:20 +1100
Subject: [PATCH] ceph: redirty page before returning AOP_WRITEPAGE_ACTIVATE

The page has been marked clean before writepage is called.  If we don't
redirty it before postponing the write, it might never get written.

Cc: stable@vger.kernel.org
Fixes: 503d4fa6ee28 ("ceph: remove reliance on bdi congestion")
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Xiubo Li <xiubli@redhat.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1340d77124ae..ee9caf7916fb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -795,8 +795,10 @@ static int ceph_writepage(struct page *page, struct writeback_control *wbc)
 	ihold(inode);
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    ceph_inode_to_fs_client(inode)->write_congested)
+	    ceph_inode_to_fs_client(inode)->write_congested) {
+		redirty_page_for_writepage(wbc, page);
 		return AOP_WRITEPAGE_ACTIVATE;
+	}
 
 	wait_on_page_fscache(page);
 


