Return-Path: <stable+bounces-169945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E265DB29E42
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813E81893F9C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D3D30F52A;
	Mon, 18 Aug 2025 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C0znPNIs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E7286D50
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510293; cv=none; b=rsjybM4shQIeeO9fyTpHezxS+EA3CkcM/fBbmz4Tz2E/ugA8ZGPOTRulnisfqqA7qW74ZY5h1zklt75SnCMiRVM3DFzTeoeF1v+TLPbB76GRdyc9ufdfiiVO1Pv4U2afxPAlHn7UehOJ9s6alR+qHAxhh2NJx1NYYE+fn9dPZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510293; c=relaxed/simple;
	bh=7LOrK+EVMJiMiQCmdouqbhIh/QYEI+YqmWtKv+sDfC8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jpPkmqiTEQJvODNM8sZq1YpWB9yA715XrGn6c8UoFcP1lt6rjV5zvIV5F+kFiry3hp6naVDL16/0d57XeF4hGt7hI5PdGF8qwRgiwaPqREhj+8SGxXnZ7C9sfG8BTKSbhsJbwjJu6xCAExirVud1fiyRkcpcHzg8BB+wsthDVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C0znPNIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0408EC4CEEB;
	Mon, 18 Aug 2025 09:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755510293;
	bh=7LOrK+EVMJiMiQCmdouqbhIh/QYEI+YqmWtKv+sDfC8=;
	h=Subject:To:Cc:From:Date:From;
	b=C0znPNIsyF+ic2fuIt1q6AMS/C0975UjheBGyb43UTEPrKSk0tCiOLPMKn+TksuKa
	 xCkobDVKyKQ5n1/PC5xM8otLZhBEDE0W/x0zHaQV9w56cR8h8ZeV00m8f3VBKxFAkh
	 10VuOqBcsEbfRrTMeG5djFH0jt31yR4djyPlvRVA=
Subject: FAILED: patch "[PATCH] x86/sev: Ensure SVSM reserved fields in a page validation" failed to apply to 6.15-stable tree
To: thomas.lendacky@amd.com,bp@alien8.de,joerg.roedel@amd.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 11:44:50 +0200
Message-ID: <2025081850-culture-uncheck-1048@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3ee9cebd0a5e7ea47eb35cec95eaa1a866af982d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081850-culture-uncheck-1048@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3ee9cebd0a5e7ea47eb35cec95eaa1a866af982d Mon Sep 17 00:00:00 2001
From: Tom Lendacky <thomas.lendacky@amd.com>
Date: Wed, 13 Aug 2025 10:26:59 -0500
Subject: [PATCH] x86/sev: Ensure SVSM reserved fields in a page validation
 entry are initialized to zero

In order to support future versions of the SVSM_CORE_PVALIDATE call, all
reserved fields within a PVALIDATE entry must be set to zero as an SVSM should
be ensuring all reserved fields are zero in order to support future usage of
reserved areas based on the protocol version.

Fixes: fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Joerg Roedel <joerg.roedel@amd.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/7cde412f8b057ea13a646fb166b1ca023f6a5031.1755098819.git.thomas.lendacky@amd.com

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 7a706db87b93..4ab0dbd043c6 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -785,6 +785,7 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	pc->entry[0].page_size = RMP_PG_SIZE_4K;
 	pc->entry[0].action    = validate;
 	pc->entry[0].ignore_cf = 0;
+	pc->entry[0].rsvd      = 0;
 	pc->entry[0].pfn       = paddr >> PAGE_SHIFT;
 
 	/* Protocol 0, Call ID 1 */
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index fc59ce78c477..43ecc6b9fb9c 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -227,6 +227,7 @@ static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
 		pe->page_size = RMP_PG_SIZE_4K;
 		pe->action    = action;
 		pe->ignore_cf = 0;
+		pe->rsvd      = 0;
 		pe->pfn       = pfn;
 
 		pe++;
@@ -257,6 +258,7 @@ static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned int d
 		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
 		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
 		pe->ignore_cf = 0;
+		pe->rsvd      = 0;
 		pe->pfn       = e->gfn;
 
 		pe++;


