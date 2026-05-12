Return-Path: <stable+bounces-245611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EarJsc6A2qh1wEAu9opvQ
	(envelope-from <stable+bounces-245611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:35:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FC7522A6E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0613E32F157C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA592399889;
	Tue, 12 May 2026 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fbqQysN2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0BDD531
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593628; cv=none; b=UepDT60Qy3SPl2ySu5jb7mlY0UqbeER76/FDvwR4uMwUSdtRnuRg/v6paeX7FEqAgCFFBKrFLgbQDGWpe7ETf0z/MoWhRXq0dV/NMSwqU6jGlo58eo/I5L0+sF238jDskGosyw8bjYuWDG1LHwLcgXGbA426Hfk7Ax+XYGyJM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593628; c=relaxed/simple;
	bh=rLXNG3jDgMcKWTq453ESXi8t82WXMvGkn62GRpZ26X8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b6WLsT7Z8FcDJOz/m1fkTODc/s8AfQehpjnpPXrwj/xYZrLV7EZfIPm8IB1KxL3oP2clPk2GedI01JAP3yyfL1bQ0nXaGbYYNT4jM6WVeWznSjwyeADYQvMKF7oIoBOWX4uGM9zXV+9tiQGWxJOecUIctuB0a6hFGv/e27PR820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fbqQysN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B4AC2BCB0;
	Tue, 12 May 2026 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778593628;
	bh=rLXNG3jDgMcKWTq453ESXi8t82WXMvGkn62GRpZ26X8=;
	h=Subject:To:Cc:From:Date:From;
	b=fbqQysN2J46UcHZXeTlicEuVNrdgTVv+TZ01PwlXgeaeFF60uqXgc9Wxs+08Nc8Ng
	 NxWE6UHq31RB4yWISS/UEqqD9T8fCe9WKS5xnDZv/k9PzsYXxxQiQ1IbhTOL6h13e8
	 LnMxWuArs0AJhjliDC1IrOQWgWEeS2e7oQGHm2Go=
Subject: FAILED: patch "[PATCH] kho: fix error handling in kho_add_subtree()" failed to apply to 7.0-stable tree
To: leitao@debian.org,akpm@linux-foundation.org,graf@amazon.com,pasha.tatashin@soleen.com,pratyush@kernel.org,rppt@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:47:12 +0200
Message-ID: <2026051212-boil-trivial-8d5e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08FC7522A6E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245611-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,linux-foundation.org:email,soleen.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 9ec95329894864170a1a7685b9a11b739393131a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051212-boil-trivial-8d5e@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ec95329894864170a1a7685b9a11b739393131a Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Apr 2026 02:03:03 -0700
Subject: [PATCH] kho: fix error handling in kho_add_subtree()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 94762de1fe5f..18509d8082ea 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -762,19 +762,24 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
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
 


