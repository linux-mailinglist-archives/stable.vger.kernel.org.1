Return-Path: <stable+bounces-243385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PWtFB2r+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:20:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 800924BF1BF
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 671E0306A4AB
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C581ADC83;
	Mon,  4 May 2026 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vuKnCqqq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF683AA4F8;
	Mon,  4 May 2026 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903747; cv=none; b=o0Q0u83oFXq3++J55uGfajo/HHu5CJxHB+FxMogISa0c8lAqRcA7fS2biOG9OFg4JLQ+SOLaRcenqAsvPGUghBQilbyVXONSbt/wDxVUFHvu4aCAd/em6eC1d1ULEE6RIUUoquZFftNiKP008yp9Bg8jZiAziFWM58B59WgJ514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903747; c=relaxed/simple;
	bh=RlAn4A+rLoGwxIn4ZKwnAFMRoP6f7As0Jkp6g2qCipU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCSajjEQ7a5HxhAB3Z5Mpk9U8urJ5Ug31oDy7xias3ZFhYEGRgwtTglXpcLshOJcqW4fzV+illiex7gK6JHf9WkGmuFtltZgAZhG0J/up/syMJvYBwoxySbKCAGQaoCfPiAOTXK7gSJnyhlTdK3O5m7YS+XeqI0k3Z1hae3MyEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vuKnCqqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57921C2BCB8;
	Mon,  4 May 2026 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903747;
	bh=RlAn4A+rLoGwxIn4ZKwnAFMRoP6f7As0Jkp6g2qCipU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vuKnCqqqGpQoCnKjgvFDYjEX8Azw/fbAL4ntiUEyc5rdLy50ejq9pDYcvjB0wM1IP
	 IPiFrv8rWt0xhCF16Zt1O5KbpDC0gaMyNtV6ezNI4j4Y2XOniWvVflhuiNR4QKDqCJ
	 NhYkC85VHuMsiAod2CH5Q6ZhXvOWoVJMJOyoxLmk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Gary Guo <gary@garyguo.net>
Subject: [PATCH 6.18 019/275] rust: dma: remove DMA_ATTR_NO_KERNEL_MAPPING from public attrs
Date: Mon,  4 May 2026 15:49:19 +0200
Message-ID: <20260504135143.652242283@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 800924BF1BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243385-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,garyguo.net:email,nvidia.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -232,9 +232,6 @@ pub mod attrs {
     /// Specifies that writes to the mapping may be buffered to improve performance.
     pub const DMA_ATTR_WRITE_COMBINE: Attrs = Attrs(bindings::DMA_ATTR_WRITE_COMBINE);
 
-    /// Lets the platform to avoid creating a kernel virtual mapping for the allocated buffer.
-    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attrs = Attrs(bindings::DMA_ATTR_NO_KERNEL_MAPPING);
-
     /// Allows platform code to skip synchronization of the CPU cache for the given buffer assuming
     /// that it has been already transferred to 'device' domain.
     pub const DMA_ATTR_SKIP_CPU_SYNC: Attrs = Attrs(bindings::DMA_ATTR_SKIP_CPU_SYNC);



