Return-Path: <stable+bounces-23216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFBC85E511
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 18:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A1A285256
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353AC83CDF;
	Wed, 21 Feb 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ilwzFD52"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD61C20
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538278; cv=none; b=Z0anS7YDRJy8Qjp8ZYkBVjFVhhNv2SnVXJrpgpsW8ziBBV149ii7YB2U/Dt7HXPKNvLaSqQ6JoOi1PGJ4ei0qytPBJMeEQ+EM3+vPCSkQTmUVd1ZgKEE5t365bCuA07Fx/y854tE/tdhl1JRSS+//DoTaZe+wnpP+cScJ+VZgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538278; c=relaxed/simple;
	bh=cMQNIy6Syx25aQIR/uFvi2t38is2Xd6+hybnV9ggKb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S67U48MeprP+eh9yxbVoFJDtW5mt97yO8/1LCJ84RLzc9T47Fj8JuXf1rtfxmau4PaMfPkdJUiQaxvWCupUIQ9eKVA9KvCn+EoBfo0viWviCqXGShJ7fvWlma0emW1/VGZu8z1yWjgEky4x8+xSriC6Ov19+2rZ413FcJFutM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ilwzFD52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB798C433F1;
	Wed, 21 Feb 2024 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708538277;
	bh=cMQNIy6Syx25aQIR/uFvi2t38is2Xd6+hybnV9ggKb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilwzFD52z0IGLYs9JQUzNUolv2uErrn3gBdlnp2bmHCQ95tuvsHpB6juXguPtVaLy
	 POythSxuT2VJRjD76+LkWlQa23hdiESWUCCcMSPlNOknKai71Q65Zh95FcJbcqE8Y2
	 L300o3Fzw4JAhs1zip67VoqzmxRvs76H2aV7W0UI=
Date: Wed, 21 Feb 2024 18:57:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Jiri Benc <jbenc@redhat.com>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: fs/bcachefs/
Message-ID: <2024022155-reformat-scorer-98ae@gregkh>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <uknxc26o6td7g6rawxffvsez46djmvcy2532kza2zyjuj33k7p@4jdywourgtqg>
 <2024022103-municipal-filter-fb3f@gregkh>
 <4900587.31r3eYUQgx@natalenko.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4900587.31r3eYUQgx@natalenko.name>

On Wed, Feb 21, 2024 at 05:00:05PM +0100, Oleksandr Natalenko wrote:
> On středa 21. února 2024 15:53:11 CET Greg KH wrote:
> > 	Given the huge patch volume that the stable tree manages (30-40 changes
> > 	accepted a day, 7 days a week), any one kernel subsystem that wishes to
> > 	do something different only slows down everyone else.
> 
> Lower down the volume then? Raise the bar for what gets backported?
> Stable kernel releases got unnecessarily big [1] (Jiří is in Cc).
> Those 40 changes a day cannot get a proper review. Each stable release
> tries to mimic -rc except -rc is in consistent state while "stable" is
> just a bunch of changes picked here and there.

If you can point out any specific commits that we should not be taking,
please let us know.

Personally I think we are not taking enough, and are still missing real
fixes.  Overall, this is only a very small % of what goes into Linus's
tree every day, so by that measure alone, we know we are missing things.

thanks,

greg k-h

