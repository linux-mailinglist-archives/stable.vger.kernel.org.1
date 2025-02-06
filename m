Return-Path: <stable+bounces-114108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F7A2AB5B
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C354A3AAC42
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FCA1EDA1A;
	Thu,  6 Feb 2025 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HTpD+4Xp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D31EDA17;
	Thu,  6 Feb 2025 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852137; cv=none; b=COJp33GWGLs3EBnUmb/OLu1LUU+NjqC98VDmSP4g+Zw9YsuaDuesllgkYcpM9qMZ1FUmzqVN3Uvumn75j9+qvCxOl4YNWmKm+2Mv/FstgMrwCQxqD3xIqJGN2ZPRDURyTZIz0d5B+oVYO4Vk+qK9ne3ooS9BGYnZbV/uketEAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852137; c=relaxed/simple;
	bh=ITWUA73jn1cGQ5+PJh765YIaWLrbFifLJIuOPNVC76E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fg0Y+Xp7I2MsNtEYVxjYbmqEkDw/rEuDMk6wFIevbIrIlOzFZIHsZ4roZJbPeDncEjsvH8GZi0OMrTbNoo1qwQawTuP93Wb+8Eu8GRJzVUuDGi1TKSejXO1aY7dU4PHyojafaQbaMQJR7T8ARjfEjSV5Db2DuaOjxrU1w7Ekrg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HTpD+4Xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827F3C4CEDD;
	Thu,  6 Feb 2025 14:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738852137;
	bh=ITWUA73jn1cGQ5+PJh765YIaWLrbFifLJIuOPNVC76E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTpD+4Xpkew6n8Zn7kKMLAFgor4nkUh70KWzPBwJjs0Zvkrmf/Vor+0nXRdTnotUl
	 WE++QCQZNZuPMh//hO7UsIW/3Ur78P4cIqr2qI6MuYbtcjWBLGtng1usgyYJ38GeOT
	 Q7OIk6syPdxGd8TH9rBaYvBbXbXwk3huyD/HZN2s=
Date: Thu, 6 Feb 2025 15:28:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	Michal Luczaj <mhal@rbox.co>, Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 544/623] vsock: Keep the binding until socket
 destruction
Message-ID: <2025020644-unwitting-scary-3c0d@gregkh>
References: <20250205134456.221272033@linuxfoundation.org>
 <20250205134517.034256003@linuxfoundation.org>
 <xv4vulunzu47uszjgzjhjzf6jetbvzy4c4uotkfh6t3ns74is4@mcpi3jj5iy4z>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xv4vulunzu47uszjgzjhjzf6jetbvzy4c4uotkfh6t3ns74is4@mcpi3jj5iy4z>

On Thu, Feb 06, 2025 at 11:44:21AM +0100, Luigi Leonardi wrote:
> On Wed, Feb 05, 2025 at 02:44:46PM +0100, Greg Kroah-Hartman wrote:
> > 6.13-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Michal Luczaj <mhal@rbox.co>
> > 
> > [ Upstream commit fcdd2242c0231032fc84e1404315c245ae56322a ]
> > 
> Hi Greg,
> 
> This patch introduced a bug[1], Michal has already sent a patch to fix it
> [2], but has not been merged yet. Should we wait and merge them together?
> WDYT?

Yes, please submit both of these to stable@vger when they hit Linus's
tree.  I'll go drop this now from all queues.

thanks,

greg k-h

