Return-Path: <stable+bounces-246402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHq9NW9vA2qI5wEAu9opvQ
	(envelope-from <stable+bounces-246402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:20:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE96F5275B6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56B9D3099053
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D145A3EDE55;
	Tue, 12 May 2026 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EjjsZt64"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21E25FA29;
	Tue, 12 May 2026 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609133; cv=none; b=jqIkH8VykXTRnpSQRyXfySFcgl15NmjNu8l7Vlpq+1W0csa6KQhw/6g2W55IIl2aC4bjVQxH32DEtDjvFCsMF9Q76vEbWBSCtaL1Tzo28MlGv+0xfBY1jLD0cZYujT2wOsPHMQh53B5jxHtPFMT8R9pEOuXlnCARCJlwYdKIb78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609133; c=relaxed/simple;
	bh=M6ydTwUiWTUG0tE0KbD/szBE402y6/fuzWJBjK5uglo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYPcQF7Cv2QLcAEfQ4RPDFIbsE38QM0OyCyO1osKh3Lyeq6Gdx2c/MI0KJRh3FSkif3Lp7Hcy4If7BPErAJZ/Unnv0fuGMR+nN5Oqmm0T1BnyzfNC3IM797ZzfdLNlXc/GCuNJOG3w7vbwcNgv/UHw9ZkC2Z4FSGuc6jTFfmU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EjjsZt64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243B2C2BCB0;
	Tue, 12 May 2026 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609133;
	bh=M6ydTwUiWTUG0tE0KbD/szBE402y6/fuzWJBjK5uglo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjjsZt64v+Z8nCB9wp9OYy32pIjVEl2k9ZDny0MWPKIIK4g41V1qP9F7JM6vrne8Z
	 kl8pbqnhkm0XWcQy0Db/ZmuK1cWii6UC39AdrHJ8C120Au2OwbqKkglYxjVYDlmDGt
	 FvUSO0k9lGswSlc1101dkYGsdR5faStrXm54J0/I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 7.0 079/307] rust: allow `clippy::collapsible_if` globally
Date: Tue, 12 May 2026 19:37:54 +0200
Message-ID: <20260512173941.787692975@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: EE96F5275B6
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246402-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,garyguo.net:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

commit 2adc8664018c1cc595c7c0c98474a33c7fe32a85 upstream.

Similar to `clippy::collapsible_match` (globally allowed in the previous
commit), the `clippy::collapsible_if` lint [1] can make code harder to
read in certain cases.

Thus just let developers decide on their own.

In addition, remove the existing `expect` we had.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/rust-for-linux/DGROP5CHU1QZ.1OKJRAUZXE9WC@garyguo.net/
Link: https://rust-lang.github.io/rust-clippy/master/index.html#collapsible_if [1]
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260426144201.227108-2-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile                                    |    1 +
 drivers/android/binder/range_alloc/array.rs |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/Makefile
+++ b/Makefile
@@ -486,6 +486,7 @@ export rust_common_flags := --edition=20
 			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::as_underscore \
 			    -Wclippy::cast_lossless \
+			    -Aclippy::collapsible_if \
 			    -Aclippy::collapsible_match \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
--- a/drivers/android/binder/range_alloc/array.rs
+++ b/drivers/android/binder/range_alloc/array.rs
@@ -204,7 +204,6 @@ impl<T> ArrayRangeAllocator<T> {
         // caller will mark them as unused, which means that they can be freed if the system comes
         // under memory pressure.
         let mut freed_range = FreedRange::interior_pages(offset, size);
-        #[expect(clippy::collapsible_if)] // reads better like this
         if offset % PAGE_SIZE != 0 {
             if i == 0 || self.ranges[i - 1].endpoint() <= (offset & PAGE_MASK) {
                 freed_range.start_page_idx -= 1;



