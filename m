Return-Path: <stable+bounces-50470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0BA9066F3
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBBB2840E6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A40213CFB6;
	Thu, 13 Jun 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ghQiA9GS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4213D524
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267609; cv=none; b=buSuKu0zVkcOyOMNUxTzrK8+/56rID6iVNJfyLkQPW2WIbacRqKf+tIElntFQxbqgkjUIr/ROqgBqUNOzwMbMxuX3WV9SeDFl6t8SOkeFXEF+V4iBuH4fK+7d2S8CHaQXsJsMi5vx5eMWsw7ZxkR8F8kb63ngPfoBjrqjpqGHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267609; c=relaxed/simple;
	bh=ztyRR14ZxwtHr5xm9JjEwek+GKid0B1Ocmbh909czhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB5XLWfxM+P0FLfNh1deATq8lzivvUjteiDOdUB+DGtUiLWQRAfzkvfKZbc/4XbkzAmSNAZ0iT66pzG3FBt0B9gH63m88aO2koa7e2jM1PU5zFRRzRHnjfJonjjTkPhOwMixNIav8r3actXUsa00YgB6on5hEeXAp3Lj80XBX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ghQiA9GS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EC9C2BBFC;
	Thu, 13 Jun 2024 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718267609;
	bh=ztyRR14ZxwtHr5xm9JjEwek+GKid0B1Ocmbh909czhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghQiA9GSpgNwYJTqz0rufLWObDg2LOHyQj2zp2GVZ4gM5hn5gobq9sCG8eI4uvh2Q
	 Yl+4HicXorhVJpcmeu+fg9MDlmnEsG9AE6TWLjxKhncb1vo0AvAdvBfQmvFx81kmwC
	 Trf6HgNp8tI+NC57Y6wIKxpbFERtbEQ8NI45hWIo=
Date: Thu, 13 Jun 2024 10:33:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH stable 5.4] xsk: validate user input for
 XDP_{UMEM|COMPLETION}_FILL_RING
Message-ID: <2024061320-boasting-overheat-db2d@gregkh>
References: <20240613011829.9232-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613011829.9232-1-shung-hsi.yu@suse.com>

On Thu, Jun 13, 2024 at 09:18:28AM +0800, Shung-Hsi Yu wrote:
> [ Upstream commit 237f3cf13b20db183d3706d997eedc3c49eacd44 ]
> 
> From: Eric Dumazet <edumazet@google.com>
> 
> syzbot reported an illegal copy in xsk_setsockopt() [1]
> 
> Make sure to validate setsockopt() @optlen parameter.
> 

Now queued up, thanks.

greg k-h

