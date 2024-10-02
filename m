Return-Path: <stable+bounces-78605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D7598D099
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 11:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD95282262
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 09:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDC31E411C;
	Wed,  2 Oct 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rZFZV8xG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D71E2035;
	Wed,  2 Oct 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863039; cv=none; b=Wvr5F3yuZQ420eI9zll4D4+5MLsTuaAPAGvtpg91LedpoyNUuyQNJSI2TK4jaj3LBgdeZOXltHUM9INrHES2xqH6weywgSrquPovxQsIIb79SfL4LHuM9PgYwToViOQBo+wt8CmqraGjSRN0lkXMiOw/5nbgZpGIUslbwa5t8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863039; c=relaxed/simple;
	bh=GONPKzWPvV6hlNqW13i39eZXWmID+K60+OzAQ97VKQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQSYb7yZAuw8yiTYEM/ryxaj2zz+uLtNzXEYqDp93akDWY710mJWT7zeEN6ijslEiQaamb7yqeidc/nv1iibtGI1iTPdVvq3tEoE+VPOfEU6/HU7bIuL8k/uqUvKBpg+o2zNS2lDPjbKKAlJijFxS/MIWipIuZod55E60NPa82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rZFZV8xG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9564C4CECD;
	Wed,  2 Oct 2024 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727863039;
	bh=GONPKzWPvV6hlNqW13i39eZXWmID+K60+OzAQ97VKQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZFZV8xGTwZhXTn5d4ovHZ9HsMI8HxHmNb9IC7bJsD6kd10ApWsI6a7wqiVRQb/TG
	 cgSAzcmXAmcKwbO48LcR/ZcA6vWTEHIjAzupd6tCoejpbpboeb7RvPho4QlYXaLilF
	 1Dx1Mup+63e2ZhOYVJ+/TNr16QtjABzqncekNwzY=
Date: Wed, 2 Oct 2024 11:56:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc: stable@vger.kernel.org, qin.wan@hp.com, andreas.noever@gmail.com,
	michael.jamet@intel.com, mika.westerberg@linux.intel.com,
	YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH 6.6 00/14] Backport thunderbolt fix(es) from v6.9
Message-ID: <2024100236-carload-oblong-d631@gregkh>
References: <20241001173109.1513-1-alexandru.gagniuc@hp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001173109.1513-1-alexandru.gagniuc@hp.com>

On Tue, Oct 01, 2024 at 05:30:55PM +0000, Alexandru Gagniuc wrote:
> From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> These patches resolve thunderbolt issues on Intel Raptor Lake systems.
> With a monitor connected to a HP Thunderbolt G4 dock, the display
> sometimes stops working after resume.
> 
> The kernel reports an issue with the DisplayPort MST topology, the
> full backtrace being pasted below. This failure is since v6.9-rc1 by
> commit b4734507ac55 ("thunderbolt: Improve DisplayPort tunnel setup
> process to be more robust"). The other commits are dependencies such
> that all changes apply cleanly without needing modification.

All now queued up, thanks!

greg k-h

