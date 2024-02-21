Return-Path: <stable+bounces-21826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2F285D66A
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 12:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90EC284209
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF833E47C;
	Wed, 21 Feb 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="rEmQOMPd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WeV5Nr7I"
X-Original-To: stable@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE13D38F
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513445; cv=none; b=Pw++jj0vFPvn6j6iJCQCS94lImWG2sLI61NWQOBy8HFaLrl70JdmnPE8x0XIyzrjjgredB041T4Om/QH4dD39YPwD84xZ/gvmRDLkZDC7nIaEO2MFOMT/yMeUoDboX9CYixdCD7fUgc8g0Wth9b+SHtjc/Eu7LgNvI+YPY/LRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513445; c=relaxed/simple;
	bh=rrONVI6mZW5HzkAjsrD2hDchFyIXci1fuo6XPPAWu0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QO1iboBSXT4sYOy9wGggW03gR5HTIZTiqJBF0caUkQC8lTLcobmK+yJU2GA7t/Ka4qhLLFYG7MD71XEars6rou8EMiIvC64t82PSyMq22mw0zbqQCKGwsXQ803w/S4FtSwaUIAxTbVr+2LBx/g1oRcBq6r/py9vLqX18z9BnRB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=rEmQOMPd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WeV5Nr7I; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 116881380099;
	Wed, 21 Feb 2024 06:04:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 21 Feb 2024 06:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708513443; x=1708599843; bh=LiAOK7MGQ8
	wQYIPql0pnZda2s+dJQUn0FX0ghboecNQ=; b=rEmQOMPdenSUG8ry+BPqr5hZCJ
	S28FLumm2OzpKiVhwCqfkEJjBt5cBuHG/ZMjFy0+3ucSdLHjkIRsl2dXmBWcg2JZ
	OUlLo0UgMO/g2TzOxhkrzy2By0u4uCgO2sErztL60gIH2YKOpnol6Qf9qWTfXmEg
	qhkc53vzfcbKuSA+h/EzqasKOMcLbghuMkbVrAiLOKMrPpQKaf/lryjbQDsKYNio
	g1Vaqrtrq2pYG/q1+ApZrA66OKbvOU3k7EPZ+cYrLPgzvonNGz8eGNEQ0F4IK4n5
	Hur50ivfIYdh9vnpm2rp3XFlsJ/tQprK/vyChnmfgQnTjkUunkM0yNLT12yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708513443; x=1708599843; bh=LiAOK7MGQ8wQYIPql0pnZda2s+dJ
	QUn0FX0ghboecNQ=; b=WeV5Nr7IEP45PScTnNJyBHAQwo8QZgylSmYgcfJVIxLh
	PRQnl+UCMnWRQ8ReecMKi2nCwurIPTnsAB0AadMa/sOI55tfMLsXfxhmq2nLRn0w
	v5QweVs1DjETyHXcy2xgrvaWObiT+o6AVf2hixd6wMKbgHVoo+mnu7tsO4dK+Iop
	H3/TvVYAAweYTGVhkMG1hBUhBrfNzGiYPOOjpts7z1ZeAN7GYek1KTOhWGF1u/Vf
	DwnoQC4yOQvj59rpqtZlWbxVWWO+3FF0Aifss/kxf9sfwg/Ri33FmgJYnJ++Ku1Y
	cvuVBdttYx93KAdBgfU+uYPThMNfgx3gW36AWTRa8w==
X-ME-Sender: <xms:otjVZZasNEw3u7DjIDAHhBtCUDK85DrYdvCEk2BE1CoDYdoRRHaq9g>
    <xme:otjVZQZcujt26Y9xEp_7ksQJqedsPYlSaZ0dsGBKZd39JaXpZNJyjiKXC-tI-oOVa
    qX1yfqsyc2pdA>
X-ME-Received: <xmr:otjVZb_q7t2a58ESktCgcSLbZn41OzSEDQg0_X2vWu-o4K7JDZxiEdYQXoKjnz9fK6xJ3qgYouTkeBBhNu3mQGRZIMvJuQVR6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:otjVZXr5mHT2bCUJTuXlfXlogJBMsxoV_i3kvTe1Brgd3ZQfWlqk-g>
    <xmx:otjVZUqZARprHkyknqclhOKbDso255eRMtSPrtysV5l4wnFiYDUfQQ>
    <xmx:otjVZdRchX8hdXAtschMBvYsmVT9MrDDUj0ZziSKg17B1iZ5oYYnDA>
    <xmx:o9jVZdmNQJPZQPBGWphWxDl6EbgqQjgHLjGYMRvrmXvGh12JyaPRQw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 06:04:02 -0500 (EST)
Date: Wed, 21 Feb 2024 12:04:01 +0100
From: Greg KH <greg@kroah.com>
To: "Doebel, Bjoern" <doebel@amazon.de>
Cc: stable@vger.kernel.org
Subject: Re: Backport commit fc4992458e0a ("fs/ntfs3: Add null pointer
 checks")
Message-ID: <2024022155-kissing-chuck-466f@gregkh>
References: <67c3ec91-2879-4a6e-9213-b147aaef74ff@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c3ec91-2879-4a6e-9213-b147aaef74ff@amazon.de>

On Tue, Feb 13, 2024 at 02:00:25PM +0100, Doebel, Bjoern wrote:
> Hi,
> 
> please backport commit fc4992458e0a ("fs/ntfs3: Add null pointer checks") to the 5.15 and 6.1 stable branches.
> 
> Commit message
> 
> """
> Added null pointer checks in function ntfs_security_init.
> Also added le32_to_cpu in functions ntfs_security_init and indx_read.
> """
> 
> We are able to reproduce below Syzkaller report on these two stable builds. The issue does not reproduce on upstream, older, or newer LTS releases. Above patch fixes the issue.

Now queued up,t hanks.

greg k-h

