Return-Path: <stable+bounces-124743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ABDA660D6
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 22:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A68189D30E
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 21:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA1C2040BE;
	Mon, 17 Mar 2025 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M+NIWZAT"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2479C2036E9;
	Mon, 17 Mar 2025 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247733; cv=none; b=OugWhzM193C6r9EWiEYgErI2aY0AW5A89zxO6R7Al+825eSy3y61StFxz9MQB0CtFwHCb/z/gQK2HSdYNCcguZ3D83FSuWt5o606pEy1cT+e8CvlZ24h6S1K96U9yfl5KG4Joe69mgGaqzGjv2pmp5I+G+ugQ5z/J7wmeV3kdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247733; c=relaxed/simple;
	bh=ITAdDrOIpr7rOlr7ArbGh4OfdGHS9xlJ0OjsfszmptQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZ3bO+UxgMhVUA2+S4711z9JPlWqdb06XfeWVxqC3yzHRm7RJ30r9nQIVXoDKqDNP7CzcWGNbCgTs8T6PTRL3kTxwEIFS2hDbmTTbORF2Q1e2B4CvDa7Eig6YY8y7eu2QwZdBiRVPSeTx5mtL5zZydNKYpZX5Hssd4K2A9KHcKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M+NIWZAT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=xMMmnPBJEktjdljv91lHGY7yLxQd4MXybxp8VFE2QGw=; b=M+
	NIWZATsfqM7inK7z02cmzoeZbrFCXpV8g3eOhwyu7NX8rd6jJ4qpiJvSvaAeSA4P9VqNUOYFdv6sK
	wy9iTCdWH8i+sO+TfAjsSikPcecBuwOx8Cdk3mLdYggKLVrMMxiyQ6EghmoLxMksjxBqeo8umOi/j
	smirC3X/+o3PwQw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuIDn-006BUL-3s; Mon, 17 Mar 2025 22:42:07 +0100
Date: Mon, 17 Mar 2025 22:42:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, netdev@vger.kernel.org,
	Lev Olshvang <lev_o@rad.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/7] net: dsa: mv88e6xxx: fix VTU methods for 6320
 family
Message-ID: <51e27911-5d31-4b47-93e7-5f81d0a6295c@lunn.ch>
References: <20250317173250.28780-1-kabel@kernel.org>
 <20250317173250.28780-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317173250.28780-2-kabel@kernel.org>

On Mon, Mar 17, 2025 at 06:32:44PM +0100, Marek Behún wrote:
> The VTU registers of the 6320 family use the 6352 semantics, not 6185.
> Fix it.
> 
> Fixes: b8fee9571063 ("net: dsa: mv88e6xxx: add VLAN Get Next support")
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.15.x

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

