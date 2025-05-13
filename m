Return-Path: <stable+bounces-144268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC11FAB5D30
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 21:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA9087A73F9
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAB91EB5D6;
	Tue, 13 May 2025 19:30:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95B1E5200;
	Tue, 13 May 2025 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164619; cv=none; b=IaYEpc7inB6/hCdLpdb5IotOlE3Wmk/TYxB/eWqHN9tHysHBpG3JsPkIJU29LVcHLP1xJB/dMK1Q+sfsgWAyR+FjublsyxaIaX4Xio0YLeMr/YpI0UVYE0QeeI/j2UPvEfVbTSqNGhrOBdbTznO6yXGKydz27rO2onO60fZ6BUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164619; c=relaxed/simple;
	bh=sO63pSNnzsj/bMDExuGGsBRR/MsgeZpkNyNAv8q2Ymw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ape98MANhpPH9SGR8X8BIXB2Zk3M4kD0Tlx7q4+3cu08B83oFwZLK2vH7UfHq0AphG9SuUGm47QRs3TB4490nuVQN8eUeX4Ft+yH/5p7S/M03bjI52nD45d7HD4zrcjP6MIROxWHqXFRn52VMLqzLFfIg9ikz95YBl30am4DmY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B507C4CEEB;
	Tue, 13 May 2025 19:30:16 +0000 (UTC)
Date: Tue, 13 May 2025 15:30:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] x86/its: Fix build errors when CONFIG_MODULES=n
Message-ID: <20250513153041.7bce37df@gandalf.local.home>
In-Reply-To: <2b706c51-5518-472b-b251-c7c8c39d3a1e@oracle.com>
References: <20250513025839.495755-1-ebiggers@kernel.org>
	<20250513141737.3ce95555@gandalf.local.home>
	<2b706c51-5518-472b-b251-c7c8c39d3a1e@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 00:53:26 +0530
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Hi Steven,
> 
> 
> On 13/05/25 23:47, Steven Rostedt wrote:
> > On Mon, 12 May 2025 19:58:39 -0700
> > Eric Biggers <ebiggers@kernel.org> wrote:
> >   
> >> Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
> >> Cc: stable@vger.kernel.org  
> > 
> > No need to Cc stable. This isn't even in Linus's tree.  
> 
> It is now(today) present I think: 
> https://github.com/torvalds/linux/commit/872df34d7c51a79523820ea6a14860398c639b87

Bah. My upstream repo gets updated every night via a cronjob, and that's
what I was looking at.

> 
> Greg queued this up for today's stable-rc which was released for Testing.

I didn't see any "stable" or "fixes" tag in the offending commit, so I
definitely didn't expect it to be in stable :-p


> 
> Informed him about this fix:
> 
> https://lore.kernel.org/all/88d537d6-57be-4fbc-9722-15997a022abb@oracle.com/

Thanks for letting me know.

-- Steve

