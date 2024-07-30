Return-Path: <stable+bounces-62629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3193940488
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 04:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B217B1C20E06
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 02:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83091A291;
	Tue, 30 Jul 2024 02:26:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FCC10A12;
	Tue, 30 Jul 2024 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722306362; cv=none; b=jHHPE7weossUHbv7gyIfKzw4McpFZKwNU6f94gwXnpQavOn0o1X74eWUWncD7xiCsWajErv5TLpo9i9kLCjDneh0cvMIbzVxev4HjWfLAR4rRPVCjZZcNx6Fq3Tv3lUD38SrG5cBcjJzVCwdXIH1E9t6+3SMJ2BzMs5eLUHqf9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722306362; c=relaxed/simple;
	bh=taQe3psEegTsQujwHfTE9wNpSVFvMPBJ23z/qcR0d0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXGqixDygrFtS7gJnrr9pJCcOHq4eVg+jwESur8xZP/VZtxbnQpKxUtvI+Of6iV/gn+57DRWLq0JOry+/p3+67UpO77B6KhNLzgJT8PTSrisMrsNUKosBgrKqgSkGfsSvgXj8Gp6rICyR0vjUUrHyjhRTIM0Or2fHf7sHoOWMKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DF8C4AF0F;
	Tue, 30 Jul 2024 02:26:00 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH for-stable] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
Date: Tue, 30 Jul 2024 10:25:42 +0800
Message-ID: <20240730022542.3553255-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <CAAhV-H6vXEaJf9NO9Lqh0xKoFAehtOOOLQVO4j5v+_tD7oKEXQ@mail.gmail.com>
References: <CAAhV-H6vXEaJf9NO9Lqh0xKoFAehtOOOLQVO4j5v+_tD7oKEXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chromium sandbox apparently wants to deny statx [1] so it could properly
inspect arguments after the sandboxed process later falls back to fstat.
Because there's currently not a "fd-only" version of statx, so that the
sandbox has no way to ensure the path argument is empty without being
able to peek into the sandboxed process's memory. For architectures able
to do newfstatat though, glibc falls back to newfstatat after getting
-ENOSYS for statx, then the respective SIGSYS handler [2] takes care of
inspecting the path argument, transforming allowed newfstatat's into
fstat instead which is allowed and has the same type of return value.

But, as LoongArch is the first architecture to not have fstat nor
newfstatat, the LoongArch glibc does not attempt falling back at all
when it gets -ENOSYS for statx -- and you see the problem there!

Actually, back when the LoongArch port was under review, people were
aware of the same problem with sandboxing clone3 [3], so clone was
eventually kept. Unfortunately it seemed at that time no one had noticed
statx, so besides restoring fstat/newfstatat to LoongArch uapi (and
postponing the problem further), it seems inevitable that we would need
to tackle seccomp deep argument inspection.

However, this is obviously a decision that shouldn't be taken lightly,
so we just restore fstat/newfstatat by defining __ARCH_WANT_NEW_STAT
in unistd.h. This is the simplest solution for now, and so we hope the
community will tackle the long-standing problem of seccomp deep argument
inspection in the future [4][5].

More infomation please reading this thread [6].

[1] https://chromium-review.googlesource.com/c/chromium/src/+/2823150
[2] https://chromium.googlesource.com/chromium/src/sandbox/+/c085b51940bd/linux/seccomp-bpf-helpers/sigsys_handlers.cc#355
[3] https://lore.kernel.org/linux-arch/20220511211231.GG7074@brightrain.aerifal.cx/
[4] https://lwn.net/Articles/799557/
[5] https://lpc.events/event/4/contributions/560/attachments/397/640/deep-arg-inspection.pdf
[6] https://lore.kernel.org/loongarch/20240226-granit-seilschaft-eccc2433014d@brauner/T/#t

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
index fcb668984f03..b344b1f91715 100644
--- a/arch/loongarch/include/uapi/asm/unistd.h
+++ b/arch/loongarch/include/uapi/asm/unistd.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_CLONE3
 
-- 
2.43.5


