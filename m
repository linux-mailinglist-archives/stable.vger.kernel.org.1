Return-Path: <stable+bounces-10829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B8682CE73
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 21:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E4A1F221E8
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 20:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148BF6D39;
	Sat, 13 Jan 2024 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yNNEC5ip"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E316410;
	Sat, 13 Jan 2024 20:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9614C433C7;
	Sat, 13 Jan 2024 20:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705178632;
	bh=lssXLb+zTu/GEgbL+MkdwmlDfzEyJ5HHfjf8dm6VAEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yNNEC5ipCwhgu2a4URTG+TiCULdcvhKoekvsqFWMWdVujNSY+58QUB6BfwTyCsQoy
	 x1wATKLgc779YY+u7Yrx/wTEXyu7yMsZ0UkON8zc/Q9YHWHz2VVc18gWg998yRNd33
	 3AciHxDvJ8aKZKX4oQ9T62611CI6G3nWi4RrbUWQ=
Date: Sat, 13 Jan 2024 21:43:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?J=F6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 09/43] net: Implement missing
 getsockopt(SO_TIMESTAMPING_NEW)
Message-ID: <2024011329-caloric-survival-1efd@gregkh>
References: <20240113094206.930684111@linuxfoundation.org>
 <20240113094207.231546964@linuxfoundation.org>
 <27f5543f5c6023ce0d9bc6161aef9e37cc720a02.camel@mailbox.tu-berlin.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27f5543f5c6023ce0d9bc6161aef9e37cc720a02.camel@mailbox.tu-berlin.de>

On Sat, Jan 13, 2024 at 08:25:54PM +0100, Jörn-Thorben Hinz wrote:
> Hi Greg,
> 
> this patch is applied in the wrong place (the wrong case) here in
> sock_getsockopt(). The function seems to have changed in a number of
> places after 5.10, apparently too much for an automatic(?!) merge.

Good catch, I've dropped it from the 5.4 and 5.10 trees now, thanks for
the review!

greg k-h

