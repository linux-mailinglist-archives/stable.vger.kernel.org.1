Return-Path: <stable+bounces-236129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE5hLkgG3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:05:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C713EDB0B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BAA93037153
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096523B777D;
	Mon, 13 Apr 2026 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1T3wObR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E3B3B3C18
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092317; cv=none; b=AaH5TVAJEdM1l9yraGd9RfRS8bxIjsFebABUGEd1p2B5xYs38SaS+CMheM6op64WfbUIjyzPzLb22hlrgWacOIZkm1U7BkBWnaNr+fcXlsYlI4ObX+kMRP6te65rDKRQcNnw9gvp9BW1GyyRY+975DbHTFtv46jQ+JNSJ0hhI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092317; c=relaxed/simple;
	bh=+65Vb8ra+TrWyLvYxM2Xlt1rJf+nedmBZHlfHtmPGx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLEOaHbg7h7ShR58KHdmB3KeqvrzcNBrz4+OQdvnnEIO2XrGi2hkQn4d+1eHQ8mCaBZ/G1KUXWeJlI3BPCdVZUlUHK2JpRSIG6uigukmQqMxb4RYL51fh6Xte2G1qXEC4irMoMHtSQqOQqx2KLB/v6/EnW8kRYV1+3yusFblIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1T3wObR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5E3C2BCAF;
	Mon, 13 Apr 2026 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776092317;
	bh=+65Vb8ra+TrWyLvYxM2Xlt1rJf+nedmBZHlfHtmPGx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1T3wObRzVbzG8vYl6N8b2vEhhYfTuCX/LcsMP+c3vEeoqiOXqXzuEYzjc+0DWGT1
	 85lmAwTeWc0twzjw3/sfVx5I70b4ndwe0iCRsFkxGsfCV4fk3xRqYsgsTwRsEpZ4GG
	 9JEBribf7AwzqT+0/xcWBC4EUb5nSUXoGFsXm/9VhLMw4BisqoP7ut9qlxlwlswLTZ
	 80GfGCb0iE42L4XWGMCvCYEIYqwuCNyhJpMjbt9qiUJUYIqSvyqpuR1yfhyjDXTcPv
	 jGAxrBkO5I5kxbFSYC7UMO57uVHyuwFwabBGvDScf0oxFMZ8P21YRSyFhr52w8IZQ0
	 QiibGi+WuijSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs
Date: Mon, 13 Apr 2026 10:58:35 -0400
Message-ID: <20260413145835.2969194-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041318-monogamy-woozy-29fe@gregkh>
References: <2026041318-monogamy-woozy-29fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236129-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 13C713EDB0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

[ Upstream commit 2619da73bb2f10d88f7e1087125c40144fdf0987 ]

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
[ applied `__DECLARE_FLEX_ARRAY(char, name)` change directly instead of inside missing `#ifdef __KERNEL__` else branch ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/uapi/asm/kvm.h | 12 ++++++------
 include/uapi/linux/kvm.h        | 11 ++++++-----
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 1a6a1f9879496..07b5685d9c769 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -191,13 +191,13 @@ struct kvm_msrs {
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
@@ -239,7 +239,7 @@ struct kvm_cpuid_entry {
 struct kvm_cpuid {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_cpuid_entry, entries);
 };
 
 struct kvm_cpuid_entry2 {
@@ -261,7 +261,7 @@ struct kvm_cpuid_entry2 {
 struct kvm_cpuid2 {
 	__u32 nent;
 	__u32 padding;
-	struct kvm_cpuid_entry2 entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_cpuid_entry2, entries);
 };
 
 /* for KVM_GET_PIT and KVM_SET_PIT */
@@ -392,7 +392,7 @@ struct kvm_xsave {
 	 * the contents of CPUID leaf 0xD on the host.
 	 */
 	__u32 region[1024];
-	__u32 extra[];
+	__DECLARE_FLEX_ARRAY(__u32, extra);
 };
 
 #define KVM_MAX_XCRS	16
@@ -520,7 +520,7 @@ struct kvm_pmu_event_filter {
 	__u32 fixed_counter_bitmap;
 	__u32 flags;
 	__u32 pad[4];
-	__u64 events[];
+	__DECLARE_FLEX_ARRAY(__u64, events);
 };
 
 #define KVM_PMU_EVENT_ALLOW 0
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 13065dd96132d..e48ba56c54858 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -11,6 +11,7 @@
 #include <linux/const.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/stddef.h>
 #include <linux/ioctl.h>
 #include <asm/kvm.h>
 
@@ -556,7 +557,7 @@ struct kvm_coalesced_mmio {
 
 struct kvm_coalesced_mmio_ring {
 	__u32 first, last;
-	struct kvm_coalesced_mmio coalesced_mmio[];
+	__DECLARE_FLEX_ARRAY(struct kvm_coalesced_mmio, coalesced_mmio);
 };
 
 #define KVM_COALESCED_MMIO_MAX \
@@ -643,7 +644,7 @@ struct kvm_clear_dirty_log {
 /* for KVM_SET_SIGNAL_MASK */
 struct kvm_signal_mask {
 	__u32 len;
-	__u8  sigset[];
+	__DECLARE_FLEX_ARRAY(__u8, sigset);
 };
 
 /* for KVM_TPR_ACCESS_REPORTING */
@@ -1256,7 +1257,7 @@ struct kvm_irq_routing_entry {
 struct kvm_irq_routing {
 	__u32 nr;
 	__u32 flags;
-	struct kvm_irq_routing_entry entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_irq_routing_entry, entries);
 };
 
 #endif
@@ -1377,7 +1378,7 @@ struct kvm_dirty_tlb {
 
 struct kvm_reg_list {
 	__u64 n; /* number of regs */
-	__u64 reg[];
+	__DECLARE_FLEX_ARRAY(__u64, reg);
 };
 
 struct kvm_one_reg {
@@ -2211,7 +2212,7 @@ struct kvm_stats_desc {
 	__u16 size;
 	__u32 offset;
 	__u32 bucket_size;
-	char name[];
+	__DECLARE_FLEX_ARRAY(char, name);
 };
 
 #define KVM_GET_STATS_FD  _IO(KVMIO,  0xce)
-- 
2.53.0


