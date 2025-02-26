Return-Path: <stable+bounces-119725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C366FA4679B
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9837A89D1
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B912248BA;
	Wed, 26 Feb 2025 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="McDrWSjy"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA09E22423E
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589976; cv=none; b=NuxGr7YmyS0qeR/Lly2tupve94B4Xlt39waCCYQlra+ANt1nIkEQ4QX80iTFL/2Uw1rTeYlvhiWM7UnI4VGz50byCzlyfooVBRpZjPBYQ/k6xXo+atLIAHP5TTm/GgQ13nawUApHJLAimC+/GJcStcxOCqWHgvUz+sf6qKBgZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589976; c=relaxed/simple;
	bh=urXId5PRG3Bx9zO++mSWyxLAMpq+LMgJcwpKLvdA4yQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sRTsSmRe1lL2+5KuBoiwzGcGJLR7sOPaZOBB5eVf6BgJDuy8nDAWyqoe2okvxeESeAVEoFm9xWHSeoh7kwfLsnt59yqlNmw3wFeMiRevl/c6aMo8o+A37RCSFeb/+HaPl8P9Tg5fGZOJNrvpi2AFFalaHEidUWvws4KgUKYGTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=McDrWSjy; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=urXId5PRG3Bx9zO++mSWyxLAMpq+LMgJcwpKLvdA4yQ=; b=McDrWSjyV/ZfVVWU6/OEeufDEy
	LoXiC81WKgvoTkkx5W5Gm3Ix13lIlHQ4eRe5ON+asMYuVq0+M1nU9QlJ737Xp+0bnKri7ccDVb0hb
	rs9eOKpGqxalSj1/XeAG8yNjrzs6xr8p1mZbxX1Hfc/4cdTUUrnSE46Hfjc3YijRBDR79BXiHnyXD
	RAix79/qkkVvE9cEwhDcuxVyY3OqrBDmFGxAZvmQnmV+BSKaQHWbkzR/e1rF3Nx/Cg6PHJQNXXvOd
	/fR68c0HLgy73t0L+k6TcESdHW3yk5kMqkbaJisxhtCxBXjDpsxnZcTMAagSjG3V+h1GB7Npy57AC
	ou+yT8xg==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnKxb-0014jn-OX; Wed, 26 Feb 2025 18:12:45 +0100
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, revest@google.com, kernel-dev@igalia.com, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>, Alexei
 Starovoitov <ast@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Jakub
 Kicinski
 <kuba@kernel.org>, syzbot+0b5c75599f1d872bea6f@syzkaller.appspotmail.com,
 syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com,
 syzbot+c1e04a422bbc0f0f2921@syzkaller.appspotmail.com, Jeongjun Park
 <aha310510@gmail.com>,
 syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com, Jason Wang
 <jasowang@redhat.com>, Willem de Bruijn <willemb@google.com>,
 syzbot+3c2b6d5d4bec3b904933@syzkaller.appspotmail.com,
 syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com,
 syzbot+c226757eb784a9da3e8b@syzkaller.appspotmail.com,
 syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com,
 syzbot+709e4c85c904bcd62735@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: [PATCH 6.6 v3 0/3] Set the bpf_net_context before invoking BPF
 XDP in the TUN driver
In-Reply-To: <20250226163158.krCJgret@linutronix.de>
References: <20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-0-360efec441ba@igalia.com>
 <20250226163158.krCJgret@linutronix.de>
Date: Wed, 26 Feb 2025 18:12:44 +0100
Message-ID: <87zfi8y6ib.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Sebastian, thanks for answering.

On Wed, Feb 26 2025 at 17:31:58, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> Just to be clear: A problem exists in v6.6 independent of my doing and
> 401cb7dae813 happens to fix it? The commit fecef4cd42c6 is a fixup for
> 401cb7dae813.
>
> If so, can you share syzbot's reproducer and/or backtrace/ report?

Actually, it's fecef4cd42c6 the one that fixes the issue, but
401cb7dae813 is needed for it to work: it implements the bpf_net_ctx_*()
api, then fecef4cd42c6 uses bpf_net_ctx_set() and bpf_net_ctx_clear() in
the tun driver.

Here's the syzkaller report on stable v6.6:
https://pastebin.com/yD0zVD0c

and here's the C reproducer:
https://pastebin.com/d415fUDU

Cheers,
Ricardo

