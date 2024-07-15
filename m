Return-Path: <stable+bounces-59369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AE9931B6F
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 22:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912BEB21F11
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 20:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1585013B293;
	Mon, 15 Jul 2024 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5aMrFvo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBC13AA46
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073824; cv=none; b=DYmHFHqtoOmz/gPc6FsX2CpHSKoTUNHoCa59UXFOi+baIoIC9OIvTzb60u0Ou2Gf7GhlXv+ontfUtUVarNCLk/8Qep/XqO97o54AoUm4K3y91wgDyXs3cR0nMgcXUtoEDr1r/JyUFyR95OXEMZuZypm1W9ktiDa+Av8gqsBX0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073824; c=relaxed/simple;
	bh=WHvL+rVoo7Z71Mefd/zLMU/oN2Hm2C56/Y5BdDxNrug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/MiKZUC5R585Tmf7CMEnOwB5PQkQsJJpUXv8VskC9i0I5yBd+mXZWigMV0N124aBmNqfIusHliY6HQJDnrfaaIzYqGOLUt/9KFnIx/u0a5pEeX5eNLUCekzQOq3r7QrhH21WDLzZc6LoWVwV3dzdG6Gov6hQNCaUCQa/4rlM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5aMrFvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFFFC32782;
	Mon, 15 Jul 2024 20:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721073824;
	bh=WHvL+rVoo7Z71Mefd/zLMU/oN2Hm2C56/Y5BdDxNrug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5aMrFvoMShZanLCn7FM1apSnex4DIEELypnmyd4+nemCqJ3jOdUeRg4kDHdRvYoW
	 940BTXnK4XRf+L3Fda5iuo8HPZVSQRb5ESxJHuvkHJ20pu4AkflgUykyl0Ps9Fl6UC
	 fSexJtIbQJIoS9aBNZ1kPkrtCK1JsiXVrcf5ZbUG2SD6PQfGCmnUxFuryP+raWAfhB
	 PhKW+r1ItRHX574sIPGn5HG3LZ3zndyZOm95Ke7nPLgnZsP5jPqtQE4gE0yfmG+ITn
	 n3E/1czocTwFS0HgR5ZhLXOaO7SupKG1zWrwZlSBNBIjNhWeYjNVLni1/YNAGmYZWL
	 4BXRRyA6eJqvQ==
From: SeongJae Park <sj@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: merge regions aggressively when max_nr_regions" failed to apply to 5.15-stable tree
Date: Mon, 15 Jul 2024 13:03:40 -0700
Message-Id: <20240715200340.1043841-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2024071532-pebble-jailhouse-48b2@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Jul 2024 19:12:42 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Jul 15, 2024 at 10:02:09AM -0700, SeongJae Park wrote:
> > Hi Greg,
> > 
> > On Mon, 15 Jul 2024 13:34:47 +0200 <gregkh@linuxfoundation.org> wrote:
> > 
> > > 
> > > The patch below does not apply to the 5.15-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > > 
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > > 
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6
> > 
> > Similar to the failure of this patch for 6.1.y, I cannot reproduce the conflict
> > on my setup.  Attaching the patch for successfully cherry-picked one on my
> > machine for any possible case.
> 
> Same issue as 6.1, it breaks the build :(

Thank you for letting me know this.  I confirmed the issue can be reproduced on
my setup, and made a local fix.  In addition to the build failure, however,
this causes a build warning.  The warning occurs on 6.1, too, so we're
discussing it on another thread[1].  I will send a fixed version once the
discussion for the warning on the thread is completed.

[1] https://lore.kernel.org/20240715195946.1043767-1-sj@kernel.org


Thanks,
SJ

