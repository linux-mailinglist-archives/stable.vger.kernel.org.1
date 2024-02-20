Return-Path: <stable+bounces-20846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B5B85C027
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 16:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE9FB2472E
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F3F7603D;
	Tue, 20 Feb 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DZNSBWG3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D252C6AA
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443488; cv=none; b=uU5D3FENPVBsDLL4w6C1JhEu154lm9xEdKQt4Ce0oDgZNEyGE+I5zSqkI5LFtjAdDaZ+2rLdc3e5J5cthwBIwwWhvIR13K0EhfZFl0iZpe41Y1uJxZb3F1J1/VpZQyW4H+rAzbMHcf7KynR38oc+9SI9HkFrrVylOM2k0mcTAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443488; c=relaxed/simple;
	bh=UqDHHHX0uJv6x2rrTS1eUZPKam1d4zqXLELUZYWNFBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSDjbbvEp3wCOJtKBj96i7SbK1DOqjMHAfypvirTo91FCQpVwFl3cm7waPxmAwzg4MAnvMIb+wby6KC5EC1NJh58mUx3Iy46HZFpp3cu6OnsxrN6yEj/SYzLLKSY/amjuAFN6xmt9QfQ1VlcPkVIyqwFZ9xDa4k4lNQp2zTozbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DZNSBWG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C38C433F1;
	Tue, 20 Feb 2024 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708443488;
	bh=UqDHHHX0uJv6x2rrTS1eUZPKam1d4zqXLELUZYWNFBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZNSBWG3Zcq9ko/WqJ19fyh4tht5kdS4r/tOxwlmz2lnQDP00KIiAaQcfnRMmUgAd
	 y3dNOuvfLgMkBXEDQnVCamKtr9R1WZBtK6qUseZC6bNFWdd4wDKZkqHJofAPb0I7Gw
	 nUB52kiC0tLb+3pjf2mD3YZjfSh/B1ice8BIvHgo=
Date: Tue, 20 Feb 2024 16:38:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
Cc: stable@vger.kernel.org, ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com
Subject: Re: [PATCH 6.1.y 0/2] Backport Fixes to linux-6.1.y
Message-ID: <2024022042-tummy-carol-4ce9@gregkh>
References: <20240210200607.3089190-1-guruswamy.basavaiah@broadcom.com>
 <20240210200607.3089190-3-guruswamy.basavaiah@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210200607.3089190-3-guruswamy.basavaiah@broadcom.com>

On Sun, Feb 11, 2024 at 01:36:07AM +0530, Guruswamy Basavaiah wrote:
> Here are the two backported patches aimed at addressing a crash.
> 
> Patch 1 fix validate offsets and lengths before dereferencing create
> contexts in smb2_parse_contexts().
> 
> Patch 2 fix issue in patch 1.
> 
> The original patches were authored by Paulo Alcantara <pc@manguebit.com>.
> Original Patches:
> 1. af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts()")
> 2. 76025cc2285d ("smb: client: fix parsing of SMB3.1.1 POSIX create context")
> 
> Please review and consider applying these patches.

All now queued up.

And it looks like af1689a9b770 ("smb: client: fix potential OOBs in
smb2_parse_contexts()") should get a CVE assignment, right?

thanks,

greg k-h

