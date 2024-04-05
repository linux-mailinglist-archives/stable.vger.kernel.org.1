Return-Path: <stable+bounces-35996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 328E989952E
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3CD1F24DA3
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4120225AE;
	Fri,  5 Apr 2024 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qrGnz0aq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819112232B
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297978; cv=none; b=mrpGXu4vWRX80Ia5hEobACVAqBLpQtePziM0f/ALHODn9+R/2diz4MbN8VYGrRX+mGUj2CaNp5EEIPbx83OR9zI5o8N3/udQ/pvPJdpO9JCzpaIOUj2Z8z2xfsxq9nkxm4mVKNSbewpo51gaMA3GmliBognndvK2dZzzrv9ykNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297978; c=relaxed/simple;
	bh=psVU958eixNYgM6dedXWnDnvSmldqLHxAkqhqsGH/Ek=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ojKvoJQlcG0QVaIEBT8FEaCkPKHN9HzqmtTe2I+IeYkMFuLJh2M0KK7b/b3ikQgODep2WEmUhIx5r5zPh/X5IGYqDGa0DATMHA1H9zQh9uLSeKGJplIAgP+TCEjrR1vTaN5qM1DYt0EgJLFjI8C0mQSWg6T6MxGIkCZwrdQ/5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qrGnz0aq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79240C433F1;
	Fri,  5 Apr 2024 06:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712297978;
	bh=psVU958eixNYgM6dedXWnDnvSmldqLHxAkqhqsGH/Ek=;
	h=Subject:To:Cc:From:Date:From;
	b=qrGnz0aqB7Zel7DWMKPDEjlaqG1xruCLH13boTFiW0HRR99c/ehQbKowvUd95FuDV
	 pTvXBtpvY0DnXFUpKBlnk5OKs86mXjQ9tN34k3xW6NeYOduwTkX1AwgRjI6AvLLaiB
	 5eFiGEvDku+OMNGyL8MeLofYAli6O8yxT8FjFItk=
Subject: FAILED: patch "[PATCH] KVM: SVM: Add support for allowing zero SEV ASIDs" failed to apply to 5.15-stable tree
To: ashish.kalra@amd.com,seanjc@google.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:19:17 +0200
Message-ID: <2024040517-motivator-seismic-4389@gregkh>
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
git cherry-pick -x 0aa6b90ef9d75b4bd7b6d106d85f2a3437697f91
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040517-motivator-seismic-4389@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

0aa6b90ef9d7 ("KVM: SVM: Add support for allowing zero SEV ASIDs")
466eec4a22a7 ("KVM: SVM: Use unsigned integers when dealing with ASIDs")
106ed2cad9f7 ("KVM: SVM: WARN, but continue, if misc_cg_set_capacity() fails")
6d1bc9754b04 ("KVM: SVM: enhance info printk's in SEV init")
73412dfeea72 ("KVM: SVM: do not allocate struct svm_cpu_data dynamically")
181d0fb0bb02 ("KVM: SVM: remove dead field from struct svm_cpu_data")
4bbef7e8eb8c ("KVM: SVM: Simplify and harden helper to flush SEV guest page(s)")
58356767107a ("KVM: SVM: Allocate sd->save_area with __GFP_ZERO")
91b692a03c99 ("KVM: SEV: provide helpers to charge/uncharge misc_cg")

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


