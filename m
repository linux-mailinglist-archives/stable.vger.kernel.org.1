Return-Path: <stable+bounces-89695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EC99BB3ED
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA88A1C211BE
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154BC1B392C;
	Mon,  4 Nov 2024 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xCoIDVaq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5861AF0A0
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721254; cv=none; b=asDVX8h9J+lZFAq1qCek6SafZdbWWJTr5xu2IZvHEASxLFK91sG9+FA3DeFe1qhNFmCyyGfpqu5Dq+Jcb/AozMshUwzy5ht9efshes8vhHpCGeGc8Rl8YuGfOgWgETHxjPCjjQLpuNz3dpuiXI/MACj3Fo1o8AXoBtaeMjzkaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721254; c=relaxed/simple;
	bh=Or4SrMWYh6/8FAqGyQJYOJYuxI0bDk2BDtiXwsiyAZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD7mLPh/ajjREl0bQdlQeXIHPD+6HTuRUuqzpzEy4rKc5NTw+sb0tudAXLoRKlyfynJ5jsmi6n0vqHwfRMtgzbnO+bojxsWzxwzPfUjS+18xpr62E3evh2QFjLgTrcIW3fP1tn1TLGZkMgB8u6aKybiAjODRctJawSSfDQsWGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xCoIDVaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CA7C4CED1;
	Mon,  4 Nov 2024 11:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730721254;
	bh=Or4SrMWYh6/8FAqGyQJYOJYuxI0bDk2BDtiXwsiyAZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xCoIDVaq5hK/kdWb60u/K3nDoRfbUehPZ3TefUHZZt3XJN2UTysLS6uC8H7/4Ct3g
	 wrfvANVFJtwxym6P58lJjLNRSt30F8gMnXvyO3mXNaHjXgpLQtVst0TCSSYJ5bwRtK
	 yvXg4Xp7y0pRyK184sdzckNRa9c3aSSusTUUpqVI=
Date: Mon, 4 Nov 2024 12:53:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org
Subject: Re: net: dpaa: Pad packets to ETH_ZLEN
Message-ID: <2024110444-napped-atonable-371b@gregkh>
References: <CAH+zgeH2Cjk3pjgrmZYN45VNa_9v8MA52QRjwdaS9hrKnaJUzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+zgeH2Cjk3pjgrmZYN45VNa_9v8MA52QRjwdaS9hrKnaJUzw@mail.gmail.com>

On Mon, Nov 04, 2024 at 05:15:57PM +0530, Hardik Gohil wrote:
> Request to add the upstream patch to v5.4 kernel.
> 
> Upstream commit cbd7ec083413c6a2e0c326d49e24ec7d12c7a9e0
> 

Already queued up for the next release.

