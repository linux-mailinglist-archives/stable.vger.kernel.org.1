Return-Path: <stable+bounces-241309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBCBEf9c72npAgEAu9opvQ
	(envelope-from <stable+bounces-241309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:56:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6D2472EFA
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE0AD3008C88
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41953BAD9C;
	Mon, 27 Apr 2026 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cEu5/Z77"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E013B47FF;
	Mon, 27 Apr 2026 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294502; cv=none; b=byquajJBTRek+FakpqJxyida6Oq1XpavpHZWj/J6SXkbMcn+VFDoL4M2X1ZjrQ5wmpWAhKX+lhun7Z6ahwPiT+i1IUCha2o5onnyCYFuekGjk5lSIPJw04SzPA+JLL9HNxPmRbKNxSYlHZNHO5MCnIY6pTtpR07eMkrt3QOpKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294502; c=relaxed/simple;
	bh=WE6s5OVMgrHAR+Fi9MS+LkdO9nyPxY1t5mC7idsquuw=;
	h=Date:To:From:Subject:Message-Id; b=Kc+UUOKy3atl8GyPL0Ljx3WugJ+V6axc0Yscsr5UGRlDM/NmVgf7IEpQlpWoHfEtbm/QhstiisM98Kzkf7Li2rc+gRJup4jSc8LoWBAhoHlPmA5FNLw7cUb6Io1gCMbZCDk5mu/qcHXCEIr/plLTYCyBiRWfnj3PUHlD4XxPv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cEu5/Z77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4495DC19425;
	Mon, 27 Apr 2026 12:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777294502;
	bh=WE6s5OVMgrHAR+Fi9MS+LkdO9nyPxY1t5mC7idsquuw=;
	h=Date:To:From:Subject:From;
	b=cEu5/Z77FSIyHAX/BnyhwG+Afh8VZIbEUGKomsNov5P0+EK/HBNvlaz78Y/36M5Nl
	 6CN4PeANfzgiiOY9Sd7TpcvtwlXOgMcLuxUgHMrPCvBK/PVibZFQTSow7Qo3Svqxr5
	 WrKNM62hYUGDC+JpFWOjyHDtuaN64bu/bACzyU5E=
Date: Mon, 27 Apr 2026 05:55:01 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,rppt@kernel.org,pratyush@kernel.org,pasha.tatashin@soleen.com,graf@amazon.com,leitao@debian.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] kho-fix-error-handling-in-kho_add_subtree.patch removed from -mm tree
Message-Id: <20260427125502.4495DC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3F6D2472EFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-241309-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[soleen.com:email]


The quilt patch titled
     Subject: kho: fix error handling in kho_add_subtree()
has been removed from the -mm tree.  Its filename was
     kho-fix-error-handling-in-kho_add_subtree.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Breno Leitao <leitao@debian.org>
Subject: kho: fix error handling in kho_add_subtree()
Date: Fri, 10 Apr 2026 02:03:03 -0700

Fix two error handling issues in kho_add_subtree(), where it doesn't
handle the error path correctly.

1. If fdt_setprop() fails after the subnode has been created, the
   subnode is not removed. This leaves an incomplete node in the FDT
   (missing "preserved-data" or "blob-size" properties).

2. The fdt_setprop() return value (an FDT error code) is stored
   directly in err and returned to the caller, which expects -errno.

Fix both by storing fdt_setprop() results in fdt_err, jumping to a new
out_del_node label that removes the subnode on failure, and only setting
err = 0 on the success path, otherwise returning -ENOMEM (instead of
FDT_ERR_ errors that would come from fdt_setprop).

No user-visible changes.  This patch fixes error handling in the KHO
(Kexec HandOver) subsystem, which is used to preserve data across kexec
reboots.  The fix only affects a rare failure path during kexec
preparation — specifically when the kernel runs out of space in the
Flattened Device Tree buffer while registering preserved memory regions.

In the unlikely event that this error path was triggered, the old code
would leave a malformed node in the device tree and return an incorrect
error code to the calling subsystem, which could lead to confusing log
messages or incorrect recovery decisions.  With this fix, the incomplete
node is properly cleaned up and the appropriate errno value is propagated,
this error code is not returned to the user.

Link: https://lore.kernel.org/20260410-kho_fix_send-v2-1-1b4debf7ee08@debian.org
Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Signed-off-by: Breno Leitao <leitao@debian.org>
Suggested-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/liveupdate/kexec_handover.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/kernel/liveupdate/kexec_handover.c~kho-fix-error-handling-in-kho_add_subtree
+++ a/kernel/liveupdate/kexec_handover.c
@@ -762,19 +762,24 @@ int kho_add_subtree(const char *name, vo
 		goto out_pack;
 	}
 
-	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
-			  &phys, sizeof(phys));
-	if (err < 0)
-		goto out_pack;
+	fdt_err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
+			      &phys, sizeof(phys));
+	if (fdt_err < 0)
+		goto out_del_node;
 
-	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
-			  &size_u64, sizeof(size_u64));
-	if (err < 0)
-		goto out_pack;
+	fdt_err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
+			      &size_u64, sizeof(size_u64));
+	if (fdt_err < 0)
+		goto out_del_node;
 
 	WARN_ON_ONCE(kho_debugfs_blob_add(&kho_out.dbg, name, blob,
 					  size, false));
 
+	err = 0;
+	goto out_pack;
+
+out_del_node:
+	fdt_del_node(root_fdt, off);
 out_pack:
 	fdt_pack(root_fdt);
 
_

Patches currently in -mm which might be from leitao@debian.org are

mm-memory-failure-report-mf_msg_kernel-for-reserved-pages.patch
mm-memory-failure-add-panic-option-for-unrecoverable-pages.patch
documentation-document-panic_on_unrecoverable_memory_failure-sysctl.patch
selftests-mm-regression-test-for-panic_on_unrecoverable_memory_failure.patch
mm-huge_memory-use-sysfs_match_string-in-defrag_store.patch
mm-huge_memory-refactor-defrag_show-to-use-defrag_flags.patch
mm-vmstat-spread-vmstat_update-requeue-across-the-stat-interval.patch


