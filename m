Return-Path: <stable+bounces-120911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 877E2A50901
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308EC1884FA7
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7A1C5D4E;
	Wed,  5 Mar 2025 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RBNSevGx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC521A5BB7;
	Wed,  5 Mar 2025 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198332; cv=none; b=RNbmlx75SWUQ9flBL17H8hjKrkfyE3ymXIAowsolB24GMQ+l8OiAXU+xCFyogzet66mM6uXPtNswAVKq181ivg2SVDpEVxbAOnIXFlhKVtVSMrSMsoZyecfiN0g35Mgz5xC8cyZSKW/SXsypkMrHQu2amTqlaW+cT2k4b6mUt2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198332; c=relaxed/simple;
	bh=uZXNVRwowt7V43zGg2Dcb7k3nSmkzNl5C97M0pyTN6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efS/ogtf39LWXe1Lu99+OVGZh2abIYhrVCZVWE4SOx7rjlh3Gjkg6guQdJKECt9o8271Rib8YdxWeUXD6LHxBuBGvPgBj/aW6KqHezn7r3PwOm0FNt5WWXmMTMtMBkqxaWimwLt9raJT+/7QwC9euCsXvFBzfRCq0jD/AK57E/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RBNSevGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53583C4CED1;
	Wed,  5 Mar 2025 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198331;
	bh=uZXNVRwowt7V43zGg2Dcb7k3nSmkzNl5C97M0pyTN6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBNSevGx6bqAFbQJhB0Q0BINQ02H7NOuqwQYfnFRmKQ8ryFI7rnxBRkehdUnrdHUR
	 wodlZmcRXBfx6pBJ1S17eUyjn31ZPTIkuXn9+aN+LarViv7e89CJ/k4B4gDAcAsv7R
	 qLXEkT7xtEmzsxBNyOZNKEN7Wg9XO4ZE7cqZ5RoE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Jones <pjones@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.12 141/150] efi: Dont map the entire mokvar table to determine its size
Date: Wed,  5 Mar 2025 18:49:30 +0100
Message-ID: <20250305174509.478421602@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174503.801402104@linuxfoundation.org>
References: <20250305174503.801402104@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Jones <pjones@redhat.com>

commit 2b90e7ace79774a3540ce569e000388f8d22c9e0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/mokvar-table.c |   42 +++++++++++-------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -103,9 +103,7 @@ void __init efi_mokvar_table_init(void)
 	void *va = NULL;
 	unsigned long cur_offset = 0;
 	unsigned long offset_limit;
-	unsigned long map_size = 0;
 	unsigned long map_size_needed = 0;
-	unsigned long size;
 	struct efi_mokvar_table_entry *mokvar_entry;
 	int err;
 
@@ -134,48 +132,34 @@ void __init efi_mokvar_table_init(void)
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



