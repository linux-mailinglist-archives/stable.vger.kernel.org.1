Return-Path: <stable+bounces-204637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C27CF3101
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 11:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AEF83014127
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B03330322;
	Mon,  5 Jan 2026 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fPgltwW4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445932FA12
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609858; cv=none; b=SFUiX8nCka0wnhh67mvdWBDmTDTuZgJOjLgWkufqfiRb86CXSlLQDNBLUANBvxICKu3vrLGm9fpWaldJJY+bv/pTYrVb4eQNTfVyLAT+C0NGmGbeCzsEwOwpUxm5NC08iGUoHs5Ak8LhCojBDrXz7F1Uwi1A0TrVVlNAGLoWQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609858; c=relaxed/simple;
	bh=1QO3DLk2yhnxowskNNFKMDzfjU/42K8tKMfyiZUya8Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a86jSZbTgoQ6cz5nFjepaPqYHx9fTi2oAxoZP53diF+qnEUf8Nz+zZ0uVuXHQWv0CeWepV2GUGoQJpgK9R7ndh4FeHRkFS8PnJUOO4rFPEdMvccfYJKtRy13CKp8eIFLZ1+5qfcwrxpQ/x1g1O4oZBGEe2ySdizrmMXyLGLcKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fPgltwW4; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-430fcb6b2ebso8461948f8f.2
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 02:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767609855; x=1768214655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iB7YE0l+vq3WW+DIqr0TlHXqLvKI5geObaEQMVL3pYo=;
        b=fPgltwW4iCduJR3FWFeUUZpJ+s00mFsCgGgyd+LfAHDNL8FmTJduhW7/NSpR4bU1Y7
         x6pwveZHRtSwmlR0Vvrnmg4Ed3nqJET7hOVhioJsDCtJPClOdbfmaCfdShrYH8Hna+HD
         nqhKikKXdD/F3UwUWROtG16pQuZaeuiKbCdSc1LD1OKdP0fC7YRrclONAGB/ahLU1Bz/
         mi2aRa2edyzYC7HDn0y2Ng4kax95T1jbGG8SCcrVr6VBBa4PbkMfDsyCTojQujcO5VR8
         YW6BdJApQiFOuDZXPHVdo7F1H1UxOFHx8NsBs0vc0SSVoSI5kdHp76ytkmhE17hCzmLx
         BcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767609855; x=1768214655;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iB7YE0l+vq3WW+DIqr0TlHXqLvKI5geObaEQMVL3pYo=;
        b=FJgwQbspD5GzzrsYsy5FLTZwloo0KTcSfkJxAkJVTJ9c6NlD40/8ofZVrGw/6NBEIt
         cv4g8r9/RGgekS54dN7eX4XruGQvBjVGegaM8P4D0azhbUZnUK3DPaXpzyYF5x17lZlH
         lxKIUaa75eCU8b48PNgeEC2HOEI6M2ZTETlIHcDsOYM1FYdLePTiuvV552bDllVoJq9s
         IWbVIfyLwQCaoiMWZTRx2d4FpTdoBQOMTzfQ1j/ZvGwr91J/tpGTxseOVkX7OOClef0U
         ZSuxkAptnbrIj+RM/Xp2B/yC+wWnHftsBnh5xjNgvzTtFTamfqz0NipU6qPCxgtnPoH6
         rszA==
X-Forwarded-Encrypted: i=1; AJvYcCXc6VqC7MhHDafE89zH212RpRtewWwSCY6GZXSHgpd35hcsZDs38rhWgOkrO8nrHZEzHTyK8Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTlAwnjUVrr5twjKwWg2nbmuvuhIhjn4NCBvoiUOokS0mTc2i
	4oSp9AqKZ+4QAKPaP6KU4jESENxDPEdjmNOQBGFYAYxopkMOJ/zgjN4+wFUZJrgBAgaEuDUCKCv
	9Zeig6yFhzgVwuVxwPA==
X-Google-Smtp-Source: AGHT+IGQ34WZFKVilT6HOUlgUQJo4didZl8RM/l4vnBrj2WM6URpfu7K3BIidVdMwnPvK5FgGd8Acedl+UGGZKU=
X-Received: from wrbck15.prod.google.com ([2002:a5d:5e8f:0:b0:42f:bb38:35d1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:609:b0:431:342:ad41 with SMTP id ffacd0b85a97d-4324e6fa1a7mr65299971f8f.61.1767609855242;
 Mon, 05 Jan 2026 02:44:15 -0800 (PST)
Date: Mon, 05 Jan 2026 10:44:06 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPWVW2kC/32NQQqDMBBFryKz7pQkEkO76j2KC2PGZMAmkoi0i
 Hdv6gG6fA/++zsUykwF7s0OmTYunGIFdWlgDEP0hOwqgxJKSyVatLympeDE0WGgeaGMSpOT1g5
 khIA6XDJN/D6jz75y4LKm/Dk/Nvmzf3ObRIla3lpHVhvTdQ+fkp/pOqYX9MdxfAFq2A2QtQAAA A==
X-Change-Id: 20251203-bitops-find-helper-25ed1bbae700
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4818; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=1QO3DLk2yhnxowskNNFKMDzfjU/42K8tKMfyiZUya8Q=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpW5X480DtzvVuRhPhMmNpQuoBcHD6YBnm8rwY9
 3CueU5yKtmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVuV+AAKCRAEWL7uWMY5
 RkIzEACet0+jmd3Fl7BK5lRdHUdojAeqaBxBt6BMkPlNfqaCrPurZiMy/2V/U6SCifYE4SKRXej
 UrP4wVCTZTWPjSedUUiJBdzVYMRpjoe+phjyjA1Hx0ovJ19aIm5ON0Vr8ImLOlMb2PgQSVC0EfB
 rozcRQquqabh9wC8r2WaI+iCc5LGHd3inCeh/+7QuXxODJNPFwwQlIUA/qhh5DHB8s8u2aCklNC
 gQsUaeds3Wim6XzAejMAu+oWeu1hktOJuKQLUJk20C3pJl1eFKqR2yyQVL5BP/2a0R9jQVVHvNt
 Ybf3jCOTNtM3FZXEa7bRYQ/wXE5caHxek3cBYCt5Mt5Tow7WCVJQUhhkFYREyIwsZfn/f4oIT7/
 uXfRrNZROsKKcBXXwuNvMh5w1ko7JRmlJloZTbY9p+lCYaYPJ/Otn1QaEPbDTuV1r86oiI41Hde
 BtL++DuSh3d/1T+OjOLxldLean7QdU1dMFqTZ/+hd9oZdBGsJiggBeXQGeV2+G3ZpN8qIiZqOP/
 brBnnD+1fcbUFRIuWkqkFf2BMIUp+ZeW87ak4c+Sqpr0kozAfVSAa/XVBHem/qrmVn2iUtkLoRw
 sOAQnP8Ktu6LxruX8IUiDGti9Gze6oQTYjG5DlIeCZMg2aoMdnwygeMVJhehf/fxu04H3qhxuSE JlK5Z1tfvRcksCw==
X-Mailer: b4 0.14.2
Message-ID: <20260105-bitops-find-helper-v2-1-ae70b4fc9ecc@google.com>
Subject: [PATCH v2] rust: bitops: fix missing _find_* functions on 32-bit ARM
From: Alice Ryhl <aliceryhl@google.com>
To: Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

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
when compiling Rust code. We do this by definining them in rust/helpers/
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

Cc: stable@vger.kernel.org
Fixes: 6cf93a9ed39e ("rust: add bindings for bitops.h")
Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/x/topic/x/near/561677301
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Remove rust_helper_ prefix from helpers.
- Improve commit message.
- The set of functions for which a helper is added is changed so that it
  matches arch/arm/include/asm/bitops.h
- Link to v1: https://lore.kernel.org/r/20251203-bitops-find-helper-v1-1-5193deb57766@google.com
---
 rust/helpers/bitops.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
index 5d0861d29d3f0d705a014ae4601685828405f33b..e79ef9e6d98f969e2a0a2a6f62d9fcec3ef0fd72 100644
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

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251203-bitops-find-helper-25ed1bbae700

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


