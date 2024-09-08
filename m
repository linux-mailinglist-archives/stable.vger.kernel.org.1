Return-Path: <stable+bounces-73870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DC597071A
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C071C20D1D
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DC714EC50;
	Sun,  8 Sep 2024 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DFN4de3Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954718C22
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725796313; cv=none; b=SbfF+TSJgnZ3z6M2wCVI55fswLVQwjd4Wnm5lkRuJnFoo/hgnWITM93pHz1AbbJ5ABGmAKE53ok3HmctiquGuX2qNWfLqS8tvzehCVM/vw6z8RsQsCEaD7rqKPLWrGTO4V7kW3NdJG/7mLIpeQ1PaqCa/IL7QooXKtPbYbkzJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725796313; c=relaxed/simple;
	bh=BG8LO+HZjTbAoflCgVvExecd8Oi/nUq8SfeiEV0kxjw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f2cp/ZnS1+MIbDoZv3sNol29SDIqCWma3viHxiLQIno7kNKz/7ObUMi7qxLClRLacGtd5H8Ifmolq3jE6mjr2fuBxr0YZhp9GNF/YvgZD1hy4QRoUG4qk9FSIuLt2GqiqBuD9P50q2j6eX65Sz4qDqncurPvO8Vh2PJ9Uj3xYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DFN4de3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F148AC4CEC3;
	Sun,  8 Sep 2024 11:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725796313;
	bh=BG8LO+HZjTbAoflCgVvExecd8Oi/nUq8SfeiEV0kxjw=;
	h=Subject:To:Cc:From:Date:From;
	b=DFN4de3QGxd6J82m8Wl+5icib3q3Y67ndG+xfkIjXaARC6ha7nYl5acEqIMRBrB5V
	 7pnoQdZw+NUwcHnP65p+KFiKm9T1MrNhY4ofW1MalJdgu770pU4f4tVoDqK6EkWnha
	 JlQozmo+UvwGcKBPj6p9jK2yZcWWHg/UZ3Fj/Pek=
Subject: FAILED: patch "[PATCH] maple_tree: remove rcu_read_lock() from mt_validate()" failed to apply to 6.6-stable tree
To: Liam.Howlett@Oracle.com,akpm@linux-foundation.org,hdanton@sina.com,paulmck@kernel.org,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 13:51:50 +0200
Message-ID: <2024090850-skirt-unsaved-fc27@gregkh>
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
git cherry-pick -x f806de88d8f7f8191afd0fd9b94db4cd058e7d4f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090850-skirt-unsaved-fc27@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

f806de88d8f7 ("maple_tree: remove rcu_read_lock() from mt_validate()")
9a40d45c1f2c ("maple_tree: remove mas_searchable()")
067311d33e65 ("maple_tree: separate ma_state node from status")
271f61a8b41d ("maple_tree: clean up inlines for some functions")
bf857ddd21d0 ("maple_tree: move debug check to __mas_set_range()")
f7a590189539 ("maple_tree: make mas_erase() more robust")
a2587a7e8d37 ("maple_tree: add test for mtree_dup()")
fd32e4e9b764 ("maple_tree: introduce interfaces __mt_dup() and mtree_dup()")
4f2267b58a22 ("maple_tree: add mt_free_one() and mt_attr() helpers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f806de88d8f7f8191afd0fd9b94db4cd058e7d4f Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Tue, 20 Aug 2024 13:54:17 -0400
Subject: [PATCH] maple_tree: remove rcu_read_lock() from mt_validate()

The write lock should be held when validating the tree to avoid updates
racing with checks.  Holding the rcu read lock during a large tree
validation may also cause a prolonged rcu read window and "rcu_preempt
detected stalls" warnings.

Link: https://lore.kernel.org/all/0000000000001d12d4062005aea1@google.com/
Link: https://lkml.kernel.org/r/20240820175417.2782532-1-Liam.Howlett@oracle.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reported-by: syzbot+036af2f0c7338a33b0cd@syzkaller.appspotmail.com
Cc: Hillf Danton <hdanton@sina.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index aa3a5df15b8e..6df3a8b95808 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7566,14 +7566,14 @@ static void mt_validate_nulls(struct maple_tree *mt)
  * 2. The gap is correctly set in the parents
  */
 void mt_validate(struct maple_tree *mt)
+	__must_hold(mas->tree->ma_lock)
 {
 	unsigned char end;
 
 	MA_STATE(mas, mt, 0, 0);
-	rcu_read_lock();
 	mas_start(&mas);
 	if (!mas_is_active(&mas))
-		goto done;
+		return;
 
 	while (!mte_is_leaf(mas.node))
 		mas_descend(&mas);
@@ -7594,9 +7594,6 @@ void mt_validate(struct maple_tree *mt)
 		mas_dfs_postorder(&mas, ULONG_MAX);
 	}
 	mt_validate_nulls(mt);
-done:
-	rcu_read_unlock();
-
 }
 EXPORT_SYMBOL_GPL(mt_validate);
 


