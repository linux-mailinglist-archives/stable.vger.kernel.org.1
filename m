Return-Path: <stable+bounces-114144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB94EA2AE93
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DED188B4C8
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE89239576;
	Thu,  6 Feb 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TStZ7Rp4"
X-Original-To: stable@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E823956E;
	Thu,  6 Feb 2025 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861918; cv=none; b=Jc9r8IdkicRkkYEpSuqjXEYFjsTJkSCco8Cp3w0gEUcI4EQPOXe096qoHg0rZlJbo3VgDOlE/CnOuollrrDd2gJXqA7RQoOrh7WLdhLIjr2fESYw0YzBfaOZpVHagBYtnvGAFKDXa3NaStMmcZBp6Jhm2TKrAOWVHfoRy/wSevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861918; c=relaxed/simple;
	bh=jzATJlyeMFLG0tJvSVPZWANhV89JpNE8JfVfoptwAn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYCX1NKUULkN4cXskTQoqRaDw+uG7J+kSDScUk4ruBdAnOr/xviq20Th9pMEmNoj7jy2baZYxAvKIYzAxPZshpwoUi6X+cIubeC5ZmUPUATJl0Oo/XPstpNJi4w0BAO/snjEEnp22770ORNLaGYc+LW4a/BsIn63ydL2BjdVhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TStZ7Rp4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8516213801E2;
	Thu,  6 Feb 2025 12:11:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 06 Feb 2025 12:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738861914; x=
	1738948314; bh=8IiLQnag1/qR/VX4wevEppCkYB3+GEEiCn4nJ4vFpgI=; b=T
	StZ7Rp41Goi+yohcg8CMTJYl23cHKlCXx3DoXL3h8klDNqSAq51WjQOtFf9P6g8B
	kjUmvEWHMf7ZGWb91EKro251O/Wk1y1PXl0JiS0RtmfpSN+wURotGFwnPHgW+rfu
	wlMRyMu0ZkG5UKETb87CDdlnhybKWzVKtdcqcNsZf9J1QmvPyCKOkZ7ZptTj6ZSD
	L9nOwUNC9bDrWl/LEmCkFFzY4CnjaABpMbOG7vHdpjOVsAgJfIP1MNH6yRItQPcA
	IYvJMTC0l380GirDvoL4eziXBb7lH56TjKfBAS4Q2vNT00ETciwxfOcWfA4yMPjP
	TaE6zQ74KksYG0Sv0GlKw==
X-ME-Sender: <xms:Wu2kZ1J7JnAarv7DnVgzxDat1LGN8hr95rH1eqno2ln8ySIM7O0PTA>
    <xme:Wu2kZxJKvGb0j9VGgDCMnUW9yyAHds41Ikk930rE9IEVSJB1UPtekZM2iQJxMRd2K
    I2G7y0CuM0tnGY>
X-ME-Received: <xmr:Wu2kZ9sNsMRALv6tdy9gh0ocJZngPQ_dFN0g4d9U1ls4hu4VungXRUpmRpvDkrMdw8mTGWQWcnmmhN6nQlf_5GWBNsWzNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepkeeggfeghfeuvdegtedtgedvuedvhfdujedv
    vdejteelvdeutdehheellefhhfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvgguuhhmrgiivghtse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehnihgtohhlrghsrdguihgthhhtvghlseei
    fihinhgurdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrlhgvkhhsrghnuggvrhdrlhhosg
    grkhhinhesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:Wu2kZ2YUMOAuqu1QZi3fi0iY12eWBxvjxvTbX056oKBqw16ltS_qMQ>
    <xmx:Wu2kZ8YXGCWp3T8tL--GkR8cwu4ph51UN1vgJVSasxPP80s_wW2Hhg>
    <xmx:Wu2kZ6CfDJBJXLXWA-U8rPEd8clTI6W3fJ560XuNGTq955EUK7bHAw>
    <xmx:Wu2kZ6ZI5wapSjiyFNErPva0KDDrJdS35TTGV0f2uoPH__UiocvYIg>
    <xmx:Wu2kZ8589NAMAfcTHRw6LQ9nyt1K0_XR_dKuX6YSMiQJhJSp6mD-OExK>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 12:11:53 -0500 (EST)
Date: Thu, 6 Feb 2025 19:11:50 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Eric Dumazet <edumazet@google.com>, nicolas.dichtel@6wind.com
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: advertise 'netns local' property via netlink
Message-ID: <Z6TtVlfe8XiWLyVB@shredder>
References: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
 <20250206165132.2898347-2-nicolas.dichtel@6wind.com>
 <CANn89iJO66n0OtC1axnkfukm=vD5AacHcuxXh3sUvyTXdSy-TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJO66n0OtC1axnkfukm=vD5AacHcuxXh3sUvyTXdSy-TQ@mail.gmail.com>

On Thu, Feb 06, 2025 at 05:59:03PM +0100, Eric Dumazet wrote:
> On Thu, Feb 6, 2025 at 5:51 PM Nicolas Dichtel
> > @@ -2229,6 +2231,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
> >         [IFLA_ALLMULTI]         = { .type = NLA_REJECT },
> >         [IFLA_GSO_IPV4_MAX_SIZE]        = NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
> >         [IFLA_GRO_IPV4_MAX_SIZE]        = { .type = NLA_U32 },
> > +       [IFLA_NETNS_LOCAL]      = { .type = NLA_U8 },
> 
> As this is a read-only attribute, I would suggest NLA_REJECT

And please update the spec:
Documentation/netlink/specs/rt_link.yaml

