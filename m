Return-Path: <stable+bounces-60781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A919893A147
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 15:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601831F22B04
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FDF15279E;
	Tue, 23 Jul 2024 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ToAhECGa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287BD152790
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741089; cv=none; b=FApO1Bm5ts883JkYVDMzYyK1BdgN7RUJjE84vRPQCLeMshvQhxxNh56Sn++sebJVuxtFKc6VASrRqZo72NzIAbjARdLJZKvr2ft11vI4ZwrAq0gUZ6oSj1sRZU+xydE1XKEyE1VStvAlKuzItxWnQLsHljmM6C1wIFkaFdMeOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741089; c=relaxed/simple;
	bh=L5SDjP+fZFTHodafASbJ05dKRPUxy6REP5RUNEO42CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3mSCWij5tPJOEVZjBMmP3GTyxnHdHLYw8Kd63rnRQmJGIjUMJXhXDS7EQoJNBPJekCNpoG8195zrwX2MbC3SxKVSXE36NjncG4krRt4XGpGNGkFq/vKtcfVWY7ba4+nA1vhvHmQgprvwj9EY/FxMNwVAl+3V5ilpDzZlj/Zojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ToAhECGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699E3C4AF09;
	Tue, 23 Jul 2024 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721741088;
	bh=L5SDjP+fZFTHodafASbJ05dKRPUxy6REP5RUNEO42CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToAhECGa+qF0NQL03QEoLPfy6s+RW70ukyahOwVHXP1408uOe3qbcTKuUDseK46VV
	 tnKA67Ae2vDn4SKfRhUzkVdFZMBTRIQMQJe5uUCbkWugAmZqRN3GRMqpzBqJgrM++/
	 eOr/XXFB/MN7q93FZ4T9wAmc5zk4IGe4gt+as4wU=
Date: Tue, 23 Jul 2024 15:24:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 5.10] bpf: Fix overrunning reservations in ringbuf
Message-ID: <2024072339-aneurism-unclaimed-bda2@gregkh>
References: <20240717065946.1336705-1-dominique.martinet@atmark-techno.com>
 <ZpeEo2nt-9vOPzg7@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpeEo2nt-9vOPzg7@atmark-techno.com>

On Wed, Jul 17, 2024 at 05:45:23PM +0900, Dominique Martinet wrote:
> Dominique Martinet wrote on Wed, Jul 17, 2024 at 03:59:46PM +0900:
> > The only conflict with the patch was in the comment at top of the patch
> > (the commit that had changed this comment, 583c1f420173 ("bpf: Define
> > new BPF_MAP_TYPE_USER_RINGBUF map type"), has nothing to do with this
> > fix), so I went ahead with it.
> > 
> > I'm not familiar with the ringbuf code but it doesn't look too wrong to
> > me at first glance; and with this all stable branches are covered.
> 
> I need a bit more sleep; that obviously missed 5.15 which didn't get
> the fix backported either due to the same conflict; this commit applies
> to both branches.
> 
> I've also checked something like bpftrace which uses the ring buffer for
> message passing doesn't blow up when spamming a bit on 5.10, just in
> case.

Both now queued up, thanks.

greg k-h

