Return-Path: <stable+bounces-157234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67581AE5313
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BE61B665C6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D532F219A7A;
	Mon, 23 Jun 2025 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oWBTGClx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BFB1A00F0;
	Mon, 23 Jun 2025 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715369; cv=none; b=mjs2G4y+hV2bcgLKnKljmRiuDZhCYeMW5TmCkZr8QdQdkxraocAnM1zx3GV4yXH4JDvL/9HGJ/LLTHCAOTOQznOH1KEP4h+sH9mKbcebkwiI3tuGbuQjfB9gGjpDbiWdRM4nN04ZvBUvX+8R3mf/PyhxvvRyeZosHwnxMXNfhLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715369; c=relaxed/simple;
	bh=uTIB3GejH0053rC9UPafPWsZJC6xb7LvwujwSotbn68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVG14aa4557asm0hBK91wXuvWwLDzY7dU5QI6wVMD+UCNeLWE17AA+rfJ6yXFkwqBEq18AJ/Ag0BP6e6Ni2/WDlZwgvElsTUhYWBwurqH3gDsE7T0CXMp0pxcAg67yj3Pz4kZhJc3dV4HQZ7IwkXvyCuPFIzCOd58a9ai8aA8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oWBTGClx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC86EC4CEEA;
	Mon, 23 Jun 2025 21:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715369;
	bh=uTIB3GejH0053rC9UPafPWsZJC6xb7LvwujwSotbn68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWBTGClx1AWTSLqngRQalOsvtmZqa4EXA0CJZ7q4RtbOae8ZmjakK90b8JY1fPbt5
	 2yOgDKAEJr8VsXnt8adIKHo0Hd+fF+nJQHYra2zJZmVBG+ZXXMvEH8ENkLbzVZESL0
	 8hk4CqMnZATTdkrRXmWgY2g6Lj+PPiR4FmATQbvA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Seunghun Han <kkamagui@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 178/414] ACPICA: fix acpi parse and parseext cache leaks
Date: Mon, 23 Jun 2025 15:05:15 +0200
Message-ID: <20250623130646.477683491@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Seunghun Han <kkamagui@gmail.com>

[ Upstream commit bed18f0bdcd6737a938264a59d67923688696fc4 ]

ACPICA commit 8829e70e1360c81e7a5a901b5d4f48330e021ea5

I'm Seunghun Han, and I work for National Security Research Institute of
South Korea.

I have been doing a research on ACPI and found an ACPI cache leak in ACPI
early abort cases.

Boot log of ACPI cache leak is as follows:
[    0.352414] ACPI: Added _OSI(Module Device)
[    0.353182] ACPI: Added _OSI(Processor Device)
[    0.353182] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.353182] ACPI: Added _OSI(Processor Aggregator Device)
[    0.356028] ACPI: Unable to start the ACPI Interpreter
[    0.356799] ACPI Error: Could not remove SCI handler (20170303/evmisc-281)
[    0.360215] kmem_cache_destroy Acpi-State: Slab cache still has objects
[    0.360648] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
4.12.0-rc4-next-20170608+ #10
[    0.361273] Hardware name: innotek gmb_h virtual_box/virtual_box, BIOS
virtual_box 12/01/2006
[    0.361873] Call Trace:
[    0.362243]  ? dump_stack+0x5c/0x81
[    0.362591]  ? kmem_cache_destroy+0x1aa/0x1c0
[    0.362944]  ? acpi_sleep_proc_init+0x27/0x27
[    0.363296]  ? acpi_os_delete_cache+0xa/0x10
[    0.363646]  ? acpi_ut_delete_caches+0x6d/0x7b
[    0.364000]  ? acpi_terminate+0xa/0x14
[    0.364000]  ? acpi_init+0x2af/0x34f
[    0.364000]  ? __class_create+0x4c/0x80
[    0.364000]  ? video_setup+0x7f/0x7f
[    0.364000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.364000]  ? do_one_initcall+0x4e/0x1a0
[    0.364000]  ? kernel_init_freeable+0x189/0x20a
[    0.364000]  ? rest_init+0xc0/0xc0
[    0.364000]  ? kernel_init+0xa/0x100
[    0.364000]  ? ret_from_fork+0x25/0x30

I analyzed this memory leak in detail. I found that “Acpi-State” cache and
“Acpi-Parse” cache were merged because the size of cache objects was same
slab cache size.

I finally found “Acpi-Parse” cache and “Acpi-parse_ext” cache were leaked
using SLAB_NEVER_MERGE flag in kmem_cache_create() function.

Real ACPI cache leak point is as follows:
[    0.360101] ACPI: Added _OSI(Module Device)
[    0.360101] ACPI: Added _OSI(Processor Device)
[    0.360101] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.361043] ACPI: Added _OSI(Processor Aggregator Device)
[    0.364016] ACPI: Unable to start the ACPI Interpreter
[    0.365061] ACPI Error: Could not remove SCI handler (20170303/evmisc-281)
[    0.368174] kmem_cache_destroy Acpi-Parse: Slab cache still has objects
[    0.369332] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
4.12.0-rc4-next-20170608+ #8
[    0.371256] Hardware name: innotek gmb_h virtual_box/virtual_box, BIOS
virtual_box 12/01/2006
[    0.372000] Call Trace:
[    0.372000]  ? dump_stack+0x5c/0x81
[    0.372000]  ? kmem_cache_destroy+0x1aa/0x1c0
[    0.372000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.372000]  ? acpi_os_delete_cache+0xa/0x10
[    0.372000]  ? acpi_ut_delete_caches+0x56/0x7b
[    0.372000]  ? acpi_terminate+0xa/0x14
[    0.372000]  ? acpi_init+0x2af/0x34f
[    0.372000]  ? __class_create+0x4c/0x80
[    0.372000]  ? video_setup+0x7f/0x7f
[    0.372000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.372000]  ? do_one_initcall+0x4e/0x1a0
[    0.372000]  ? kernel_init_freeable+0x189/0x20a
[    0.372000]  ? rest_init+0xc0/0xc0
[    0.372000]  ? kernel_init+0xa/0x100
[    0.372000]  ? ret_from_fork+0x25/0x30
[    0.388039] kmem_cache_destroy Acpi-parse_ext: Slab cache still has objects
[    0.389063] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
4.12.0-rc4-next-20170608+ #8
[    0.390557] Hardware name: innotek gmb_h virtual_box/virtual_box, BIOS
virtual_box 12/01/2006
[    0.392000] Call Trace:
[    0.392000]  ? dump_stack+0x5c/0x81
[    0.392000]  ? kmem_cache_destroy+0x1aa/0x1c0
[    0.392000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.392000]  ? acpi_os_delete_cache+0xa/0x10
[    0.392000]  ? acpi_ut_delete_caches+0x6d/0x7b
[    0.392000]  ? acpi_terminate+0xa/0x14
[    0.392000]  ? acpi_init+0x2af/0x34f
[    0.392000]  ? __class_create+0x4c/0x80
[    0.392000]  ? video_setup+0x7f/0x7f
[    0.392000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.392000]  ? do_one_initcall+0x4e/0x1a0
[    0.392000]  ? kernel_init_freeable+0x189/0x20a
[    0.392000]  ? rest_init+0xc0/0xc0
[    0.392000]  ? kernel_init+0xa/0x100
[    0.392000]  ? ret_from_fork+0x25/0x30

When early abort is occurred due to invalid ACPI information, Linux kernel
terminates ACPI by calling acpi_terminate() function. The function calls
acpi_ut_delete_caches() function to delete local caches (acpi_gbl_namespace_
cache, state_cache, operand_cache, ps_node_cache, ps_node_ext_cache).

But the deletion codes in acpi_ut_delete_caches() function only delete
slab caches using kmem_cache_destroy() function, therefore the cache
objects should be flushed before acpi_ut_delete_caches() function.

"Acpi-Parse" cache and "Acpi-ParseExt" cache are used in an AML parse
function, acpi_ps_parse_loop(). The function should complete all ops
using acpi_ps_complete_final_op() when an error occurs due to invalid
AML codes.
However, the current implementation of acpi_ps_complete_final_op() does not
complete all ops when it meets some errors and this cause cache leak.

This cache leak has a security threat because an old kernel (<= 4.9) shows
memory locations of kernel functions in stack dump. Some malicious users
could use this information to neutralize kernel ASLR.

To fix ACPI cache leak for enhancing security, I made a patch to complete all
ops unconditionally for acpi_ps_complete_final_op() function.

I hope that this patch improves the security of Linux kernel.

Thank you.

Link: https://github.com/acpica/acpica/commit/8829e70e
Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/2363774.ElGaqSPkdT@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/psobject.c | 52 ++++++++++------------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 54471083ba545..0bce1baaa62b3 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -636,7 +636,8 @@ acpi_status
 acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 			  union acpi_parse_object *op, acpi_status status)
 {
-	acpi_status status2;
+	acpi_status return_status = status;
+	u8 ascending = TRUE;
 
 	ACPI_FUNCTION_TRACE_PTR(ps_complete_final_op, walk_state);
 
@@ -650,7 +651,7 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 			  op));
 	do {
 		if (op) {
-			if (walk_state->ascending_callback != NULL) {
+			if (ascending && walk_state->ascending_callback != NULL) {
 				walk_state->op = op;
 				walk_state->op_info =
 				    acpi_ps_get_opcode_info(op->common.
@@ -672,49 +673,26 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 				}
 
 				if (status == AE_CTRL_TERMINATE) {
-					status = AE_OK;
-
-					/* Clean up */
-					do {
-						if (op) {
-							status2 =
-							    acpi_ps_complete_this_op
-							    (walk_state, op);
-							if (ACPI_FAILURE
-							    (status2)) {
-								return_ACPI_STATUS
-								    (status2);
-							}
-						}
-
-						acpi_ps_pop_scope(&
-								  (walk_state->
-								   parser_state),
-								  &op,
-								  &walk_state->
-								  arg_types,
-								  &walk_state->
-								  arg_count);
-
-					} while (op);
-
-					return_ACPI_STATUS(status);
+					ascending = FALSE;
+					return_status = AE_CTRL_TERMINATE;
 				}
 
 				else if (ACPI_FAILURE(status)) {
 
 					/* First error is most important */
 
-					(void)
-					    acpi_ps_complete_this_op(walk_state,
-								     op);
-					return_ACPI_STATUS(status);
+					ascending = FALSE;
+					return_status = status;
 				}
 			}
 
-			status2 = acpi_ps_complete_this_op(walk_state, op);
-			if (ACPI_FAILURE(status2)) {
-				return_ACPI_STATUS(status2);
+			status = acpi_ps_complete_this_op(walk_state, op);
+			if (ACPI_FAILURE(status)) {
+				ascending = FALSE;
+				if (ACPI_SUCCESS(return_status) ||
+				    return_status == AE_CTRL_TERMINATE) {
+					return_status = status;
+				}
 			}
 		}
 
@@ -724,5 +702,5 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 
 	} while (op);
 
-	return_ACPI_STATUS(status);
+	return_ACPI_STATUS(return_status);
 }
-- 
2.39.5




