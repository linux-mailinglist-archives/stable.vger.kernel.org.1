Return-Path: <stable+bounces-35994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 801C689952D
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 211E6B22578
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10797224DC;
	Fri,  5 Apr 2024 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BmuOvMsI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45312232B
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297966; cv=none; b=rMq2GZwk6g5BLVPmhrnV13jZ/D9yDgrNpGqDfKaMilxwWDa/xAi8IET2eCqA15uK9zX2J309s05ZI6Y2I5J0pU7tpBgNSa3mhM4qeS9zMPDr0FVIb0BVDqrodxQ6X+3KwAUvD3ixpSUNyt1yRVsGOrvJQBrNT82yLVAhF/Fpvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297966; c=relaxed/simple;
	bh=cfUPWg0K0+ZvisQvGvUhExP3SQh8Ij4C7TxpLDwcOgM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aMenR64TvJ1v6/ngwRDyJFevUhDSDY5KwO7WAAKaKAr8ysarr1CsFj4nuAIVpMT8i4BFcle6plZHCmDPmcFE3QDEQYAZL1jdLIP/LJrKs0GwfSeVx7XVk/qyVG4fm+fgv4eK1FBnK1/IbQq2hhpqEwKXvBDrWkWfr2FSyQ2d7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BmuOvMsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24B0C433F1;
	Fri,  5 Apr 2024 06:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712297966;
	bh=cfUPWg0K0+ZvisQvGvUhExP3SQh8Ij4C7TxpLDwcOgM=;
	h=Subject:To:Cc:From:Date:From;
	b=BmuOvMsI6ZeyVHTiBBW9bCvOASgfMmwDOE2w6WjBEH+SfkRQ+Br+coMIHQBg4fQDa
	 SpQLvEP9y+iW7fKa4saORprsRoXLRXxTWFHpZJ/THky247awkq37U2i0OcM9vNP2kj
	 0yubDcbqeiQ2qL3H1D8x2fHvwoi+mdZNUTl/iRIU=
Subject: FAILED: patch "[PATCH] KVM: SVM: Add support for allowing zero SEV ASIDs" failed to apply to 6.6-stable tree
To: ashish.kalra@amd.com,seanjc@google.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:19:15 +0200
Message-ID: <2024040515-playlist-dramatize-da62@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0aa6b90ef9d75b4bd7b6d106d85f2a3437697f91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040515-playlist-dramatize-da62@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0aa6b90ef9d7 ("KVM: SVM: Add support for allowing zero SEV ASIDs")
466eec4a22a7 ("KVM: SVM: Use unsigned integers when dealing with ASIDs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0aa6b90ef9d75b4bd7b6d106d85f2a3437697f91 Mon Sep 17 00:00:00 2001
From: Ashish Kalra <ashish.kalra@amd.com>
Date: Wed, 31 Jan 2024 15:56:08 -0800
Subject: [PATCH] KVM: SVM: Add support for allowing zero SEV ASIDs

Some BIOSes allow the end user to set the minimum SEV ASID value
(CPUID 0x8000001F_EDX) to be greater than the maximum number of
encrypted guests, or maximum SEV ASID value (CPUID 0x8000001F_ECX)
in order to dedicate all the SEV ASIDs to SEV-ES or SEV-SNP.

The SEV support, as coded, does not handle the case where the minimum
SEV ASID value can be greater than the maximum SEV ASID value.
As a result, the following confusing message is issued:

[   30.715724] kvm_amd: SEV enabled (ASIDs 1007 - 1006)

Fix the support to properly handle this case.

Fixes: 916391a2d1dc ("KVM: SVM: Add support for SEV-ES capability in KVM")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240104190520.62510-1-Ashish.Kalra@amd.com
Link: https://lore.kernel.org/r/20240131235609.4161407-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index eeef43c795d8..5f8312edee36 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -144,10 +144,21 @@ static void sev_misc_cg_uncharge(struct kvm_sev_info *sev)
 
 static int sev_asid_new(struct kvm_sev_info *sev)
 {
-	unsigned int asid, min_asid, max_asid;
+	/*
+	 * SEV-enabled guests must use asid from min_sev_asid to max_sev_asid.
+	 * SEV-ES-enabled guest can use from 1 to min_sev_asid - 1.
+	 * Note: min ASID can end up larger than the max if basic SEV support is
+	 * effectively disabled by disallowing use of ASIDs for SEV guests.
+	 */
+	unsigned int min_asid = sev->es_active ? 1 : min_sev_asid;
+	unsigned int max_asid = sev->es_active ? min_sev_asid - 1 : max_sev_asid;
+	unsigned int asid;
 	bool retry = true;
 	int ret;
 
+	if (min_asid > max_asid)
+		return -ENOTTY;
+
 	WARN_ON(sev->misc_cg);
 	sev->misc_cg = get_current_misc_cg();
 	ret = sev_misc_cg_try_charge(sev);
@@ -159,12 +170,6 @@ static int sev_asid_new(struct kvm_sev_info *sev)
 
 	mutex_lock(&sev_bitmap_lock);
 
-	/*
-	 * SEV-enabled guests must use asid from min_sev_asid to max_sev_asid.
-	 * SEV-ES-enabled guest can use from 1 to min_sev_asid - 1.
-	 */
-	min_asid = sev->es_active ? 1 : min_sev_asid;
-	max_asid = sev->es_active ? min_sev_asid - 1 : max_sev_asid;
 again:
 	asid = find_next_zero_bit(sev_asid_bitmap, max_asid + 1, min_asid);
 	if (asid > max_asid) {
@@ -2234,8 +2239,10 @@ void __init sev_hardware_setup(void)
 		goto out;
 	}
 
-	sev_asid_count = max_sev_asid - min_sev_asid + 1;
-	WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV, sev_asid_count));
+	if (min_sev_asid <= max_sev_asid) {
+		sev_asid_count = max_sev_asid - min_sev_asid + 1;
+		WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV, sev_asid_count));
+	}
 	sev_supported = true;
 
 	/* SEV-ES support requested? */
@@ -2266,7 +2273,9 @@ void __init sev_hardware_setup(void)
 out:
 	if (boot_cpu_has(X86_FEATURE_SEV))
 		pr_info("SEV %s (ASIDs %u - %u)\n",
-			sev_supported ? "enabled" : "disabled",
+			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
+								       "unusable" :
+								       "disabled",
 			min_sev_asid, max_sev_asid);
 	if (boot_cpu_has(X86_FEATURE_SEV_ES))
 		pr_info("SEV-ES %s (ASIDs %u - %u)\n",


