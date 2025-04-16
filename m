Return-Path: <stable+bounces-132823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A406A8AEA4
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 05:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311723B94D1
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 03:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D21227E87;
	Wed, 16 Apr 2025 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jny7FgP2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73712557C;
	Wed, 16 Apr 2025 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775552; cv=none; b=h2ubrJqgsKGpLm8acUsMQIptnMvU2ArtqFT0WjRMK4ZgFYOOmQKKJaxcIszMYLMFLEp8rmavITngF15B6be3U14EwC17vwsxwyfSW8KhTesUVhmP/up29AL4lqWPZmIJl+iRYUcD95bIyMgx4u/eUUjoYTLSrxQVytkmob+SRW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775552; c=relaxed/simple;
	bh=X8GOj8KzoE65AU/0QNunTtYNIU1O+4MiqmW1xDDR3Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojxJOn7MKGG2CstO0rJ0EBaDmgIoJUYNad9+PVSPCR/A3J5/Ije+OlQS/KTdDu0fz43/bKuIZu2zu/qXNxstGozyvuz3i9mFnkHBsatcmbykUJF0heSAQ0dYkstyppKYtJoH8zcIQTtPc0gBYAqxvmXYCmp7wmrtZufeqRlRnCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jny7FgP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E71C4CEE2;
	Wed, 16 Apr 2025 03:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744775552;
	bh=X8GOj8KzoE65AU/0QNunTtYNIU1O+4MiqmW1xDDR3Xw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jny7FgP2iKu/iyC6ShA6j74KOTQlsjxkJthKBvnAjIsqNJPR8UqHSyueDrkDNqAPS
	 zFcQY8WCYMD1SmrOSTiTW7OAYRrlYNLm7v6ViOte3FZDIDP+rGfH+xyvbwYCerx/4v
	 qHwDLT/yMehAoNdfORHlYi/c/jR4QhX3ttT09M5R7O1EdCB4kXVYsix+mLf5yZx+A3
	 /GDi4FElPQc+LbUuxGoT623HJ4i4G6Ejp6vy5IoRznm0RE8fsBvoZM2SnwXLUG9wGS
	 V41fGBeIEj6LNAkVYs0hNVz9DSokZajoAvGHx5B3cbw6aZkT1ZFmBU6xrSTwMiKzgA
	 7ScXEf6C4lc5Q==
Date: Tue, 15 Apr 2025 20:52:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Qasim Ijaz <qasdev00@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH 5/5] net: ch9200: avoid triggering NWay restart on
 non-zero PHY ID
Message-ID: <20250415205230.01f56679@kernel.org>
In-Reply-To: <b49e6c21-8e0a-4e54-86eb-c18f1446c430@lunn.ch>
References: <20250412183829.41342-1-qasdev00@gmail.com>
	<20250412183829.41342-6-qasdev00@gmail.com>
	<b49e6c21-8e0a-4e54-86eb-c18f1446c430@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 03:35:07 +0200 Andrew Lunn wrote:
> > @@ -182,7 +182,7 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
> >  		   __func__, phy_id, loc);
> >  
> >  	if (phy_id != 0)
> > -		return -ENODEV;
> > +		return 0;  
> 
> An actually MDIO bus would return 0xffff is asked to read from a PHY
> which is not on the bus. But i've no idea how the ancient mii code
> handles this.
> 
> If this code every gets updated to using phylib, many of the changes
> you are making will need reverting because phylib actually wants to
> see the errors. So i'm somewhat reluctant to make changes like this.

Right.

I mean most of the patches seem to be adding error checking, unlike
this one, but since Qasim doesn't have access to this HW they are
more likely to break stuff than fix. I'm going to apply the first
patch, Qasim if you'd like to clean up the rest I think it should
be done separately without the Fixes tags, if at all.

