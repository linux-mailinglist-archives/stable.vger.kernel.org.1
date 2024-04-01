Return-Path: <stable+bounces-33898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B9893994
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 11:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379D31F22133
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8D9101EB;
	Mon,  1 Apr 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oIck0IAh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D7FBFD
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964504; cv=none; b=q8Zrnm/uC1ksDpuXBdYmBef2ZrV/jID5D3DTbnDJyZvxGWmjYFnEdFUl0a5Enr/HH/gnodZPBlOiCSmmOgouvYzHU9MyMBSF+ZQLZrB336Joo0v9JpNEfm05UxY/K7+S1kGedrUUIDRsOYJyDq1FRSupsMPNXHuuw6PpE84g+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964504; c=relaxed/simple;
	bh=qmBu2S+Pb6X5NmpPuXkxLgXvtJFWYAjjdhMYsPA3g2E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kYea+wcEe7p3pWYS3yn8czoZSeS0q8fbQXO3tF2xj8XKWLlwrPXX+CQHnID9tcwzJ0qFfudr/5eaX3DGaSRTCcGGHsB6F2sSZnOAplTpPTzikrw/1gWxp5vKlNP8utv3NRmHgY0PaK4AV+iKm6ORW7K7f8u0FohvF8wH6d3lY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oIck0IAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB60C433C7;
	Mon,  1 Apr 2024 09:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711964504;
	bh=qmBu2S+Pb6X5NmpPuXkxLgXvtJFWYAjjdhMYsPA3g2E=;
	h=Subject:To:Cc:From:Date:From;
	b=oIck0IAhOAE6CdkPrcXq5jgvXTxdkrdVYB4P4/lYOCBj4Zucv3DIv3MAVG6sbCv7v
	 VvKWQDz9Axlll5gJcRUrAElNz9BAvAV6vXOGK4hwA7oIQNsgCZodoLa5nRbiI+rfEL
	 vzZV/+6WL4LJNSunYwIAYFe5/Ink/qQ0otXrQB+Q=
Subject: FAILED: patch "[PATCH] Revert "x86/mm/ident_map: Use gbpages only where full GB page" failed to apply to 4.19-stable tree
To: mingo@kernel.org,dave.hansen@linux.intel.com,rja@hpe.com,stable@vger.kernel.org,steve.wahl@hpe.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Apr 2024 11:41:24 +0200
Message-ID: <2024040123-denial-syndrome-2d01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x c567f2948f57bdc03ed03403ae0234085f376b7d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040123-denial-syndrome-2d01@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

c567f2948f57 ("Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."")
0a845e0f6348 ("mm/treewide: replace pud_large() with pud_leaf()")
d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
27af67f35631 ("powerpc/book3s64/mm: enable transparent pud hugepage")
104c49d5b6dc ("powerpc/mm/trace: convert trace event to trace event class")
040ec6202bb8 ("powerpc/mm/book3s64: Use pmdp_ptep helper instead of typecasting.")
bb1520d581a3 ("s390/mm: start kernel with DAT enabled")
9c3205b2b062 ("s390/boot: cleanup decompressor header files")
47477c84b891 ("Merge tag 's390-6.2-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c567f2948f57bdc03ed03403ae0234085f376b7d Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 25 Mar 2024 11:47:51 +0100
Subject: [PATCH] Revert "x86/mm/ident_map: Use gbpages only where full GB page
 should be mapped."

This reverts commit d794734c9bbfe22f86686dc2909c25f5ffe1a572.

While the original change tries to fix a bug, it also unintentionally broke
existing systems, see the regressions reported at:

  https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/

Since d794734c9bbf was also marked for -stable, let's back it out before
causing more damage.

Note that due to another upstream change the revert was not 100% automatic:

  0a845e0f6348 mm/treewide: replace pud_large() with pud_leaf()

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Cc: Russ Anderson <rja@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
Fixes: d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index a204a332c71f..968d7005f4a7 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,31 +26,18 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
-		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		/* if this is already a gbpage, this portion is already mapped */
-		if (pud_leaf(*pud))
-			continue;
-
-		/* Is using a gbpage allowed? */
-		use_gbpage = info->direct_gbpages;
-
-		/* Don't use gbpage if it maps more than the requested region. */
-		/* at the begining: */
-		use_gbpage &= ((addr & ~PUD_MASK) == 0);
-		/* ... or at the end: */
-		use_gbpage &= ((next & ~PUD_MASK) == 0);
-
-		/* Never overwrite existing mappings */
-		use_gbpage &= !pud_present(*pud);
-
-		if (use_gbpage) {
+		if (info->direct_gbpages) {
 			pud_t pudval;
 
+			if (pud_present(*pud))
+				continue;
+
+			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;


