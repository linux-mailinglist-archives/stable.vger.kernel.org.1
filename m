Return-Path: <stable+bounces-220144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHbOBi4ro2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:51:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B30D71C5259
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DEA130C13BD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60248BD3D;
	Sat, 28 Feb 2026 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABQKywp2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF948BD33;
	Sat, 28 Feb 2026 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300053; cv=none; b=Dyr/gZcBBklrbxPj4UrKWhVetojezc258utvkdBToNtN6y4XMtD/Gwb39MLJk7uB8nGqJIvXoboEXRkOL/Cc0RRH21+aMTy06jz+yG5KZAsvbq7BWPMj3XtFMhENb0JaV8TWvyuF0kIlA+0IL9EAn5v1JaACdapT2yZznvwUK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300053; c=relaxed/simple;
	bh=WVF40FSFeIi/MlfoGa/yfIpY+sPRyFeLMXkqnv8miz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzH1qoex+yIXlzisWalH3L3RnCxSf73k0NJtazdVF+xVjgByNCjrfp1qRuazI1vGWt1bzx6moW6FdrfYzkyIt10pW0pnoW6vXb4kKKtJgOj2AlJRdkskDWowAFND1P+JVT7F2Lfbv51676QET837VsRoPY0PYkpr1XlA9YN3wi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABQKywp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EAEC116D0;
	Sat, 28 Feb 2026 17:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300053;
	bh=WVF40FSFeIi/MlfoGa/yfIpY+sPRyFeLMXkqnv8miz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABQKywp2aPpnWzudue/zZlJvsWDa6Gj8XgIXP4pVd0qayTHmwQAy2RpdF2n2AxBhs
	 AV/VA3U5AXJ7hIc48j7C2aMo+KoN9VGx2X/2TNOPgIm3irvAe5H2JHcN1+R1RAw3kk
	 H/2lakFrJaWYRrUVAB4DDKTIDhXD+OufhYoiLuw3diuaawrtryOK/tacYvsSgJEaJY
	 diprBQtwX93uqzrusOE0uAF9G//k3VwBRemi1kiBeAzjlE0r98gWuDOG7kT3j5JGXX
	 Qw7Uraj3SpqHGL4chFubUVOH8zpl/OnNbcaz7wG83O+xdFgkkYwVyJlewphDhDMybO
	 +b5krcWPPC+SQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 066/844] APEI/GHES: ensure that won't go past CPER allocated record
Date: Sat, 28 Feb 2026 12:19:39 -0500
Message-ID: <20260228173244.1509663-67-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220144-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,huawei];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,intel.com:email]
X-Rspamd-Queue-Id: B30D71C5259
X-Rspamd-Action: no action

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit fa2408a24f8f0db14d9cfc613ef162dc267d7ad4 ]

The logic at ghes_new() prevents allocating too large records, by
checking if they're bigger than GHES_ESTATUS_MAX_SIZE (currently, 64KB).
Yet, the allocation is done with the actual number of pages from the
CPER bios table location, which can be smaller.

Yet, a bad firmware could send data with a different size, which might
be bigger than the allocated memory, causing an OOPS:

    Unable to handle kernel paging request at virtual address fff00000f9b40000
    Mem abort info:
      ESR = 0x0000000096000007
      EC = 0x25: DABT (current EL), IL = 32 bits
      SET = 0, FnV = 0
      EA = 0, S1PTW = 0
      FSC = 0x07: level 3 translation fault
    Data abort info:
      ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
      CM = 0, WnR = 0, TnD = 0, TagAccess = 0
      GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
    swapper pgtable: 4k pages, 52-bit VAs, pgdp=000000008ba16000
    [fff00000f9b40000] pgd=180000013ffff403, p4d=180000013fffe403, pud=180000013f85b403, pmd=180000013f68d403, pte=0000000000000000
    Internal error: Oops: 0000000096000007 [#1]  SMP
    Modules linked in:
    CPU: 0 UID: 0 PID: 303 Comm: kworker/0:1 Not tainted 6.19.0-rc1-00002-gda407d200220 #34 PREEMPT
    Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
    Workqueue: kacpi_notify acpi_os_execute_deferred
    pstate: 214020c5 (nzCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
    pc : hex_dump_to_buffer+0x30c/0x4a0
    lr : hex_dump_to_buffer+0x328/0x4a0
    sp : ffff800080e13880
    x29: ffff800080e13880 x28: ffffac9aba86f6a8 x27: 0000000000000083
    x26: fff00000f9b3fffc x25: 0000000000000004 x24: 0000000000000004
    x23: ffff800080e13905 x22: 0000000000000010 x21: 0000000000000083
    x20: 0000000000000001 x19: 0000000000000008 x18: 0000000000000010
    x17: 0000000000000001 x16: 00000007c7f20fec x15: 0000000000000020
    x14: 0000000000000008 x13: 0000000000081020 x12: 0000000000000008
    x11: ffff800080e13905 x10: ffff800080e13988 x9 : 0000000000000000
    x8 : 0000000000000000 x7 : 0000000000000001 x6 : 0000000000000020
    x5 : 0000000000000030 x4 : 00000000fffffffe x3 : 0000000000000000
    x2 : ffffac9aba78c1c8 x1 : ffffac9aba76d0a8 x0 : 0000000000000008
    Call trace:
     hex_dump_to_buffer+0x30c/0x4a0 (P)
     print_hex_dump+0xac/0x170
     cper_estatus_print_section+0x90c/0x968
     cper_estatus_print+0xf0/0x158
     __ghes_print_estatus+0xa0/0x148
     ghes_proc+0x1bc/0x220
     ghes_notify_hed+0x5c/0xb8
     notifier_call_chain+0x78/0x148
     blocking_notifier_call_chain+0x4c/0x80
     acpi_hed_notify+0x28/0x40
     acpi_ev_notify_dispatch+0x50/0x80
     acpi_os_execute_deferred+0x24/0x48
     process_one_work+0x15c/0x3b0
     worker_thread+0x2d0/0x400
     kthread+0x148/0x228
     ret_from_fork+0x10/0x20
    Code: 6b14033f 540001ad a94707e2 f100029f (b8747b44)
    ---[ end trace 0000000000000000 ]---

Prevent that by taking the actual allocated are into account when
checking for CPER length.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
[ rjw: Subject tweaks ]
Link: https://patch.msgid.link/4e70310a816577fabf37d94ed36cde4ad62b1e0a.1767871950.git.mchehab+huawei@kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 6 +++++-
 include/acpi/ghes.h      | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0dc767392a6c6..a37c8fb574832 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -29,6 +29,7 @@
 #include <linux/cper.h>
 #include <linux/cleanup.h>
 #include <linux/platform_device.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
 #include <linux/vmalloc.h>
@@ -294,6 +295,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 		error_block_length = GHES_ESTATUS_MAX_SIZE;
 	}
 	ghes->estatus = kmalloc(error_block_length, GFP_KERNEL);
+	ghes->estatus_length = error_block_length;
 	if (!ghes->estatus) {
 		rc = -ENOMEM;
 		goto err_unmap_status_addr;
@@ -365,13 +367,15 @@ static int __ghes_check_estatus(struct ghes *ghes,
 				struct acpi_hest_generic_status *estatus)
 {
 	u32 len = cper_estatus_len(estatus);
+	u32 max_len = min(ghes->generic->error_block_length,
+			  ghes->estatus_length);
 
 	if (len < sizeof(*estatus)) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
 		return -EIO;
 	}
 
-	if (len > ghes->generic->error_block_length) {
+	if (!len || len > max_len) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
 		return -EIO;
 	}
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index ebd21b05fe6ed..93db60da5934e 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -21,6 +21,7 @@ struct ghes {
 		struct acpi_hest_generic_v2 *generic_v2;
 	};
 	struct acpi_hest_generic_status *estatus;
+	unsigned int estatus_length;
 	unsigned long flags;
 	union {
 		struct list_head list;
-- 
2.51.0


