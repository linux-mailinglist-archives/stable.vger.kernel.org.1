Return-Path: <stable+bounces-119495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A30A43E9E
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993013A902C
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CB3267B89;
	Tue, 25 Feb 2025 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pH/yM+PY"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9581C861B
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484629; cv=none; b=V6XZ/gUb//Pe741YZwKq5PJVx99ZVMDxiDb5f+6tVcjIrlb36YwOWQ7zvBIqQGb1K1KfopKZp6IBNjm0tkvPPx6pNLmQHKeLVjHbCFwcbbRR7Vh4Crl0ihHV7u13uAnmPlklQ6sgJA/XN865Ss1FVgyeZ4luLEZY7RqCr3ddN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484629; c=relaxed/simple;
	bh=Erzx1Zz5LqH1aI0ZmSbUpSO0Kno9Skv6pNAjKi0Qees=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MTyUWmQgfePVZ2ALYWvaQZKggqmJksne0E8+ny3iIzgS2+GLAouva/Ztovf1hLIdJqPfBrqWMgFk479rdz6N3FgxzimZXkgD24KR4FyjnuOgfviJHsJaqXkTcprMJNH2UL5MNecL++7upZyrG9ImS0IJR29G/mzHQ7maa1+ggwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pH/yM+PY; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Z571lzPL8oKeIyklZGtjRbzcK+lbrAafO3gOCUhY1x0=; b=pH/yM+PY/4j18p7t7BkMh6nQFg
	cvEU7+84ghCmlhCBdCvUkFXmSuPviyLMlpeY9NOEPzwIH0ZdEkAygH87hn8XJbss72udMp+Toz/uS
	QMROam20RHtqm9DXzj4zSW/bUpkJawFo8GkT08rhsW4Ynme20mkJKXK4Trbrgf9eWpAWrCyvMCHE7
	yjyDBt3rNNVF/FL+RZB2yAi9Kxrfq1wKkAXedMvNFg8SnZ7tp8QmJZnSmHI8hUjg1YPBfOpv3H0Gv
	W2KITr0seQ22atYG1KiFJVLRuP7q56gd4vn3tBHDWGLIakzRUnMI9R2BG0TWldn94Vc9OUyV1+UsN
	/c0EBrrA==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tmtYS-000Ms0-IH; Tue, 25 Feb 2025 12:56:58 +0100
From: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Subject: [PATCH 6.6 v2 0/2] Set the bpf_net_context before invoking BPF XDP
 in the TUN driver
Date: Tue, 25 Feb 2025 12:56:26 +0100
Message-Id: <20250225-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v2-0-bc31173653b4@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOqvvWcC/62OQQ6CMBBFr2Jm7ZBaKYor72EIGeiAE6VgC0RDu
 LsNXsHd//8t/lsgsBcOcNkt4HmWIL2LRe93UN/JtYxiYwettFFap/gLKsUHBXIYnlThFBipGdl
 j45nRM1kUh5bnsqOhZPeaeOKyDFPVyYhVrk7UnI/5WRmIR4PnRt6bxA2yJIMijncJY+8/m9h82
 NA/HeYDqgiNTU/GZDbPrtLSUyip+w6KdV2/04pMHBoBAAA=
X-Change-ID: 20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-b907af839805
To: stable@vger.kernel.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: revest@google.com, kernel-dev@igalia.com, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 syzbot+0b5c75599f1d872bea6f@syzkaller.appspotmail.com, 
 syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com, 
 syzbot+c1e04a422bbc0f0f2921@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2

A private syzbot instance reported "KASAN: slab-use-after-free Read in
dev_map_enqueue" under some runtime environments.

Upstream patch fecef4cd42c6 ("tun: Assign missing bpf_net_context")
fixes the issue. In order to bring this patch to stable v6.6 it's also
necessary to bring upstream patch 401cb7dae813 ("net: Reference
bpf_redirect_info via task_struct on PREEMPT_RT.") as a dependency.

The dependency patch (401cb7dae813 ("net: Reference bpf_redirect_info
via task_struct on PREEMPT_RT.")) comes from a patch series [1], the
second patch addresses a missing change in the series. Only these two
patches were picked up because the purpose of this backport is to fix
the particular issue discovered by syzbot. However, maybe Sebastian may
consider it's a better idea to backport the whole series instead of only
these two patches. I'd also appreciate if you can share your opinion on
whether this backport should be applied to other stable branches as
well.

Both patches needed some manual work in order to be applied on stable,
mostly related to changes in the context lines:

In the case of 401cb7dae813 ("net: Reference bpf_redirect_info via
task_struct on PREEMPT_RT."), the backport addresses the differences in
net/core/dev.c:napi_threaded_poll(), busy_poll_stop(), napi_busy_loop()
and net_rx_action() between upstream and stable. This
allows the patch to be applied without bringing additional dependencies,
such as dad6b9770263 ("net: Allow to use SMP threads for backlog
NAPI."). The rest of the changes are made to adapt context lines and are
unrelated to the purpose of the patch.

For fecef4cd42c6 ("tun: Assign missing bpf_net_context"), the backport
addresses the changes in function parameters introduced by
7cd1107f48e2a ("bpf, xdp: constify some bpf_prog * function arguments")
and 4d2bb0bfe874 ("xdp: rely on skb pointer reference in do_xdp_generic
and netif_receive_generic_xdp").

[1] https://lore.kernel.org/all/20240612170303.3896084-1-bigeasy@linutronix.de/

Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>

---
Changes in v2:
- Fix backport for patch 401cb7dae813 ("net: Reference bpf_redirect_info
  via task_struct on PREEMPT_RT.") in v1.
- Add context for the patches and SoB tags.
- Extend the recipient list.
- Link to v1: https://lore.kernel.org/r/20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v1-0-de5d47556d96@igalia.com

---
Sebastian Andrzej Siewior (2):
      net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
      tun: Assign missing bpf_net_context.

 drivers/net/tun.c      |  7 +++++++
 include/linux/filter.h | 56 +++++++++++++++++++++++++++++++++++++++++---------
 include/linux/sched.h  |  3 +++
 kernel/bpf/cpumap.c    |  3 +++
 kernel/bpf/devmap.c    |  9 +++++++-
 kernel/fork.c          |  1 +
 net/bpf/test_run.c     | 11 +++++++++-
 net/core/dev.c         | 33 ++++++++++++++++++++++++++++-
 net/core/filter.c      | 44 +++++++++++----------------------------
 net/core/lwt_bpf.c     |  3 +++
 10 files changed, 125 insertions(+), 45 deletions(-)
---
base-commit: c0249d3a0c3cf082d56f4285647ddba19ef604a7
change-id: 20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-b907af839805

Cheers,
Ricardo


