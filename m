Return-Path: <stable+bounces-119649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2CA45A6B
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 10:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7593E3A860D
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558AC20DD4D;
	Wed, 26 Feb 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="V6dax4hT"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4A23815A
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562788; cv=none; b=KatKLG5L74VyXK3GMYsSRt3rUOtRk2Gvw72xFuDelUQgbgIyInhBDSTkdsbzAYsSMGxNNvh1Zsby6M61Lkss4uDhQVKjUJaasYoECv9ZUCTx1oF0vLyxgbe2FLLGcwgN13V4pYxPvYU9LTNKQX7KaForOjg09lscsyT71dspDS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562788; c=relaxed/simple;
	bh=8iBwATOuG82dou1fJ5FVq3SffXjmkdNsG1dUv6pT0BQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I5tMOrGAgzAhM8iATPXXYIj9ao7qpBR/Ro0RBKOj6ZnNkIoxYfbtIH1YS15QqBLZh3i3u9bi2Pue9NAjitSjwbsqpl7g2mh2+odWvCaQmeXnfH9pAdLQGz9K+xvoMbN3Aqy+fYpHYHNWZ5pfoHgDDiBQt8dFWnW4Uzch8XkxArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=V6dax4hT; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ijmMgvcp3WC35fN39hEojqXBzPeBl3L/tva127EbWww=; b=V6dax4hTIXAYAGau73KuS+GyIC
	LSsTs1lJgyRA+QyyMvCTLh+W789DVIGdVNEAAD5j7XK+JdkYDwWNiDxfexKE++sCVz6+v9rNpUfBX
	GDfFauY93haGLOwcsM3Wje4PNRAUrEUUfSVuevndOdY0SiNllndoI6VNK11+A48JQQSBbmeku942m
	TfjuYXnrfXAz2L2UK6bO2SX8g3vMUAy4o1MHUUUEZVlD21ZkMjLgUgVapRSySDK+RLKp9MwTWyYdZ
	unXA8dudHsBvpq+ciB1bWjw3zNeXxyIjaryLhilbVOAf20xgEiybx/LaFZlSft27QrwJXfGIA2iYQ
	ngWsI/BA==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnDt3-000seA-A1; Wed, 26 Feb 2025 10:39:35 +0100
From: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Subject: [PATCH 6.6 v3 0/3] Set the bpf_net_context before invoking BPF XDP
 in the TUN driver
Date: Wed, 26 Feb 2025 10:39:04 +0100
Message-Id: <20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-0-360efec441ba@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADjhvmcC/63OQW7CMBAF0KsgrzvIsWOHsOIeVRWN4wmMShywE
 6sVyt2xwqbds5s/f/H+QySKTEkcdw8RKXPiKZSgP3aiv2A4E7AvWSipjFSqhtcha/jGhAHSFR0
 siQCHmSIMkQgioQcO4Cl3I946CveFFuq6tLiRZ3CtbHA46PYgjSjQLdLAP9uIT2H3VnyV54XTP
 MXfbViutuqdG3IFspTG140x1rf2xGe8Mu77adz8rP6a5i2mKqbrdVU12hrt6n/muq5PZfogyY4
 BAAA=
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
 syzbot+c1e04a422bbc0f0f2921@syzkaller.appspotmail.com, 
 Jeongjun Park <aha310510@gmail.com>, 
 syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com, 
 Jason Wang <jasowang@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 syzbot+3c2b6d5d4bec3b904933@syzkaller.appspotmail.com, 
 syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com, 
 syzbot+c226757eb784a9da3e8b@syzkaller.appspotmail.com, 
 syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com, 
 syzbot+709e4c85c904bcd62735@syzkaller.appspotmail.com, 
 "David S. Miller" <davem@davemloft.net>
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

Additionally, upstream commit 9da49aa80d68 ("tun: Add missing
bpf_net_ctx_clear() in do_xdp_generic()"), which fixes
fecef4cd42c6 ("tun: Assign missing bpf_net_context") is also backported
with trivial changes to adapt the differences in the patch context.

[1] https://lore.kernel.org/all/20240612170303.3896084-1-bigeasy@linutronix.de/

Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>

---
Changes in v3:
- Additional patch backported:
  9da49aa80d68 ("tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()")
  which fixes fecef4cd42c6 ("tun: Assign missing bpf_net_context.").
  Suggested by Sasha's helper bot.
- Link to v2: https://lore.kernel.org/r/20250225-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v2-0-bc31173653b4@igalia.com

Changes in v2:
- Fix backport for patch 401cb7dae813 ("net: Reference bpf_redirect_info
  via task_struct on PREEMPT_RT.") in v1.
- Add context for the patches and SoB tags.
- Extend the recipient list.
- Link to v1: https://lore.kernel.org/r/20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v1-0-de5d47556d96@igalia.com

---
Jeongjun Park (1):
      tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()

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
 net/core/dev.c         | 34 +++++++++++++++++++++++++++++-
 net/core/filter.c      | 44 +++++++++++----------------------------
 net/core/lwt_bpf.c     |  3 +++
 10 files changed, 126 insertions(+), 45 deletions(-)
---
base-commit: c0249d3a0c3cf082d56f4285647ddba19ef604a7
change-id: 20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-b907af839805

Cheers,
Ricardo


