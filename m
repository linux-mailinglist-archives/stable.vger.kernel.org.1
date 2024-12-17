Return-Path: <stable+bounces-104510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6D99F4E44
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 15:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308531673DA
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 14:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A91C1F7078;
	Tue, 17 Dec 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2d5V7Emf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D51F7071;
	Tue, 17 Dec 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446997; cv=none; b=eYtvVbeNw1TwUBcN4s4MqtoWIxHtl9ZlcqWIWgUm4u+VVoD4uYju/AcEnQBe8D7hc5uGBNuFIOIAYQSCNh4NRUzGFwirshxDx/FbBJWjSJgwOE2SjlAurMK3EQdz9fgamEw1J2HtAQsQcpFAcoHuTZ62rt5PsmJV00FKkNxhUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446997; c=relaxed/simple;
	bh=H3XMaMnqYuL3e4+tH/pvlndNBZxo6dScvYg4WOvDYKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7JJ+1ym9sb18HfkwbwFtXhxz4tblAtSDArIiZFaZhHaSK+glGc8simx6P7+zzWNYR3yM4QQ9Unj0PIUDCypNinjWmgOQJUuqY2mdOZyGbuZSgXwhLGBDiKL5jKy+YUrFAmb/tNLqGhpR/n33jfNhvhl5Ic5vFjpfrZpE+bZVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2d5V7Emf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BB2C4CED3;
	Tue, 17 Dec 2024 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734446996;
	bh=H3XMaMnqYuL3e4+tH/pvlndNBZxo6dScvYg4WOvDYKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2d5V7EmftUKj89yQA/hqiFVotXPQdqxKwkVwEc0A9sgXBGtZutQbjaJTAQGyAsIwI
	 h9XGc8xFt8kXKGFTQxfnt9at3G7rS23WeVqeFt9VgebQJsVtQc9nIDw3J6vSsdu+Sd
	 C2iDNHBPirYgPnNEzEg3hzHye4Iwkg2UtLeOyUzM=
Date: Tue, 17 Dec 2024 15:49:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gustavo Padovan <gus@collabora.com>
Cc: sashal <sashal@kernel.org>,
	"kernelci lists.linux.dev" <kernelci@lists.linux.dev>,
	stable <stable@vger.kernel.org>,
	Engineering - Kernel <kernel@collabora.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: add 'X-KernelTest-Commit' in the stable-rc mail header
Message-ID: <2024121700-spotless-alike-5455@gregkh>
References: <193d4f2b9cc.10a73fabb1534367.6460832658918619961@collabora.com>
 <2024121731-famine-vacate-c548@gregkh>
 <193d506e75f.b285743e1543989.3693511477622845098@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193d506e75f.b285743e1543989.3693511477622845098@collabora.com>

On Tue, Dec 17, 2024 at 11:30:19AM -0300, Gustavo Padovan wrote:
> 
> 
> ---- On Tue, 17 Dec 2024 11:15:58 -0300 Greg KH  wrote ---
> 
>  > On Tue, Dec 17, 2024 at 11:08:17AM -0300, Gustavo Padovan wrote: 
>  > > Hey Greg, Sasha, 
>  > > 
>  > > 
>  > > We are doing some work to further automate stable-rc testing, triage, validation and reporting of stable-rc branches in the new KernelCI system. As part of that, we want to start relying on the X-KernelTest-* mail header parameters, however there is no parameter with the git commit hash of the brach head. 
>  > > 
>  > > Today, there is only information about the tree and branch, but no tags or commits. Essentially, we want to parse the email headers and immediately be able to request results from the KernelCI Dashboard API passing the head commit being tested. 
>  > > 
>  > > Is it possible to add 'X-KernelTest-Commit'? 
>  >  
>  > Not really, no.  When I create the -rc branches, I apply them from 
>  > quilt, push out the -rc branch, and then delete the branch locally, 
>  > never to be seen again. 
>  >  
>  > That branch is ONLY for systems that can not handle a quilt series, as 
>  > it gets rebased constantly and nothing there should ever be treated as 
>  > stable at all. 
>  >  
>  > So my systems don't even have that git id around in order to reference 
>  > it in an email, sorry.  Can't you all handle a quilt series? 
> 
> We have no support at all for quilt in KernelCI. The system pulls kernel
> branches frequently from all the configured trees and build and test them,
> so it does the same for stable-rc.
> 
> Let me understand how quilt works before adding a more elaborated
> answer here as I never used it before.

Ok, in digging, I think I can save off the git id, as I do have it right
_before_ I create the email.  If you don't do anything with quilt, I
can try to add it, but for some reason I thought kernelci was handling
quilt trees in the past.  Did this change?

thanks,

greg k-h

