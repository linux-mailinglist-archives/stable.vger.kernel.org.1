Return-Path: <stable+bounces-151415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CE1ACDF83
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177873A3018
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17A28F929;
	Wed,  4 Jun 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmUWSekf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67E28FAB3;
	Wed,  4 Jun 2025 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044634; cv=none; b=ZE7R8tn1IW+92S7ees4gq7cbNcAQB8Ib5f137KT9AZsZTkpRAgvy+0LShOHGNF29UhNssjpXCViGnRJL6AvcCiZbbsZaA4/+7dBQNuPZtc0KQ91ySZ0kMgZkv9INGMszi8/cKEQMzC+h+N/fY2bcWy3E9AiIsHXrHvU2SmDAqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044634; c=relaxed/simple;
	bh=P+lH2ko8gaskpFvOoIGVplo2oG0ShWHoC4Hb2rcnhos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JU19VlJwP5hA/QuzDpLwzrwrXoEOxGVomWnR1e0wJPwpELT1hHEPHkj1JgN1JezbmUfnHuWwV0YYrWaFpeznlT5QZSwpmpGAU8DyjRljzvmKAJ4VgMa7fV/HwDZ9ag+hDrEogWaAtZucKNPzXyHCzGukBOBP88Nq3/2PeNNssXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmUWSekf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05BBC4CEE7;
	Wed,  4 Jun 2025 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749044633;
	bh=P+lH2ko8gaskpFvOoIGVplo2oG0ShWHoC4Hb2rcnhos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PmUWSekfAl95RaHPAiN2mMrc4fFPSm/r50eHrN9KKSjct6LMlgETWQQ4Xng5WYKhc
	 SNi8UsM7lMYsIT0P54jKvnYrqpZONdQIVZDWU0BUFxMM3m8kOYCnXBGp3feLgvN6Iw
	 Hyf5cXhv/zkJwnYEvbM3lw9P1ypJ3I87YIQbO3uWtO0may8qkRhzT64E99+dVP9HlP
	 FkC5IOWh4aw0bST34Pj7EPAQqJTDgiWoG+EmtlKQ0hlWsvKDVRqb74fqBqYjANuxih
	 B3J/O4gA7S+Grkzwiuu/K05PK+zEwM5DJ9U3VsJvOXvG/PnHwEx4flmSag+3MIAfi0
	 t72HsDfKiyo7A==
Date: Wed, 4 Jun 2025 14:43:47 +0100
From: Lee Jones <lee@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>, Rao Shoaib <Rao.Shoaib@oracle.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6.1 05/27] af_unix: Replace BUG_ON() with WARN_ON_ONCE().
Message-ID: <20250604134347.GH7758@google.com>
References: <20250521152920.1116756-1-lee@kernel.org>
 <20250521152920.1116756-6-lee@kernel.org>
 <20250523221418.6de8c601@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523221418.6de8c601@pumpkin>

On Fri, 23 May 2025, David Laight wrote:

> On Wed, 21 May 2025 16:27:04 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
> > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > 
> > [ Upstream commit d0f6dc26346863e1f4a23117f5468614e54df064 ]
> > 
> > This is a prep patch for the last patch in this series so that
> > checkpatch will not warn about BUG_ON().
> 
> Does any of this actually make any sense?
> Either the BUG_ON() should be just deleted because it can't happen
> (or doesn't matter) or there should be an error path.
> Blindly replacing with WARN_ON_ONCE() can't be right.
> 
> The last change (repeated here)
> >  	if (u) {
> > -		BUG_ON(!u->inflight);
> > -		BUG_ON(list_empty(&u->link));
> > +		WARN_ON_ONCE(!u->inflight);
> > +		WARN_ON_ONCE(list_empty(&u->link));
> >  
> >  		u->inflight--;
> >  		if (!u->inflight)
> is clearly just plain wrong.
> If 'inflight' is zero then 'decrementing' it to ~0 is just going
> to 'crash and burn' very badly not much later on.

All of this gets removed in patch 20, so I fear the point is moot.

-- 
Lee Jones [李琼斯]

