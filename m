Return-Path: <stable+bounces-189786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA0CC0A9FF
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14203A3178
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E3E2DC763;
	Sun, 26 Oct 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l65MJcda"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989C2DF15E
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488812; cv=none; b=kkJOrmpJiopHwT8CyJhlAAdpcp6iVoKzI+tb9Ip5AsmT8lk6OC1qvHI9Lz8ISblZk9edmOydJdaiddjA0wSefX07XcpFwmm6ojWftolnkfGBbTZW4s32rMdVhNPXbt5uQAoCYuoC41uVg6FcSUIJ+X+JIQeuFJSn93EyrcpZXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488812; c=relaxed/simple;
	bh=H+y7tokTGnmDnAM7YmgWy0+3H/x0312btwmlaEX6aH4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XjD8KwHdUsL9xSCWMJInP9nuhyIlzRsKxMC3lRR4JbdGBUvpMZgGBvsjEX3OG8uCF60dggcCklbdOigSgC8uPi/jq98jX7hitB0sAOlMqXRo1PdfwcyoAyNIHwIxIkeG+0pbKcXIqxPNCieR+KSLHm61fpiFoKVhriTiqOZx0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l65MJcda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7A6C4CEE7;
	Sun, 26 Oct 2025 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761488811;
	bh=H+y7tokTGnmDnAM7YmgWy0+3H/x0312btwmlaEX6aH4=;
	h=Subject:To:Cc:From:Date:From;
	b=l65MJcdaJRuRtkehL99dhjOe4JHgRafx4CaEgwM3aCfEyZhOul/yDxLwE5ekjdlPS
	 gtCD6x+usVjOb4FU4lF0S6yMA519MiOpWmGLKlVLN0O79ExddPhApHM/3ZLUOlYhnz
	 l1QZXz0VQ6Ehn3M+FqGTN+nu89LBg5+Qe0ptxkQ0=
Subject: FAILED: patch "[PATCH] arm64: mte: Do not warn if the page is already tagged in" failed to apply to 6.12-stable tree
To: catalin.marinas@arm.com,david@redhat.com,wangkefeng.wang@huawei.com,will@kernel.org,yang@os.amperecomputing.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:26:49 +0100
Message-ID: <2025102649-rebirth-stray-74d8@gregkh>
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
git cherry-pick -x b98c94eed4a975e0c80b7e90a649a46967376f58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102649-rebirth-stray-74d8@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b98c94eed4a975e0c80b7e90a649a46967376f58 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 22 Oct 2025 11:09:14 +0100
Subject: [PATCH] arm64: mte: Do not warn if the page is already tagged in
 copy_highpage()

The arm64 copy_highpage() assumes that the destination page is newly
allocated and not MTE-tagged (PG_mte_tagged unset) and warns
accordingly. However, following commit 060913999d7a ("mm: migrate:
support poisoned recover from migrate folio"), folio_mc_copy() is called
before __folio_migrate_mapping(). If the latter fails (-EAGAIN), the
copy will be done again to the same destination page. Since
copy_highpage() already set the PG_mte_tagged flag, this second copy
will warn.

Replace the WARN_ON_ONCE(page already tagged) in the arm64
copy_highpage() with a comment.

Reported-by: syzbot+d1974fc28545a3e6218b@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/68dda1ae.a00a0220.102ee.0065.GAE@google.com
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index a86c897017df..cd5912ba617b 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -35,7 +35,7 @@ void copy_highpage(struct page *to, struct page *from)
 		    from != folio_page(src, 0))
 			return;
 
-		WARN_ON_ONCE(!folio_try_hugetlb_mte_tagging(dst));
+		folio_try_hugetlb_mte_tagging(dst);
 
 		/*
 		 * Populate tags for all subpages.
@@ -51,8 +51,13 @@ void copy_highpage(struct page *to, struct page *from)
 		}
 		folio_set_hugetlb_mte_tagged(dst);
 	} else if (page_mte_tagged(from)) {
-		/* It's a new page, shouldn't have been tagged yet */
-		WARN_ON_ONCE(!try_page_mte_tagging(to));
+		/*
+		 * Most of the time it's a new page that shouldn't have been
+		 * tagged yet. However, folio migration can end up reusing the
+		 * same page without untagging it. Ignore the warning if the
+		 * page is already tagged.
+		 */
+		try_page_mte_tagging(to);
 
 		mte_copy_page_tags(kto, kfrom);
 		set_page_mte_tagged(to);


