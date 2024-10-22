Return-Path: <stable+bounces-87731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50899AB0A9
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 16:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9EDB22A3C
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 14:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380E91A072A;
	Tue, 22 Oct 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUMAtAOe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1D199EA2;
	Tue, 22 Oct 2024 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606731; cv=none; b=K3e6Xk8HCujnBXVRSQN9o3f4ElqTVaMLUa4MR59KgNhdoRmH5VFF70IIYwCDyaZCqVDqaxStzmmR2Uee6Y2WzWlTGwpVq6CgNiJQU9JTojdXXZpKzgexecuRqdbmyinBu7HengL9hbx4hYPfRZxZo9qkp8O+Lst1Jk3W7fw1XYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606731; c=relaxed/simple;
	bh=kSy/v9zsfg+uchR+oZgQGS8E9s2D6ymYvJFZLCaTfa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1eP1qZBjX0nsF29M75DsTKN2nlf64ifUIT1w8eRf9XpE56H0cgUNR8xQ36Bpkvsy3ady/OvtYf+pc7lsmWsd8YTe9mdoyXZHnYhiAB763IphQofQPLjPZPM+KMnRbLDfSSeBVXhJgNnqEQ3z/zP2KSqjFYRgq3mHPwxss/dXTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUMAtAOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4C9C4CEC3;
	Tue, 22 Oct 2024 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729606730;
	bh=kSy/v9zsfg+uchR+oZgQGS8E9s2D6ymYvJFZLCaTfa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUMAtAOe/7jErEnEwy4C5P8AzfM8Jm+XyKKU479VR9/+EIPyEfTRzYa1Vdpusj3PF
	 U/2LaeLFCoAfnZFw2JswMx9NVFrFidCEJGbSg5ToVhV8qm6Xbizr+HoQAWBgREcDlK
	 NqZEVJ9S0XG7KdK+LXB6A50eATww+OSZZGOyz92juzuNZ9SAJvwqzlttivja+WBlRJ
	 v2NTMImDteJ643cXx8/89wWAppyClzovyOjvkbIQIywu8RZkzI5tmbDBbLt+oJu4Yk
	 WTHTqs7Op5riRXT79yie5gAVHm2j3BqIKR0YuCMqm69TadsGM+RGns+44Hwg+alIuD
	 XPOUpqXUCHIpQ==
Date: Tue, 22 Oct 2024 15:18:45 +0100
From: Simon Horman <horms@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Wolfram Sang <wsa@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Dung Cao <dung@os.amperecomputing.com>
Subject: Re: [PATCH net v3] mctp i2c: handle NULL header address
Message-ID: <20241022141845.GV402847@kernel.org>
References: <20241022-mctp-i2c-null-dest-v3-1-e929709956c5@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-mctp-i2c-null-dest-v3-1-e929709956c5@codeconstruct.com.au>

On Tue, Oct 22, 2024 at 06:25:14PM +0800, Matt Johnston wrote:
> daddr can be NULL if there is no neighbour table entry present,
> in that case the tx packet should be dropped.
> 
> saddr will usually be set by MCTP core, but check for NULL in case a
> packet is transmitted by a different protocol.
> 
> Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
> Cc: stable@vger.kernel.org
> Reported-by: Dung Cao <dung@os.amperecomputing.com>
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> ---
> Changes in v3:
> - Revert to simpler saddr check of v1, mention in commit message
> - Revert whitespace change from v2
> - Link to v2: https://lore.kernel.org/r/20241021-mctp-i2c-null-dest-v2-1-4503e478517c@codeconstruct.com.au
> 
> Changes in v2:
> - Set saddr to device address if NULL, mention in commit message
> - Fix patch prefix formatting
> - Link to v1: https://lore.kernel.org/r/20241018-mctp-i2c-null-dest-v1-1-ba1ab52966e9@codeconstruct.com.au

Thanks for the updates Matt.

Reviewed-by: Simon Horman <horms@kernel.org>


