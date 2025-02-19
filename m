Return-Path: <stable+bounces-118262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717BA3BF7E
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308323AA549
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37321E0DE6;
	Wed, 19 Feb 2025 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6N9/mEt4"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC001DF724;
	Wed, 19 Feb 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970529; cv=none; b=YAHFBLitYoTiqdasDDe30YRBbIGWRw3XQ0NRbgBw1jkbuK4DCJzuP7vcljimp7uMzZWbNmdLeNi28GxHJClYPe/eJ2ocp/d8N9OQ59aSt1GKJnPgwPeYfoWquLxuWbC6NaLy3q/Y+y31otb2SIMOutj5sMFIn03+wJQFHfRJdOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970529; c=relaxed/simple;
	bh=Dmhq1otLEb52QzA5/vDqPObz/CJLQjndNWKTPXQJrVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP4Tq7WpW+oQnkKg5bn2zOEXO2m6kdjkMOrsK33Jwq/8V3sgg7wqTnBJznzdMb/EmI0QvFBhfWaPk5+mQI2A9FFdwGq28TzxMk7WxiXsuW+OuvZzR9uvJEzkzIWZJD4AMVYgZPO2KcRDAAL8jrRPZLP2KVBMVUYevMCfZb7+Vhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6N9/mEt4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ps97fPFgvv7ms46pdb7Qt0QiYmDXak+HI5iWt8qfj18=; b=6N9/mEt4wns58U5pxS7JkGhoPU
	UFX563rzhNHSXzCCq2Jet0BYWl4sNkymJ8TAE/z5OOIGxvRczgf65AOkGucoerbi+NUVIG3CbWs8g
	E3tvfbA72FvMDSoh52QcJ19ca9RIWQH1F0kd82c2MdxJwxtwCNlAh468rRDWOlBiGepo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkjoZ-00FdPJ-95; Wed, 19 Feb 2025 14:08:35 +0100
Date: Wed, 19 Feb 2025 14:08:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: advertise 'netns local' property
 via netlink
Message-ID: <e542b4f8-176d-4c2a-bb93-6c7380a5a16b@lunn.ch>
References: <20250218171334.3593873-1-nicolas.dichtel@6wind.com>
 <20250218171334.3593873-2-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218171334.3593873-2-nicolas.dichtel@6wind.com>

On Tue, Feb 18, 2025 at 06:12:35PM +0100, Nicolas Dichtel wrote:
> Since the below commit, there is no way to see if the netns_local property
> is set on a device. Let's add a netlink attribute to advertise it.
> 
> CC: stable@vger.kernel.org
> Fixes: 05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to dev->netns_local")

So you would like this backported. The patch Subject is then wrong and
indicate it is for net. Please see:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The second patch does not have a fixes tag, and i would say is just
ongoing development, not a fix. So please submit that one to net-next.

The code changes themselves look O.K. to me.

    Andrew

---
pw-bot: cr

