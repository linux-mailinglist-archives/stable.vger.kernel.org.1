Return-Path: <stable+bounces-254585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JWHHTb2FmrUywcAu9opvQ
	(envelope-from <stable+bounces-254585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:48:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB53B5E551F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A56DF3000A67
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0E63E958D;
	Wed, 27 May 2026 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QPzUUUfX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E223B0AD8
	for <stable@vger.kernel.org>; Wed, 27 May 2026 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889288; cv=none; b=ETVGhukutecZGY5hkyKWJSJRp3hmZ5Pa7l5ulAe4x5Col42LAjb2nKBLlURO4wQATXA1wmYpOBBUFhjSpJLZntWxqoGc42TencMMIR5mIh6q7l6MXfDNHnRp0+80vICp2u8OpD9n5afZ5BEwVVoPK84MZNJY9VkVApD3eCRHFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889288; c=relaxed/simple;
	bh=LeUS4h0dAZFMR118R/wSEgBwYTGlXM0bV41TWFIWpWU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NLWS7VX7P4pH9FxxPePNrGdctnGqeClR1lCmrammv0KW/qUVv/ndmxECDMG70TR3VPhYbvQ6GYOvm4rcdwuOpX51fBlnxqiHOSuFNIbGWnwYBtfPRMClmbUSrtpFAZxZgPBzVd/o1dBiqwzsQYoHjiEJjtRm+/CGyp1y2JDFxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QPzUUUfX; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45ea38c03a1so5543079f8f.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779889285; x=1780494085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EcF/LO4YfqSS2ARnboxZ+flFU1P58FX+oV9Y6yXSPGM=;
        b=QPzUUUfXNA75XB2cKHJro7FlP4gjZO2bWI6bFyFMkajWbV5sVWJGdV6/3T3s4lO06P
         ugAWMMMfdVopiZ81stH6mhrwFAmcu65vl4xP0c5dPSUDu7xa4DGEA/zaG9/ULGjzHbGa
         IbaPiBrOrRL7xJ/2G5xfibmn10AihfZCy0Ax3Rs5iYPiopmThfiD+fuDV87CPUIwp3DA
         VRu/iKvpDmD7T37w91gkliYCsWcHQ9Pfibi5AFHUM2U2TIdjqWcEW4DbiAvNySAZkSdx
         oF47gpPQwVO/Kq7td2dq+/ZDUOuqIjSHHN9x2eUyOCshiwc5I23uhj4Ik+2OCVOuNfH0
         1xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779889285; x=1780494085;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcF/LO4YfqSS2ARnboxZ+flFU1P58FX+oV9Y6yXSPGM=;
        b=lNGWJTR01I3zj3b+ifOUgD/ujmB/vcoUn3kG8YSm61hD0l+jXT1YqfmALI/NFZ7Vg5
         uIWhwPoghtq9ipP3ptA3vAKJacG4LBFpqJ7DI23x3Ofugps5ub4gra9UpvhHSBOyRayL
         KmtPsz2jDgI04mYU2EenoV74czp1L4uRn2W9okmpX1x5SRYU3zlrFa4QlTwRF2qiwFci
         LU/fplDo5OWn7F37Yl5acSo3Nm48kjzEUALu6mn/wViqwvogRSc0/2KJw8woKpd8oaVD
         +ysV2U+VoAOXk8bhZy+SBKHg6MGdD58+j4hKId0Yz2AKdDmXF9SwkMWpc5axXzaUMEv3
         vXjw==
X-Forwarded-Encrypted: i=1; AFNElJ8cwINWf71Tvbp+CEEdQW0EcI2vizVy5nD+qbPk5qFKXDnxqQ63Mu3OWpks2ZUGLb08bFbHyIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmlFKIecevSwGqLUJ6Z0kG5+LcxoJcZJ21NLKCT5uAsMO0XxJ
	D6VjvGEWPK1SQZGbjmJsa+CxMMhKe9arU93qS3oEZHc0BH/eDLawYXOj6b1gg0c/BJqjuqrp/N0
	Lv9aIld49lpQRmCruJQ==
X-Received: from wrrw11.prod.google.com ([2002:adf:f9cb:0:b0:44c:2fb:a56c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:25e1:b0:449:9aee:4575 with SMTP id ffacd0b85a97d-45eb389fd2emr36824679f8f.30.1779889284888;
 Wed, 27 May 2026 06:41:24 -0700 (PDT)
Date: Wed, 27 May 2026 13:41:18 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAH30FmoC/x3MMQqAMBAF0avI1i7EiBG9iliI+eo2iWxEhODdD
 ZavmMmUoIJEY5VJcUuSGAqauqL1WMIOFl9M1lhnOttzwsV4LgQPz1CNyrDr0vYwbnCeSngqNnn +6TS/7wf4nJJtZAAAAA==
X-Change-Id: 20260527-set-extended-error-e2ca37e0696d
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=LeUS4h0dAZFMR118R/wSEgBwYTGlXM0bV41TWFIWpWU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqFvR/cIwJ0wIRo2NQEAKrPozLiXiTML/lhWcRV
 WH7CV39rqGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCahb0fwAKCRAEWL7uWMY5
 RmM2EACCfg3cMc8eTmm9+Vj1Co70ZV4OI/h8ofoPKZcYPgyk63W7RVd1lnt9zATusgigW4J7A8U
 +tK1KyqX2nWARqYb8Ini5VYVHjSs3w5bh49MDYkNpwurp1tREB/MDas4ASZrNvmeTzkJwDAXSng
 K+tATFxQfSjhHHFHVnRnXE9kjjilP9YjDr9jnQ4yh2W2Wr6ZLG7WF9QR6SAp0HnUgWcgfwp0ZT6
 SCEexi9rzTZq0FMUUiBKUwU1cJajEhpeGU+J/jFne0MW9qnXf3IItrPlrbyjswu5009vTqZIKEM
 BvbWSibmYISxJzqulX7Jp3YfrrcPceIz11BZ+9B9F91ePsPc0Q7iU/e54il1DkF29Fg5QvdgJac
 lyMJh4YR70q7MAWVEMfM/cFH1wCEahUvyyzdDEcnK2MpDxRUEPxSLp8etqDP/4A1Apj83Nz1C8J
 8st2n6a43+h+nGtTAE6gqrzXZXPemUZMEpI1ueL1SzMxBwbWcmZHNCwfPUHkV+FO3Lt3mkYYGwI
 IJydN40W3esfD+xsIJ2IkRsMqwUOcXHwLziVcQ5N2U4s4KggbioVJGu1J7W28WUi4AIADXUE/ar
 vq5NVFp9GPI281pXDUuc7mkBjSrMSZ8v120U7Yatmky1vwGXSHQMmC0KDAI0i5eRcvKCKX5IT6z Kc2EpQ1+MKk84ew==
X-Mailer: b4 0.14.3
Message-ID: <20260527-set-extended-error-v1-1-407b4b466035@google.com>
Subject: [PATCH] rust_binder: fix setting the extended_error
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254585-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CB53B5E551F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This code currently copies the ExtendedError struct to the stack,
modifies the copy, and then doesn't modify the original. Thus, fix it.
Clearly nobody actually uses this feature, because nobody noticed that
this is broken until they tried changing userspace to make some errors
fatal.

A test in userspace is being added along with this change.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/thread.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 97d5f31e8fe3..0c74436c4e62 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1249,9 +1249,9 @@ fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Resu
                 info.reply = err.reply;
 
                 {
-                    let mut ee = self.inner.lock().extended_error;
-                    ee.command = err.reply;
-                    ee.param = source.to_errno();
+                    let mut inner = self.inner.lock();
+                    inner.extended_error.command = err.reply;
+                    inner.extended_error.param = source.to_errno();
                 }
 
                 pr_warn!(

---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260527-set-extended-error-e2ca37e0696d

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


