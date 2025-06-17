Return-Path: <stable+bounces-153509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE59ADD511
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FED3A9A41
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C62EF292;
	Tue, 17 Jun 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VM8NPG1n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD82DFF10;
	Tue, 17 Jun 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176193; cv=none; b=awKj0srl1zFf9z0UIKIxsLiCViQqkvGf23Evrgi4c1jBvP21er7V2orFtAXHHXOfwMk4oDjHOECLwTG4IAAq/7HG+AA+h3VSl6a47fwfVYL552oMPkmEWPDflBthkkdJdpm4u7ABmGlvArWhFY6jzkeFlTScfCyk8KxZPu7E+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176193; c=relaxed/simple;
	bh=RzH3W9pVSo8zwTN5YBbOLYGU3Wk5gnqXgRPNKnqT3j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSt/lA4N9tjl3ByvCTRWsqfmf7pV2nCYx42FCuooLlO9C1qdCvIv2hBQiWmE8dlaOxtuls5mKMBlzPJ5RwmHs/txLisjdjLWaQh6bFbh9geWqY8XjAkywzGH8RRhrBAv9raDXQTLVgkTxAcG1B74pnaqpDuxJN7zulesxn9E8do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VM8NPG1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72903C4CEE3;
	Tue, 17 Jun 2025 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176193;
	bh=RzH3W9pVSo8zwTN5YBbOLYGU3Wk5gnqXgRPNKnqT3j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VM8NPG1nOCentgRGUrK5XynWjZqNaECpxXjtwdZy8meUYllkVcPvQ06kQ9PcCles8
	 IWY6/L3dpdPv5T8bLMJKprdHiCbT/etav2Pkf/jm+Kc+560Odu6/zc2gojTk8sy/Gp
	 KoCPllraXEM3tVvYboZDHl0xKMVY7Q+edmybzrEE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com,
	KaFai Wan <mannkafai@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 205/512] bpf: Avoid __bpf_prog_ret0_warn when jit fails
Date: Tue, 17 Jun 2025 17:22:51 +0200
Message-ID: <20250617152427.943152190@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

From: KaFai Wan <mannkafai@gmail.com>

[ Upstream commit 86bc9c742426a16b52a10ef61f5b721aecca2344 ]

syzkaller reported an issue:

WARNING: CPU: 3 PID: 217 at kernel/bpf/core.c:2357 __bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
Modules linked in:
CPU: 3 UID: 0 PID: 217 Comm: kworker/u32:6 Not tainted 6.15.0-rc4-syzkaller-00040-g8bac8898fe39
RIP: 0010:__bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
Call Trace:
 <TASK>
 bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 cls_bpf_classify+0x74a/0x1110 net/sched/cls_bpf.c:105
 ...

When creating bpf program, 'fp->jit_requested' depends on bpf_jit_enable.
This issue is triggered because of CONFIG_BPF_JIT_ALWAYS_ON is not set
and bpf_jit_enable is set to 1, causing the arch to attempt JIT the prog,
but jit failed due to FAULT_INJECTION. As a result, incorrectly
treats the program as valid, when the program runs it calls
`__bpf_prog_ret0_warn` and triggers the WARN_ON_ONCE(1).

Reported-by: syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/6816e34e.a70a0220.254cdc.002c.GAE@google.com
Fixes: fa9dd599b4da ("bpf: get rid of pure_initcall dependency to enable jits")
Signed-off-by: KaFai Wan <mannkafai@gmail.com>
Link: https://lore.kernel.org/r/20250526133358.2594176-1-mannkafai@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a713cc7b00849..68a327158989b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2419,7 +2419,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	/* In case of BPF to BPF calls, verifier did all the prep
 	 * work with regards to JITing, etc.
 	 */
-	bool jit_needed = false;
+	bool jit_needed = fp->jit_requested;
 
 	if (fp->bpf_func)
 		goto finalize;
-- 
2.39.5




