Return-Path: <stable+bounces-192779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A4CC42DF3
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 15:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56186188F67C
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03002153FB;
	Sat,  8 Nov 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic8tssL4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE25B2139CE
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610635; cv=none; b=LmJJ262aNCT8c65zTnMQCMfYlOBLEz/Bqyd27aPWWrPHIREnLOmdBnIDUCxykanL32yH/V12mCWWM3F0nRwrgE7olxCEL9TsnSNHH7i2WqpnpiGNXFx9Z/Mu+YgfJa0PAWwcbanzUN4Wdj7R/pKrgUp8C9+YnHbkq1BghJvNkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610635; c=relaxed/simple;
	bh=nxKlvALyC4XTaCooCD+7QWxZzYumcDofoMI4P8YYTeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHgSDdOyZzzi/7pEQbqXgS4jizfa8WCDJCPCjwSQl0SvfujqrmC2Ix7aO0RKcaT/F8b6Cu023mBW7U4AgoCVM5cTlKur51uL5DZDLYDnh3h9urVkxj/oFJI3XhOyKulH+ldRUoTL57UW4nhCB6DPUkuOrkdpV3njAtFA/pL7MZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic8tssL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6AAC116C6;
	Sat,  8 Nov 2025 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762610635;
	bh=nxKlvALyC4XTaCooCD+7QWxZzYumcDofoMI4P8YYTeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ic8tssL4lQfdcim58C/9gkf4anEf54fXBlqygH6Rdzkw5milT7cWIhj23pz0V0e9X
	 N1TNy8BpxjXee5zUTHQaeplkHHL6Ko1eXmPbI57h9cRKfwVIEIgwbWefIKzN4ZDJPW
	 RicyZcO6sVhY+672eqVvDDAGaQmQ+F8cS1lPI4P0GSDNQllh/hWuFLC4Gz2Rm3MuEB
	 DV95H9xKwpqdm2o685bjE5Jz90fJtHphHHlRrtMVLrM0LkHnE482V7cmQocSBVbQFa
	 +UwjOw/9n+MXxwKDcs4XNJDwNm4Apt2aFlDDO3KH2nu19jph86pRyrI55pCyMAok8Y
	 m3IpW2a230xGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] rust: kbuild: workaround `rustdoc` doctests modifier bug
Date: Sat,  8 Nov 2025 09:03:52 -0500
Message-ID: <20251108140352.127731-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110805-fame-viability-c333@gregkh>
References: <2025110805-fame-viability-c333@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit fad472efab0a805dd939f017c5b8669a786a4bcf ]

The `rustdoc` modifiers bug [1] was fixed in Rust 1.90.0 [2], for which
we added a workaround in commit abbf9a449441 ("rust: workaround `rustdoc`
target modifiers bug").

However, `rustdoc`'s doctest generation still has a similar issue [3],
being fixed at [4], which does not affect us because we apply the
workaround to both, and now, starting with Rust 1.91.0 (released
2025-10-30), `-Zsanitizer` is a target modifier too [5], which means we
fail with:

      RUSTDOC TK rust/kernel/lib.rs
    error: mixing `-Zsanitizer` will cause an ABI mismatch in crate `kernel`
     --> rust/kernel/lib.rs:3:1
      |
    3 | //! The `kernel` crate.
      | ^
      |
      = help: the `-Zsanitizer` flag modifies the ABI so Rust crates compiled with different values of this flag cannot be used together safely
      = note: unset `-Zsanitizer` in this crate is incompatible with `-Zsanitizer=kernel-address` in dependency `core`
      = help: set `-Zsanitizer=kernel-address` in this crate or unset `-Zsanitizer` in `core`
      = help: if you are sure this will not cause problems, you may use `-Cunsafe-allow-abi-mismatch=sanitizer` to silence this error

A simple way around is to add the sanitizer to the list in the existing
workaround (especially if we had not started to pass the sanitizer
flags in the previous commit, since in that case that would not be
necessary). However, that still applies the workaround in more cases
than necessary.

Instead, only modify the doctests flags to ignore the check for
sanitizers, so that it is more local (and thus the compiler keeps checking
it for us in the normal `rustdoc` calls). Since the previous commit
already treated the `rustdoc` calls as kernel objects, this should allow
us in the future to easily remove this workaround when the time comes.

By the way, the `-Cunsafe-allow-abi-mismatch` flag overwrites previous
ones rather than appending, so it needs to be all done in the same flag.
Moreover, unknown modifiers are rejected, and thus we have to gate based
on the version too.

Finally, `-Zsanitizer-cfi-normalize-integers` is not affected (in Rust
1.91.0), so it is not needed in the workaround for the moment.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust/issues/144521 [1]
Link: https://github.com/rust-lang/rust/pull/144523 [2]
Link: https://github.com/rust-lang/rust/issues/146465 [3]
Link: https://github.com/rust-lang/rust/pull/148068 [4]
Link: https://github.com/rust-lang/rust/pull/138736 [5]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
Link: https://patch.msgid.link/20251102212853.1505384-2-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
[ added --remap-path-prefix comments missing in stable branch ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 07c13100000cd..bd1d21f116e30 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -59,6 +59,8 @@ core-edition := $(if $(call rustc-min-version,108700),2024,2021)
 # the time being (https://github.com/rust-lang/rust/issues/144521).
 rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),-Cunsafe-allow-abi-mismatch=fixed-x18)
 
+# Similarly, for doctests (https://github.com/rust-lang/rust/issues/146465).
+doctests_modifiers_workaround := $(rustdoc_modifiers_workaround)$(if $(call rustc-min-version,109100),$(comma)sanitizer)
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
@@ -183,7 +185,7 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
 		--extern bindings --extern uapi \
 		--no-run --crate-name kernel -Zunstable-options \
 		--sysroot=/dev/null \
-		$(rustdoc_modifiers_workaround) \
+		$(doctests_modifiers_workaround) \
 		--test-builder $(objtree)/scripts/rustdoc_test_builder \
 		$< $(rustdoc_test_kernel_quiet); \
 	$(objtree)/scripts/rustdoc_test_gen
-- 
2.51.0


