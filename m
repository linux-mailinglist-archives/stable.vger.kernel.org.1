Return-Path: <stable+bounces-41634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8418B5662
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB55F1F21B8B
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F463D961;
	Mon, 29 Apr 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AgR+g8su"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882B1EB2F
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389673; cv=none; b=hN5+kZnDrxbwm0oYunrLppw76vdQX9Q6HIOAmShBeUwBGxBtLW3oPhWf9c3Zd+8kpjneMnGcGgSnYX1nUPJRHyu/pfO2yCQsEjL8wt2Vd1HglrBgR7f0YKQkjnySr4M2QPQprHlZgubZi2dxSBH4D8Ku9P31LPUDksAKIUWL0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389673; c=relaxed/simple;
	bh=4FKLf2k/jaqEb3qjoZ7bvegY4se0MZXwmrsQhv8NFUk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ER4qidHoFhXXFTYsXizXOfoC8Hg5Ax4fxoYva7byOfRJHhqDPXCGbBsvxHD5/fY1Onxqpfcwc3XSedAwhSptgRtf3TAbWbsbIijTV8xx9+nTz7C+uX8VOAk38aiWarMy6ZX5Pd2L2uwWZRJJUTbus4z0JjBfKklhXBFXmjZ+0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AgR+g8su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A269C113CD;
	Mon, 29 Apr 2024 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389672;
	bh=4FKLf2k/jaqEb3qjoZ7bvegY4se0MZXwmrsQhv8NFUk=;
	h=Subject:To:Cc:From:Date:From;
	b=AgR+g8suUQJl+M82u4k+owngCce2qUHSxZRh8l/ElnlVOMnyCRTM5TUs0QCRMTYkD
	 UOUN9lk0QHN7o3x+CkyQus9GukpgXtXESaE4ybEwUDMdgVkLEQNbR392VI3n0pElq+
	 VwHEa4tBxWYMLilyFxcnOMmhjhyMvGjGEx68ASO4=
Subject: FAILED: patch "[PATCH] kbuild: rust: force `alloc` extern to allow "empty" Rust" failed to apply to 6.1-stable tree
To: ojeda@kernel.org,aliceryhl@google.com,daniel.almeida@collabora.com,gary@garyguo.net,julian.stecklina@cyberus-technology.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:21:09 +0200
Message-ID: <2024042909-whimsical-drapery-40d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ded103c7eb23753f22597afa500a7c1ad34116ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042909-whimsical-drapery-40d1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

ded103c7eb23 ("kbuild: rust: force `alloc` extern to allow "empty" Rust files")
295d8398c67e ("kbuild: specify output names separately for each emission type from rustc")
16169a47d5c3 ("kbuild: refactor host*_flags")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ded103c7eb23753f22597afa500a7c1ad34116ba Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Mon, 22 Apr 2024 11:06:44 +0200
Subject: [PATCH] kbuild: rust: force `alloc` extern to allow "empty" Rust
 files

If one attempts to build an essentially empty file somewhere in the
kernel tree, it leads to a build error because the compiler does not
recognize the `new_uninit` unstable feature:

    error[E0635]: unknown feature `new_uninit`
     --> <crate attribute>:1:9
      |
    1 | feature(new_uninit)
      |         ^^^^^^^^^^

The reason is that we pass `-Zcrate-attr='feature(new_uninit)'` (together
with `-Zallow-features=new_uninit`) to let non-`rust/` code use that
unstable feature.

However, the compiler only recognizes the feature if the `alloc` crate
is resolved (the feature is an `alloc` one). `--extern alloc`, which we
pass, is not enough to resolve the crate.

Introducing a reference like `use alloc;` or `extern crate alloc;`
solves the issue, thus this is not seen in normal files. For instance,
`use`ing the `kernel` prelude introduces such a reference, since `alloc`
is used inside.

While normal use of the build system is not impacted by this, it can still
be fairly confusing for kernel developers [1], thus use the unstable
`force` option of `--extern` [2] (added in Rust 1.71 [3]) to force the
compiler to resolve `alloc`.

This new unstable feature is only needed meanwhile we use the other
unstable feature, since then we will not need `-Zcrate-attr`.

Cc: stable@vger.kernel.org # v6.6+
Reported-by: Daniel Almeida <daniel.almeida@collabora.com>
Reported-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/x/near/424096982 [1]
Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
Link: https://github.com/rust-lang/rust/issues/111302 [2]
Link: https://github.com/rust-lang/rust/pull/109421 [3]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/r/20240422090644.525520-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index baf86c0880b6..533a7799fdfe 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -273,7 +273,7 @@ rust_common_cmd = \
 	-Zallow-features=$(rust_allowed_features) \
 	-Zcrate-attr=no_std \
 	-Zcrate-attr='feature($(rust_allowed_features))' \
-	--extern alloc --extern kernel \
+	-Zunstable-options --extern force:alloc --extern kernel \
 	--crate-type rlib -L $(objtree)/rust/ \
 	--crate-name $(basename $(notdir $@)) \
 	--sysroot=/dev/null \


