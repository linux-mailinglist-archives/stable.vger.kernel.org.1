Return-Path: <stable+bounces-243049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMQDIVal+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:55:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 290094BE1FB
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44F4A301483D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7FF3DDDD7;
	Mon,  4 May 2026 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tXwSX/QL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CEC3DDDD5;
	Mon,  4 May 2026 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902886; cv=none; b=YCE4D80NW9SCMg8sj6HUCJSg8qn+qUE6m0qWLumlMiF54Nr/72CbJiqG3nhpcFe1QzJkCt5oBVK1AgxAiEv9hfzIJzPx8H6FT8nEBlns/7NWFfPKBrgVl29Rn3mKbhqO9RJ8WT3eLQk29l2fQnEEXI+mO9jZsoAU1atiOCdhoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902886; c=relaxed/simple;
	bh=wFY6mHbX1ErhbraK/HMSTWzJYVS3OjVoYJcno3QzzMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGZTdf4qnnbryybdPWqxqecUK9ewlZa5Tj57ZYIRaYkYl21XBZCMHBSvVZc7vAdlo6QdWvx9gUVlJpKDNA3BArhLn5z216zGBjpNXnpxbVlihZcX2edmn4X4MMcTCaEtaMyLpTZko7qI2DImVN7dgP7DEvgYqM26nJWmtjOIGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tXwSX/QL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA36C2BCB8;
	Mon,  4 May 2026 13:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777902886;
	bh=wFY6mHbX1ErhbraK/HMSTWzJYVS3OjVoYJcno3QzzMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXwSX/QLwlX3OX9yoQxD4PR7m8UTR5w4SdDyUZmd4KaaGsAsAJ8PpgovwID88Rsf1
	 NN3IhwyTpPJMpXMaoqPuHwqBhnrp0tpCIu41L7G534bQsflgMovEyLsW8+ChGnsnx5
	 mgmbM3yaHQnvjbCB0oMFAWxvcH3AHnC1/nVyRUsU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Gary Guo <gary@garyguo.net>
Subject: [PATCH 7.0 020/307] rust: dma: remove DMA_ATTR_NO_KERNEL_MAPPING from public attrs
Date: Mon,  4 May 2026 15:48:25 +0200
Message-ID: <20260504135143.587646485@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 290094BE1FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243049-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <dakr@kernel.org>

commit 18fb5f1f0289b8217c0c43d54d12bccc201dd640 upstream.

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
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260321172749.592387-1-dakr@kernel.org
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/dma.rs |    3 ---
 1 file changed, 3 deletions(-)

--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -250,9 +250,6 @@ pub mod attrs {
     /// Specifies that writes to the mapping may be buffered to improve performance.
     pub const DMA_ATTR_WRITE_COMBINE: Attrs = Attrs(bindings::DMA_ATTR_WRITE_COMBINE);
 
-    /// Lets the platform to avoid creating a kernel virtual mapping for the allocated buffer.
-    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attrs = Attrs(bindings::DMA_ATTR_NO_KERNEL_MAPPING);
-
     /// Allows platform code to skip synchronization of the CPU cache for the given buffer assuming
     /// that it has been already transferred to 'device' domain.
     pub const DMA_ATTR_SKIP_CPU_SYNC: Attrs = Attrs(bindings::DMA_ATTR_SKIP_CPU_SYNC);



