Return-Path: <stable+bounces-225876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNhNBlRDuWmK+QEAu9opvQ
	(envelope-from <stable+bounces-225876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:04:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AECE32A972E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A3B0301625B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5809346792;
	Tue, 17 Mar 2026 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EpA7azsR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0B1DF742
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748987; cv=none; b=QNIxTy8tVFj6ab3+p+CNCSIeS9u1+5DDXTvxGdwVOoaw0yExg7DXCeJStTg0nv8WO8GPNmlR8MkYAXeg/tjLshscd8qAZpvQVB/MKrW+COONb5wUuuJJ3C1kigVz9EvlfIveAYOEqef7a054jeW3cZMg/bWBYGZ23L0a0P4XDaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748987; c=relaxed/simple;
	bh=qXI6t+7iQxAF+RIUtMhCbv3yKjOCB3B5C0G/r5D7FtE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p7F/r3kTdYf3was8b4wed64hq/YMjKE4nnNHP4b/DvVoVZL9+IgQITskIsMf6gdtdfCU5Xb9bmvANYpZ8puqf04j2dsqmlm4Ql8jYIsjN3gxipGC7AoMRMeTg5lABrJGlTefU+IdmhIe3pGEAeFz3BDZXRN/x0OhlATc/AK4OBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EpA7azsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EA9C4CEF7;
	Tue, 17 Mar 2026 12:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773748987;
	bh=qXI6t+7iQxAF+RIUtMhCbv3yKjOCB3B5C0G/r5D7FtE=;
	h=Subject:To:Cc:From:Date:From;
	b=EpA7azsRHYCx4wXJ7yo1yBm4rjD2G7lg+rz99RGOJ4NfLndhLlVHuPaxtJqAtNyjW
	 2G7E+oBiPZKWo9s+lXkScORUn8f2UuOuxo1KfFfYyGOsC7gGpvgpqucUJf7zg2Beug
	 ZMpniPhXiIinpMh60ZI/dU3DroUVOqgRnEp+5xHA=
Subject: FAILED: patch "[PATCH] arm64: mm: Add PTE_DIRTY back to PAGE_KERNEL* to fix" failed to apply to 5.15-stable tree
To: catalin.marinas@arm.com,jianpeng.chang.cn@windriver.com,linux@roeck-us.net,will@kernel.org,ying.huang@linux.alibaba.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:02:55 +0100
Message-ID: <2026031755-gravel-surfacing-cad8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225876-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:email,windriver.com:email,arm.com:email]
X-Rspamd-Queue-Id: AECE32A972E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c25c4aa3f79a488cc270507935a29c07dc6bddfc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031755-gravel-surfacing-cad8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c25c4aa3f79a488cc270507935a29c07dc6bddfc Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 27 Feb 2026 18:53:06 +0000
Subject: [PATCH] arm64: mm: Add PTE_DIRTY back to PAGE_KERNEL* to fix
 kexec/hibernation

Commit 143937ca51cc ("arm64, mm: avoid always making PTE dirty in
pte_mkwrite()") changed pte_mkwrite_novma() to only clear PTE_RDONLY
when PTE_DIRTY is set. This was to allow writable-clean PTEs for swap
pages that haven't actually been written.

However, this broke kexec and hibernation for some platforms. Both go
through trans_pgd_create_copy() -> _copy_pte(), which calls
pte_mkwrite_novma() to make the temporary linear-map copy fully
writable. With the updated pte_mkwrite_novma(), read-only kernel pages
(without PTE_DIRTY) remain read-only in the temporary mapping.
While such behaviour is fine for user pages where hardware DBM or
trapping will make them writeable, subsequent in-kernel writes by the
kexec relocation code will fault.

Add PTE_DIRTY back to all _PAGE_KERNEL* protection definitions. This was
the case prior to 5.4, commit aa57157be69f ("arm64: Ensure
VM_WRITE|VM_SHARED ptes are clean by default"). With the kernel
linear-map PTEs always having PTE_DIRTY set, pte_mkwrite_novma()
correctly clears PTE_RDONLY.

Fixes: 143937ca51cc ("arm64, mm: avoid always making PTE dirty in pte_mkwrite()")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: stable@vger.kernel.org
Reported-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Link: https://lore.kernel.org/r/20251204062722.3367201-1-jianpeng.chang.cn@windriver.com
Cc: Will Deacon <will@kernel.org>
Cc: Huang, Ying <ying.huang@linux.alibaba.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 2b32639160de..f560e6420267 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -50,11 +50,11 @@
 
 #define _PAGE_DEFAULT		(_PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
 
-#define _PAGE_KERNEL		(PROT_NORMAL)
-#define _PAGE_KERNEL_RO		((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY)
-#define _PAGE_KERNEL_ROX	((PROT_NORMAL & ~(PTE_WRITE | PTE_PXN)) | PTE_RDONLY)
-#define _PAGE_KERNEL_EXEC	(PROT_NORMAL & ~PTE_PXN)
-#define _PAGE_KERNEL_EXEC_CONT	((PROT_NORMAL & ~PTE_PXN) | PTE_CONT)
+#define _PAGE_KERNEL		(PROT_NORMAL | PTE_DIRTY)
+#define _PAGE_KERNEL_RO		((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY | PTE_DIRTY)
+#define _PAGE_KERNEL_ROX	((PROT_NORMAL & ~(PTE_WRITE | PTE_PXN)) | PTE_RDONLY | PTE_DIRTY)
+#define _PAGE_KERNEL_EXEC	((PROT_NORMAL & ~PTE_PXN) | PTE_DIRTY)
+#define _PAGE_KERNEL_EXEC_CONT	((PROT_NORMAL & ~PTE_PXN) | PTE_CONT | PTE_DIRTY)
 
 #define _PAGE_SHARED		(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
 #define _PAGE_SHARED_EXEC	(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_WRITE)


