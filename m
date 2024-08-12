Return-Path: <stable+bounces-66757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB5D94F200
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B1B1F21CC4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D9A186E53;
	Mon, 12 Aug 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BRo67Bn7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3FA186E52;
	Mon, 12 Aug 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477608; cv=none; b=puIOCJAkU+Z3SlcE1og4XdEc9K6Jtuvv3FWkwt/TxVMDVmcAF3MrKIARiqH+y2HW1105W78aq5iJ3XyC4Koz0Etv142borUFlrzlxjxmG6IhDfdyyjze2HumrROxShqtf+JeyHQjVRVYFPVBHJedeEgfGdmaSY+SecdoeUqXGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477608; c=relaxed/simple;
	bh=N6ovgBsToB3v9sIT/pDQLZpDRIFhW3gulpnUbGT4dfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz+iuSKAQVb9y1BlxRQw9X1kCjoewAQvZhHjd6Qlkp5efuws0djsVYRn7JMNKGnKc9m2mi0O9NIjDYepCTyWPvqndWVazjodF2IkvG3dGbZyhiOeT+oeg6sYAqurZxO+4UVDnBGqc+vHw1fmVgcwfxMUYcCy5rlNwMc3fvgPOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BRo67Bn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B09C32782;
	Mon, 12 Aug 2024 15:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723477608;
	bh=N6ovgBsToB3v9sIT/pDQLZpDRIFhW3gulpnUbGT4dfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRo67Bn7znlm886Py4hrXEAS8FSIBuFjQuzTPJVOooWSkF3J8QHruIQfFiCnomK3A
	 GcU0aPj8TjBNPueuxMCFvMMrvbTYOvGmcDwZOX2TSfwaLDfnqd/TTxiOmOYrrGIUec
	 Yga6pLRcSm5b6Gtb/Si65Bm8BSbqOEdXYeKSMf78=
Date: Mon, 12 Aug 2024 17:46:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y 0/5] Backport of "mptcp: pm: don't try to create sf
 if alloc failed" and more
Message-ID: <2024081237-unlikable-unarmored-4e3a@gregkh>
References: <2024081244-uncertain-snarl-e4f6@gregkh>
 <20240812153050.573404-7-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812153050.573404-7-matttbe@kernel.org>

On Mon, Aug 12, 2024 at 05:30:51PM +0200, Matthieu Baerts (NGI0) wrote:
> Patches "mptcp: pm: don't try to create sf if alloc failed" and "mptcp:
> pm: do not ignore 'subflow' if 'signal' flag is also set" depend on
> "mptcp: pm: reduce indentation blocks", a simple refactoring that can be
> picked to ease the backports. Including this patch avoids conflicts with
> the two other patches.
> 
> While at it, also picked the modifications of the selftests to validate
> the other modifications.
> 
> If you prefer, feel free to backport these 5 commits to v6.6:
> 
>   c95eb32ced82 cd7c957f936f 85df533a787b bec1f3b119eb 4d2868b5d191
> 
> In this order, and thanks to c95eb32ced82, there are no conflicts.

All now queued up, thanks!

gre gk-h

