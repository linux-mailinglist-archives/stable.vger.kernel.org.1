Return-Path: <stable+bounces-119852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F27A48578
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 17:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD94A1770C2
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA81ACEB5;
	Thu, 27 Feb 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tMbnI/RH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gqyi57sL"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA361A38E3
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673887; cv=none; b=D6oHoTmhPYZYTskl3vE2oTWgvC6hZviXrDKJUWr30kU8p/00hka7lozGBjkJsaSuceTMDWQUpZD6XYUbE24jm+bkqIfB+Rbl2+nfd3FB3irUJp9Gw4lXd9NJ5EMGAvm94aYLBG1kmglOfWtNY/f/dw2nWE5gqGCcreKaoLJdxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673887; c=relaxed/simple;
	bh=mwJBHwkHwdNM/VutVuXI6pqXHE8qIZjhH8Jat4VDczY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EO0IGFDI9SK7PQBWWsy+8pGq98dGNljy3grOz0jTsx6vIr0BMIC3/i+/lHAQ9OVqhdoiL/8/LKKNkKmLLUyc8LDS7y0kRpgF1xsRMixRReFN009CuWLmWiFjp+YubjxP6OCnLfTnY1LjgWHt+unHqAiev2MCOSRUEhFP1GqH9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tMbnI/RH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gqyi57sL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 17:31:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740673883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwJBHwkHwdNM/VutVuXI6pqXHE8qIZjhH8Jat4VDczY=;
	b=tMbnI/RHFUh2uLlNpZea3oZ+4mLIKeOIL/fhhRpN5BTr76GWs5NAKFCA16WUjCitwlB5pv
	ZBKSsH63O2JZdrKuPJ3TCZnnadthOKERlUh9aBQdehgynTAuoa0tPQB7p+O56RDeWimhQj
	/1vhIyQAlA53oCmyEbAiy5XrKAIfCVcZvAei/HUIt/UXhpfXhfuT7fdFy/InzCQNJfxsdb
	rrai1EG13IRoR8rc2zvCfzgTdvtxGCpsxr8y38ie4xqa6Xnw5YCnIppp2BcslKvflFRDDi
	XDaiRo9n2CuVIypZOMm1L1t45wtdo/RabOmO5bWCSizkilVmQGC/a9RpOKmL0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740673883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwJBHwkHwdNM/VutVuXI6pqXHE8qIZjhH8Jat4VDczY=;
	b=gqyi57sL/sk9TVflqB5ofTWiZtXE8YFgSHOaARvcl1pyvrd8jIvXMMYsZGLoFznbPGee8H
	BR3SgTCz41OU53BQ==
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
Message-ID: <20250227163121.w3MmV3vF@linutronix.de>
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
> Both patches needed some manual work in order to be applied on stable,
> mostly related to changes in the context lines:

Did the same rebase and came to the same set of patches so
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Based on KASAN report Ricardo provided it is the dst->dev dereference in
dev_map_enqueue(). This originates from bpf_redirect_info::tgt_value
which is a per-CPU variable. It is assigned in __bpf_xdp_redirect_map().=20
Since it is claimed that this patches fix it, the bot must have found a
way to share the per-CPU data with another instance/ thread.
Haven't figured out how=E2=80=A6

> Signed-off-by: Ricardo Ca=C3=B1uelo Navarro <rcn@igalia.com>

Sebastian

