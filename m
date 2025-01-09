Return-Path: <stable+bounces-108126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE84A07B76
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 16:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA9C161439
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590A21D5BA;
	Thu,  9 Jan 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjPEZE6W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802AE21CA14;
	Thu,  9 Jan 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435464; cv=none; b=bZ13MlQfnFenhGTqNeG9I6SsFM/zK/gTFf+mCjmNbFh2mfk4sJMqnsNj0alUqYXhHnEF2pjzEjF4/geqSBwxpvLZmzPR2ymckD3xKgpQ5pwGmZoW+XNuJ20MynYaS0zLEMyA7iJ8ujXmnwCEQixY1vZBd7QI1lMhg3I4il6hh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435464; c=relaxed/simple;
	bh=RZhfDkE6p46GlDtLzAG8SL7OVdV6Nd9Z6bBWdU17A2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2HHzUqYoHpVTPeWov7sW9/ZNrWJ7hKzGTkZKi0GmwtkTMqBX3JCio9ajHx94lxyCU3v8S3g93uHXu7Ki4Fm5HAemADF6zbkUkxvNhRnPoH6rx2pnVI8Nrpa8OCTvMjABnCGBBUFVwU2fTw5GPD8QQui2kYiK/O9/R9gp3YttKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjPEZE6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B594C4CED2;
	Thu,  9 Jan 2025 15:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736435464;
	bh=RZhfDkE6p46GlDtLzAG8SL7OVdV6Nd9Z6bBWdU17A2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BjPEZE6WcTgx0B90cbZDD4QCTZETHaAl+AC4yNzA1tcaDVwBnBHagf5P4+6Z7G3pk
	 zySY3kNdNnF1jxtT9AJ8RT68j0A+7mdMuq1zqIO5R/7Ag/ubHu2/G7aPJ3Td7qqJqM
	 1aY3AxxO05pvf6oko/+8Z3OnTMZt4kF7Pzgwc/LN7cHyN2zR+OImkENRoWzYs0fxwp
	 JlcozEJMMvwCKPjDbQMdda0u/EOCA9UYyxAW1ckNBcVM5tYNsD4Yi1RUD3a/7P11Y0
	 xUaxynEdCE9Q09LcpOAmKYR9vuop/j2DAwn07F6i3mD/aeqgCjYTohVBZl5Lti9sEQ
	 MdxthGFJhTHXQ==
Date: Thu, 9 Jan 2025 07:11:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg
 <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Ignat
 Korchagin <ignat@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Eric Dumazet <edumazet@google.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP: handle NULL sock pointer in
 l2cap_sock_alloc
Message-ID: <20250109071102.23a5205d@kernel.org>
In-Reply-To: <20250109-fbd0cb9fa9036bc76ea9b003-pchelkin@ispras.ru>
References: <20241217211959.279881-1-pchelkin@ispras.ru>
	<20250109-fbd0cb9fa9036bc76ea9b003-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 10:47:12 +0300 Fedor Pchelkin wrote:
> On Wed, 18. Dec 00:19, Fedor Pchelkin wrote:
> > A NULL sock pointer is passed into l2cap_sock_alloc() when it is called
> > from l2cap_sock_new_connection_cb() and the error handling paths should
> > also be aware of it.
> > 
> > Seemingly a more elegant solution would be to swap bt_sock_alloc() and
> > l2cap_chan_create() calls since they are not interdependent to that moment
> > but then l2cap_chan_create() adds the soon to be deallocated and still
> > dummy-initialized channel to the global list accessible by many L2CAP
> > paths. The channel would be removed from the list in short period of time
> > but be a bit more straight-forward here and just check for NULL instead of
> > changing the order of function calls.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE static
> > analysis tool.
> > 
> > Fixes: 7c4f78cdb8e7 ("Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > ---  
> 
> Urgh.. a bit confused about which tree the patch should go to - net or
> bluetooth.
> 
> I've now noticed the Fixes commit went directly via net-next as part of a
> series (despite "Bluetooth: L2CAP:" patches usually go through bluetooth
> tree first). So what about this patch?

7c4f78cdb8e7 went directly to net-next because it was a larger series touching
multiple sub-subsystems:

$ git log -12 --graph --oneline 2d859aff775df54
*   2d859aff775d Merge branch 'do-not-leave-dangling-sk-pointers-in-pf-create-functions'
|\  
| * 18429e6e0c2a Revert "net: do not leave a dangling sk pointer, when socket creation fails"
| * 48156296a08c net: warn, if pf->create does not clear sock->sk on error
| * 9df99c395d0f net: inet6: do not leave a dangling sk pointer in inet6_create()
| * 9365fa510c6f net: inet: do not leave a dangling sk pointer in inet_create()
| * b4fcd63f6ef7 net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
| * 811a7ca7320c net: af_can: do not leave a dangling sk pointer in can_create()
| * 3945c799f12b Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
| * 7c4f78cdb8e7 Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
| * 46f2a11cb82b af_packet: avoid erroring out after sock_init_data() in packet_create()
|/  
* 397006ba5d91 net/sched: cbs: Fix integer overflow in cbs_set_port_rate()

