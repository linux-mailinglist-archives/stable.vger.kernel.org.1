Return-Path: <stable+bounces-77866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 523DE987EFD
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 08:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAA21F214A9
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 06:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E8178376;
	Fri, 27 Sep 2024 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dVR6puLk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481815854D;
	Fri, 27 Sep 2024 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420180; cv=none; b=d9nRwNBWY1fHqMp+agLOweuw5w0KT468QQ9arP4oBlzuaVPdsG9NMyfEPh4pcwBUwQWUyzwowzt/rYZdAdONX7lTHE9zwhe+srkF8SeoePmHPgYWNAlV7OYyrMh7TrntsS0Eghy1K0gYcMCMiiQQZPRup4D6JRLAqLJTmI8GTEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420180; c=relaxed/simple;
	bh=WdMFmeU3Y2QwmftoIxuugDuR3ydbfT8qtz7eor0PU+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJWLkWs1BJzSHY20BQ0Wf3mOOV4dmLDZX8TxxVhEeY8fg+ip4GYH9q9G50U32rB7JVUkgY4OJ1862dwqCWBhxiBx4QCsFPIc4oSDwnGeLAUiBx/ta7/rl0SAvy40QICTo4dFyAQ4riTNS+Dh0RVku4DOFW7adRgFAptEi5hwMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dVR6puLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69842C4CEC4;
	Fri, 27 Sep 2024 06:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727420178;
	bh=WdMFmeU3Y2QwmftoIxuugDuR3ydbfT8qtz7eor0PU+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVR6puLkqCCZyHEMc4OTBxdfoiQsTgP/47hu9fO2w1RHdCv309lpgww32UWnTKUlY
	 QlLBC9mkyZtqCQuRYhLYue5kalk3oJrdjjYdU3PhVKrwZNCDmrywe4z0je9Qd7oFii
	 TqEtQyTCv06+GB3Qcbij5lPZyQYAMo1IspMWFKS0=
Date: Fri, 27 Sep 2024 08:56:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Westphal <fw@strlen.de>
Cc: stable@vger.kernel.org,
	netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: stable request: netfilter:  make cgroupsv2 matching work with
 namespaces
Message-ID: <2024092758-mutation-subplot-07fa@gregkh>
References: <20240920101146.GA10413@breakpoint.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920101146.GA10413@breakpoint.cc>

On Fri, Sep 20, 2024 at 12:11:46PM +0200, Florian Westphal wrote:
> Hello,
> 
> please consider picking up:
> 7f3287db6543 ("netfilter: nft_socket: make cgroupsv2 matching work with namespaces")
> and its followup fix,
> 7052622fccb1 ("netfilter: nft_socket: Fix a NULL vs IS_ERR() bug in nft_socket_cgroup_subtree_level()")
> 
> It should cherry-pick fine for 6.1 and later.
> I'm not sure a 5.15 backport is worth it, as its not a crash fix and
> noone has reported this problem so far with a 5.15 kernel.
> 

Now queued up for 6.1 and newer, thanks.

greg k-h

