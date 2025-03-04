Return-Path: <stable+bounces-120379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B8AA4ED52
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 20:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C7C169816
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01724C069;
	Tue,  4 Mar 2025 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1tMTgYG"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA6A18CBE1
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116537; cv=none; b=RJyvO2VGZnRS2H3RPsCZEfbzIc1r2mj4fPK6k+KbUR2yTHCr2Ibjix1B1qxpAvqLfa+QGzCH8F8cKsgBPaMxdyWNSgT+CdCpLR71fMpaK/sVkxMFMg5EpMyskMDpdhNVPVZD9nPbefO2n9YUIsUIRcGn/75urGXkCUKf7Cx6RHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116537; c=relaxed/simple;
	bh=CVtH3rjj5H+D+sbh6Nnc9FLN+Wm2B6Lt6W2QtHIEJR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbxEL2rDuFLVEwvSV74OwFjxpzj/K73r5EcTIWK53FkoVbbNKYAaOP6DyepRkDdyv+NkDCd1no+SJkNs7mZ1i/ZEOcnU/PRgepLEoT/5h2BcsMEq/bTXxfDO7xdZPcDqXHaqMPh3hGyjgk802SDknpe5WyyOnD9z5cqgtfxtFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1tMTgYG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741116534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46fpeNL+b7wmtfFCTN6hPI9ZqT/KfQA/W6Pb0PS2rjU=;
	b=N1tMTgYGy0SrUvBOgnpKTEr9VjXGIKcizEnMNaYs7WKoV4JQwy18GTWkL+ufan6ZMwo5LQ
	MocCPza1RFSLdrIJU/FH1dWq5G8CyV/ZKTM1WFxa5PdXfVbgSP/xGlVeAsnXaulil/IAcB
	0ZS8IYFPBFHuvWFcEfr3QSflg0UwfTg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-jVMqwJ9oNy---1TqzY3omw-1; Tue,
 04 Mar 2025 14:28:36 -0500
X-MC-Unique: jVMqwJ9oNy---1TqzY3omw-1
X-Mimecast-MFC-AGG-ID: jVMqwJ9oNy---1TqzY3omw_1741116515
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88FE419560BC;
	Tue,  4 Mar 2025 19:28:35 +0000 (UTC)
Received: from random.internal.datastacks.com (unknown [10.22.82.71])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0BDF180035F;
	Tue,  4 Mar 2025 19:28:34 +0000 (UTC)
From: Peter Jones <pjones@redhat.com>
To: stable@vger.kernel.org
Cc: Peter Jones <pjones@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.12.y] efi: Don't map the entire mokvar table to determine its size
Date: Tue,  4 Mar 2025 14:28:29 -0500
Message-ID: <20250304192829.3044702-1-pjones@redhat.com>
In-Reply-To: <2025030422-depict-timing-18a8@gregkh>
References: <2025030422-depict-timing-18a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
(cherry picked from commit 2b90e7ace79774a3540ce569e000388f8d22c9e0)
---
 drivers/firmware/efi/mokvar-table.c | 42 +++++++++--------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index 5ed0602c2f7..4eb0dff4dfa 100644
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
-- 
2.48.1


