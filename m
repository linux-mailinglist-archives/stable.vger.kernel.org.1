Return-Path: <stable+bounces-136860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0336EA9EFA7
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7623AECF7
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C600159B71;
	Mon, 28 Apr 2025 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="F+wDp3PJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nm1HzUA9"
X-Original-To: stable@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88E4A21
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841010; cv=none; b=opY1+gO0kVO+NmmxVQLwMaePQQ8KqkHzxtn5F6G2Q0lQVIo9RKOur2GuiWNbq7UXr/ylAZyCb9zx69WkCpdInFTo0T7N9eBblcm2gMB69/wB+2TZjSZrvbofeb8u5b9gna1lML0pokw9BfDjqtRnth/w7hIL7+PwW6my4ZFwCRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841010; c=relaxed/simple;
	bh=72Y9mMqiW4+aTUHANvGRIu+qQU1TD9NX6ZfCeMAkMGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjN7j0T/El3h5Zi2zPdkG4hJopbITPiS295irORXexYvTxREWP9za0XNJBfSBJhX+tx2wDf9X3s/pIgwWHnO21xgQd9rfDmadGFny8pABp8zE8IjzrzOESrW3zaEhGto6EtVgHxNvEEc1dyc2gP6ymdw9VBkfr/qwUIXCc05EHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=F+wDp3PJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nm1HzUA9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F13913801CB;
	Mon, 28 Apr 2025 07:50:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 28 Apr 2025 07:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745841006; x=1745927406; bh=bR0Udwdu2C
	TPDC3iJi3jJ5bNAIV6jrJ3l81y2pVMUeo=; b=F+wDp3PJPW6KGRR8tQQ3t6FUbi
	0lSJNNmuTsMtImP1B0+KbFq3snBbtsMIEqo0t+a8EPLMoqW5aZjRpkx03hr5QUIA
	YxS7Hg0xjw58hu1BWRa5pXyIoJ788lu1k60nYapsfZICSFnv7qJLt7c2Dc08cgdE
	Pr5yhyHnfzA5RQNp1Bj7HXMokP+o2tBtfep8aM2W4UMFrvveOx4A5BdJhnzTaRpB
	1T6Z+M7TMCu4nVqKJEY5lEBpodJ8hvM0UgKtMOUXQAUKvRag8b9+EgOKFp0KNd+h
	DhwZeb+Fi7abQQUAiF/kHDfLR2nYYXzcI75Cioq1O7kvUur/lNgDclttVtyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745841006; x=1745927406; bh=bR0Udwdu2CTPDC3iJi3jJ5bNAIV6jrJ3l81
	y2pVMUeo=; b=nm1HzUA9stacQg/NfnM156B8aBMBLx0zKadx8si+F10LUpZLDCf
	X9DyuZufOY+NRAyK+l2xHOhbiQ/3CtQ1vW1VaXCwO+SkGf1R+D62X1mY5b/jKxh1
	S/ulzPCtDIoTCXSX6rCBRCINjL2fn3XN0iDGuvQcbIkfXIz0LZUU6y6QDjQkgwh4
	HniwIHPXMPjADOXLLaRxJ3wSkuACN9U2BShXTsMpLIz2VX1lbNTQSB3oGpBhjaoG
	sZqVqulYLp/preru7PI6OYRmf2VAKkKIsAKbgz0YthlMH0OYSOnQXleJsn8Sx7Pp
	DPnGNlUQhfxK6FpUEy9a1q3CTSIBJqSbgTg==
X-ME-Sender: <xms:bGsPaFx1SRslGDt-8VfhUpstyc0HKRUWOnYKvF26-YMLfFot5bS6Nw>
    <xme:bGsPaFS8fd4I7zmkYKsyqAMEf8QMO1L4lfqWGX8Yl_x5HTMkIUNGAAEqsfqJVJAXh
    6AHTWtVV3pHpQ>
X-ME-Received: <xmr:bGsPaPX_jB_lwNPwZHEYI2-U8lbFcnCkfwyvZh9ZFZ6z9TDEh-brCDzGuPnSufwgxj08E-MmLYAEBqeKg9VizQcy6uijcqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudef
    feelvedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfh
    ifsehsthhrlhgvnhdruggvpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphgrsghlohesnhgvthhfihhlthgvrhdrohhrghdprh
    gtphhtthhopehlihhnuhigsehslhgrvhhinhhordhskh
X-ME-Proxy: <xmx:bGsPaHiFvs2RVDspGJfph4FSv0dvTPd134jLUOmCEHqr2k7v_9OPiQ>
    <xmx:bGsPaHBo7BzsxguPo4ZmYkbNKSZygH6foMi_mF_FEzmCFZpSpUUabQ>
    <xmx:bGsPaAK0o57cWP-QugU1treZrnECYIY-Ch0dzH4RA05f82HQOsPGdQ>
    <xmx:bGsPaGAC479yEUw5_BfPW0iaeL1f8FXetAv1ehNOGIJdYW2RvlJ7Iw>
    <xmx:bmsPaHbJJIpxGQRCXgkHwN5wyan10U2UnMkrMcpAkEkHDt7aBUWFKN1P>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 07:50:03 -0400 (EDT)
Date: Mon, 28 Apr 2025 13:50:01 +0200
From: Greg KH <greg@kroah.com>
To: Florian Westphal <fw@strlen.de>
Cc: stable@vger.kernel.org, pablo@netfilter.org, linux@slavino.sk
Subject: Re: stable request: eaaff9b6702e ("netfilter: fib: avoid lookup if
 socket is available")
Message-ID: <2025042856-skimming-storm-a49b@gregkh>
References: <20250424183306.GA24548@breakpoint.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424183306.GA24548@breakpoint.cc>

On Thu, Apr 24, 2025 at 08:33:06PM +0200, Florian Westphal wrote:
> Hi Greg, hi Sasha,
> 
> Could you please queue up
> 
> eaaff9b6702e ("netfilter: fib: avoid lookup if socket is available")
> 
> for 6.14 and 6.12?
> 
> Unfortunately I did not realize that the missing handling of
> 'input' is not just a missing optimization but an actual bug fix, else
> I would have split this patch in two.
> 
> The bug exists since 5.19, but its not a regression ('never worked').
> 
> Given noone noticed/reported this until this week
> (https://lore.kernel.org/netfilter/20250422114352.GA2092@breakpoint.cc/),
> we think it makes sense to only apply this to the two most recent trees
> and keep the rest as-is, users of those trees evidently don't use the
> b0rken configuration or they would have complained long ago.
> 
> The commit cherry-picks cleanly to both.
> If you disagree let me know, I could also make a stable-only patch that
> only contains the bug fix part of the mentioned commit.

Now queued up, thanks.

greg k-h

