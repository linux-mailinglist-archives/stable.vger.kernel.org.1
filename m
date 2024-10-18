Return-Path: <stable+bounces-86841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 477A69A413B
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 16:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640DC1C21ABF
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3974F18FC79;
	Fri, 18 Oct 2024 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N66RNpua"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332274421
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262007; cv=none; b=dDd+puVxTp3JfjbHin4kc5/DTRrLKZBq1Gz8IXR01/d56VvhaJXGGUtcYnB7ChFGCGxesdpBLqr98caHF5zBFldMnswY3j2nbfNG0mKWLEi5xqC1+C9lOQdbpVmuQFBk5LTCto/szMXQrEG8pi6IvPpXpAg3bF0k3i//tO88Dp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262007; c=relaxed/simple;
	bh=mEQ6RJGvWu+qahEVJvuodkFd/r/3vaoQ6JkTNE2KFCA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tU+8Ho+B0d6HPpoVliop+QD5VQtWCGWHUMMbcRaugQMg1KtOBiiJ3db7q6xL7ADaNKSth2KpN8SckSy7fH1Dsc1snEdGhua+C6MlUxcdEqU15W2Yfa95EeFv+3r0aDRD6lwmG+INOPF1oSsjSFWksvGQtwo7z5BAeWzrhnKGi1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N66RNpua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F685C4CEC3;
	Fri, 18 Oct 2024 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729262006;
	bh=mEQ6RJGvWu+qahEVJvuodkFd/r/3vaoQ6JkTNE2KFCA=;
	h=Subject:To:Cc:From:Date:From;
	b=N66RNpuazgfG7zNd9x9ZC2sdloDvgY10X4qesXLUguDAu05Md3zs+LH14eTqsBltf
	 fdpVTh4zmd71Y1VziPKrdRyESzvXq7ltOa/oF4k0kxcLNMHe6vpyNKw9NTOA0irGYj
	 e+UAJGc4OgKv4YalfadgoaxgZxUiOhVFGUVU+H3Y=
Subject: FAILED: patch "[PATCH] KVM: s390: gaccess: Check if guest address is in memslot" failed to apply to 5.15-stable tree
To: nrb@linux.ibm.com,frankja@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 18 Oct 2024 16:33:23 +0200
Message-ID: <2024101823-tractor-twitter-a318@gregkh>
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
git cherry-pick -x e8061f06185be0a06a73760d6526b8b0feadfe52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101823-tractor-twitter-a318@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


