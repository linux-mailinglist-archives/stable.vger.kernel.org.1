Return-Path: <stable+bounces-152873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9355ADCFDD
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE221942760
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF622EF644;
	Tue, 17 Jun 2025 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OKbivJiH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22E2EF64E
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170217; cv=none; b=J6T5OFO9vMvpuE5M1dNaVYIZdzXknllbixiCEozp6LURj0WEC6bH+mV0NEi0COTP3bHFTFlvupLnWMHchiuSXK4sNMbThSdiONXxCXAyWposx0+eUBateCYO5Jd4BLeeYdAas3jZc0bBC6meDpezFe+ij5qCBIMAGttlxZw6kAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170217; c=relaxed/simple;
	bh=uQi5KtdQ5oQuJwi/62SX29yD1MzOyTQNAVDMmUCbYFU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LlAIDBfh6VnhKL8kxWRW75d9M0JUjOqMxRtFyumuuYm5WNdAPWKzjtPs0/Ca0lM6TBxLRwWgp51eXOpPL9Grlp3+JsEHaVs3xcaXewkLKYNaNAW3Guzw9UoJiQl13lsBlr2gUTe4dDEtUnAqVYmHr4rhSH3sWqhDwkZf9iXhZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OKbivJiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EA8C4CEE3;
	Tue, 17 Jun 2025 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750170216;
	bh=uQi5KtdQ5oQuJwi/62SX29yD1MzOyTQNAVDMmUCbYFU=;
	h=Subject:To:Cc:From:Date:From;
	b=OKbivJiH52hJPAfJJHVPUNoiUQ0nqC/so5faQ6fdaqnqcsRGapgMoc6in42d9zbv+
	 a/cZBFgnsU35fxTHmQ3PATL/4OCKK/lsoTbQi6Q7+ohlS/0SYpJ3JVChouRyDcaKSh
	 GgWFT4yX6dA/0dGeCxJZOy6BVyJMTRDo3oo3TeMM=
Subject: FAILED: patch "[PATCH] VMCI: fix race between vmci_host_setup_notify and" failed to apply to 5.10-stable tree
To: mawupeng1@huawei.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 16:23:33 +0200
Message-ID: <2025061733-scarring-crevice-7648@gregkh>
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
git cherry-pick -x 1bd6406fb5f36c2bb1e96e27d4c3e9f4d09edde4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025061733-scarring-crevice-7648@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1bd6406fb5f36c2bb1e96e27d4c3e9f4d09edde4 Mon Sep 17 00:00:00 2001
From: Wupeng Ma <mawupeng1@huawei.com>
Date: Sat, 10 May 2025 11:30:40 +0800
Subject: [PATCH] VMCI: fix race between vmci_host_setup_notify and
 vmci_ctx_unset_notify

During our test, it is found that a warning can be trigger in try_grab_folio
as follow:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1678 at mm/gup.c:147 try_grab_folio+0x106/0x130
  Modules linked in:
  CPU: 0 UID: 0 PID: 1678 Comm: syz.3.31 Not tainted 6.15.0-rc5 #163 PREEMPT(undef)
  RIP: 0010:try_grab_folio+0x106/0x130
  Call Trace:
   <TASK>
   follow_huge_pmd+0x240/0x8e0
   follow_pmd_mask.constprop.0.isra.0+0x40b/0x5c0
   follow_pud_mask.constprop.0.isra.0+0x14a/0x170
   follow_page_mask+0x1c2/0x1f0
   __get_user_pages+0x176/0x950
   __gup_longterm_locked+0x15b/0x1060
   ? gup_fast+0x120/0x1f0
   gup_fast_fallback+0x17e/0x230
   get_user_pages_fast+0x5f/0x80
   vmci_host_unlocked_ioctl+0x21c/0xf80
  RIP: 0033:0x54d2cd
  ---[ end trace 0000000000000000 ]---

Digging into the source, context->notify_page may init by get_user_pages_fast
and can be seen in vmci_ctx_unset_notify which will try to put_page. However
get_user_pages_fast is not finished here and lead to following
try_grab_folio warning. The race condition is shown as follow:

cpu0			cpu1
vmci_host_do_set_notify
vmci_host_setup_notify
get_user_pages_fast(uva, 1, FOLL_WRITE, &context->notify_page);
lockless_pages_from_mm
gup_pgd_range
gup_huge_pmd  // update &context->notify_page
			vmci_host_do_set_notify
			vmci_ctx_unset_notify
			notify_page = context->notify_page;
			if (notify_page)
			put_page(notify_page);	// page is freed
__gup_longterm_locked
__get_user_pages
follow_trans_huge_pmd
try_grab_folio // warn here

To slove this, use local variable page to make notify_page can be seen
after finish get_user_pages_fast.

Fixes: a1d88436d53a ("VMCI: Fix two UVA mapping bugs")
Cc: stable <stable@kernel.org>
Closes: https://lore.kernel.org/all/e91da589-ad57-3969-d979-879bbd10dddd@huawei.com/
Signed-off-by: Wupeng Ma <mawupeng1@huawei.com>
Link: https://lore.kernel.org/r/20250510033040.901582-1-mawupeng1@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index abe79f6fd2a7..b64944367ac5 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -227,6 +227,7 @@ static int drv_cp_harray_to_user(void __user *user_buf_uva,
 static int vmci_host_setup_notify(struct vmci_ctx *context,
 				  unsigned long uva)
 {
+	struct page *page;
 	int retval;
 
 	if (context->notify_page) {
@@ -243,13 +244,11 @@ static int vmci_host_setup_notify(struct vmci_ctx *context,
 	/*
 	 * Lock physical page backing a given user VA.
 	 */
-	retval = get_user_pages_fast(uva, 1, FOLL_WRITE, &context->notify_page);
-	if (retval != 1) {
-		context->notify_page = NULL;
+	retval = get_user_pages_fast(uva, 1, FOLL_WRITE, &page);
+	if (retval != 1)
 		return VMCI_ERROR_GENERIC;
-	}
-	if (context->notify_page == NULL)
-		return VMCI_ERROR_UNAVAILABLE;
+
+	context->notify_page = page;
 
 	/*
 	 * Map the locked page and set up notify pointer.


