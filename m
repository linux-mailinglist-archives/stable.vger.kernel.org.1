Return-Path: <stable+bounces-92981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FD09C867F
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 10:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359CB2836E2
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8731632F2;
	Thu, 14 Nov 2024 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8UFFbfd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9EE1F583E
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578021; cv=none; b=CfZNnvAvj4V8feQs5gdzk+ekJMJ4wcLo0hngcqL/JkKm8PmZwY1aHHwdp/YtGXz+k3/usnPc4j8qg+kt/pe/GAgUS0mbGAW+fJ3rKDHD9WcvCeP5aoYKt8804vgkF0WTOJUwWAOaWKDvvlUMYiVgZXXIhS64c68wiTbKkckmev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578021; c=relaxed/simple;
	bh=BH5DNo2WAnWH8HNwRpFgXkTiNcVlRrlX/l2dKCZTwCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WjPJSoxc++in3DCgV71YvgdRDUHxZzhgaOyxHDQXJTXxZc/MuP0CpwqteClkbCgTljgNdS0jVKVCSMYaU97K/KdXw/J6dqbdepvQaO2kmjc6b1KVdMwoYST9V1en/FmjwY4OF411jzMLRxkBDKdNubYXQoWi6oWVImzIGBATd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8UFFbfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8256DC4CECD;
	Thu, 14 Nov 2024 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731578020;
	bh=BH5DNo2WAnWH8HNwRpFgXkTiNcVlRrlX/l2dKCZTwCM=;
	h=From:To:Cc:Subject:Date:From;
	b=N8UFFbfdTJpwcr9jciX4f3n66x7L9mIKbO3MP4jKUavH9LPpNueuqN5hgetEKgXlY
	 jvH/jH1s6seNncRkbxW5eIVTnTNDsTp4cm7O4IUquebirSuCVxvb0XZ/cIy1bdWn+M
	 smrei8YPpMXBUDXsV6C9JI/Aczg1XnaQdXBnuUosav9AW1+8feQ9S2Ka5avwZ0zzsa
	 q/JXfRHhC9tl0442Bu/6c17krMn68jDUm5rln6h16lrWHT32Kt5pxOPAG4HrNqCta1
	 L5FZ16FAGt2YixKZ4vvxLyhbUQOQoQrw9L6DN0LvBZupjUFwY+hJPtmmo8nTWlFKZD
	 RghgFziM4oTqQ==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com
Cc: maz@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: tls: Fix context-switching of tpidrro_el0 when kpti is enabled
Date: Thu, 14 Nov 2024 09:53:32 +0000
Message-Id: <20241114095332.23391-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 18011eac28c7 ("arm64: tls: Avoid unconditional zeroing of
tpidrro_el0 for native tasks") tried to optimise the context switching
of tpidrro_el0 by eliding the clearing of the register when switching
to a native task with kpti enabled, on the erroneous assumption that
the kpti trampoline entry code would already have taken care of the
write.

Although the kpti trampoline does zero the register on entry from a
native task, the check in tls_thread_switch() is on the *next* task and
so we can end up leaving a stale, non-zero value in the register if the
previous task was 32-bit.

Drop the broken optimisation and zero tpidrro_el0 unconditionally when
switching to a native 64-bit task.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <stable@vger.kernel.org>
Fixes: 18011eac28c7 ("arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks")
Signed-off-by: Will Deacon <will@kernel.org>
---

You fix one side-channel and introduce another... :(

 arch/arm64/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 3e7c8c8195c3..2bbcbb11d844 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -442,7 +442,7 @@ static void tls_thread_switch(struct task_struct *next)
 
 	if (is_compat_thread(task_thread_info(next)))
 		write_sysreg(next->thread.uw.tp_value, tpidrro_el0);
-	else if (!arm64_kernel_unmapped_at_el0())
+	else
 		write_sysreg(0, tpidrro_el0);
 
 	write_sysreg(*task_user_tls(next), tpidr_el0);
-- 
2.47.0.277.g8800431eea-goog


