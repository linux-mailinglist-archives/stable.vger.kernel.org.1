Return-Path: <stable+bounces-53838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E2090EA37
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB17282C66
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D28E13212E;
	Wed, 19 Jun 2024 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kjsLl26i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B42B76035
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798318; cv=none; b=oKHeqDkKJ5qiNST3pDfT+whSTp91ftKa2QuoQhAO9NirFSOS4JW7HT0tjt22h7oWblnQwX27G8doG/SdvSLahy3Trh6vPrMHCczPPs1CftN82f12lRNCWXBqUIVuEurf+PGeH8b7DEg9urZ0XPtXUefGrdfSmnE4dX8izvHJUWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798318; c=relaxed/simple;
	bh=LvljYJ+YeuOYMerp6SN0lzv5HhCMow9M1vE2O+nc9YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GclEgLBBqG0QfJEerkJnWrKJU4DhmnR4D7TyDUbLm/DOV7odDF/ABBRGdCH0zXYKh7PxlH8ZMkFh5iZ0KwZyv4MvyUGuAB8v0E74II84KroctgwtiIBKAvqag2reFyCZydmB8XOcQ/ulpJH9uCTE+MsJEb4RAyjAO8oRpkE8lug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kjsLl26i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584A0C2BBFC;
	Wed, 19 Jun 2024 11:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718798317;
	bh=LvljYJ+YeuOYMerp6SN0lzv5HhCMow9M1vE2O+nc9YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjsLl26iESu1Vb3Yiqwx7ojVcUCs2AHhUSPXYPASWl6kF0Tz99faprWExcE+1inDa
	 jtjThaWGYWFGWgNdzfTuzjtZlSlS4ANVd+731SFP59/L6sv/B4X9hHGxifeM5xJopd
	 KhNCBpn/ED4J54BKmiVwx9ULTKbadMUEFCEZK6/Q=
Date: Wed, 19 Jun 2024 13:58:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronnie Sahlberg <rsahlberg@ciq.com>
Cc: stable@vger.kernel.org
Subject: Re: Candidates for stable v6.9..v6.10-rc3 NULL pointers
Message-ID: <2024061924-obedience-doorframe-12da@gregkh>
References: <CAK4epfyJJKm6kShw9Fa0dA=ns3CK8wjA4v236nRfubxfibnRFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK4epfyJJKm6kShw9Fa0dA=ns3CK8wjA4v236nRfubxfibnRFw@mail.gmail.com>

On Sat, Jun 15, 2024 at 07:28:30PM -0400, Ronnie Sahlberg wrote:
> Manually checked list of commits in upstream that mention NULL pointers and
> that reference that they fix a commit that is in linux-running-stable.
> 
> a9b9741854a9fe9df948
> c4ab9da85b9df3692f86
> c44711b78608c98a3e6b
> 0dcc53abf58d572d34c5

All already grabbed.

> 445c0b69c72903528fdf

Note, this one references a 6.10-rc1 commit, so it can't be included.
Don't know if you want to add that to your script to check.

> 97ab3e8eec0ce79d9e26

Same, 6.10-rc1.  And also, the check is wrong, that's not what this
commit does, you might want to read the commits :)

> 47558cbaa842c4561d08

Fixes 6.10-rc1

> 62cbabc6fd228e62daff

Fixes 6.10-rc1

> 02367f52901932674ff2

Welcome to my hell :(

This already is in the tree, as a totally different commit, and
backported properly, but the AMD developers seem to like to apply it to
different branches at the same time, AND give us no hints that they did
so.  Ugh, it's a mess and one reason I dread reviewing amdgpu driver
patches for stable these days...

thanks,

greg k-h

