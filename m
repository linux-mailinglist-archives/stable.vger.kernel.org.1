Return-Path: <stable+bounces-210972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPuwDxcrcWniewAAu9opvQ
	(envelope-from <stable+bounces-210972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:37:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D77D05C535
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F88B70608D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E7D3A89B0;
	Wed, 21 Jan 2026 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QBvUaTJh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3346236656E;
	Wed, 21 Jan 2026 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020005; cv=none; b=O/fCyUgUiXEcmzFeMRV2VBr0nA0y9QxT5/MWVEWorPFSn4z+TgYCWJwdLJVZdudHCIWgTaUJ2cPuLXfbmU9qQ8FifAoNtp7Fx65mbWKyKY4Gkc3uuGLyNoaAp8d97bZrCy7bQ8k+0EuU/r/v04XE5BHR+Y5xUt961FhEvCJJqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020005; c=relaxed/simple;
	bh=GB0zZ17NaaVvEJej7HKUqoq2WtsQmd7BKBHX8n8uk58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ja0UmD5eOq6IYBytq//t1voOX2YiDGOdxyUM3Yl9qkDF8NNheg//gMohbrN51c5KWzip8IXK6SW5WzN7FW3Ee2OcShMIpLiyftsGZCXa9QdEk2OXFVs77rfZbi31EMYXvOly1aul5RT3cQ3Wtjyy2Avk43NV5TQQKa3fPcpnEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QBvUaTJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3726BC4CEF1;
	Wed, 21 Jan 2026 18:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020004;
	bh=GB0zZ17NaaVvEJej7HKUqoq2WtsQmd7BKBHX8n8uk58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QBvUaTJhFz3ByAH1BHboBhS0YEVv+mlpfumMrAUTbjivnzOSnpGsuZCbyiuB5El5o
	 dLqsJ+X4Cy7XMyvoQW9rMd9WYE4q0B+7G5FcToiuN7A4pQD6aQk5urdpWDZp2p6IY2
	 67Ik8DLsQnBhWYU0cRINxxbZskmvhPIv2zmcVrNg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Alice Ryhl <aliceryhl@google.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 6.18 006/198] rust: bitops: fix missing _find_* functions on 32-bit ARM
Date: Wed, 21 Jan 2026 19:13:54 +0100
Message-ID: <20260121181418.772952941@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,de.bosch.com,google.com,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210972-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,bosch.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,zulipchat.com:url]
X-Rspamd-Queue-Id: D77D05C535
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alice Ryhl <aliceryhl@google.com>

commit 6a069876eb1402478900ee0eb7d7fe276bb1f4e3 upstream.

On 32-bit ARM, you may encounter linker errors such as this one:

	ld.lld: error: undefined symbol: _find_next_zero_bit
	>>> referenced by rust_binder_main.43196037ba7bcee1-cgu.0
	>>>               drivers/android/binder/rust_binder_main.o:(<rust_binder_main::process::Process>::insert_or_update_handle) in archive vmlinux.a
	>>> referenced by rust_binder_main.43196037ba7bcee1-cgu.0
	>>>               drivers/android/binder/rust_binder_main.o:(<rust_binder_main::process::Process>::insert_or_update_handle) in archive vmlinux.a

This error occurs because even though the functions are declared by
include/linux/find.h, the definition is #ifdef'd out on 32-bit ARM. This
is because arch/arm/include/asm/bitops.h contains:

	#define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
	#define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_le(p,sz,off)
	#define find_first_bit(p,sz)		_find_first_bit_le(p,sz)
	#define find_next_bit(p,sz,off)		_find_next_bit_le(p,sz,off)

And the underscore-prefixed function is conditional on #ifndef of the
non-underscore-prefixed name, but the declaration in find.h is *not*
conditional on that #ifndef.

To fix the linker error, we ensure that the symbols in question exist
when compiling Rust code. We do this by defining them in rust/helpers/
whenever the normal definition is #ifndef'd out.

Note that these helpers are somewhat unusual in that they do not have
the rust_helper_ prefix that most helpers have. Adding the rust_helper_
prefix does not compile, as 'bindings::_find_next_zero_bit()' will
result in a call to a symbol called _find_next_zero_bit as defined by
include/linux/find.h rather than a symbol with the rust_helper_ prefix.
This is because when a symbol is present in both include/ and
rust/helpers/, the one from include/ wins under the assumption that the
current configuration is one where that helper is unnecessary. This
heuristic fails for _find_next_zero_bit() because the header file always
declares it even if the symbol does not exist.

The functions still use the __rust_helper annotation. This lets the
wrapper function be inlined into Rust code even if full kernel LTO is
not used once the patch series for that feature lands.

Yury: arches are free to implement they own find_bit() functions. Most
rely on generic implementation, but arm32 and m86k - not; so they require
custom handling. Alice confirmed it fixes the build for both.

Cc: stable@vger.kernel.org
Fixes: 6cf93a9ed39e ("rust: add bindings for bitops.h")
Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/x/topic/x/near/561677301
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/helpers/bitops.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
index 5d0861d29d3f..e79ef9e6d98f 100644
--- a/rust/helpers/bitops.c
+++ b/rust/helpers/bitops.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/bitops.h>
+#include <linux/find.h>
 
 void rust_helper___set_bit(unsigned long nr, unsigned long *addr)
 {
@@ -21,3 +22,44 @@ void rust_helper_clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	clear_bit(nr, addr);
 }
+
+/*
+ * The rust_helper_ prefix is intentionally omitted below so that the
+ * declarations in include/linux/find.h are compatible with these helpers.
+ *
+ * Note that the below #ifdefs mean that the helper is only created if C does
+ * not provide a definition.
+ */
+#ifdef find_first_zero_bit
+__rust_helper
+unsigned long _find_first_zero_bit(const unsigned long *p, unsigned long size)
+{
+	return find_first_zero_bit(p, size);
+}
+#endif /* find_first_zero_bit */
+
+#ifdef find_next_zero_bit
+__rust_helper
+unsigned long _find_next_zero_bit(const unsigned long *addr,
+				  unsigned long size, unsigned long offset)
+{
+	return find_next_zero_bit(addr, size, offset);
+}
+#endif /* find_next_zero_bit */
+
+#ifdef find_first_bit
+__rust_helper
+unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
+{
+	return find_first_bit(addr, size);
+}
+#endif /* find_first_bit */
+
+#ifdef find_next_bit
+__rust_helper
+unsigned long _find_next_bit(const unsigned long *addr, unsigned long size,
+			     unsigned long offset)
+{
+	return find_next_bit(addr, size, offset);
+}
+#endif /* find_next_bit */
-- 
2.52.0




