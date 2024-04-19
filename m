Return-Path: <stable+bounces-40318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1FC8AB569
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 21:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3734E1C216D4
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 19:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B146813AD08;
	Fri, 19 Apr 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EZMeU8+N"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE5C8DE;
	Fri, 19 Apr 2024 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713553587; cv=none; b=QzlmoDsB8h39BcF95mY+ymfnGRUTs2aLbIgJQodZxzV6ihHCAa3aWNzYrxUfBYbtDQrJCVS3HABX1eH9HMJRVRkl70RF5PNrgAp9ekqGM+2GfIZJUmQxuJ4E3F/fRso4bYY07P2h6rYbpxBqQNXCRTONBy2JMfHu2eAB40FFILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713553587; c=relaxed/simple;
	bh=frL8nDEOPNIliRkZiIQStZruuhfZi9k5U/6Msmie5BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd7HiLNlDkUpUjmZ7PvJ9baIJ0ByvDx5lt2VVki87sV1Be7I08q6Mbe5UWCrHNUViNiT2GisJMbVNKuz4zaWxgW2mn+oS1qp1XA90MwX5i5pmUT13EsnIPXjPxgQ8IXYb2OEssf9N5kfVxyBtg6bZwVDom4WlVvVAd9RkbCGifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EZMeU8+N; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ZmQFYaswe3z60hg/CuMLOym6Q3T9KnwS2wmjRnDn+oM=; b=EZ
	MeU8+NJ+ZBi999lgafyf432ur07xzuxB+/J3aV8ZPqjM+K67GilYYxGY8tp16Khd9GDYYYGh0QUZl
	LsfvAlWENVANlpRQt1Mj9pwexlARzPWjgG0AMAa/TD5/ompi7HSxnIq1/IKhJcRZXLcNSkaZb/FUL
	tpQeUw16KVNMhTI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxtZ0-00DTab-4O; Fri, 19 Apr 2024 21:06:22 +0200
Date: Fri, 19 Apr 2024 21:06:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Peter =?iso-8859-1?Q?M=FCnster?= <pm@a16n.net>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH net v2] net: b44: set pause params only when interface is
 up
Message-ID: <3615d058-13c7-4e51-9299-e994ca9c13f3@lunn.ch>
References: <875xwd1g44.fsf@a16n.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xwd1g44.fsf@a16n.net>

On Fri, Apr 19, 2024 at 06:17:47PM +0200, Peter Münster wrote:
> Hi,
> 
> This patch fixes a kernel panic when using netifd.
> Could you please apply it also to linux-5.15.y at least?
> 
> TIA and kind regards,
> -- 
>            Peter

Hi Peter

This is better, but still has some process issues.

> b44_free_rings() accesses b44::rx_buffers (and ::tx_buffers)
> unconditionally, but b44::rx_buffers is only valid when the
> device is up (they get allocated in b44_open(), and deallocated
> again in b44_close()), any other time these is just a NULL pointers.
> 
> So if you try to change the pause params while the network interface
> is disabled/administratively down, everything explodes (which likely
> netifd tries to do).
> 
> Link: https://github.com/openwrt/openwrt/issues/13789
> Fixes: 1da177e4c3f4 (Linux-2.6.12-rc2)

Cc: stable@vger.kernel.org

needs to go here. Your patch will first get applied to the next -rc
release. Once it is published there, any patches with this tag are
automatically added to the list for backporting to stable. That will
include all long term stable branches, so there is no need to request
specifically linux-5.15.

There is some documentation about this here:

https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst

> Reported-by: Peter Münster <pm@a16n.net>
> Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Vaclav Svoboda <svoboda@neng.cz>
> Tested-by: Peter Münster <pm@a16n.net>
> Signed-off-by: Peter Münster <pm@a16n.net>
> ---

Anything above the --- gets merged as the commit message. Anything
below it and the patch proper gets discarded. This is where you can
add comments for Maintainers etc. For this patch, you don't actually
need any such comments.

I often say to mainline newbies: The code is easy, the hard bit is the
processes.

	Andrew

