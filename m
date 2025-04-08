Return-Path: <stable+bounces-131439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A483A80964
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C6547B3B6A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E794D27605A;
	Tue,  8 Apr 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EH4D4dPR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2120A5C3;
	Tue,  8 Apr 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116399; cv=none; b=iYIoAESK5SHL1InV8c23jUgE5YkaXl3b1MEZMBNcbI1EU+HpWIkfEtbKJpGUaD9AhvAw9iRcxovSIJ1jWMtS5eE71+Vw6RYh6WGZSZcVtNyDS86SQBrQ4m2EZfDe6blu0KeAcH5uPVnMFczNIboh1O+STV+HjRAAsNCu+rBdpmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116399; c=relaxed/simple;
	bh=YQS4NnULN64+SIL81o1DqBt0ehTqSsx3h0MGfL5cMjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZjVQnEvAXBZJZM3Ygt1WuAyIByixQhI/UvMwePL5QES2fMDcnjAkkz29jzO2FbPKUQC+2qm9HEZCxNzNSbVs2jWHaRze8wtHqNVE+Oh/JtFMhF0vN4R3+TCoQBrf7sgd+kxm8AnPSgeTx4fWbc9eFB3bU68bvvI88oZ1MYqER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EH4D4dPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34475C4CEE5;
	Tue,  8 Apr 2025 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116399;
	bh=YQS4NnULN64+SIL81o1DqBt0ehTqSsx3h0MGfL5cMjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EH4D4dPRN0SiI3aQvzpCuZHWaOjBLB0X4Ol9Qu2kkiJy5E6GVGa8Westk/jvEqT7L
	 Dh76PQuz9JcKyj8CXepVNDgnn7L6xIokX3P7mdKdIz5rj/WNE5TR+jIxYituiNcfl2
	 /dUiUCYWw3bTBieGN5XaehXP1VXHSImT41im+wbM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 125/423] bpf: Use preempt_count() directly in bpf_send_signal_common()
Date: Tue,  8 Apr 2025 12:47:31 +0200
Message-ID: <20250408104848.638628024@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit b4a8b5bba712a711d8ca1f7d04646db63f9c88f5 ]

bpf_send_signal_common() uses preemptible() to check whether or not the
current context is preemptible. If it is preemptible, it will use
irq_work to send the signal asynchronously instead of trying to hold a
spin-lock, because spin-lock is sleepable under PREEMPT_RT.

However, preemptible() depends on CONFIG_PREEMPT_COUNT. When
CONFIG_PREEMPT_COUNT is turned off (e.g., CONFIG_PREEMPT_VOLUNTARY=y),
!preemptible() will be evaluated as 1 and bpf_send_signal_common() will
use irq_work unconditionally.

Fix it by unfolding "!preemptible()" and using "preempt_count() != 0 ||
irqs_disabled()" instead.

Fixes: 87c544108b61 ("bpf: Send signals asynchronously if !preemptible")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20250220042259.1583319-1-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 449efaaa387a6..55f279ddfd63d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -833,7 +833,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 	if (unlikely(is_global_init(current)))
 		return -EPERM;
 
-	if (!preemptible()) {
+	if (preempt_count() != 0 || irqs_disabled()) {
 		/* Do an early check on signal validity. Otherwise,
 		 * the error is lost in deferred irq_work.
 		 */
-- 
2.39.5




