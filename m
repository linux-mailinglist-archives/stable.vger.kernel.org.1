Return-Path: <stable+bounces-146448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1DCAC515B
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A449F16C506
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 14:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1C4278E5A;
	Tue, 27 May 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Yb36hvEa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D9jPvhbM"
X-Original-To: stable@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D96C2741CD;
	Tue, 27 May 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357627; cv=none; b=EQo+cuQzGz5OkuD/CzjQNvD+AvWUqjSC8QBVHGoXbDPPSPhuUDyvn+GdyB7AmH/x9jSMlEq2uqsV1Tv4Q1vGlKthA7Tq6a+B66BfVuKkMofWcEcSb/XMzBzeczeJqP226R3PCqTTPt8zLfSuPQ5Nv2i1iLlWkfjSm7XHa+lqrdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357627; c=relaxed/simple;
	bh=3nxwOeg6ETo7LH7s94m2L3YQAfi8dMXmqj1zk7Sp7Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFTdR7QiwSFxE56s1a+tmRF3+n5dUjFN7k+NYWJ3g+FpT7YQvpvjuyfTeXrrPdteyce8Aa+pq3qMCI+RGFSc3hpwC6sCOmqYwRWYGzi0Pa566SRbQVikWG2mCavpehQMjZp4kDZrg9UUupiL3pvhAeNbgzLtX9HTcTt07lgIh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Yb36hvEa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D9jPvhbM; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 2C2191D4085B;
	Tue, 27 May 2025 10:53:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 27 May 2025 10:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748357622;
	 x=1748364822; bh=zQ/DY/4NQ5d7L/53CKMQRUA5FIeSr2CH8TIXMMREa1c=; b=
	Yb36hvEapLkjeie5aGI1MeLJG7oZk3+sKn+rCDpXDuyo1rNuSnMG8gwZ3WrK2nPa
	HqWHfxZEVUBI184GPy4GJEOWhmi319V7EAEP1tBrxtrGQJcrB8Q1sPwWaVGQymr9
	MNZGmrHooWTT3I026PetD1UGFemGsK5WTuWV2f/PoCfjoFWKj4IxhvFXUIh69Sp7
	q6PUR6iIAWPyCw5yQHj0R/1X8XTClap7+a5dwyX7p5qDbRE21K0XpBduKReKKh+W
	hN+iNxqNsgRXv+P0/pN8Vovl6s4E/7g79hbulFjK2iYztgUCaWeRFmtlkSnS0MjV
	wOJiUfY+p3QnJzPtvcWOUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748357622; x=
	1748364822; bh=zQ/DY/4NQ5d7L/53CKMQRUA5FIeSr2CH8TIXMMREa1c=; b=D
	9jPvhbMjqog2/RNenzqtxaSu/i3Lc1upMmAzd2PlDaLMY/MOePqf5sa9jWqnDwWI
	Y2JUi0iR8+jzdHzKE2FoUCLzE5wcfI3WZve0qYEvAnm4aE01KydPlYN+RaFTrj3r
	QvOFVuF/BMydjLH+H0TUZnQ8vGZ+K308Fweo9WHCy+FBzDKV0jan/gvQt6C52dv0
	PX27WnKcKfCN/5nZZjMj1sXqqhnYy5/4ZHRLZoR747pBSB2BCYXuJUCzNOP15lIX
	gF9Fy3ZOa6v5TfZoYDAWsDThcYpob/aKBwSpdeYjSy7ynRkTAgxURn1e3b1j0Emi
	GI3tsc0Wdd83cSf1Btuww==
X-ME-Sender: <xms:9dE1aEIO9nmlo9HNAneyRNvE2UjKv7xToTiSU8kA7HgeTrRvT8CnXA>
    <xme:9dE1aEJ6YafjcEQi_c8Fh7dBcK7DRpB7Ego1s_dMmfd8GuBFJNsRtiTl9lB5DqGwS
    DTY4OC6Mu3Hqw>
X-ME-Received: <xmr:9dE1aEuykMC__yKvkxsJeTMtY4IIBl8gicEBTiKe75cUpoGEGQG8_Y82Ox57vS6qE1DsD156CEqijgeBpAsYNj4nlm5SrqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdeiieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskh
    hrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepleekheejjeeiheejvdetheejveek
    udegueeigfefudefgfffhfefteeuieekudefnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    rhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepgeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgt
    phhtthhopehkvghrnhgvlhhjrghsohhngihinhhgsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshht
    rggslhgvqdgtohhmmhhithhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggr
    rhgsohigrdhnvghtpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhg
    sehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9dE1aBa40qlrQ9Cr5xMnhoha7PAHHJopi_0rDwN35bps9wGAJcGtjw>
    <xmx:9dE1aLbpp6SQ_MeLt-LVncBfCFLtYFQ-eqHK-HBB7IwvUgqmGSmvjA>
    <xmx:9dE1aNCiJsC6gDHETSiJH5KxIvZ1YfkdwFfMFONiaf-hCoCMBhhNKQ>
    <xmx:9dE1aBbEF3EbtP8j_msC3AqYnDygSmA-t6k1ec3_QHak36vztdDVAQ>
    <xmx:9tE1aJ4tONabWCY_bkqGfZeot1f1A3u8JJemg3iap-M28fIWnb9hSM3K>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:53:40 -0400 (EDT)
Date: Tue, 27 May 2025 16:53:38 +0200
From: Greg KH <greg@kroah.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jason Xing <kerneljasonxing@gmail.com>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Subject: Re: Patch "bpf: Prevent unsafe access to the sock fields in the BPF
 timestamping callback" has been added to the 6.1-stable tree
Message-ID: <2025052729-uphold-punctuate-1b57@gregkh>
References: <20250522231656.3254864-1-sashal@kernel.org>
 <CAL+tcoBEGozJ1Zs2c0L-kG=ZTVfPGXdshQxs7nCxwr-NhZoUPw@mail.gmail.com>
 <69d1a996-5eaa-4af9-978d-c59c70a95438@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69d1a996-5eaa-4af9-978d-c59c70a95438@linux.dev>

On Fri, May 23, 2025 at 04:17:21PM -0700, Martin KaFai Lau wrote:
> On 5/22/25 4:25 PM, Jason Xing wrote:
> > On Fri, May 23, 2025 at 7:17 AM Sasha Levin <sashal@kernel.org> wrote:
> > > 
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >      bpf: Prevent unsafe access to the sock fields in the BPF timestamping callback
> > > 
> > > to the 6.1-stable tree which can be found at:
> > >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >       bpf-prevent-unsafe-access-to-the-sock-fields-in-the-.patch
> > > and it can be found in the queue-6.1 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > Hi,
> > 
> > I'm notified that this patch has been added into many branches, which
> > is against my expectations. The BPF timestaping feature was
> > implemented in 6.14 and the patch you are handling is just one of them.
> > 
> > The function of this patch prevents unexpected bpf programs using this
> > feature from triggering
> > fatal problems. So, IMHO, we don't need this patch in all the
> > older/stable branches:)
> > 
> > Thanks,
> > Jason
> > 
> > 
> > > 
> > > 
> > > 
> > > commit 00b709040e0fdf5949dfbf02f38521e0b10943ac
> > > Author: Jason Xing <kerneljasonxing@gmail.com>
> > > Date:   Thu Feb 20 15:29:31 2025 +0800
> > > 
> > >      bpf: Prevent unsafe access to the sock fields in the BPF timestamping callback
> > > 
> > >      [ Upstream commit fd93eaffb3f977b23bc0a48d4c8616e654fcf133 ]
> > > 
> > >      The subsequent patch will implement BPF TX timestamping. It will
> 
> Agree. The patch is a preparation work for the new bpf tx timestamping
> feature. It is not stable material.

Dropped from everywhere, thanks.

greg k-h

