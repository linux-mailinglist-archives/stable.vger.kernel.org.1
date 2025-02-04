Return-Path: <stable+bounces-112203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C8A278F2
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC6B1887669
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7B32144CA;
	Tue,  4 Feb 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHtnS5Kt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB018A6D4;
	Tue,  4 Feb 2025 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691351; cv=none; b=m9yIz34yBF1I0faHJkcqn/drglsr5oK+x2d+vQv6IIKdSj2QlNaf8JsncHOp74t8E6l1WT20YPFvEH2ho3m/x7+7gW7nfIjCEHD8xNu5IwoVZVFJJINuCjyBUj5wfvrvC7JUfSF1faVKA017LUPps/vPO7y7WVIy108fvvqSs/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691351; c=relaxed/simple;
	bh=rXAK34OphyEItP6/+639hQrb7zlf+ZgtdRAQ99Mc1xA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jbil56Qpa7lm5WI5VC8XceXzYoanEF55L51EtDFH27KgcKEnxO5GsP636RyrG8yvsnhThu3U8inzjDXvGKkZtQf6YCA6AKHdYJT+unlpvGirSVPOlmOQRw/CKctfPueKUc7r/uTbEx0NyAYO6jDzqYMZXMD36IKdKEgaYMN42aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHtnS5Kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5820C4CEDF;
	Tue,  4 Feb 2025 17:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738691351;
	bh=rXAK34OphyEItP6/+639hQrb7zlf+ZgtdRAQ99Mc1xA=;
	h=From:Date:Subject:To:Cc:From;
	b=SHtnS5KtsZ/GOENUm5oQLadqfIxf887yWaCuZngDsiv7/CyDO9QC34fijUzxSRrVQ
	 kngZDnCH3unbXVxFTR1GxMquyEiACyFsVKrPj4yeLVPUlnNETP0mXxW7iswjxU3KlW
	 /McoIFOGzYDLIuIXTUiRu4dlzQ7HXgW8WB1z+iTtn18pR6AMMLGsxZzC/x9kHfcIOh
	 T3da3wf/qvYrWehDk8r5wVS0UMofLrV8hFynf+w7TTf+PY99/jrik4Y1hsfVmA6kxR
	 tytim7CxgxFzQeV/FTL/cQmo6RQkZsCG7Olaw14EdKN/pSFujkGTkWP4PuNtNbF9jn
	 0fogOD/mQ/kAQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 04 Feb 2025 10:48:55 -0700
Subject: [PATCH v2] arm64: Handle .ARM.attributes section in linker scripts
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-arm64-handle-arm-attributes-in-linker-script-v2-1-d684097f5554@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAZTomcC/5WNyw6CMBBFf4V07Rj6AB8r/8OwKGWAiVjItBIN4
 d8tJH6Ay3NPcs8iAjJhENdsEYwzBRp9AnXIhOut7xCoSSxUropcKg2Wn6WBpJoBNwAbI1P9ihi
 APAzkH8gQHNMU4awsoiq01NaJdDkxtvTec/cqcU8hjvzZ67Pc1l/I/BeaJUg4GamLunStNpdbk
 h6H48idqNZ1/QLKQtx56QAAAA==
X-Change-ID: 20250123-arm64-handle-arm-attributes-in-linker-script-82aee25313ac
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; i=nathan@kernel.org;
 h=from:subject:message-id; bh=rXAK34OphyEItP6/+639hQrb7zlf+ZgtdRAQ99Mc1xA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOmLgkVPWnK9OzmvIvdskY3O/JnndpzanxPoV98gZS8Uo
 c038eCCjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjARhamMDB0LlsU8eMydZMf/
 Jz9cUGOBxqbSa3cXLD0levu1rdbunX8ZGTa3exwvDM59N3HSnji5A3vPGxt9M9++e3fGg5o/iss
 j7dkA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

A recent LLVM commit [1] started generating an .ARM.attributes section
similar to the one that exists for 32-bit, which results in orphan
section warnings (or errors if CONFIG_WERROR is enabled) from the linker
because it is not handled in the arm64 linker scripts.

  ld.lld: error: arch/arm64/kernel/vdso/vgettimeofday.o:(.ARM.attributes) is being placed in '.ARM.attributes'
  ld.lld: error: arch/arm64/kernel/vdso/vgetrandom.o:(.ARM.attributes) is being placed in '.ARM.attributes'

  ld.lld: error: vmlinux.a(lib/vsprintf.o):(.ARM.attributes) is being placed in '.ARM.attributes'
  ld.lld: error: vmlinux.a(lib/win_minmax.o):(.ARM.attributes) is being placed in '.ARM.attributes'
  ld.lld: error: vmlinux.a(lib/xarray.o):(.ARM.attributes) is being placed in '.ARM.attributes'

Discard the new sections in the necessary linker scripts to resolve the
warnings, as the kernel and vDSO do not need to retain it, similar to
the .note.gnu.property section.

Cc: stable@vger.kernel.org
Fixes: b3e5d80d0c48 ("arm64/build: Warn on orphan section placement")
Link: https://github.com/llvm/llvm-project/commit/ee99c4d4845db66c4daa2373352133f4b237c942 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Discard the section instead of adding it to the final artifacts to
  mirror the .note.gnu.property section handling (Will).
- Link to v1: https://lore.kernel.org/r/20250124-arm64-handle-arm-attributes-in-linker-script-v1-1-74135b6cf349@kernel.org
---
 arch/arm64/kernel/vdso/vdso.lds.S | 1 +
 arch/arm64/kernel/vmlinux.lds.S   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 4ec32e86a8da..8095fef66209 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -80,6 +80,7 @@ SECTIONS
 		*(.data .data.* .gnu.linkonce.d.* .sdata*)
 		*(.bss .sbss .dynbss .dynsbss)
 		*(.eh_frame .eh_frame_hdr)
+		*(.ARM.attributes)
 	}
 }
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index f84c71f04d9e..e73326bd3ff7 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -162,6 +162,7 @@ SECTIONS
 	/DISCARD/ : {
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
+		*(.ARM.attributes)
 	}
 
 	. = KIMAGE_VADDR;

---
base-commit: 1dd3393696efba1598aa7692939bba99d0cffae3
change-id: 20250123-arm64-handle-arm-attributes-in-linker-script-82aee25313ac

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


