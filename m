Return-Path: <stable+bounces-128885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C58A7FB22
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8470E19E27EA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AF8268C50;
	Tue,  8 Apr 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UsAWnbY1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D5268C49
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106206; cv=none; b=lQn7T8+UmXpu3HfC4+CZfAPPjpGI0xUKhEDlJwPVxUzckQtXA9mFqVfIzInFJTVi9VgxE8vfWa15kLxJ23c+Ro2cX1pzKjTc5t+WtTPdGd75zqQJRbarIWWjVegp2OVlEXxZkX5kIKz1zSTZU9Bm8hYM0MKT89ggUBo0lPzxrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106206; c=relaxed/simple;
	bh=3M4NBwJINsLC7CO0OjHRcLDifzFAqB9c1tsokO5HABA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oakos6D89toWCm+GdLWSUADNYDnh3oO7sX6Zg7iRTlpVD3s4dNQ9pNs08VejV7s6nBPKo4cGv9qiW86jsR7FIjyUyeUfGPVyARP/E9UAVzIJGzrT59X76frknrtVjj4AExmJRn7lm/WEh5/pOprXcqAe9+arLAraSE2QADzUUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UsAWnbY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA17C4CEE5;
	Tue,  8 Apr 2025 09:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744106205;
	bh=3M4NBwJINsLC7CO0OjHRcLDifzFAqB9c1tsokO5HABA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsAWnbY1TzWqdcxqu4JnQQATaOiAhPF9YElayScQMHbw2z2m5PJZlSglt8JBsaVor
	 R0CiOV4p+uEKliaHXnubpD07hYWBoiJTd80S5fgL9uBjTrQ9VRa+6Ea0DgHhGpFwOp
	 GzdiiCzQTlEpDYl7huMEB0jiscziUxB5xxF4qSPc=
Date: Tue, 8 Apr 2025 11:55:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: dianders@chromium.org, catalin.marinas@arm.com, james.morse@arm.com,
	stable@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: FAILED: patch "[PATCH] arm64: errata: Add newer ARM cores to
 the" failed to apply to 6.14-stable tree
Message-ID: <2025040836-tweet-unbiased-e9b6@gregkh>
References: <2025040844-unlivable-strum-7c2f@gregkh>
 <61c27910-8d4f-4d25-b0aa-cd6c393e1754@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61c27910-8d4f-4d25-b0aa-cd6c393e1754@oracle.com>

On Tue, Apr 08, 2025 at 03:22:47PM +0530, Harshit Mogalapalli wrote:
> Hi stable maintainers,
> 
> On 08/04/25 14:45, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.14-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x a5951389e58d2e816eed3dbec5877de9327fd881
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040844-unlivable-strum-7c2f@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> 
> Note:
> 
> Have observed that mostly these dependencies are empty in newer stable
> FAILED patch emails.

Maybe because there are no possible dependencies?  I don't know, those
are generated somehow "magically" by Sasha, so maybe he hasn't updated
them for newer releases?

thanks,

greg k-h

