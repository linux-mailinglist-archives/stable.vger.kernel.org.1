Return-Path: <stable+bounces-73064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7741E96C043
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2691C2513D
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747EE1DC054;
	Wed,  4 Sep 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c88XGUuG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5E1DB937;
	Wed,  4 Sep 2024 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459740; cv=none; b=KAcc5X5oUTELttaObyPxs63krU0F/m0UjSCuKxPqnTFFSptjDMreXJO9Ge+v3G9pX1nY0kOZaYas7TwbGfbN6Xg/QYFBF/xN2qWPihuZ8WCoFhmJipe5i/gz+nSNKA2Tt6WIO+jmqid4qpaH9lwLN22MMvfVVsoB86YsIFNwhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459740; c=relaxed/simple;
	bh=hIiIY41fkK2zy2zljqXTV1SqpfVoUzdq+U6aynT+NOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyKoRT9C9E0Sq3UxplDUcyxADJfst/trTnE0Y+EJLdSlmiZ6GLb8bxqVtcrot5XpcKsZs78sKcmlZIUwDt6Hjz6RtHeCVTDHHQYxkZvRr/XKxCKpDs8TayWU4Wybb/u+OisWjjZ81ixbvCH7ix7I/YTCdWXGnM6yGlhXXDWvTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c88XGUuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13719C4CEC2;
	Wed,  4 Sep 2024 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725459738;
	bh=hIiIY41fkK2zy2zljqXTV1SqpfVoUzdq+U6aynT+NOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c88XGUuG/+bY63ciU91GiCJmooCOk9cBavobyHbHzDnYdMKTGvRkrjde55kgRaBNb
	 6KYu113OMf0shHUa3f36IS0kSp41oEdW7/LgsOfzqRfZmLU9DTtgvkNieCCCFgKU22
	 wqfcng8Dslv3UJeqfSabxMCCwlmr6vizSRf5/opQ=
Date: Wed, 4 Sep 2024 16:22:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] selftests: mptcp: join: cannot rm sf if closed
Message-ID: <2024090455-debate-underfeed-d667@gregkh>
References: <2024083052-unedited-earache-8049@gregkh>
 <20240903101845.3378766-2-matttbe@kernel.org>
 <129aa31e-44e9-4327-ba0a-d976a5e00d06@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <129aa31e-44e9-4327-ba0a-d976a5e00d06@kernel.org>

On Wed, Sep 04, 2024 at 03:43:03PM +0200, Matthieu Baerts wrote:
> Hi Greg, Sasha,
> 
> On 03/09/2024 12:18, Matthieu Baerts (NGI0) wrote:
> > commit e93681afcb96864ec26c3b2ce94008ce93577373 upstream.
> > 
> > Thanks to the previous commit, the MPTCP subflows are now closed on both
> > directions even when only the MPTCP path-manager of one peer asks for
> > their closure.
> > 
> > In the two tests modified here -- "userspace pm add & remove address"
> > and "userspace pm create destroy subflow" -- one peer is controlled by
> > the userspace PM, and the other one by the in-kernel PM. When the
> > userspace PM sends a RM_ADDR notification, the in-kernel PM will
> > automatically react by closing all subflows using this address. Now,
> > thanks to the previous commit, the subflows are properly closed on both
> > directions, the userspace PM can then no longer closes the same
> > subflows if they are already closed. Before, it was OK to do that,
> > because the subflows were still half-opened, still OK to send a RM_ADDR.
> > 
> > In other words, thanks to the previous commit closing the subflows, an
> > error will be returned to the userspace if it tries to close a subflow
> > that has already been closed. So no need to run this command, which mean
> > that the linked counters will then not be incremented.
> > 
> > These tests are then no longer sending both a RM_ADDR, then closing the
> > linked subflow just after. The test with the userspace PM on the server
> > side is now removing one subflow linked to one address, then sending
> > a RM_ADDR for another address. The test with the userspace PM on the
> > client side is now only removing the subflow that was previously
> > created.
> FYI, Sasha has recently queued this patch to v6.6, with a bunch of
> dependences.
> 
> I'm OK with that, no need to take this version here where I resolved the
> conflicts not to take the dependences. But then, please also queue the 2
> patches that are needed for new dependences that have been added:
> 
>   https://lore.kernel.org/20240904133755.67974-4-matttbe@kernel.org

Ok, I think I've got this all right for 6.6.y now, if not, please let me
know.

thanks,

greg k-h

