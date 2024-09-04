Return-Path: <stable+bounces-73060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB36E96C02F
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086E41C250CC
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC25F1DC04B;
	Wed,  4 Sep 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="froQbjmF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763581D4170;
	Wed,  4 Sep 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459638; cv=none; b=aOik2hzm33EXwW5KdIfLt5slClWCn+47eSQTqx2boRHe4TO7mEHCK+boAML9dzcJEQlCXbcl0xQ6lS4erjg76Su3Tqqj8kmSCOQNKEvT5cCPzlxdhAqgSF2iuE3xSZs3BwHQyoO3dsZH8nbX96t3h6t3NzNmtw2I/suE+D2gh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459638; c=relaxed/simple;
	bh=8TeTyxkPuqKs0E9KlcjCyubBjugwoozVVKl+fR8/568=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoftiKdHnnUcXUusfR7Eq+NIj3hm1TaOKsNB6fJnSXcCvd83LYdPcHk4a2sI9Yj1dplrKqgMThfwl4Wb6i4K5WSiDBa+5GBcBGC81KPLAeT1zGrlr8mEr7SAEsCQDxPR1IuFwFs9yPzij/EWgLW6S00kvkz+dGtT7wrOG/jFJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=froQbjmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A070FC4CEC2;
	Wed,  4 Sep 2024 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725459637;
	bh=8TeTyxkPuqKs0E9KlcjCyubBjugwoozVVKl+fR8/568=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=froQbjmFZTxaLYOiosB3BTWeto7tmLASwku3J5xv9yABKCKVXzw+Nxa2y3gHTErHf
	 UKEm35YYb4AlzQqyzlsMKfJCH1tJOV7PnVbirutO0ic7K9KBQxa04+nwnLcu2f/6f3
	 lGgDJUFotoxX6JBw6ftLnAwMOOp0aplUcFKwX/T8=
Date: Wed, 4 Sep 2024 16:20:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: Re: [PATCH 6.6.y 2/4] selftests: mptcp: join: test for flush/re-add
 endpoints
Message-ID: <2024090428-jingle-railway-8ddd@gregkh>
References: <2024082617-capture-unbolted-5880@gregkh>
 <20240903100807.3365691-8-matttbe@kernel.org>
 <a5f25f18-d60f-4544-9f28-3a463911fd0b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f25f18-d60f-4544-9f28-3a463911fd0b@kernel.org>

On Wed, Sep 04, 2024 at 02:59:07PM +0200, Matthieu Baerts wrote:
> Hi Greg, Sasha,
> 
> On 03/09/2024 12:08, Matthieu Baerts (NGI0) wrote:
> > commit e06959e9eebdfea4654390f53b65cff57691872e upstream.
> > 
> > After having flushed endpoints that didn't cause the creation of new
> > subflows, it is important to check endpoints can be re-created, re-using
> > previously used IDs.
> > 
> > Before the previous commit, the client would not have been able to
> > re-create the subflow that was previously rejected.
> > 
> > The 'Fixes' tag here below is the same as the one from the previous
> > commit: this patch here is not fixing anything wrong in the selftests,
> > but it validates the previous fix for an issue introduced by this commit
> > ID.
> 
> FYI, Sasha has recently queued all the patches from this series for
> v6.6, except this one, the backport of e06959e9eebd ("selftests: mptcp:
> join: test for flush/re-add endpoints").
> 
> In theory, this commit can be applied without any conflicts now that
> commit b5e2fb832f48 ("selftests: mptcp: add explicit test case for
> remove/readd") has been queued in v6.6.

Now queued up, thanks.

greg k-h

