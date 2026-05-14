Return-Path: <stable+bounces-247282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFmOHBAiBmodfgIAu9opvQ
	(envelope-from <stable+bounces-247282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:27:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0445465D5
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B50CA3021EB9
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B738A72A;
	Thu, 14 May 2026 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G40jEvkT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E3336897
	for <stable@vger.kernel.org>; Thu, 14 May 2026 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786756; cv=none; b=o9/kqYz2mOCtrdd3YtGs3dBagcQYvxn3AjyOEQPVLjV1sjFv76IgmsbfYt68JltfnhU+OsBrSyx3bBs0C0pEWXSl+PW+/wHJIU5glekG31GK1Q9YnSTjxlobFMrFjbMfatTYAqXcLX4DX+GF3+GBVHUhR7kjBE0LciVjScTfhoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786756; c=relaxed/simple;
	bh=2G+Vqyw4oxghE7pnHIg+cKn/MgZLF+X4PYv/6qAS0R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrSQRLDphHCmTOcw+jrrPY51EJKRYQpbbdIh14pJ58mCsQmGyCvK4T/jSY0DCeiciV37VHu8Uyi9mzTDQv1/ZEJ7qyktj16gCj9dPbLlvBJVdITLisO6p79wuUZjUtjEBGATRN7c9jH4o0nBlnnGASxUBrDpItFAA+YXhcFQ3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G40jEvkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEDEC2BCB3;
	Thu, 14 May 2026 19:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778786756;
	bh=2G+Vqyw4oxghE7pnHIg+cKn/MgZLF+X4PYv/6qAS0R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G40jEvkTgCILcqney2jlMHyJ+38mnqve1XEGt0ARwpCZOyRhK5es3EWYJlssfc4Le
	 0uqxIL33Buw+gQXyLHGpl5BHQIWXJY6IgWwJtSA0GX8Supxb/1RYJ9eDTS7X96fCFh
	 MKPWY9gd8zJpH8YuF6vhIgtiEvWrKwwYHJb7uf3OD2BapojVuaOTLvK5Ue4YVuKtUS
	 JNFp9MgweCeK3uGLK5BtsRG5yFvzBGt98bFIsxGtMD/y/inbUdedW/ogMLNSSLQ/Ma
	 5FDOjLfv6Tx+BbAqsMutp5GeCtv2J6agXgEEr37COfGygMFm1uyNDnstJg+xQiNW4V
	 ednnrR5W6ucNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y] kho: fix error handling in kho_add_subtree()
Date: Thu, 14 May 2026 15:25:53 -0400
Message-ID: <20260514192553.1255751-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051212-boil-trivial-8d5e@gregkh>
References: <2026051212-boil-trivial-8d5e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC0445465D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247282-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,soleen.com:email]
X-Rspamd-Action: no action

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 9ec95329894864170a1a7685b9a11b739393131a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index cc68a3692905d..479c42e08b74a 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -757,13 +757,18 @@ int kho_add_subtree(const char *name, void *fdt)
 		goto out_pack;
 	}
 
-	err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
-			  &phys, sizeof(phys));
-	if (err < 0)
-		goto out_pack;
+	fdt_err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
+			      &phys, sizeof(phys));
+	if (fdt_err < 0)
+		goto out_del_node;
 
 	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false));
 
+	err = 0;
+	goto out_pack;
+
+out_del_node:
+	fdt_del_node(root_fdt, off);
 out_pack:
 	fdt_pack(root_fdt);
 
-- 
2.53.0


