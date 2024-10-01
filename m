Return-Path: <stable+bounces-78547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D898C104
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AEC1F23E07
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC9C1CB323;
	Tue,  1 Oct 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bc9Hf9ff"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1F1C9EA3
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794876; cv=none; b=szZW2TKmHuFVc0q+Xs0ZtrOuUUR1Y7luXFV/dO+yPVzWaQTiAx62A/e6Fq7J8WlovggCldQsFqJqWdVu0opUP6IEH5hWljQUXkoZKxLJ6gnxebDa62GCE6eG5ZYjGOrJ+5zT/3n1O5XiExG528s/c2po7EQ//9nw2C0PAMu/PTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794876; c=relaxed/simple;
	bh=s2GhYID8tH/G0dneJ2qTPktCYmCJB4TXNlmtGuzoljE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7rW/Xm2j8mfdgfKPEkc7KDvxKsT/8VrJRtBa/YRXimuT2qWNl+UFOR9WuWbqW/taoWQELqqPi14XkHnazF81IpzrdrZVmt0E9Ea9/vsnJsTnDATRgYzYEBYGar5Rn6356tFQOTKF9BQP/VaUqyl1n3JzbSJvA49JxUc5VSAemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=bc9Hf9ff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3FCC4CEC7;
	Tue,  1 Oct 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bc9Hf9ff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727794873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IKytWmSvxpgRZ8azTggW1hxVunYU1454v9Ag/j4MzLc=;
	b=bc9Hf9ffsYx9/fqSPi3JGjCnEPAgdGNvxXlnYk8Tqkb3ffDl/ALw6SuTwh4rXMIZ4yFR2P
	+HpwsILyjkHX/0FvLo6DAAVJNp3rtrpJbcRxX6eahVABb3wT2/Akpd900Uweg0dYl3wjYy
	dm0UoMuyANCETNYWvOYmjJtXZpE0lzM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 570fddd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 15:01:13 +0000 (UTC)
Date: Tue, 1 Oct 2024 17:01:12 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>
Subject: Re: patches sent up to 6.13-rc1 that shouldn't be backported
Message-ID: <ZvwOuERpwrkG5KPN@zx2c4.com>
References: <CAHmME9rtJ1YZGjYkWR10Wc24bVoJ4yZ-uQn0eTWjpfKxngBvvA@mail.gmail.com>
 <2024100107-womb-share-931a@gregkh>
 <ZvvjyyO00fL_JL4q@zx2c4.com>
 <2024100120-unlucky-sample-091b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024100120-unlucky-sample-091b@gregkh>

On Tue, Oct 01, 2024 at 02:13:14PM +0200, Greg Kroah-Hartman wrote:
> Ok, I'll try to rework the other dependant patches to see if we can get
> that fix in somehow without this change.  But why not take this, what is
> it hurting?

I just don't see the need to backport *any* patches from my tree that
don't have an explicit Cc: stable@ marker on them. I'm pretty careful
about adding those, and when I forget, I send them manually onward to
stable@. If there's some judgement that a certain patch needs to be
backported that I didn't mark, that sounds like something to
deliberately raise, rather than a heap of emails that this patch and
that patch have been added willy-nilly.

The reason I care about this is that I generally care about stable and
consistency of rationale and such, and so if you *do* want to backport
some stuff, I am going to spend time checking and verifying and being
careful. I don't want to do that work if it's just the consequence of a
random script and not somebody's technical decision.

