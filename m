Return-Path: <stable+bounces-236014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH4FEsnc3GlwXgkAu9opvQ
	(envelope-from <stable+bounces-236014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:08:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8503EBB6F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30A873007AC3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0363BD25E;
	Mon, 13 Apr 2026 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c0ogeqNK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60722D94A0
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082115; cv=none; b=grLpmzHQw54D1i64rjY4VXe3bDJrXmuwmx4/b0ukwgvhP4gX2SUXHxjfLeig4WbwG9mfZi0ZdY9jb5Bn+39UInr4JAi98xi9J2+DrUdFtCDSvb8yi7sHzyaxTKYhTwVUnmYvPgtAyyCUpR+xT1tSOixoy3XSjueRxQg/3kGL0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082115; c=relaxed/simple;
	bh=4BvExntQhsSjjHJrNTkHimeH0wbJLV5Tl4x9yUYYJg8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s7IwDXz9IR2K6RyNt0MVjfQ+l6DstJf+F4s42hx+sMGjD+v+aMRgBlLCbDAS9cGo/JjInZbyknQT6BvQZBlE6Z18M0B5xn4Zap/I+fDsjBrhxnHlOFGFssHQ1Fr6rCWdwrUCvAPK9xfiR7Us2khlTOTh8tn+o16hNaaiJg8g5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c0ogeqNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5B9C116C6;
	Mon, 13 Apr 2026 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776082115;
	bh=4BvExntQhsSjjHJrNTkHimeH0wbJLV5Tl4x9yUYYJg8=;
	h=Subject:To:Cc:From:Date:From;
	b=c0ogeqNKUeb3BJKKLTUytlOF2AiwIXJhfptAG7ExeAo20I3vH6zwoTjRTsrtS6xyf
	 qBDGZjmEOiN4mu/ZVhQmpwtWgmrz8cu2JCfx+OzMXPVvLypQvtOr92ENrt1fQNUXlw
	 7vFHhO8sleVQ+iqeDQNJfpQHXFLl2+amw4k8rGMY=
Subject: FAILED: patch "[PATCH] KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with" failed to apply to 6.1-stable tree
To: dwmw@amazon.co.uk,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:08:19 +0200
Message-ID: <2026041319-perceive-bok-f424@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236014-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,amazon.co.uk:email,msgid.link:url,gregkh:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C8503EBB6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2619da73bb2f10d88f7e1087125c40144fdf0987
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041319-perceive-bok-f424@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2619da73bb2f10d88f7e1087125c40144fdf0987 Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Thu, 5 Mar 2026 20:49:55 +0100
Subject: [PATCH] KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with
 VLAs

Commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
flexible-array members") broke the userspace API for C++.

These structures ending in VLAs are typically a *header*, which can be
followed by an arbitrary number of entries. Userspace typically creates
a larger structure with some non-zero number of entries, for example in
QEMU's kvm_arch_get_supported_msr_feature():

    struct {
        struct kvm_msrs info;
        struct kvm_msr_entry entries[1];
    } msr_data = {};

While that works in C, it fails in C++ with an error like:
 flexible array member 'kvm_msrs::entries' not at end of 'struct msr_data'

Fix this by using __DECLARE_FLEX_ARRAY() for the VLA, which uses [0]
for C++ compilation.

Fixes: 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with flexible-array members")
Cc: stable@vger.kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Link: https://patch.msgid.link/3abaf6aefd6e5efeff3b860ac38421d9dec908db.camel@infradead.org
[sean: tag for stable@]
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 0d4538fa6c31..5f2b30d0405c 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -197,13 +197,13 @@ struct kvm_msrs {
 	__u32 nmsrs; /* number of msrs in entries */
 	__u32 pad;
 
-	struct kvm_msr_entry entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_msr_entry, entries);
 };
 
 /* for KVM_GET_MSR_INDEX_LIST */
 struct kvm_msr_list {
 	__u32 nmsrs; /* number of msrs in entries */
-	__u32 indices[];
+	__DECLARE_FLEX_ARRAY(__u32, indices);
 };
 
 /* Maximum size of any access bitmap in bytes */
@@ -245,7 +245,7 @@ struct kvm_cpuid_entry {
 struct kvm_cpuid {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_cpuid_entry, entries);
 };
 
 struct kvm_cpuid_entry2 {
@@ -267,7 +267,7 @@ struct kvm_cpuid_entry2 {
 struct kvm_cpuid2 {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry2 entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_cpuid_entry2, entries);
 };
 
 /* for KVM_GET_PIT and KVM_SET_PIT */
@@ -398,7 +398,7 @@ struct kvm_xsave {
 	 * the contents of CPUID leaf 0xD on the host.
 	 */
 	__u32 region[1024];
-	__u32 extra[];
+	__DECLARE_FLEX_ARRAY(__u32, extra);
 };
 
 #define KVM_MAX_XCRS	16
@@ -566,7 +566,7 @@ struct kvm_pmu_event_filter {
 	__u32 fixed_counter_bitmap;
 	__u32 flags;
 	__u32 pad[4];
-	__u64 events[];
+	__DECLARE_FLEX_ARRAY(__u64, events);
 };
 
 #define KVM_PMU_EVENT_ALLOW 0
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 80364d4dbebb..3f0d8d3c3daf 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -11,6 +11,7 @@
 #include <linux/const.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/stddef.h>
 #include <linux/ioctl.h>
 #include <asm/kvm.h>
 
@@ -542,7 +543,7 @@ struct kvm_coalesced_mmio {
 
 struct kvm_coalesced_mmio_ring {
 	__u32 first, last;
-	struct kvm_coalesced_mmio coalesced_mmio[];
+	__DECLARE_FLEX_ARRAY(struct kvm_coalesced_mmio, coalesced_mmio);
 };
 
 #define KVM_COALESCED_MMIO_MAX \
@@ -592,7 +593,7 @@ struct kvm_clear_dirty_log {
 /* for KVM_SET_SIGNAL_MASK */
 struct kvm_signal_mask {
 	__u32 len;
-	__u8  sigset[];
+	__DECLARE_FLEX_ARRAY(__u8, sigset);
 };
 
 /* for KVM_TPR_ACCESS_REPORTING */
@@ -1051,7 +1052,7 @@ struct kvm_irq_routing_entry {
 struct kvm_irq_routing {
 	__u32 nr;
 	__u32 flags;
-	struct kvm_irq_routing_entry entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_irq_routing_entry, entries);
 };
 
 #define KVM_IRQFD_FLAG_DEASSIGN (1 << 0)
@@ -1142,7 +1143,7 @@ struct kvm_dirty_tlb {
 
 struct kvm_reg_list {
 	__u64 n; /* number of regs */
-	__u64 reg[];
+	__DECLARE_FLEX_ARRAY(__u64, reg);
 };
 
 struct kvm_one_reg {
@@ -1608,7 +1609,7 @@ struct kvm_stats_desc {
 #ifdef __KERNEL__
 	char name[KVM_STATS_NAME_SIZE];
 #else
-	char name[];
+	__DECLARE_FLEX_ARRAY(char, name);
 #endif
 };
 


