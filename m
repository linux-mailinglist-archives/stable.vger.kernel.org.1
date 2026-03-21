Return-Path: <stable+bounces-227779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JWKER7VvmlwewMAu9opvQ
	(envelope-from <stable+bounces-227779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 18:27:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FC62E6843
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 18:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63AF8300D621
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F14339856;
	Sat, 21 Mar 2026 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXLLueIw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430F4317D;
	Sat, 21 Mar 2026 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114075; cv=none; b=I4CHqt2th1i2auc60pEKJmF13lJr516e4jbDLgcvCS4w2sKcnflU/99MLFa1FnP6yir4PMp7ozP6z0WshqwlG25COmeomAPekLmmz9eccXps6zdaw2clwexj4831gufnEYK1AWL+Bu+Fpx6+kG8cAURjx3zlXQ57zJbCPp/smTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114075; c=relaxed/simple;
	bh=skP89Tr9N6B1+Y/LraUOofptzQoKcEF0khe8i4Y5hZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+vy/2+p2i0B6MFWsFQFOkeI9xF+DbYwmwk2cUNkRjImLoTPH8kfxuHFF5Xcz7FsWBOwg8I6uwBlc9GicMiMFNUU2deedZZn0mtylt33YnumSD5bvvozLzEDtUIpi/CZ6uiH8vN7HozndynI2CBqduegaxbPxXZ6G3eDYFUhI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXLLueIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AD3C19421;
	Sat, 21 Mar 2026 17:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774114074;
	bh=skP89Tr9N6B1+Y/LraUOofptzQoKcEF0khe8i4Y5hZs=;
	h=From:To:Cc:Subject:Date:From;
	b=VXLLueIwy32Pf5lQogMGRbKEC4j7qA39CpqS8b6Z0TAbuyftEeA3wqRVJqQCuQbm8
	 ePq3jMfEaHiBglROZ4JzHN+JP6N+yMcRNUFwtEXYzqSF3Kvycga5kQaN/JnmP4TvXk
	 BgZzPrKXP10Ue9YG8evf12X8AAPGg/FIECqKLm6v9UWRp9D3ylo+HfB0PZSvEaI+PJ
	 7439mBAYwsNm3nVKkoCSz2uYqdRIQG80M/8BG+LRa0m6MKFbIy73HmSIUsxFIXDApo
	 BokIWT/mysdfvf9/OflS85byEVCzUJkwwAs3QsZINJBE5sy1bw5fxQojoOSNUIFXK8
	 U5aaO3758UnnA==
From: Danilo Krummrich <dakr@kernel.org>
To: abdiel.janulgue@gmail.com,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	a.hindborg@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] rust: dma: remove DMA_ATTR_NO_KERNEL_MAPPING from public attrs
Date: Sat, 21 Mar 2026 18:27:46 +0100
Message-ID: <20260321172749.592387-1-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com,collabora.com,arm.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu];
	TAGGED_FROM(0.00)[bounces-227779-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8FC62E6843
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When DMA_ATTR_NO_KERNEL_MAPPING is passed to dma_alloc_attrs(), the
returned CPU address is not a pointer to the allocated memory but an
opaque handle (e.g. struct page *).

Coherent<T> (or CoherentAllocation<T> respectively) stores this value as
NonNull<T> and exposes methods that dereference it and even modify its
contents.

Remove the flag from the public attrs module such that drivers cannot
pass it to Coherent<T> (or CoherentAllocation<T> respectively) in the
first place.

Instead DMA_ATTR_NO_KERNEL_MAPPING can be supported with an additional
opaque type (e.g. CoherentHandle) which does not provide access to the
allocated memory.

Cc: stable@vger.kernel.org
Fixes: ad2907b4e308 ("rust: add dma coherent allocator abstraction")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/dma.rs | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 6d2bec52806b..9e0c9ff91cba 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -264,9 +264,6 @@ pub mod attrs {
     /// Specifies that writes to the mapping may be buffered to improve performance.
     pub const DMA_ATTR_WRITE_COMBINE: Attrs = Attrs(bindings::DMA_ATTR_WRITE_COMBINE);
 
-    /// Lets the platform to avoid creating a kernel virtual mapping for the allocated buffer.
-    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attrs = Attrs(bindings::DMA_ATTR_NO_KERNEL_MAPPING);
-
     /// Allows platform code to skip synchronization of the CPU cache for the given buffer assuming
     /// that it has been already transferred to 'device' domain.
     pub const DMA_ATTR_SKIP_CPU_SYNC: Attrs = Attrs(bindings::DMA_ATTR_SKIP_CPU_SYNC);
-- 
2.53.0


