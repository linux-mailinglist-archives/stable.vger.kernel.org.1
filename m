Return-Path: <stable+bounces-179161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29357B50E61
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 08:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554C71C809A6
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 06:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937AA31076C;
	Wed, 10 Sep 2025 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NMxKQyIq"
X-Original-To: stable@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829131076B;
	Wed, 10 Sep 2025 06:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486445; cv=none; b=ok/29JjgxWi/L5vOypGSZUIjXxDyRh3uIj2Qc2kNcKvAZKqA3HQ2g2i6YW170ZnHIk2NuJ5LcV8VqPNBH7InbAxgDSx6NhFO4aD3nDY4m98+CcwrGdJ7XYOG8++OKjQZawhzIagPOqwXRaVrLtG8rWCSSVRI5wBajDrF4Bs1ok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486445; c=relaxed/simple;
	bh=7jjRD8BTevaY7rS1pWoOxLrH6ISRJVP/bKev31mEkng=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KRouUt1i88Op6biTXfPwn7x6outKalu8RgHThZ3VcNpekV1cdjBrX1ryMC6l4f6WqGHKe44Pi0CC0Smmn75XyonWMsRBjmNWRoUpexHQozRjj6r74jUS5MsYX5Dc7oIGydjBVkEGk1uzSyZCkQT36lDfTHaNy7CaEnHdpujBn2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NMxKQyIq; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 722AEEC0278;
	Wed, 10 Sep 2025 02:40:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 02:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757486442; x=1757572842; bh=OWQWCqJ4zr2cR9931ynOENBrPmoeSoM6f+s
	8UfHmcZQ=; b=NMxKQyIqsV+4hmpmHYOHcVEue8A57DfTFChqozpiUOdBRDSNcJK
	Qsc1tUH5rjX2YW9XnzJnSjXC2gbAiIF6afkMsmScV23ehGQdtRgfr/cfxR758cFj
	PkVwvVFVyn3aQEoYttFuUgh154tVGIfomWcv4E9QKHkYyeYo8sZMjpv3ppzZvp1F
	kA9unavSGGgyyiaToLWzWEuHdA1g8Qzszo6oIbZgCMvLAHTsaepZAW+daGNjnBr4
	tcIpOg9JSaG1uhPU8C0a0wOV5GfB2wgfZfAQOBbY9wgAkL86cqZbQ472UvVvJAJy
	+2xVW8r88/7zwxOZDUES839Egt44ha/tZqQ==
X-ME-Sender: <xms:Zx3BaAZUsnSQ2E-K482BSo5TYgZ20eqXIipdRTCAN_zRlF6bOTjiKA>
    <xme:Zx3BaMuDOy09feaelUwWxHImuVsfmjw8hQeL0UFE8Xq-ua-429qPzn-c-WOvx-oja
    WlUMW8SIIa9wt3J9Ck>
X-ME-Received: <xmr:Zx3BaNbGDRL2iXrCufwse8uqy117dtMdir0HgB2xrvgdtwLmGuYz-yCOkYoZfUmxvyn6-e-Rn0xgQqC9qQtaGCM2p0Jlw1uOkLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepvdegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkvghnthdrohhvvghrshhtrhgvvghtsehlih
    hnuhigrdguvghvpdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrdguvghv
    pdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopegrmhgrihhnuggvgiesohhuthhlohhokhdrtghomhdprhgtphhtthhopegr
    nhhnrgdrshgthhhumhgrkhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepsghoqh
    hunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgvvghrtheslhhinhhu
    gidqmheikehkrdhorhhgpdhrtghpthhtohepihhofihorhhkvghrtdesghhmrghilhdrtg
    homhdprhgtphhtthhopehjohgvlhdrghhrrghnrgguohhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Zx3BaAQthzqmSYw39aO2VgYP9PxAdLi9hjYNcNQCGTj7FjplinTihg>
    <xmx:Zx3BaIzTi8c062zBH73nzXMBPfWDn0UND5dKemdmI1BxsLzDE7nR_g>
    <xmx:Zx3BaEctcdIo5UcSdZuTdSH2trc8Idp9vjrshCcy4XemvaIsV7QWZA>
    <xmx:Zx3BaBojm5dPEyideLjqfC5hG2lP0DfwiGN0ZgoUmbEYtDXeR3xltw>
    <xmx:ah3BaJqMfRY_qQLjBsH-3uDLhfe_dGA8I-vCOHl-krAinZNb0t6oyRVg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 02:40:38 -0400 (EDT)
Date: Wed, 10 Sep 2025 16:40:53 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org, 
    amaindex@outlook.com, anna.schumaker@oracle.com, boqun.feng@gmail.com, 
    geert@linux-m68k.org, ioworker0@gmail.com, joel.granados@kernel.org, 
    jstultz@google.com, leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org, 
    mingo@redhat.com, mingzhe.yang@ly.com, oak@helsinkinet.fi, 
    peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, 
    tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
In-Reply-To: <gtie7ylcuftmi2jgzviipxnvjzcds46eqce4fxxalbutwphbe4@erwrj3p7udrz>
Message-ID: <e94499dc-0155-0268-60a4-f9a11ad298a6@linux-m68k.org>
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov> <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org> <ufkr7rkg7rsfo6ovsnwz2gqf4mtmmevb3mququeukqlryzwzmz@x4chw22ojvnu>
 <bea3d81c-2b33-a89d-ae26-7d565a5d2217@linux-m68k.org> <gtie7ylcuftmi2jgzviipxnvjzcds46eqce4fxxalbutwphbe4@erwrj3p7udrz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 9 Sep 2025, Kent Overstreet wrote:

> Err, I believe the topic was just alignment and the breaking of commonly 
> held expectations :)
> 

...

> 
> Also, grep for READ_ONCE/WRITE_ONCE in the kernel tree if you want to 
> see how big the issue is

I'm already aware of the comment in include/asm-generic/rwonce.h about 
load tearing and 64-bit loads on 32-bit architectures. That's partly why I 
mentioned long long alignment on i386. Perhaps, for being so common, i386 
has generally lowered expectations?

