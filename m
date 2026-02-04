Return-Path: <stable+bounces-214287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MlQAiVug2kFmwMAu9opvQ
	(envelope-from <stable+bounces-214287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:04:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BD9E9D4B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 932D6318018C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3772D8768;
	Wed,  4 Feb 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TP2+RMFb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46972D738F;
	Wed,  4 Feb 2026 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219184; cv=none; b=QrCaKNaUr7YgMOOoEM990fEles+3MerxJW2GksO92nkaRCt9LJzo1cFVS0zVi0POjTCrHuagGbOkUJNx++s5yMOOKhNSne8LoiIoFn55kI7lj4EYIoZ6t+vEm8+pPjO/SG1dsw61IDKTlZvSyKCajcKPUO2V1j3kA90UKIP8td0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219184; c=relaxed/simple;
	bh=1WEWMUHBa7UO1cJCIKf5UdiQiJexXkwjpKXy9RdpG/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQqFuBYdf5Atov+lNVmQAXSDCIJfGf43cku/2VWdxDkCibRsZUP5OZH0VtdFMnLKGEugKI3fhLUqY6I5lzjQT8fh77R4Fu6ybtLT3vInJ6uC5oz/jCSZodnVIvXnbDtXhgdnQ0Ii5TGbNCzbvSrZNPT71vFo9qrf+5gXAAgJr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TP2+RMFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F88EC4CEF7;
	Wed,  4 Feb 2026 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219184;
	bh=1WEWMUHBa7UO1cJCIKf5UdiQiJexXkwjpKXy9RdpG/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TP2+RMFbHM2SgvIbcS3WE1YoBMPr3f1kCNOR3n6nFmMP29CHRJdMdOWmzwIMEfHDl
	 e9jOhW4l4XmRu3sknm06NylvjT/BceJAAISMU27fPH6EzoekEgnVqLFFfAMXrkleLC
	 BSZHU8Lraskrg0VsfMUJ/pyjp8gBOQdZGZZqt3rc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.18 091/122] rust: bits: always inline functions using build_assert with arguments
Date: Wed,  4 Feb 2026 15:41:13 +0100
Message-ID: <20260204143855.125714449@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214287-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,collabora.com:email]
X-Rspamd-Queue-Id: 86BD9E9D4B
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Courbot <acourbot@nvidia.com>

commit 09c3c9112d71c44146419c87c55c710e68335741 upstream.

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Cc: stable@vger.kernel.org
Fixes: cc84ef3b88f4 ("rust: bits: add support for bits/genmask macros")
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Link: https://patch.msgid.link/20251208-io-build-assert-v3-4-98aded02c1ea@nvidia.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/bits.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
index 553d50265883..2daead125626 100644
--- a/rust/kernel/bits.rs
+++ b/rust/kernel/bits.rs
@@ -27,7 +27,8 @@ pub fn [<checked_bit_ $ty>](n: u32) -> Option<$ty> {
             ///
             /// This version is the default and should be used if `n` is known at
             /// compile time.
-            #[inline]
+            // Always inline to optimize out error path of `build_assert`.
+            #[inline(always)]
             pub const fn [<bit_ $ty>](n: u32) -> $ty {
                 build_assert!(n < <$ty>::BITS);
                 (1 as $ty) << n
@@ -75,7 +76,8 @@ pub fn [<genmask_checked_ $ty>](range: RangeInclusive<u32>) -> Option<$ty> {
             /// This version is the default and should be used if the range is known
             /// at compile time.
             $(#[$genmask_ex])*
-            #[inline]
+            // Always inline to optimize out error path of `build_assert`.
+            #[inline(always)]
             pub const fn [<genmask_ $ty>](range: RangeInclusive<u32>) -> $ty {
                 let start = *range.start();
                 let end = *range.end();
-- 
2.53.0




