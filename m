Return-Path: <stable+bounces-114891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4140AA30877
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91E216742F
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75E71F3BB1;
	Tue, 11 Feb 2025 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VNvZm19f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E11F37BC
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269641; cv=none; b=SHAc9zHU8CHlhJm0ZBGqv3lq9c/qd63GK6YJKts0XgFDlViF9J8tnGV2kHLHBa2jS56LbZQSq2N0xBkPpHPmiUXRkA1QU4KBpe56TYeSr80GhgROUs5cdfLH/mj5ocz7QHMHgDMRE2BIPuSKEmFvOUJFNH1YN86vQgfhEHR8amc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269641; c=relaxed/simple;
	bh=pi4eDcWwekqoByKG49zz2SFPK0y0Ly2er3tXdKtVjUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njuAM06HK+tNfuIImqSUM5WGoNw6b60fiMpkOYR6UO9ejy9reg2PCm3SmYA7WWdlVeMLv2p6A0ivOGoteflJkFJF25+r51nRzFKmg6BwkL0hFHo0Mb+TrSppVv7tX7AgOHWro45ygG8D63/3oSbB6Z8AfRpj3Lw8v6mtg/hTz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VNvZm19f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53237C4CEE4;
	Tue, 11 Feb 2025 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739269640;
	bh=pi4eDcWwekqoByKG49zz2SFPK0y0Ly2er3tXdKtVjUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNvZm19f1k6TE6XATMWlJsoXynv6DAieefuUnC7TN/EA0awLATs7EO9HxgVcYgfrJ
	 29t/7k3UUjPG5WNrQ6AWByM/xX+JlEPM+Ml7Zul97ZskdTjvM7OQbJlg/eAVU0t3HJ
	 J8cpP0wtmsb681LTEmOexBNMVdvtUM3B6omfqNNc=
Date: Tue, 11 Feb 2025 11:27:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Cc: umesh.nerlige.ramappa@intel.com, jonathan.cavitt@intel.com,
	matthew.brost@intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] xe/oa: Fix query mode of operation for
 OAR/OAC" failed to apply to 6.13-stable tree
Message-ID: <2025021107-sadness-automated-c51d@gregkh>
References: <2025021014-cartridge-snooze-15bd@gregkh>
 <85ikph33pc.wl-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ikph33pc.wl-ashutosh.dixit@intel.com>

On Mon, Feb 10, 2025 at 01:11:27PM -0800, Dixit, Ashutosh wrote:
> On Mon, 10 Feb 2025 05:02:14 -0800, <gregkh@linuxfoundation.org> wrote:
> >
> 
> Hi Greg,
> 
> > The patch below does not apply to the 6.13-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 55039832f98c7e05f1cf9e0d8c12b2490abd0f16
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021014-cartridge-snooze-15bd@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..
> >
> > Possible dependencies:
> 
> This was a modified commit we had sent for 6.12. It will not apply to
> 6.13. Neither is it needed for 6.13, since the original commit
> 
> 	55039832f98c ("xe/oa: Fix query mode of operation for OAR/OAC")
> 
> is already present in 6.13.

The commit you reference here, 55039832f98c ("xe/oa: Fix query mode of
operation for OAR/OAC"), is in 6.14-rc1.

Do you mean commit f0ed39830e60 ("xe/oa: Fix query mode of operation for
OAR/OAC") instead?

what a mess.

greg k-h

