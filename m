Return-Path: <stable+bounces-212605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA5iLe80eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:10:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2295BA533E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A966D3168DF7
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E102DF138;
	Wed, 28 Jan 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PCLZZuM4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B92836A6;
	Wed, 28 Jan 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616080; cv=none; b=aaeln8XjZGMEl6M8lY6/5/1RF0VPjHYTnv1sJN3IpBh+RxQdzVrYnYePy8IKEXUlNg7kpeYXCUmSZXqTa5rOlb+/9MZeoSnTmQ+niOIVMvD5wrCZ1ylDK+uK2nKymtgA/AcJeav8nyfUh3aa7NmZ7sW4O75TM7Rop/Y7SxZ/ggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616080; c=relaxed/simple;
	bh=HM6v5pVWyktMp5URKq2ZjQTYWIcXGDKJVhTnYc4Mpqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+fjMlAPIHwK1jUg/WOEkv/+DTt/YbNFDNj4+PIqR6+0tbsQGmecRVGe+/7Q6ZEhGh2DDws2eWZ44h11KormSe0AECNMlQrWWYBjkYtFTmhxXy4GO8DuIbtgFEXunUjM65X1G/y2ySSc/SCdpyNtKSaYBMXJg/I3ieN+Rg8BYuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PCLZZuM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFD2C4CEF1;
	Wed, 28 Jan 2026 16:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616080;
	bh=HM6v5pVWyktMp5URKq2ZjQTYWIcXGDKJVhTnYc4Mpqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCLZZuM4XEZQPTg2uaBu1gt6+vYPHmC80VfcvDk7GOn7Vk9bmhsuW47Xwx6LPOXX1
	 W+2ua8oMSmQvfsNy4n4Sgjossdao5LmzMsoXf2cCGeJYbaM/KKsCcRtmyKZRtOI/Yp
	 RUpIag0sjmDPMPWVwvhXnlJs/1Z3mAP8ENLRP878=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.18 199/227] rust: io: always inline functions using build_assert with arguments
Date: Wed, 28 Jan 2026 16:24:04 +0100
Message-ID: <20260128145351.603308222@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212605-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,collabora.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 2295BA533E
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Courbot <acourbot@nvidia.com>

commit 33d19f621641de1b6ec6fe1bb2ac68a7d2c61f6a upstream.

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Cc: stable@vger.kernel.org
Fixes: ce30d94e6855 ("rust: add `io::{Io, IoRaw}` base types")
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Tested-by: Timur Tabi <ttabi@nvidia.com>
Link: https://patch.msgid.link/20251208-io-build-assert-v3-2-98aded02c1ea@nvidia.com
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/io.rs          |    9 ++++++---
 rust/kernel/io/resource.rs |    2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -140,7 +140,8 @@ macro_rules! define_read {
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
         /// time, the build will fail.
         $(#[$attr])*
-        #[inline]
+        // Always inline to optimize out error path of `io_addr_assert`.
+        #[inline(always)]
         pub fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
@@ -169,7 +170,8 @@ macro_rules! define_write {
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
         /// time, the build will fail.
         $(#[$attr])*
-        #[inline]
+        // Always inline to optimize out error path of `io_addr_assert`.
+        #[inline(always)]
         pub fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
@@ -237,7 +239,8 @@ impl<const SIZE: usize> Io<SIZE> {
         self.addr().checked_add(offset).ok_or(EINVAL)
     }
 
-    #[inline]
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     fn io_addr_assert<U>(&self, offset: usize) -> usize {
         build_assert!(Self::offset_valid::<U>(offset, SIZE));
 
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -222,6 +222,8 @@ impl Flags {
     /// Resource represents a memory region that must be ioremaped using `ioremap_np`.
     pub const IORESOURCE_MEM_NONPOSTED: Flags = Flags::new(bindings::IORESOURCE_MEM_NONPOSTED);
 
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     const fn new(value: u32) -> Self {
         crate::build_assert!(value as u64 <= c_ulong::MAX as u64);
         Flags(value as c_ulong)



