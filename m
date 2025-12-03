Return-Path: <stable+bounces-198692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BE5CA061D
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0D533000B1C
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BD733ADB7;
	Wed,  3 Dec 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L2f+T2sz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE32FBDFF;
	Wed,  3 Dec 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777377; cv=none; b=Ss6XIg3hMq242lMCUFxwLLiv5hww5jNkcEFJ6sD7Xx7kTl58oY7yJmt9Taf7Ve7OD6M9WljF8jwGtS0pafyOlCwYIabjVa3b4X4/+SAOtt4iYd77SC3TRwN3vzNCwj/LrWrfariqosEErCOaXPOrhjfRyxsxx3LurYDJ1cgbHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777377; c=relaxed/simple;
	bh=rhnNgSPjZtThRL3zecLRUFqVaJxzm2Fb1YhpNYivH8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6WWaQJlMQYAm77e51BQvJ+471Uf4q37hydvEZTRcOZd7tvxbOBlVut3q02jzEOQ+KrK0GDsk1uM3hPEA0AD6HfwUDodq45WCQ75cVM1Mf7jU4y6tBdj/fQ31mma6zqxkc/0cZdWlNXM/ooX14e/ZERL7AGm9ahjVVX40d5JtR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L2f+T2sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CC2C4CEF5;
	Wed,  3 Dec 2025 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777376;
	bh=rhnNgSPjZtThRL3zecLRUFqVaJxzm2Fb1YhpNYivH8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2f+T2sz4bE3gs9QcHl3EGALoas60nmmSkOWdEO4SB6p4nZ66VU1zuq2evb7X1jVJ
	 QHuXKsjUs8ql0IOOAYkJ5Zfouwewz9sZB8LubiaTydL+A3DoRJGWfAfSEfbUANwHPP
	 akdA4fmVo3mOdHheaz6BbhzD6PSY5qlAOjY/SO/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com,
	Noorain Eqbal <nooraineqbal@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 019/392] bpf: Sync pending IRQ work before freeing ring buffer
Date: Wed,  3 Dec 2025 16:22:49 +0100
Message-ID: <20251203152414.809988015@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
 kernel/bpf/ringbuf.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -190,6 +190,8 @@ static void bpf_ringbuf_free(struct bpf_
 	struct page **pages = rb->pages;
 	int i, nr_pages = rb->nr_pages;
 
+	irq_work_sync(&rb->work);
+
 	vunmap(rb);
 	for (i = 0; i < nr_pages; i++)
 		__free_page(pages[i]);



