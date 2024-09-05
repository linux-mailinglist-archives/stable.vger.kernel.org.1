Return-Path: <stable+bounces-73618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0150896DD36
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 17:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04B71F22362
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3857F1A08C1;
	Thu,  5 Sep 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4V8xMNDN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z8mQr2qA"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0519F410;
	Thu,  5 Sep 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548611; cv=none; b=Dx5WQPTBACZK0KnRXcmUK5WGNkaNCSO/6uP19Hwh4OYHFJ8RofqOlgdF/wUQx99lQAe3fsDiq0ISeg14+M6fAlqL7al8P5EF32QlYnITPXREP0YewuHsLkAETYBB/JSnjoZ+J6iR1yCNeCCas1toaZqw0A7DFIqdy/RkY9Xs4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548611; c=relaxed/simple;
	bh=72m1hTW0Vb/s2r0/NTJhF0AbEGcphFzil/bdprqJBFg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M5dshvq3gJ3+XvkL+LVCxy1Md1wX+D/XhXZUrv4PNCOCD26ceeTvyR3EQ5xrkoMwUzqN5T4RzAoYqOQ2G6QEJbuzRrvChTzZCXgRirEiT44iEWNWAI5QL0NXN9x9AapN+PHrlZE/yI+46XrHD1YRCiuWaDGkN3hUdix8K3YwpPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4V8xMNDN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z8mQr2qA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 15:03:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725548608;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2stGUD3jNCq9QC/M3Ol1drOEyWUND3hLtoKu4OGBt4=;
	b=4V8xMNDN6KhH1iFmqkZjUyVqpsVe1r3pElJ20Cn8bFlhiRwRNacGFdLZ4BHUz0BP5J1Tvg
	bLpPgKiP4Vjl48HaqxM9TjOK+R8ZVC64jSKd+BZyeGLSug8dt8uBFsoFEYN/4tzvJGwRLH
	NdFAVx+feONLBCpMYetA1kt1UeO8x4fqx89qm/L9VAasAgyHup6jeTeGL0Zw6MDBFT2Z9o
	tCUhVGKFWxjiA21EWy3UEVhvWBq5X4Fc6xE1U5JR1m6xEqBG2+QcEeQ69r1BPbrOErEHGq
	uIxoXQ95wB7Rr5yyupCXJIhvHoV7FcG3UoLkjP+FP5Cqavj47SfZJmdFifcFaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725548608;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2stGUD3jNCq9QC/M3Ol1drOEyWUND3hLtoKu4OGBt4=;
	b=Z8mQr2qAzp6/Gg9zP8EzdrfxOIr7B9SD0oP2epd7WVcQgO+u5KT7aIIWVlI8PcKhoqCxOh
	6NPuoZDQmQo8j6DQ==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] bpf: Fix use-after-free in bpf_uprobe_multi_link_attach()
Cc: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com,
 Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240813152524.GA7292@redhat.com>
References: <20240813152524.GA7292@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172554860794.2215.16584270124824931506.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5fe6e308abaea082c20fbf2aa5df8e14495622cf
Gitweb:        https://git.kernel.org/tip/5fe6e308abaea082c20fbf2aa5df8e14495622cf
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Tue, 13 Aug 2024 17:25:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Sep 2024 16:56:13 +02:00

bpf: Fix use-after-free in bpf_uprobe_multi_link_attach()

If bpf_link_prime() fails, bpf_uprobe_multi_link_attach() goes to the
error_free label and frees the array of bpf_uprobe's without calling
bpf_uprobe_unregister().

This leaks bpf_uprobe->uprobe and worse, this frees bpf_uprobe->consumer
without removing it from the uprobe->consumers list.

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Closes: https://lore.kernel.org/all/000000000000382d39061f59f2dd@google.com/
Reported-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240813152524.GA7292@redhat.com
---
 kernel/trace/bpf_trace.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4e391da..90cd30e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3484,17 +3484,20 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 						    &uprobes[i].consumer);
 		if (IS_ERR(uprobes[i].uprobe)) {
 			err = PTR_ERR(uprobes[i].uprobe);
-			bpf_uprobe_unregister(uprobes, i);
-			goto error_free;
+			link->cnt = i;
+			goto error_unregister;
 		}
 	}
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-		goto error_free;
+		goto error_unregister;
 
 	return bpf_link_settle(&link_primer);
 
+error_unregister:
+	bpf_uprobe_unregister(uprobes, link->cnt);
+
 error_free:
 	kvfree(uprobes);
 	kfree(link);

