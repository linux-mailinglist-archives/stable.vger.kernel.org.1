Return-Path: <stable+bounces-170046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0BBB2A084
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5260B7B4BD7
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A63B2E2293;
	Mon, 18 Aug 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqMP/AJu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2C52E2290
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516635; cv=none; b=TfDSCtdbCLXq8q/qYbfUaViZpKA9c/OhgAlXOVLy09tzmfD5/ZQ9AeXWLh8QjpL8tcid/b0HrDQf1gw0xkzPyebcLqwoMpC2/wj+A9RkMr17qH15idpTL5kKdeBJags74xx2eWwov9T8PUIZsQBpAJTnkPVTpfDPwyTJo5f7yeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516635; c=relaxed/simple;
	bh=f1VLnziEchSqIKSHjNXeno1l34dCi5Rr4Bgm5603OrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNie71ZAjxyMx/7c/eAOfn3sx+LtODsi/5T7q25Y0dgs5TsZ+yTBHKkolt+r59Ckddog60HEi7hmIZfsKl2Rc9YNYHP8uKGB1uXBDoq1PYNTD6zGPAthTeuVZ2ZdWoGd2COBeLFzYzN+aZGNYdknwJeC7D6jspmDrZgmQx5sHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqMP/AJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84C8C4CEF1;
	Mon, 18 Aug 2025 11:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755516634;
	bh=f1VLnziEchSqIKSHjNXeno1l34dCi5Rr4Bgm5603OrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RqMP/AJuPchnotxzXVcbwCNzaUEC5oFvH2kEK6MHE96ax8+xem9idGAJzc3Sy25op
	 OWubpmd4HFoEsVhoT7EmeMRGWTubotL22GrPAPgyr662Ss2AotsDkNAcUkvKIV/ubF
	 vpP6dH+7JTQgoDbpMs0OK9EbTCrZy8gsNf/YOonQHJIbzqi9dDwDuWtMaLIxqJuebe
	 krl0AcahLcWBhDWew++y0cVu5YwNDFake6dGMXQ9VdPFLgq4NXtRq1qkxIGkNZBhcW
	 iuE3W4f7L3lnyZNxBc6eT4CypsM1xqODCHdCf4SSsKRLLOaSTgg64aRkc2ojueJSG5
	 oexrlL0PzHWsw==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH 6.12.y] rust: workaround `rustdoc` target modifiers bug
Date: Mon, 18 Aug 2025 13:30:25 +0200
Message-ID: <20250818113025.2845480-1-ojeda@kernel.org>
In-Reply-To: <2025081813-overhand-resolute-c0f3@gregkh>
References: <2025081813-overhand-resolute-c0f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Rust 1.88.0 (released 2025-06-26), `rustdoc` complains
about a target modifier mismatch in configurations where `-Zfixed-x18`
is passed:

    error: mixing `-Zfixed-x18` will cause an ABI mismatch in crate `rust_out`
      |
      = help: the `-Zfixed-x18` flag modifies the ABI so Rust crates compiled with different values of this flag cannot be used together safely
      = note: unset `-Zfixed-x18` in this crate is incompatible with `-Zfixed-x18=` in dependency `core`
      = help: set `-Zfixed-x18=` in this crate or unset `-Zfixed-x18` in `core`
      = help: if you are sure this will not cause problems, you may use `-Cunsafe-allow-abi-mismatch=fixed-x18` to silence this error

The reason is that `rustdoc` was not passing the target modifiers when
configuring the session options, and thus it would report a mismatch
that did not exist as soon as a target modifier is used in a dependency.

We did not notice it in the kernel until now because `-Zfixed-x18` has
been a target modifier only since 1.88.0 (and it is the only one we use
so far).

The issue has been reported upstream [1] and a fix has been submitted
[2], including a test similar to the kernel case.

  [ This is now fixed upstream (thanks Guillaume for the quick review),
    so it will be fixed in Rust 1.90.0 (expected 2025-09-18).

      - Miguel ]

Meanwhile, conditionally pass `-Cunsafe-allow-abi-mismatch=fixed-x18`
to workaround the issue on our side.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Closes: https://lore.kernel.org/rust-for-linux/36cdc798-524f-4910-8b77-d7b9fac08d77@oss.qualcomm.com/
Link: https://github.com/rust-lang/rust/issues/144521 [1]
Link: https://github.com/rust-lang/rust/pull/144523 [2]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20250727092317.2930617-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
(cherry picked from commit abbf9a44944171ca99c150adad9361a2f517d3b6)
---
 rust/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/Makefile b/rust/Makefile
index 17491d8229a4..dc1ec2e077e1 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -55,6 +55,10 @@ core-cfgs = \
 
 core-edition := $(if $(call rustc-min-version,108700),2024,2021)
 
+# `rustdoc` did not save the target modifiers, thus workaround for
+# the time being (https://github.com/rust-lang/rust/issues/144521).
+rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),-Cunsafe-allow-abi-mismatch=fixed-x18)
+
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
@@ -63,6 +67,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 		-Zunstable-options --generate-link-to-definition \
 		--output $(rustdoc_output) \
 		--crate-name $(subst rustdoc-,,$@) \
+		$(rustdoc_modifiers_workaround) \
 		$(if $(rustdoc_host),,--sysroot=/dev/null) \
 		@$(objtree)/include/generated/rustc_cfg $<
 
@@ -175,6 +180,7 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
 		--extern bindings --extern uapi \
 		--no-run --crate-name kernel -Zunstable-options \
 		--sysroot=/dev/null \
+		$(rustdoc_modifiers_workaround) \
 		--test-builder $(objtree)/scripts/rustdoc_test_builder \
 		$< $(rustdoc_test_kernel_quiet); \
 	$(objtree)/scripts/rustdoc_test_gen
-- 
2.50.1


