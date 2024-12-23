Return-Path: <stable+bounces-105618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3E19FAE4E
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 13:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F620165439
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D5A19DFB4;
	Mon, 23 Dec 2024 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1BLaNRzt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36818FDDC
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734957201; cv=none; b=L7UFq96KZwdpHBbnJ+bmvCtqnqE5Eer/KY2eqUMH3RBtCsYsN2sQTcRB/TgqnwC5ZcN8tg9zeUX00IaSC/Ad4hrwk6iFwpJMUp0Rh1C/mjNemiQlqEZ/yFq/Deb4DKtnF5w+HEmYQQfKkZLknHgyYp+9fyqOTg6iREH1h7RYHHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734957201; c=relaxed/simple;
	bh=gNdPIKQWNchUI05DVfttdowLVV5p63k5A2kfSZ0Z0qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJWaNf2YHSFy0L3UEAsSr1T4fcBJw9blIcxmjsebnplE7ifSyYns9UT2TruYfpF+pSoyExXg58c+2ZOeNFf/xshti2pKTjwhPRs5NqN9WrRvLkqRpCh2xdiGWAUn1abtxDpbBMwz4hxIZNSIgux+K8ER03oWMDx0Qi+oiEBEqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1BLaNRzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC3CC4CED3;
	Mon, 23 Dec 2024 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734957200;
	bh=gNdPIKQWNchUI05DVfttdowLVV5p63k5A2kfSZ0Z0qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1BLaNRztxQfyWGlAb6IpRcvN367Lcvx7glUtiHhLjzyyqb1aGRM853P55DoFR8aee
	 ogXm7xR59t2pL5WOU3OGmzgLsVJfBhRnBC+X44lOUIi5v6F9+UFHb7Paf83UvbwfpT
	 bJXcy0RCrCZdqGU2TuoHN/jOf0Pl44zIX9mFukOM=
Date: Mon, 23 Dec 2024 13:33:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org
Subject: Re: Request to port to 6.6.y : c809b0d0e52d ("x86/microcode/AMD:
 Flush patch buffer mapping after application")
Message-ID: <2024122345-demotion-zit-15c6@gregkh>
References: <Z2GZp14ZFOadAskq@antipodes>
 <2024121745-roundworm-thursday-107d@gregkh>
 <Z2LABy6mqCSdvBge@antipodes>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2LABy6mqCSdvBge@antipodes>

On Wed, Dec 18, 2024 at 01:28:55PM +0100, Thomas De Schampheleire wrote:
> On Tue, Dec 17, 2024 at 04:53:43PM +0100, Greg KH wrote:
> > 
> > Please send a set of working, and tested, commits that you wish for us
> > to commit, we can't cherry-pick stuff out of an email like this for
> > obvious reasons :)
> > 
> > And whenever possible, yes, we do want to take the fixes that are in
> > Linus's tree, otherwise maintaining the branch over time gets harder and
> > harder.  So just backport them all please.
> 
> Thanks Greg for your input, understood.
> 
> Borislav, are you open to preparing the required commits?

Wait, why do you want these for the 6.6.y tree if you haven't even
tested to see if they are required or work there?  Why not just move to
6.12.y instead as you know that works.

thanks,

greg k-h

