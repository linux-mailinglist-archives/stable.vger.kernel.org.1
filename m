Return-Path: <stable+bounces-120362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF85A4EAE6
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 19:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02538E3B2E
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152132980CB;
	Tue,  4 Mar 2025 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ErWha+7o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B802980A1
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109904; cv=none; b=ua4nNCAd10hx/MIi1hgh1meDdujAJZIWnV/s1LhKdz77Gp10PihQW/dDxql7PDLSyiE1ZjQQFYFUhDHXiBjZuEf6XJmSNoolQ4JfRsgtdlKXjFwJBNpZxZZpfp3kf40hNFzKZR8IYILceunNoGXftzPcOMECWrRi1bO36c7ccuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109904; c=relaxed/simple;
	bh=1Nq3MRL+UdYRWNZqYAsWeGVXFGOZIf+oy/xlgu/yjOo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CE2JhmhShSAKqEe5AwyAF7SoN7zXw4NMNrb5QBMZB/bIkNi47viUnTS1wn5QfwhEDEfbwmMfOPOX0s+wi+dAeYbpXjArFcKxZnzk0d/TKElY6ZGKEuVFExXxL8Wfql9XY6jZpetbdktYzK1ZhVqH+QIGYNaiJyfvUswQFqHcccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ErWha+7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B0BC4CEE5;
	Tue,  4 Mar 2025 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741109904;
	bh=1Nq3MRL+UdYRWNZqYAsWeGVXFGOZIf+oy/xlgu/yjOo=;
	h=Subject:To:Cc:From:Date:From;
	b=ErWha+7oxAKGID6DtiA8i4KqyxqGcTUg+KXAGFdhC/O16oZdJG58TpsWc0CHbnuTj
	 Fulz4I8UbuS+Dg0flkDMHqJrkVbZuRTdsLGFNF8fA8YhbFnwSP9lnpMOEI5sRxAWXx
	 +qQU9pDkUqzODFmXeLv3i4cbFiu6snegqAOL5OPA=
Subject: FAILED: patch "[PATCH] efi: Don't map the entire mokvar table to determine its size" failed to apply to 6.13-stable tree
To: pjones@redhat.com,ardb@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 18:38:21 +0100
Message-ID: <2025030421-disgrace-wince-4786@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x 2b90e7ace79774a3540ce569e000388f8d22c9e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030421-disgrace-wince-4786@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b90e7ace79774a3540ce569e000388f8d22c9e0 Mon Sep 17 00:00:00 2001
From: Peter Jones <pjones@redhat.com>
Date: Wed, 26 Feb 2025 15:18:39 -0500
Subject: [PATCH] efi: Don't map the entire mokvar table to determine its size

Currently, when validating the mokvar table, we (re)map the entire table
on each iteration of the loop, adding space as we discover new entries.
If the table grows over a certain size, this fails due to limitations of
early_memmap(), and we get a failure and traceback:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 0 at mm/early_ioremap.c:139 __early_ioremap+0xef/0x220
  ...
  Call Trace:
   <TASK>
   ? __early_ioremap+0xef/0x220
   ? __warn.cold+0x93/0xfa
   ? __early_ioremap+0xef/0x220
   ? report_bug+0xff/0x140
   ? early_fixup_exception+0x5d/0xb0
   ? early_idt_handler_common+0x2f/0x3a
   ? __early_ioremap+0xef/0x220
   ? efi_mokvar_table_init+0xce/0x1d0
   ? setup_arch+0x864/0xc10
   ? start_kernel+0x6b/0xa10
   ? x86_64_start_reservations+0x24/0x30
   ? x86_64_start_kernel+0xed/0xf0
   ? common_startup_64+0x13e/0x141
   </TASK>
  ---[ end trace 0000000000000000 ]---
  mokvar: Failed to map EFI MOKvar config table pa=0x7c4c3000, size=265187.

Mapping the entire structure isn't actually necessary, as we don't ever
need more than one entry header mapped at once.

Changes efi_mokvar_table_init() to only map each entry header, not the
entire table, when determining the table size.  Since we're not mapping
any data past the variable name, it also changes the code to enforce
that each variable name is NUL terminated, rather than attempting to
verify it in place.

Cc: <stable@vger.kernel.org>
Signed-off-by: Peter Jones <pjones@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index 5ed0602c2f75..d865cb1dbaad 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -103,7 +103,6 @@ void __init efi_mokvar_table_init(void)
 	void *va = NULL;
 	unsigned long cur_offset = 0;
 	unsigned long offset_limit;
-	unsigned long map_size = 0;
 	unsigned long map_size_needed = 0;
 	unsigned long size;
 	struct efi_mokvar_table_entry *mokvar_entry;
@@ -134,48 +133,34 @@ void __init efi_mokvar_table_init(void)
 	 */
 	err = -EINVAL;
 	while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
-		mokvar_entry = va + cur_offset;
-		map_size_needed = cur_offset + sizeof(*mokvar_entry);
-		if (map_size_needed > map_size) {
-			if (va)
-				early_memunmap(va, map_size);
-			/*
-			 * Map a little more than the fixed size entry
-			 * header, anticipating some data. It's safe to
-			 * do so as long as we stay within current memory
-			 * descriptor.
-			 */
-			map_size = min(map_size_needed + 2*EFI_PAGE_SIZE,
-				       offset_limit);
-			va = early_memremap(efi.mokvar_table, map_size);
-			if (!va) {
-				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%lu.\n",
-				       efi.mokvar_table, map_size);
-				return;
-			}
-			mokvar_entry = va + cur_offset;
+		if (va)
+			early_memunmap(va, sizeof(*mokvar_entry));
+		va = early_memremap(efi.mokvar_table + cur_offset, sizeof(*mokvar_entry));
+		if (!va) {
+			pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%zu.\n",
+			       efi.mokvar_table + cur_offset, sizeof(*mokvar_entry));
+			return;
 		}
+		mokvar_entry = va;
 
 		/* Check for last sentinel entry */
 		if (mokvar_entry->name[0] == '\0') {
 			if (mokvar_entry->data_size != 0)
 				break;
 			err = 0;
+			map_size_needed = cur_offset + sizeof(*mokvar_entry);
 			break;
 		}
 
-		/* Sanity check that the name is null terminated */
-		size = strnlen(mokvar_entry->name,
-			       sizeof(mokvar_entry->name));
-		if (size >= sizeof(mokvar_entry->name))
-			break;
+		/* Enforce that the name is NUL terminated */
+		mokvar_entry->name[sizeof(mokvar_entry->name) - 1] = '\0';
 
 		/* Advance to the next entry */
-		cur_offset = map_size_needed + mokvar_entry->data_size;
+		cur_offset += sizeof(*mokvar_entry) + mokvar_entry->data_size;
 	}
 
 	if (va)
-		early_memunmap(va, map_size);
+		early_memunmap(va, sizeof(*mokvar_entry));
 	if (err) {
 		pr_err("EFI MOKvar config table is not valid\n");
 		return;


