Return-Path: <stable+bounces-119722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68081A466D5
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 17:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B712441ACB
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C2F21D3EF;
	Wed, 26 Feb 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WgAq2V8Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hf8rzer5"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE41F16B
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587523; cv=none; b=KrVw68kd+cdrw2m73e4e2Af2/XkHctHC8XR1cCcYYkGMQjieoILx1e79yqqsLP9NhHlrQ2Z+MbS6Ya7c3y42KADytRMupqCkoEQevRNvCtZX7STQsX9UIVJBZ4hIzC2xUUg0/XHk7sjNVujAU4WfiCVxtB7WeTBaXuyomXM9lVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587523; c=relaxed/simple;
	bh=7qwh/zSAp/fpuTMuSt8AlczM+uNYnfBgtTKyWUmulV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gial2pX2ZvNYG6BluPcssUYaKHCJ4YFNc5nFtJ5DnI0I6UJ1LmHd/quJ3L7lmYh3AA5mmnFsgbt9fRK0pjrd49wVSvAjQiesV9mTROttdO4KvC+9laV9auCGjoDW/zLoFGGblkGnncQOm2YaAA4sKNtPkASV54hj3bIU4od6eK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WgAq2V8Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hf8rzer5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 17:31:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740587520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qwh/zSAp/fpuTMuSt8AlczM+uNYnfBgtTKyWUmulV4=;
	b=WgAq2V8QpKXHscWdecCkD3JsfyAEwKxkHnDtkq6NY1JVy4FKtyL6D2M0F8EQRHIGg5MYaA
	ORXfLPr2jQy85ZtrBtOC4AeB8WdhRkEuY4S/RgV0mxySbwFt6nLFHHXEB2Djr9mGoAe3BL
	/kcNeFfMJ5OzdvFi1Ff2pon8v1AeoVATv6Lw9Ml16u1j+64Op3f+66xDA6gH6MMMrwoU/u
	zRmkYfkLXpKv69E1ddJnFWlGAAzTHsxJUU4Zg4INXJ7oPMTqPKDHFBI/g3qMtkFtAoPoSB
	YF+EuZMbwQV5OfS7JQ1vKjoihw855gyT3sHRDAaQ2wOSQOGv+ndTLeBFc1XW/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740587520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qwh/zSAp/fpuTMuSt8AlczM+uNYnfBgtTKyWUmulV4=;
	b=hf8rzer5dPPEHjazU+ev4eLXg6q5BbrFQ3VnvIcu6D+8X4C4JcM3cswRWHzSt/MI8ZTpY4
	mD0ugijO8ojG9ZBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
Cc: stable@vger.kernel.org, revest@google.com, kernel-dev@igalia.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+0b5c75599f1d872bea6f@syzkaller.appspotmail.com,
	syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com,
	syzbot+c1e04a422bbc0f0f2921@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>,
	syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	syzbot+3c2b6d5d4bec3b904933@syzkaller.appspotmail.com,
	syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com,
	syzbot+c226757eb784a9da3e8b@syzkaller.appspotmail.com,
	syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com,
	syzbot+709e4c85c904bcd62735@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.6 v3 0/3] Set the bpf_net_context before invoking BPF
 XDP in the TUN driver
Message-ID: <20250226163158.krCJgret@linutronix.de>
References: <20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-0-360efec441ba@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-0-360efec441ba@igalia.com>

On 2025-02-26 10:39:04 [+0100], Ricardo Ca=C3=B1uelo Navarro wrote:
> A private syzbot instance reported "KASAN: slab-use-after-free Read in
> dev_map_enqueue" under some runtime environments.
>=20
> Upstream patch fecef4cd42c6 ("tun: Assign missing bpf_net_context")
> fixes the issue. In order to bring this patch to stable v6.6 it's also
> necessary to bring upstream patch 401cb7dae813 ("net: Reference
> bpf_redirect_info via task_struct on PREEMPT_RT.") as a dependency.

Just to be clear: A problem exists in v6.6 independent of my doing and
401cb7dae813 happens to fix it? The commit fecef4cd42c6 is a fixup for
401cb7dae813.

If so, can you share syzbot's reproducer and/or backtrace/ report?

Sebastian

