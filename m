Return-Path: <stable+bounces-217267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBXmAY6olWlVTAIAu9opvQ
	(envelope-from <stable+bounces-217267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:54:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 938F015623E
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60E14304F484
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E813530F931;
	Wed, 18 Feb 2026 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKsVbLsP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C730DEAD
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771415629; cv=none; b=X+j0eZ6bGNV9l8qA/f6q9sCJdO+3KHtt3HDZxqU7Rxq0CwhGgItpPAPUfjAxSPU9+ujapz71EVPe7Dwfr9Px7X+r9wGS5Y+aNLOxKh4a9US0WnNV89phXq2YELt34hBapG/zJuEglY8Iy8t0j4XsQ3Nw1GJrhbczrG473nNwZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771415629; c=relaxed/simple;
	bh=dxslJAb5KIt29+Pmlra1MsYzJUsqBlgsseUHaKRC00Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pIdNH5Rm/jb/uLpBtcu52dKAAgC2mht20eirHr1Iv9OpTuaRE/9jmV48troVwDSd0aC03JOEBh3fLlvWWXvstUro17yUjavIlqGPe9Xg6cXU+G9rjryjxv6+7acU5A3sx+nni/vymeAuxoii/MWQ2t9CngqwuUdv3Oi/eF2HmLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IKsVbLsP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso29298265e9.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 03:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771415626; x=1772020426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nREefhNbsS6m+NzCv8p/u3MUoT+tS1ddYgBqAgzIBg=;
        b=IKsVbLsP2kRnSGVyZ7gFXiqkELJYXkM4Y9t/+2Z83IeHfKMt8akYguBhpAgWP9z31C
         984VJZaCffFLZL5SvUWqH8nDeJxnRrb2+CKYfIrfHgkxx1E9Nd45yOlmDcWdGJhUMMzV
         caVi8lE//nApGsh6oAmSuE9RoettuU9SibY3qX+lDc3LmtF/Y9kEbAFJnIAj2QppTMBp
         lFQlVSbDCnMjTgqynDEIj5l7f0Ta5eg7yXFYQ7YpsUlmFAd0Zl2O4s7cm+9NatfuZBNE
         6XcqFG1Pc+lqNNNG3XfZs5zALj12Jdc2SHDS08scgRMDAmDbKK22jhsMkRJmw5cag4uK
         lK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771415626; x=1772020426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nREefhNbsS6m+NzCv8p/u3MUoT+tS1ddYgBqAgzIBg=;
        b=ahQawZPPLDQ9NYCmW0KYaXDzg2UVudJPgv6P8l8VrV3dTiEq8SHYGwrQNfo2m88aGW
         HtmY3oZiZl66K9aGKg/zRPN2skGhDnZYWBjdsUrRAWC/UuLTaVzJrjCL0GgwBRluy7TZ
         68MYsROwjDvbcwByJY7IFP+dqW8FEsbz63Sj/p7rsEmCsDhLrlsqVQcZzyk68MCdiikP
         Xib2qyIzcOcXTMmvYMY0yE1HOMDfasd4ZBkQ7vohNai/EvD3OwYBapZaqAbr4u7zd3l7
         6iO3EaNALldRtbs0cP4vfpLFXpqHNW+fw3NIebbChrSUAgpsUABlJMsvYhNBbvGvxybu
         tgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoTVBQ6pA/mxSwl0stHaf25hgs5jxrIyriFbuj0JTve4oACWDru7QWv7E5p3vVkziz23TDba4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8PNvndr/HLR8Nl3pLJzdOUWxYKU9GjA9Qzpj1ijlsbdWLmBY
	R3jSiJv1mo2fP4ymjIuzq67sQ4YH+NYKZ7rHhjV/UeO9ESjNxr9P0piT5+MLWccR5LgCHHtKK51
	FzIxKaJSENyZuz0s7fQ==
X-Received: from wmof9.prod.google.com ([2002:a05:600c:44c9:b0:477:988a:7675])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c25:b0:47d:3ead:7440 with SMTP id 5b1f17b1804b1-48379c14606mr212400745e9.32.1771415625987;
 Wed, 18 Feb 2026 03:53:45 -0800 (PST)
Date: Wed, 18 Feb 2026 11:53:27 +0000
In-Reply-To: <20260218-binder-vma-check-v2-0-60f9d695a990@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260218-binder-vma-check-v2-0-60f9d695a990@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2898; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=dxslJAb5KIt29+Pmlra1MsYzJUsqBlgsseUHaKRC00Q=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBplahFqqe27pmaRIiimlvXAoI7c4Aaeb8gzBCoW
 7sqLygMmP2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaZWoRQAKCRAEWL7uWMY5
 RiinD/93Hu+5kQo1qJcL+IetJ2vxyhhemT1hfThuvAADi5VceWTgLmJNepFXO7G77pW/2GeTBB3
 hglYyOoUtJStG2fdTUp+EutcYerAtSgpAnbhEpOIaMKO2Yes5W+M92MyD+6fyb2jpTNX29pujW0
 uca1oss6kBre/m26qiICetpHoL1NS1gN7YdP9JmrVujhz3kE+tFIJlMb+hNWp6ai7tdcn4gTSB9
 J9OLQvOEIMk/kiA0xLkm+5Gl/u+m5OBPNotZfvsSwjCFDHFAi76dii3zfnn0ogXbsk8Cng5gEkS
 CK49G2PrS5MB/lyNm8FVpbgDxUbHE4/HJ7qOJv7iBgDtBwkxpeW+4sWHaflHwSkyBMB0o06XkSy
 CcTe+B3ydUvhCe1jg0tUlmuCqtsRcBwEX4XonP13fIL3aJPniOO4Ofg5aT1emcncDjlovMuwzj6
 ChcMKSLOqtG2QV6h2HY6a7qu7ih04BkCqiTbRiQ3zKOKqB29seNh/1VwxImeQ3abXclaS/J87Xd
 uEk0oq0T080GYz/oSMJjJ9jLLpuinmaE6Y6d5KtexouBUr1Z2YA40lB77+roEZf/5v/XL+n/rVc
 Yc/ENTdwPvpAqKsnqxruyi+lhem8Kr5FlqNy93Krvh7d4uqyPNFvWixXuiZrM0Rb+RVZDF1DJ1I F2yQblZRdRGtoHQ==
X-Mailer: b4 0.14.2
Message-ID: <20260218-binder-vma-check-v2-2-60f9d695a990@google.com>
Subject: [PATCH v2 2/2] rust_binder: avoid reading the written value in
 offsets array
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Jann Horn <jannh@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217267-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 938F015623E
X-Rspamd-Action: no action

When sending a transaction, its offsets array is first copied into the
target proc's vma, and then the values are read back from there. This is
normally fine because the vma is a read-only mapping, so the target
process cannot change the value under us.

However, if the target process somehow gains the ability to write to its
own vma, it could change the offset before it's read back, causing the
kernel to misinterpret what the sender meant. If the sender happens to
send a payload with a specific shape, this could in the worst case lead
to the receiver being able to privilege escalate into the sender.

The intent is that gaining the ability to change the read-only vma of
your own process should not be exploitable, so remove this TOCTOU read
even though it's unexploitable without another Binder bug.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/thread.rs | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 1f1709a6a77abc1c865cc9387e7ba7493448c71d..a81910f4cedf9bf485bf1cf954b95aee6c122cfd 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1016,12 +1016,9 @@ pub(crate) fn copy_transaction_data(
 
         // Copy offsets if there are any.
         if offsets_size > 0 {
-            {
-                let mut reader =
-                    UserSlice::new(UserPtr::from_addr(trd_data_ptr.offsets as _), offsets_size)
-                        .reader();
-                alloc.copy_into(&mut reader, aligned_data_size, offsets_size)?;
-            }
+            let mut offsets_reader =
+                UserSlice::new(UserPtr::from_addr(trd_data_ptr.offsets as _), offsets_size)
+                    .reader();
 
             let offsets_start = aligned_data_size;
             let offsets_end = aligned_data_size + offsets_size;
@@ -1042,11 +1039,9 @@ pub(crate) fn copy_transaction_data(
                 .step_by(size_of::<u64>())
                 .enumerate()
             {
-                let offset: usize = view
-                    .alloc
-                    .read::<u64>(index_offset)?
-                    .try_into()
-                    .map_err(|_| EINVAL)?;
+                let offset = offsets_reader.read::<u64>()?;
+                view.alloc.write(index_offset, &offset)?;
+                let offset: usize = offset.try_into().map_err(|_| EINVAL)?;
 
                 if offset < end_of_previous_object || !is_aligned(offset, size_of::<u32>()) {
                     pr_warn!("Got transaction with invalid offset.");

-- 
2.53.0.310.g728cabbaf7-goog


