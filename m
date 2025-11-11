Return-Path: <stable+bounces-193044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C096C49F7A
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 761D44F2916
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E2524BBEB;
	Tue, 11 Nov 2025 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LpkuIHeC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C7192B75;
	Tue, 11 Nov 2025 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822165; cv=none; b=VlAqGHx7fTpmegVIWv7jbGpF3QTnUgomQ6T3DzKi7iiAbJCblA9511lruISvwvd3dXUpAbu8U3KPasXJleF8MpXO2zdKRykBgYXhziOpRD7o+oMWuwVtPy4DiIgqArBH1M0mm93VGbHak4/1S9c9VOkE+EP7tu3yjggidvtyh4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822165; c=relaxed/simple;
	bh=q2Ptivv6yP7GOrx0KrZfrBruQI/Oh62pJ+e1X0Humso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8u0BZxKOhYov11aIphCAUut8ubqxxO01ERiL7hL/t1Dt4tVpALy3Npi2SREljtl4TXc0ZAh2dkic05VeUNKxZmXXSDj4q/0TAvGu6FWf1AGSm7J06WlsIjb7c+Hj+su5+0mE19o8gbXnggZZsO78IVwH6dGYLHZBLZaRFxbBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LpkuIHeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAB4C16AAE;
	Tue, 11 Nov 2025 00:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762822165;
	bh=q2Ptivv6yP7GOrx0KrZfrBruQI/Oh62pJ+e1X0Humso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpkuIHeC2YQJmGLg3sCEZYJ3auZkLKSSc/RVAgFG4lko4AHI5+LDeSgdXcjRloMm2
	 R0P1Ml4wX6Iwnqo9Nbh0mGTecKI6omZuIdJk5qUvrmp1ba78yMqEUX3F6WimH4MQ+Y
	 bSP7xcWPB+pekSv2wRk+p7WZbijIP56Vmv2qfCIM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com,
	Noorain Eqbal <nooraineqbal@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 043/849] bpf: Sync pending IRQ work before freeing ring buffer
Date: Tue, 11 Nov 2025 09:33:33 +0900
Message-ID: <20251111004537.482914851@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Noorain Eqbal <nooraineqbal@gmail.com>

[ Upstream commit 4e9077638301816a7d73fa1e1b4c1db4a7e3b59c ]

Fix a race where irq_work can be queued in bpf_ringbuf_commit()
but the ring buffer is freed before the work executes.
In the syzbot reproducer, a BPF program attached to sched_switch
triggers bpf_ringbuf_commit(), queuing an irq_work. If the ring buffer
is freed before this work executes, the irq_work thread may accesses
freed memory.
Calling `irq_work_sync(&rb->work)` ensures that all pending irq_work
complete before freeing the buffer.

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2617fc732430968b45d2
Tested-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Signed-off-by: Noorain Eqbal <nooraineqbal@gmail.com>
Link: https://lore.kernel.org/r/20251020180301.103366-1-nooraineqbal@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/ringbuf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 719d73299397b..d706c4b7f532d 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -216,6 +216,8 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 
 static void bpf_ringbuf_free(struct bpf_ringbuf *rb)
 {
+	irq_work_sync(&rb->work);
+
 	/* copy pages pointer and nr_pages to local variable, as we are going
 	 * to unmap rb itself with vunmap() below
 	 */
-- 
2.51.0




