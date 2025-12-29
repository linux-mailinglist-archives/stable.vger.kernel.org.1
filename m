Return-Path: <stable+bounces-203612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3C6CE70C9
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4644A3029C12
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF4B320CAB;
	Mon, 29 Dec 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W28l5stC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A23246ED
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018495; cv=none; b=Cr+zhKvyk64rr4J4vX6UqNC7Ev2IFRRRPPuYrwSDvJGpO9VIpk2RBPaTiZrJC5JV+k7j3NYf/T4Yt60OJ0zTTmv0GOH2tFSdVDZKu7OwFJgecK35JH+ivj1A8UGHWOdPuVR10j4FoykYvBmkP9w9Idpsbw+MpMkVq3vCgFHm6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018495; c=relaxed/simple;
	bh=rNfaOdj+tar2CU2Q4GxQjULpGgMFF89SOeXZbRFCFFM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P5Aupr4o8rKILrM76FPcj1Nsk+Oqx246+4gEVJL0EEiHBk53xgbD3evq0J4vE7uMN3sB4gJmGbIsQ28AXyjri/RFXpcPBzCDBJH0tQn4C909ctwgnwARwlm2jAdDyPGoB94gNVwkTKUsO0sVhWh21IunuAdq2yMGZZh60nf2ptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W28l5stC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A383CC4CEF7;
	Mon, 29 Dec 2025 14:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018495;
	bh=rNfaOdj+tar2CU2Q4GxQjULpGgMFF89SOeXZbRFCFFM=;
	h=Subject:To:Cc:From:Date:From;
	b=W28l5stCtPExLTHG2fZfxH0y08iNNrgBjblrmb0bLkReCrwqsaEnPYAk40URFsU06
	 HeyhNjmkez5L1RP2TaKKavvzjMBGKPToT1RnfIWNEJfwsxpo5eBq0KFKnHAYXHd3ZB
	 MNHIbt7zsuVgn7BNpiv7D+Uy7RQXpCsS0ZS6OQWg=
Subject: FAILED: patch "[PATCH] KVM: s390: Fix gmap_helper_zap_one_page() again" failed to apply to 6.18-stable tree
To: imbrenda@linux.ibm.com,borntraeger@linux.ibm.com,hca@linux.ibm.com,mhartmay@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:28:07 +0100
Message-ID: <2025122907-grant-reformist-a323@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2f393c228cc519ddf19b8c6c05bf15723241aa96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122907-grant-reformist-a323@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f393c228cc519ddf19b8c6c05bf15723241aa96 Mon Sep 17 00:00:00 2001
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Date: Tue, 4 Nov 2025 16:40:48 +0100
Subject: [PATCH] KVM: s390: Fix gmap_helper_zap_one_page() again

A few checks were missing in gmap_helper_zap_one_page(), which can lead
to memory corruption in the guest under specific circumstances.

Add the missing checks.

Fixes: 5deafa27d9ae ("KVM: s390: Fix to clear PTE when discarding a swapped page")
Cc: stable@vger.kernel.org
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index 549f14ad08af..d41b19925a5a 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -47,6 +47,7 @@ static void ptep_zap_softleaf_entry(struct mm_struct *mm, softleaf_t entry)
 void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 {
 	struct vm_area_struct *vma;
+	unsigned long pgstev;
 	spinlock_t *ptl;
 	pgste_t pgste;
 	pte_t *ptep;
@@ -65,9 +66,13 @@ void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 	if (pte_swap(*ptep)) {
 		preempt_disable();
 		pgste = pgste_get_lock(ptep);
+		pgstev = pgste_val(pgste);
 
-		ptep_zap_softleaf_entry(mm, softleaf_from_pte(*ptep));
-		pte_clear(mm, vmaddr, ptep);
+		if ((pgstev & _PGSTE_GPS_USAGE_MASK) == _PGSTE_GPS_USAGE_UNUSED ||
+		    (pgstev & _PGSTE_GPS_ZERO)) {
+			ptep_zap_softleaf_entry(mm, softleaf_from_pte(*ptep));
+			pte_clear(mm, vmaddr, ptep);
+		}
 
 		pgste_set_unlock(ptep, pgste);
 		preempt_enable();


