Return-Path: <stable+bounces-86842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B29A413C
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 16:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300C2285B2E
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 14:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD81D9686;
	Fri, 18 Oct 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I1xuFOjc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236518643
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262011; cv=none; b=e21MER4K0INTAV66eyuP6Fq2aL95elb/orBosyVVsOAI33gJRSm+9BbHr7oNKC7i4Omn+e1eLNEn2Iupek6JND1Y5Jvcik4KBCvB8MVeiEuWbRGduMWbzwif4XjZuPqXSujSWt+ysyL00xuf6s+OSbieqBs8C7xoIF7VUGmG5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262011; c=relaxed/simple;
	bh=ueIQxdQBI+i8WwcOULAg+Pi3um4QuctLfJGyu+EB+eY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LTMqgDL99oUUI/MGXx/Vbtqpa/9oxeFc0FyliFGBRoZLHu3rO+sA/HM/3oLpdnnS46f6EiS8b2+oVTF5V5AUNw4KSsVoUEDsZ+8Hd4pps63pQD47euR967d8zsiz3NKxnAyr1uhTRlfQj4NcBR5gAHVqGJN87wGo4aGkvH804Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I1xuFOjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DF1C4CEC3;
	Fri, 18 Oct 2024 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729262010;
	bh=ueIQxdQBI+i8WwcOULAg+Pi3um4QuctLfJGyu+EB+eY=;
	h=Subject:To:Cc:From:Date:From;
	b=I1xuFOjcn47rh8nhFPZhpkeTVnc6O2+Ih3PTin4FSYBPFYl5116qcMr3rEtLE21X7
	 Gje3Bezmz41+kOHRwiF4knn4HBGaEkny1XhpzowQkYgaAw5hh67f1MQVIoWPY0lxrZ
	 iVqreY44KShtrEax6ai7emDNjFD+mCTc9BnWHbzo=
Subject: FAILED: patch "[PATCH] KVM: s390: gaccess: Check if guest address is in memslot" failed to apply to 5.10-stable tree
To: nrb@linux.ibm.com,frankja@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 18 Oct 2024 16:33:24 +0200
Message-ID: <2024101824-departure-oversight-aa1e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e8061f06185be0a06a73760d6526b8b0feadfe52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101824-departure-oversight-aa1e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e8061f06185be0a06a73760d6526b8b0feadfe52 Mon Sep 17 00:00:00 2001
From: Nico Boehr <nrb@linux.ibm.com>
Date: Tue, 17 Sep 2024 17:18:33 +0200
Subject: [PATCH] KVM: s390: gaccess: Check if guest address is in memslot

Previously, access_guest_page() did not check whether the given guest
address is inside of a memslot. This is not a problem, since
kvm_write_guest_page/kvm_read_guest_page return -EFAULT in this case.

However, -EFAULT is also returned when copy_to/from_user fails.

When emulating a guest instruction, the address being outside a memslot
usually means that an addressing exception should be injected into the
guest.

Failure in copy_to/from_user however indicates that something is wrong
in userspace and hence should be handled there.

To be able to distinguish these two cases, return PGM_ADDRESSING in
access_guest_page() when the guest address is outside guest memory. In
access_guest_real(), populate vcpu->arch.pgm.code such that
kvm_s390_inject_prog_cond() can be used in the caller for injecting into
the guest (if applicable).

Since this adds a new return value to access_guest_page(), we need to make
sure that other callers are not confused by the new positive return value.

There are the following users of access_guest_page():
- access_guest_with_key() does the checking itself (in
  guest_range_to_gpas()), so this case should never happen. Even if, the
  handling is set up properly.
- access_guest_real() just passes the return code to its callers, which
  are:
    - read_guest_real() - see below
    - write_guest_real() - see below

There are the following users of read_guest_real():
- ar_translation() in gaccess.c which already returns PGM_*
- setup_apcb10(), setup_apcb00(), setup_apcb11() in vsie.c which always
  return -EFAULT on read_guest_read() nonzero return - no change
- shadow_crycb(), handle_stfle() always present this as validity, this
  could be handled better but doesn't change current behaviour - no change

There are the following users of write_guest_real():
- kvm_s390_store_status_unloaded() always returns -EFAULT on
  write_guest_real() failure.

Fixes: 2293897805c2 ("KVM: s390: add architecture compliant guest access functions")
Cc: stable@vger.kernel.org
Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20240917151904.74314-2-nrb@linux.ibm.com
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index e65f597e3044..a688351f4ab5 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -828,6 +828,8 @@ static int access_guest_page(struct kvm *kvm, enum gacc_mode mode, gpa_t gpa,
 	const gfn_t gfn = gpa_to_gfn(gpa);
 	int rc;
 
+	if (!gfn_to_memslot(kvm, gfn))
+		return PGM_ADDRESSING;
 	if (mode == GACC_STORE)
 		rc = kvm_write_guest_page(kvm, gfn, data, offset, len);
 	else
@@ -985,6 +987,8 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 		gra += fragment_len;
 		data += fragment_len;
 	}
+	if (rc > 0)
+		vcpu->arch.pgm.code = rc;
 	return rc;
 }
 
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index b320d12aa049..3fde45a151f2 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -405,11 +405,12 @@ int read_guest_abs(struct kvm_vcpu *vcpu, unsigned long gpa, void *data,
  * @len: number of bytes to copy
  *
  * Copy @len bytes from @data (kernel space) to @gra (guest real address).
- * It is up to the caller to ensure that the entire guest memory range is
- * valid memory before calling this function.
  * Guest low address and key protection are not checked.
  *
- * Returns zero on success or -EFAULT on error.
+ * Returns zero on success, -EFAULT when copying from @data failed, or
+ * PGM_ADRESSING in case @gra is outside a memslot. In this case, pgm check info
+ * is also stored to allow injecting into the guest (if applicable) using
+ * kvm_s390_inject_prog_cond().
  *
  * If an error occurs data may have been copied partially to guest memory.
  */
@@ -428,11 +429,12 @@ int write_guest_real(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
  * @len: number of bytes to copy
  *
  * Copy @len bytes from @gra (guest real address) to @data (kernel space).
- * It is up to the caller to ensure that the entire guest memory range is
- * valid memory before calling this function.
  * Guest key protection is not checked.
  *
- * Returns zero on success or -EFAULT on error.
+ * Returns zero on success, -EFAULT when copying to @data failed, or
+ * PGM_ADRESSING in case @gra is outside a memslot. In this case, pgm check info
+ * is also stored to allow injecting into the guest (if applicable) using
+ * kvm_s390_inject_prog_cond().
  *
  * If an error occurs data may have been copied partially to kernel space.
  */


