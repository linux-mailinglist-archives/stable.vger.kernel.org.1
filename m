Return-Path: <stable+bounces-88244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B34839B218D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 01:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776B728136D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 00:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE6F63B9;
	Mon, 28 Oct 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qwULEzCu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F54C6C
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730075163; cv=none; b=T7M3moab0czOB8uJ9I2RgQ8ZQ+RpZ1GdE9mNKF1FPpOrAUPyhON72OPZxwdIso8zRO9T9Yb5g/JZ/OmcyAzg9COtayK5NUninLEo5/199iVLMsyWBNCD/lIEFb+qEcVE1c3qBBAlodN4iG4EGWd4GtLKCYk7b0bOKCGaU8RIl2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730075163; c=relaxed/simple;
	bh=pvMrrxkYrJBwUJQf5FEDHHClPCEYU5bmNHJBGU3fK8U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=obWbTtVZsTikSKfIhTVMv2f+ZLL6nfretX+dNtYJpp+O0iuLdUNBP23dnuRfu8T4A7dwBiZVBzawx+ejhEtz6OZxHr8rMtwB1N+VxRLgdjd9V1m0tseQIojb0I+GNZvk6dPbsy6CWX78YwpVBIl0g0M/10yNWA++WOZMnvWrWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qwULEzCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD328C4CEC3;
	Mon, 28 Oct 2024 00:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730075163;
	bh=pvMrrxkYrJBwUJQf5FEDHHClPCEYU5bmNHJBGU3fK8U=;
	h=Subject:To:Cc:From:Date:From;
	b=qwULEzCuKkMFuk8MpbieC3KVbG0skXJIkAQNwXpe8Q1sY9Rp37GLWweBZlvMtnYd4
	 XF1g2Elx2JoY98h75pTNtqEL4WnZLTQXIrYUyeHQ/vRkB08XExLqcB9rXjeh550kCR
	 MFKX1LC3r6w/IkAX0G5N0UpQwXl/cMzmR7w6UAmI=
Subject: FAILED: patch "[PATCH] ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and" failed to apply to 5.15-stable tree
To: kobak@nvidia.com,ardb@kernel.org,mochs@nvidia.com,rafael.j.wysocki@intel.com,rui.zhang@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Oct 2024 01:25:50 +0100
Message-ID: <2024102850-postal-pogo-94ed@gregkh>
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
git cherry-pick -x 088984c8d54c0053fc4ae606981291d741c5924b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102850-postal-pogo-94ed@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 088984c8d54c0053fc4ae606981291d741c5924b Mon Sep 17 00:00:00 2001
From: Koba Ko <kobak@nvidia.com>
Date: Sun, 13 Oct 2024 04:50:10 +0800
Subject: [PATCH] ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and
 context

PRMT needs to find the correct type of block to translate the PA-VA
mapping for EFI runtime services.

The issue arises because the PRMT is finding a block of type
EFI_CONVENTIONAL_MEMORY, which is not appropriate for runtime services
as described in Section 2.2.2 (Runtime Services) of the UEFI
Specification [1]. Since the PRM handler is a type of runtime service,
this causes an exception when the PRM handler is called.

    [Firmware Bug]: Unable to handle paging request in EFI runtime service
    WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c:341
        __efi_queue_work+0x11c/0x170
    Call trace:

Let PRMT find a block with EFI_MEMORY_RUNTIME for PRM handler and PRM
context.

If no suitable block is found, a warning message will be printed, but
the procedure continues to manage the next PRM handler.

However, if the PRM handler is actually called without proper allocation,
it would result in a failure during error handling.

By using the correct memory types for runtime services, ensure that the
PRM handler and the context are properly mapped in the virtual address
space during runtime, preventing the paging request error.

The issue is really that only memory that has been remapped for runtime
by the firmware can be used by the PRM handler, and so the region needs
to have the EFI_MEMORY_RUNTIME attribute.

Link: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf # [1]
Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Koba Ko <kobak@nvidia.com>
Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://patch.msgid.link/20241012205010.4165798-1-kobak@nvidia.com
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 1cfaa5957ac4..d59307a76ca3 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -72,17 +72,21 @@ struct prm_module_info {
 	struct prm_handler_info handlers[] __counted_by(handler_count);
 };
 
-static u64 efi_pa_va_lookup(u64 pa)
+static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 {
 	efi_memory_desc_t *md;
 	u64 pa_offset = pa & ~PAGE_MASK;
 	u64 page = pa & PAGE_MASK;
 
 	for_each_efi_memory_desc(md) {
-		if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
+		if ((md->attribute & EFI_MEMORY_RUNTIME) &&
+		    (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
 			return pa_offset + md->virt_addr + page - md->phys_addr;
+		}
 	}
 
+	pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
+
 	return 0;
 }
 
@@ -148,9 +152,15 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		th = &tm->handlers[cur_handler];
 
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
-		th->handler_addr = (void *)efi_pa_va_lookup(handler_info->handler_address);
-		th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
-		th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
+		th->handler_addr =
+			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
+
+		th->static_data_buffer_addr =
+			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
+
+		th->acpi_param_buffer_addr =
+			efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
+
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
 
 	return 0;
@@ -277,6 +287,13 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 		if (!handler || !module)
 			goto invalid_guid;
 
+		if (!handler->handler_addr ||
+		    !handler->static_data_buffer_addr ||
+		    !handler->acpi_param_buffer_addr) {
+			buffer->prm_status = PRM_HANDLER_ERROR;
+			return AE_OK;
+		}
+
 		ACPI_COPY_NAMESEG(context.signature, "PRMC");
 		context.revision = 0x0;
 		context.reserved = 0x0;


