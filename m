Return-Path: <stable+bounces-121455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EC7A57528
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 23:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A1418992A8
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 22:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD3D23FC68;
	Fri,  7 Mar 2025 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iR0+v/7g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9E18BC36;
	Fri,  7 Mar 2025 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387836; cv=none; b=CmntaRfzbeRU3ClaQCG2eYIezISLzLboNkW6EMVwKPfZnPDBsenqHNvteQHcYolZJgMf4A3pBV9wPEU3wk2MmI0+9IjGtjgWK3zIKPkKuor3ke7surLQFaTwrjoSDG1uMAu9QvzVR2bKtRmGdqCamXCp8EB/G2R2YiCGrk96tJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387836; c=relaxed/simple;
	bh=NAGVmOZ2bV3/p+zP9WyIeVEOO8pb7Xo8s0U8iaDHrtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jb4xyL4hfVmZBwT+SpAIliF44pNO/LAqy7JI6u8TpODo1CJQM8hukVAFb5VKsA3m4XLtJEjgcQ8AH3m32B5KqQCkKSY6pE8Z287avmjRd7g4/Hynq4t/ZMrQYUsVTNwZiemyfOZup5k4vstPY8eip8n3dt3kuPpFzoBP2QNzzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iR0+v/7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1416C4CED1;
	Fri,  7 Mar 2025 22:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741387836;
	bh=NAGVmOZ2bV3/p+zP9WyIeVEOO8pb7Xo8s0U8iaDHrtg=;
	h=From:To:Cc:Subject:Date:From;
	b=iR0+v/7gZyU+uOMpIyvZEyHsiSW8gSJ2JJs01T1chsYThIRbw9g/oJe2o6+pj3tg8
	 AQdN4OKhN2Gzawfg4LinsCm4de37n+DcX3JuI3Fwz01FACHe6BIW1StX5gs83XPXod
	 OJtx2Qgtsf5GUyfFN7pyPD8vffNpfZuOXFrFhS45WfVy0czm1aT6Vg6XjiF91ntwC5
	 kt/gwGc3uT6QFOya135LZChOEtQdjOft9YZWc5MkWcQIExQ+2vDpqEz8PSMskNdr0y
	 +U5Mz5buv1FSke+8BJFEpX/U3vA7w2gCGNzBcsvsY/b5+Bko/awGF/ykhGMLkgccXo
	 Udg+d8n7wOAug==
From: Miguel Ojeda <ojeda@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Alyssa Ross <hi@alyssa.is>,
	NoisyCoil <noisycoil@disroot.org>,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12.y 00/60] `alloc`, `#[expect]` and "Custom FFI"
Date: Fri,  7 Mar 2025 23:49:07 +0100
Message-ID: <20250307225008.779961-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha,

Please consider this series for 6.12.y. It should apply cleanly on top
of v6.12.18.

These are the patches to backport the `alloc` series for Rust, which
will be useful for Rust Android Binder and others. It also means that,
with this applied, we will not rely on the standard library `alloc` (and
the unstable `cfg` option we used) anymore in any stable kernel that
supports several Rust versions, so e.g. upstream Rust could consider
removing that `cfg` if they needed.

The entire series of cherry-picks apply almost cleanly (only 2 trivial
conflicts) -- to achieve that, I included the `#[expect]` support, which
will make future backports that use that feature easier anyway. That
series also enabled some Clippy warnings. We could reduce the series,
but the end result is warning-free and Clippy is opt-in anyway.
Out-of-tree code could, of course, see some warnings if they use it.

I also included a bunch of Clippy warnings cleanups for the DRM QR Code
to have this series clean up to Rust 1.85.0 (the latest stable), but
I could send them separately if needed.

Finally, I included the "Custom FFI" series backport, which in turn
solves the arm64 + Rust 1.85.0 + `CONFIG_RUST_FW_LOADER_ABSTRACTIONS=y`
issue. It will also make future patches easier to backport, since we
will have the same `ffi::` types.

I tested that the entire series builds between every commit for x86_64
`LLVM=1` with the latest stable and minimum supported Rust compiler
versions. I also ran my usual stable kernel tests on the end result;
that is, boot-tested in QEMU for several architectures etc. In v6.12.18
for loongarch there is an unrelated error that was not there in v6.12.17
when I did a previous test run -- reported separately.

Things could still break, so extra tests on the next -rc from users in
Cc here would be welcome -- thanks!

Cheers,
Miguel

Asahi Lina (1):
  rust: alloc: Fix `ArrayLayout` allocations

Benno Lossin (1):
  rust: alloc: introduce `ArrayLayout`

Danilo Krummrich (28):
  rust: alloc: add `Allocator` trait
  rust: alloc: separate `aligned_size` from `krealloc_aligned`
  rust: alloc: rename `KernelAllocator` to `Kmalloc`
  rust: alloc: implement `ReallocFunc`
  rust: alloc: make `allocator` module public
  rust: alloc: implement `Allocator` for `Kmalloc`
  rust: alloc: add module `allocator_test`
  rust: alloc: implement `Vmalloc` allocator
  rust: alloc: implement `KVmalloc` allocator
  rust: alloc: add __GFP_NOWARN to `Flags`
  rust: alloc: implement kernel `Box`
  rust: treewide: switch to our kernel `Box` type
  rust: alloc: remove extension of std's `Box`
  rust: alloc: add `Box` to prelude
  rust: alloc: implement kernel `Vec` type
  rust: alloc: implement `IntoIterator` for `Vec`
  rust: alloc: implement `collect` for `IntoIter`
  rust: treewide: switch to the kernel `Vec` type
  rust: alloc: remove `VecExt` extension
  rust: alloc: add `Vec` to prelude
  rust: error: use `core::alloc::LayoutError`
  rust: error: check for config `test` in `Error::name`
  rust: alloc: implement `contains` for `Flags`
  rust: alloc: implement `Cmalloc` in module allocator_test
  rust: str: test: replace `alloc::format`
  rust: alloc: update module comment of alloc.rs
  kbuild: rust: remove the `alloc` crate and `GlobalAlloc`
  MAINTAINERS: add entry for the Rust `alloc` module

Ethan D. Twardy (1):
  rust: kbuild: expand rusttest target for macros

Filipe Xavier (2):
  rust: error: make conversion functions public
  rust: error: optimize error type to use nonzero

Gary Guo (3):
  rust: fix size_t in bindgen prototypes of C builtins
  rust: map `__kernel_size_t` and friends also to usize/isize
  rust: use custom FFI integer types

Miguel Ojeda (17):
  rust: workqueue: remove unneeded ``#[allow(clippy::new_ret_no_self)]`
  rust: sort global Rust flags
  rust: types: avoid repetition in `{As,From}Bytes` impls
  rust: enable `clippy::undocumented_unsafe_blocks` lint
  rust: enable `clippy::unnecessary_safety_comment` lint
  rust: enable `clippy::unnecessary_safety_doc` lint
  rust: enable `clippy::ignored_unit_patterns` lint
  rust: enable `rustdoc::unescaped_backticks` lint
  rust: init: remove unneeded `#[allow(clippy::disallowed_names)]`
  rust: sync: remove unneeded
    `#[allow(clippy::non_send_fields_in_send_ty)]`
  rust: introduce `.clippy.toml`
  rust: replace `clippy::dbg_macro` with `disallowed_macros`
  rust: provide proper code documentation titles
  rust: enable Clippy's `check-private-items`
  Documentation: rust: add coding guidelines on lints
  rust: start using the `#[expect(...)]` attribute
  Documentation: rust: discuss `#[expect(...)]` in the guidelines

Thomas Böhler (7):
  drm/panic: avoid reimplementing Iterator::find
  drm/panic: remove unnecessary borrow in alignment_pattern
  drm/panic: prefer eliding lifetimes
  drm/panic: remove redundant field when assigning value
  drm/panic: correctly indent continuation of line in list item
  drm/panic: allow verbose boolean for clarity
  drm/panic: allow verbose version check

 .clippy.toml                             |   9 +
 .gitignore                               |   1 +
 Documentation/rust/coding-guidelines.rst | 148 ++++
 MAINTAINERS                              |   8 +
 Makefile                                 |  15 +-
 drivers/block/rnull.rs                   |   4 +-
 drivers/gpu/drm/drm_panic_qr.rs          |  23 +-
 mm/kasan/kasan_test_rust.rs              |   3 +-
 rust/Makefile                            |  92 +--
 rust/bindgen_parameters                  |   5 +
 rust/bindings/bindings_helper.h          |   1 +
 rust/bindings/lib.rs                     |   6 +
 rust/exports.c                           |   1 -
 rust/ffi.rs                              |  13 +
 rust/helpers/helpers.c                   |   1 +
 rust/helpers/slab.c                      |   6 +
 rust/helpers/vmalloc.c                   |   9 +
 rust/kernel/alloc.rs                     | 150 +++-
 rust/kernel/alloc/allocator.rs           | 208 ++++--
 rust/kernel/alloc/allocator_test.rs      |  95 +++
 rust/kernel/alloc/box_ext.rs             |  89 ---
 rust/kernel/alloc/kbox.rs                | 456 +++++++++++
 rust/kernel/alloc/kvec.rs                | 913 +++++++++++++++++++++++
 rust/kernel/alloc/layout.rs              |  91 +++
 rust/kernel/alloc/vec_ext.rs             | 185 -----
 rust/kernel/block/mq/operations.rs       |  18 +-
 rust/kernel/block/mq/raw_writer.rs       |   2 +-
 rust/kernel/block/mq/tag_set.rs          |   2 +-
 rust/kernel/error.rs                     |  79 +-
 rust/kernel/init.rs                      | 127 ++--
 rust/kernel/init/__internal.rs           |  13 +-
 rust/kernel/init/macros.rs               |  18 +-
 rust/kernel/ioctl.rs                     |   2 +-
 rust/kernel/lib.rs                       |   5 +-
 rust/kernel/list.rs                      |   1 +
 rust/kernel/list/arc_field.rs            |   2 +-
 rust/kernel/net/phy.rs                   |  16 +-
 rust/kernel/prelude.rs                   |   5 +-
 rust/kernel/print.rs                     |   5 +-
 rust/kernel/rbtree.rs                    |  49 +-
 rust/kernel/std_vendor.rs                |  12 +-
 rust/kernel/str.rs                       |  46 +-
 rust/kernel/sync/arc.rs                  |  25 +-
 rust/kernel/sync/arc/std_vendor.rs       |   2 +
 rust/kernel/sync/condvar.rs              |   7 +-
 rust/kernel/sync/lock.rs                 |   8 +-
 rust/kernel/sync/lock/mutex.rs           |   4 +-
 rust/kernel/sync/lock/spinlock.rs        |   4 +-
 rust/kernel/sync/locked_by.rs            |   2 +-
 rust/kernel/task.rs                      |   8 +-
 rust/kernel/time.rs                      |   4 +-
 rust/kernel/types.rs                     | 140 ++--
 rust/kernel/uaccess.rs                   |  23 +-
 rust/kernel/workqueue.rs                 |  29 +-
 rust/macros/lib.rs                       |  14 +-
 rust/macros/module.rs                    |   8 +-
 rust/uapi/lib.rs                         |   6 +
 samples/rust/rust_minimal.rs             |   4 +-
 samples/rust/rust_print.rs               |   1 +
 scripts/Makefile.build                   |   4 +-
 scripts/generate_rust_analyzer.py        |  11 +-
 61 files changed, 2482 insertions(+), 756 deletions(-)
 create mode 100644 .clippy.toml
 create mode 100644 rust/ffi.rs
 create mode 100644 rust/helpers/vmalloc.c
 create mode 100644 rust/kernel/alloc/allocator_test.rs
 delete mode 100644 rust/kernel/alloc/box_ext.rs
 create mode 100644 rust/kernel/alloc/kbox.rs
 create mode 100644 rust/kernel/alloc/kvec.rs
 create mode 100644 rust/kernel/alloc/layout.rs
 delete mode 100644 rust/kernel/alloc/vec_ext.rs

--
2.48.1

