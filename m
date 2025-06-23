Return-Path: <stable+bounces-156596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40EEAE503C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F2F17ECD3
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512CF1E521E;
	Mon, 23 Jun 2025 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FjDcN+rO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE682628C;
	Mon, 23 Jun 2025 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713801; cv=none; b=KVvQRrr2CrVPm64oYZ+KvXb7d42s7SfteK+j9EZ0oyMg39APEwCYKt7/qQY7QEIuI8dJIrKqL510hAOA6TVNmV+JETuMgBhxuwjQcZPrKB20qD0hdGORNYWAY+J9pbGx3lp1S0mNCgMgyvZplnYYqlaL7dnt8GO4vPPZh4U48wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713801; c=relaxed/simple;
	bh=hfy6ggw8UISOawMRoC/1lYi2AEqwhP5W6u0I2gQe9VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIvvA9tHAoJ4n2JPUmdFB57xbq0lmevWWMO9cBiB2SBCyg2rKaywdAOhupEKyghWGEDMPUdRWir5goWCbfQb+s/pdLMWeYNkbJ2F4xQ5EEAqIB4qg+9eYyYAWprRXv0bGYbU18MOjxvrB94jmolYU9KQrLsiwbw1hHuEuzFS18c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FjDcN+rO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F1FC4CEEA;
	Mon, 23 Jun 2025 21:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713800;
	bh=hfy6ggw8UISOawMRoC/1lYi2AEqwhP5W6u0I2gQe9VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjDcN+rOCZhgTWzui4JkWLQcYhmqgo3r2gB+vk9qMC8IoOCA/BzxbYm3Z6aVK7bJ/
	 X0dkPorVLmKUXL0xQ0aQk4qW8n+2j7xYy9lEs+smxFbvdF8eHkZKMcguoDlrYDMAnf
	 LOY76ANFGeub2MIYI/OVTHC5adPYg8//tPQjNapY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Seunghun Han <kkamagui@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 116/290] ACPICA: fix acpi operand cache leak in dswstate.c
Date: Mon, 23 Jun 2025 15:06:17 +0200
Message-ID: <20250623130630.433524875@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Seunghun Han <kkamagui@gmail.com>

[ Upstream commit 156fd20a41e776bbf334bd5e45c4f78dfc90ce1c ]

ACPICA commit 987a3b5cf7175916e2a4b6ea5b8e70f830dfe732

I found an ACPI cache leak in ACPI early termination and boot continuing case.

When early termination occurs due to malicious ACPI table, Linux kernel
terminates ACPI function and continues to boot process. While kernel terminates
ACPI function, kmem_cache_destroy() reports Acpi-Operand cache leak.

Boot log of ACPI operand cache leak is as follows:
>[    0.585957] ACPI: Added _OSI(Module Device)
>[    0.587218] ACPI: Added _OSI(Processor Device)
>[    0.588530] ACPI: Added _OSI(3.0 _SCP Extensions)
>[    0.589790] ACPI: Added _OSI(Processor Aggregator Device)
>[    0.591534] ACPI Error: Illegal I/O port address/length above 64K: C806E00000004002/0x2 (20170303/hwvalid-155)
>[    0.594351] ACPI Exception: AE_LIMIT, Unable to initialize fixed events (20170303/evevent-88)
>[    0.597858] ACPI: Unable to start the ACPI Interpreter
>[    0.599162] ACPI Error: Could not remove SCI handler (20170303/evmisc-281)
>[    0.601836] kmem_cache_destroy Acpi-Operand: Slab cache still has objects
>[    0.603556] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc5 #26
>[    0.605159] Hardware name: innotek gmb_h virtual_box/virtual_box, BIOS virtual_box 12/01/2006
>[    0.609177] Call Trace:
>[    0.610063]  ? dump_stack+0x5c/0x81
>[    0.611118]  ? kmem_cache_destroy+0x1aa/0x1c0
>[    0.612632]  ? acpi_sleep_proc_init+0x27/0x27
>[    0.613906]  ? acpi_os_delete_cache+0xa/0x10
>[    0.617986]  ? acpi_ut_delete_caches+0x3f/0x7b
>[    0.619293]  ? acpi_terminate+0xa/0x14
>[    0.620394]  ? acpi_init+0x2af/0x34f
>[    0.621616]  ? __class_create+0x4c/0x80
>[    0.623412]  ? video_setup+0x7f/0x7f
>[    0.624585]  ? acpi_sleep_proc_init+0x27/0x27
>[    0.625861]  ? do_one_initcall+0x4e/0x1a0
>[    0.627513]  ? kernel_init_freeable+0x19e/0x21f
>[    0.628972]  ? rest_init+0x80/0x80
>[    0.630043]  ? kernel_init+0xa/0x100
>[    0.631084]  ? ret_from_fork+0x25/0x30
>[    0.633343] vgaarb: loaded
>[    0.635036] EDAC MC: Ver: 3.0.0
>[    0.638601] PCI: Probing PCI hardware
>[    0.639833] PCI host bridge to bus 0000:00
>[    0.641031] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> ... Continue to boot and log is omitted ...

I analyzed this memory leak in detail and found acpi_ds_obj_stack_pop_and_
delete() function miscalculated the top of the stack. acpi_ds_obj_stack_push()
function uses walk_state->operand_index for start position of the top, but
acpi_ds_obj_stack_pop_and_delete() function considers index 0 for it.
Therefore, this causes acpi operand memory leak.

This cache leak causes a security threat because an old kernel (<= 4.9) shows
memory locations of kernel functions in stack dump. Some malicious users
could use this information to neutralize kernel ASLR.

I made a patch to fix ACPI operand cache leak.

Link: https://github.com/acpica/acpica/commit/987a3b5c
Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/4999480.31r3eYUQgx@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/dsutils.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index fb9ed5e1da89d..2bdae8a25e084 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -668,6 +668,8 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	union acpi_parse_object *arguments[ACPI_OBJ_NUM_OPERANDS];
 	u32 arg_count = 0;
 	u32 index = walk_state->num_operands;
+	u32 prev_num_operands = walk_state->num_operands;
+	u32 new_num_operands;
 	u32 i;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_create_operands, first_arg);
@@ -696,6 +698,7 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 
 	/* Create the interpreter arguments, in reverse order */
 
+	new_num_operands = index;
 	index--;
 	for (i = 0; i < arg_count; i++) {
 		arg = arguments[index];
@@ -720,7 +723,11 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	 * pop everything off of the operand stack and delete those
 	 * objects
 	 */
-	acpi_ds_obj_stack_pop_and_delete(arg_count, walk_state);
+	walk_state->num_operands = i;
+	acpi_ds_obj_stack_pop_and_delete(new_num_operands, walk_state);
+
+	/* Restore operand count */
+	walk_state->num_operands = prev_num_operands;
 
 	ACPI_EXCEPTION((AE_INFO, status, "While creating Arg %u", index));
 	return_ACPI_STATUS(status);
-- 
2.39.5




