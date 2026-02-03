Return-Path: <stable+bounces-213263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJUzNTAMgmmCOQMAu9opvQ
	(envelope-from <stable+bounces-213263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:54:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA8DDAD79
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2377B30947F9
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A6395DAF;
	Tue,  3 Feb 2026 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJXmnnbG"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A8394486
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130136; cv=none; b=UvWK3D7haG4JQOa/fhERH5bF+6+dQ174ZAA+41MP/9v8v/i7Vdi46++IMxVVSSeHNM3Du94lu/e37+73v2riUvOHEfKORR4UwRlIxRCpEO4/boPf+XgIKUW8hDQwwKzmtcKIJN5Ri3Ij47lfHw9I2XuIDLZKAQ7xKpJJf0UKz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130136; c=relaxed/simple;
	bh=ZWNMIok2mtbaI2PfdQpsK+ox9X80WS5ALkwyK2qpfR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrYVRh9ls3qig5y5rEtJpoDgC0BX0u7AOGXMtyfEfmHZf8WK8QeNKXAWR1L3/Gev98j184l95/lMx4lphTKNoa/bj/VsnbuCPIsVhaXHYhG6+g9gll++QNdXaXWt+/8yqKt/jBd1ZMK09iJbTbBmfnESvWzhFm/6joKb51y06zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJXmnnbG; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45c7c841904so3819666b6e.3
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 06:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770130133; x=1770734933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8iLbQX1XIXI1v0KLe0qd86D4q9L/49u2ODU5DqPEiU=;
        b=VJXmnnbGQZkZ6Yt2HNy1Qy/Ioy19C7bhNXIKKtsE3JaAzOBzdowBHJg1ZGpk6vjvvQ
         cxO+KNxPvnxLpg8qnAWwno1CXvuoPTnEMzObYrnM1YaTjljGKXTRYkIDvvTAsdvuvuTs
         F9QuXm1B/VqessOMrtsLyrljzfbsr9RHRNhsx8hJKEGX6KZoQ3GxymGuZEeHU92NziG5
         TNyIt8sWNEgXj40Q355kNXcNtQ8WacbE1WOff/079Nx6InW2UZWuZHnOdpwmpAbggAct
         2vt7+XsHX4VRlazsYNidMFX34dIoh8gbJHQHkVt1aTSLZqhHY4JWroBrlIl6ck9uoCB9
         l+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770130133; x=1770734933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V8iLbQX1XIXI1v0KLe0qd86D4q9L/49u2ODU5DqPEiU=;
        b=Gf++YIhBJOHZRx9HdCNo9Pc8v43gd3qmpEzkIKCArPV+Yg9tDtjh9xgAeZUZUx6J7P
         Xdm3OR5FKleMUcHAm68UYjnNKuMdcpgPP5jMboh8jIoZJNy0g2uzoKCSCJ6Zeq87mftR
         VxRpuvoOmhmxb7qvf+Amn1H9865hzpdo0wtoB1QR/GKXeyhxNfLwyVMA1hI4N/TZFtSU
         dxyqkcv0Z5ftrsRMzHohaBctVUqnC6mOoEgwKCDOoE0EWxIoTXuKPIHC44kRKaYCttI+
         xqPKXBRRqASGgw9w98d8/7TlIqf3EnN3DAfru0EUoDRKQJES732E2GIivcaBy3w3Cn2I
         XV8g==
X-Forwarded-Encrypted: i=1; AJvYcCWXtyWe1oB8XqzWitdIvbsgb8hM/lHoBAPsqsjq49/q807BMNpA9/QB6BLwdi43JPoHZsxwzz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOMDYQ9cHNFsKTxEfw1/w7lrELewVFRaRfBVAUzEaCO6XTkQIk
	zEWviMp4laNCrToId25jB6E2HP4x9LSkkqxxPyqIkjAImdOV9vLGpVQN
X-Gm-Gg: AZuq6aIcmN81T0M0y7H5mPrQNa6PLSWgtXEl/W277K6jU8Irqmo1bzW9Q+3nnTJcZS0
	SyWox9jBgGexfGT/9p14oOxX7Gyd6ftsmTrnHfr82MpfCsqN15moAZg9pbJ9uaHf6HjVhrehLCM
	NhkYvuyvm0hozJsR9YJDq2Pag2O36IyJVY+aOijtF9QnO/IoqtlVn3Vxk1ibETcmDaQJFRpFt9n
	E0EXwq/Ccker0eA20VySUZkpi6zYej3FHheGVcwgPHUZkdtVLOMSw8CF4Jn7aQyh8g/+gszgJtf
	tYp7eebcOzgKdq1RfSHZECPrzpkk28D+ERR6gIw76WxETx6nJqKbHuBi+7bXZIJCnN1HBB/N/fP
	2UMHfeZGMrDvzyZE1Fpr8wOqBLfGi7G3MRg0dck/V/NqseN0RG3BM8b7jy95kSCYC1LPD4hnYz7
	FY/C5F5XN5FFr1pA==
X-Received: by 2002:a05:6808:4702:b0:459:9961:5114 with SMTP id 5614622812f47-45f34bcc989mr6716499b6e.16.1770130133211;
        Tue, 03 Feb 2026 06:48:53 -0800 (PST)
Received: from misys ([58.120.241.145])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-409575f6551sm13788352fac.22.2026.02.03.06.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:48:52 -0800 (PST)
From: HeeSu Kim <mlksvender@gmail.com>
To: nathan@kernel.org
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@google.com,
	charmitro@posteo.net,
	dakr@kernel.org,
	gary@garyguo.net,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	nsc@kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	HeeSu Kim <mlksvender@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] rust: Makefile: bound rustdoc workaround to affected versions
Date: Wed,  4 Feb 2026 08:48:43 +0900
Message-ID: <20260203234843.2834885-1-mlksvender@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203005627.GB52989@ax162>
References: <20260203005627.GB52989@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	DATE_IN_FUTURE(4.00)[8];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-213263-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[kernel.org,google.com,protonmail.com,posteo.net,garyguo.net,vger.kernel.org,gmail.com,umich.edu];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlksvender@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AA8DDAD79
X-Rspamd-Action: no action

The `-Cunsafe-allow-abi-mismatch=fixed-x18` workaround was added to
handle a rustdoc bug where target modifiers were not properly saved [1].

This bug was fixed in Rust 1.90.0 [2]. Restrict the workaround to only
apply for Rust 1.88.x and 1.89.x versions that are affected by the
bug, preserving ABI compatibility checks on newer compiler versions.

Add `rustc-max-version` macro to `scripts/Makefile.compiler` for
version upper bound checks, mirroring the existing `rustc-min-version`.

Link: https://github.com/rust-lang/rust/issues/144521 [1]
Link: https://github.com/rust-lang/rust/pull/144523 [2]
Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/rust-for-linux/DG4JM9PU51M0.1YRGM9HVTY24U@garyguo.net/
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/rust-for-linux/CANiq72n39eU9WE=Yh0_yJzmqMxo=QAaU2pN0UqP9jZ7bT7rhgA@mail.gmail.com/
Cc: stable@vger.kernel.org # Useful in 6.18.y and later.
Signed-off-by: HeeSu Kim <mlksvender@gmail.com>
---
Changes in v4:
- Add rustc-max-version macro for cleaner version bounds
- Use rustc-max-version instead of test-lt for readability

Changes in v3:
- Remove Fixes: tag (this is a feature, not a fix)
- Use full URLs with Link: tags instead of GitHub-style references
- Add Link: to lore.kernel.org for Suggested-by attribution
- Add Cc: stable for potential backporting to 6.18.y

Changes in v2:
- Change approach: bound to affected Rust versions instead of ARM64-only
  (the flag is simply ignored on non-ARM64 architectures)

 rust/Makefile             | 3 ++-
 scripts/Makefile.compiler | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 5c0155b83454..1e8a75bc2878 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -136,7 +136,8 @@ pin_init-flags := \
 
 # `rustdoc` did not save the target modifiers, thus workaround for
 # the time being (https://github.com/rust-lang/rust/issues/144521).
-rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),-Cunsafe-allow-abi-mismatch=fixed-x18)
+# The bug was fixed in Rust 1.90.0, so only apply for 1.88.x and 1.89.x.
+rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),$(if $(call rustc-max-version,108999),-Cunsafe-allow-abi-mismatch=fixed-x18))
 
 # Similarly, for doctests (https://github.com/rust-lang/rust/issues/146465).
 doctests_modifiers_workaround := $(rustdoc_modifiers_workaround)$(if $(call rustc-min-version,109100),$(comma)sanitizer)
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index ef91910de265..85268f6f1494 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -71,6 +71,10 @@ clang-min-version = $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
 # Usage: rustc-$(call rustc-min-version, 108500) += -Cfoo
 rustc-min-version = $(call test-ge, $(CONFIG_RUSTC_VERSION), $1)
 
+# rustc-max-version
+# Usage: rustc-$(call rustc-max-version, 109000) += -Cfoo
+rustc-max-version = $(call test-le, $(CONFIG_RUSTC_VERSION), $1)
+
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
 ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
-- 
2.52.0


