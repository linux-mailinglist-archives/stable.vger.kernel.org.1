Return-Path: <stable+bounces-146984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C2DAC559A
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3F7188FEE8
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9389280021;
	Tue, 27 May 2025 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uuv4yjgQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F4A27FD49;
	Tue, 27 May 2025 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365914; cv=none; b=WQKkoP43ogTxrRIURGJIOolL1YOfMIPTdJ9RNDgEbY5Dw34PHhqY6bVJk71AHpCCs797T+Tz6jTUGY5/nnri1a1KiPHfFJh0GRtIEwMlDtxHYJ8QKpJVUUdaoLKfQqcAmsu0Hf57N2r2s4E91cST0ZV8Dz8a4zklqsoLJ+RqouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365914; c=relaxed/simple;
	bh=uYCbZrqMvZTDUg1k1kYUVvhB5a99pUMYrxnUgyfFSSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDq4ZKSEPKIY9EEq0HZ1dSZfIDFYlXSOytsVPJboMX91Ircr135G7+rfLVtlA5cxR0rla0k/H1/0QrSsIZJ/s3cnHSZ+XXqtw5bR0oH7lH1D8N7IT2R/5c7NjGneDjEMziLtAIIyfTY5xOo3OhvUeRVXKcDBao1pHpW4+4gJwaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uuv4yjgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21BCC4CEF3;
	Tue, 27 May 2025 17:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365914;
	bh=uYCbZrqMvZTDUg1k1kYUVvhB5a99pUMYrxnUgyfFSSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uuv4yjgQBemAUsR7x4jPJX8cW3oIK7iQFEndlFgbxm5LBeft0OwIo9qyIjyYwj7zi
	 3OgdCoxsYPvDs001l/z/U6MBq7JQdHpmnbbRzDfNwtNttt8b9Bkat6nM2jpeBjUXCJ
	 Z5AeQNPSdqg7p7nh4HGFWkGaahc+QZRF3aoY6w4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pawe=C5=82=20Anikiel?= <panikiel@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 530/626] x86/Kconfig: make CFI_AUTO_DEFAULT depend on !RUST or Rust >= 1.88
Date: Tue, 27 May 2025 18:27:03 +0200
Message-ID: <20250527162506.526765323@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paweł Anikiel <panikiel@google.com>

[ Upstream commit 5595c31c370957aabe739ac3996aedba8267603f ]

Calling core::fmt::write() from rust code while FineIBT is enabled
results in a kernel panic:

[ 4614.199779] kernel BUG at arch/x86/kernel/cet.c:132!
[ 4614.205343] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 4614.211781] CPU: 2 UID: 0 PID: 6057 Comm: dmabuf_dump Tainted: G     U     O       6.12.17-android16-0-g6ab38c534a43 #1 9da040f27673ec3945e23b998a0f8bd64c846599
[ 4614.227832] Tainted: [U]=USER, [O]=OOT_MODULE
[ 4614.241247] RIP: 0010:do_kernel_cp_fault+0xea/0xf0
...
[ 4614.398144] RIP: 0010:_RNvXs5_NtNtNtCs3o2tGsuHyou_4core3fmt3num3impyNtB9_7Display3fmt+0x0/0x20
[ 4614.407792] Code: 48 f7 df 48 0f 48 f9 48 89 f2 89 c6 5d e9 18 fd ff ff 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 41 81 ea 14 61 af 2c 74 03 0f 0b 90 <66> 0f 1f 00 55 48 89 e5 48 89 f2 48 8b 3f be 01 00 00 00 5d e9 e7
[ 4614.428775] RSP: 0018:ffffb95acfa4ba68 EFLAGS: 00010246
[ 4614.434609] RAX: 0000000000000000 RBX: 0000000000000010 RCX: 0000000000000000
[ 4614.442587] RDX: 0000000000000007 RSI: ffffb95acfa4ba70 RDI: ffffb95acfa4bc88
[ 4614.450557] RBP: ffffb95acfa4bae0 R08: ffff0a00ffffff05 R09: 0000000000000070
[ 4614.458527] R10: 0000000000000000 R11: ffffffffab67eaf0 R12: ffffb95acfa4bcc8
[ 4614.466493] R13: ffffffffac5d50f0 R14: 0000000000000000 R15: 0000000000000000
[ 4614.474473]  ? __cfi__RNvXs5_NtNtNtCs3o2tGsuHyou_4core3fmt3num3impyNtB9_7Display3fmt+0x10/0x10
[ 4614.484118]  ? _RNvNtCs3o2tGsuHyou_4core3fmt5write+0x1d2/0x250

This happens because core::fmt::write() calls
core::fmt::rt::Argument::fmt(), which currently has CFI disabled:

library/core/src/fmt/rt.rs:
171     // FIXME: Transmuting formatter in new and indirectly branching to/calling
172     // it here is an explicit CFI violation.
173     #[allow(inline_no_sanitize)]
174     #[no_sanitize(cfi, kcfi)]
175     #[inline]
176     pub(super) unsafe fn fmt(&self, f: &mut Formatter<'_>) -> Result {

This causes a Control Protection exception, because FineIBT has sealed
off the original function's endbr64.

This makes rust currently incompatible with FineIBT. Add a Kconfig
dependency that prevents FineIBT from getting turned on by default
if rust is enabled.

[ Rust 1.88.0 (scheduled for 2025-06-26) should have this fixed [1],
  and thus we relaxed the condition with Rust >= 1.88.

  When `objtool` lands checking for this with e.g. [2], the plan is
  to ideally run that in upstream Rust's CI to prevent regressions
  early [3], since we do not control `core`'s source code.

  Alice tested the Rust PR backported to an older compiler.

  Peter would like that Rust provides a stable `core` which can be
  pulled into the kernel: "Relying on that much out of tree code is
  'unfortunate'".

    - Miguel ]

Signed-off-by: Paweł Anikiel <panikiel@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://github.com/rust-lang/rust/pull/139632 [1]
Link: https://lore.kernel.org/rust-for-linux/20250410154556.GB9003@noisy.programming.kicks-ass.net/ [2]
Link: https://github.com/rust-lang/rust/pull/139632#issuecomment-2801950873 [3]
Link: https://lore.kernel.org/r/20250410115420.366349-1-panikiel@google.com
Link: https://lore.kernel.org/r/att0-CANiq72kjDM0cKALVy4POEzhfdT4nO7tqz0Pm7xM+3=_0+L1t=A@mail.gmail.com
[ Reduced splat. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7b3622ba4c3c8..15425c9bdc2bc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2420,6 +2420,7 @@ config STRICT_SIGALTSTACK_SIZE
 config CFI_AUTO_DEFAULT
 	bool "Attempt to use FineIBT by default at boot time"
 	depends on FINEIBT
+	depends on !RUST || RUSTC_VERSION >= 108800
 	default y
 	help
 	  Attempt to use FineIBT by default at boot time. If enabled,
-- 
2.39.5




