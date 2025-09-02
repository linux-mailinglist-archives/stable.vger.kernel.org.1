Return-Path: <stable+bounces-176997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F719B3FDD7
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F0D3BEEB3
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADDE285C92;
	Tue,  2 Sep 2025 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKV7eH2R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14166247298;
	Tue,  2 Sep 2025 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812796; cv=none; b=M+/dFz+8tbb9+hFnK9eG6xWWlO29yCo+k3vcUps+XCBu+7YoUMLbRYjDbHRYLnJFdlQhTANnNVhwQPsxBj58kJe8MhP/tXCXIvohlqQCiB3zUej02Q7CM25/tO7nMcgTx5LDUhTkou0/8j65240z/TNXGeVR3WBGAtPx8NYxpS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812796; c=relaxed/simple;
	bh=IbP+qoATdoUmKJcwSnOy5l+EPGBWNGta0hBPdHVH0mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7Vn51C/WrE4Tgdko40D0F97ygNNg6P0qY0wqpsaFWaM7nE2rnXpNOjAZ5TjmRJUQin9S8UTO8t7ir2C5RZgHRYLYQtwFQS19rr6zVb8kqewHgj0GB5nVXfaFR1V3fPQ8y3u/7t7zels2iX+qDfd60ITGiLyJ5SNkPAs6bglbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKV7eH2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62063C4CEED;
	Tue,  2 Sep 2025 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756812795;
	bh=IbP+qoATdoUmKJcwSnOy5l+EPGBWNGta0hBPdHVH0mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKV7eH2Ruy7b9erul+GWOUa/Pnm2TPnaSjk8zrUBHEwrniqt0hJ6MzXuEhIdsxQWJ
	 azHnvOHYL9iG8pR7flL3/iEyIConSjFbs0i/v9Yknodw6Biy6pTYGwi1pZrTcxcuUS
	 MTyjDkcvyfUYrk6aiYYAN08wn/zgnzniuNzduVW2afI7p50TlS0Np24JN8E+KSybLl
	 kPrmQ/SZ+OfkMFo1yOABRGYgX3OsLqSg1e7Pf42wWN3rd3yHhUCTyjTi8vMSvopvSG
	 NPIZH+1Uu2ez59h9sA9uD/pFnC7vHcbmQUJ4dEKCvb/kDgQ527Jwj2t9ixwlWUICBt
	 wtgku0ikT1AsA==
Date: Tue, 2 Sep 2025 12:33:10 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: libwx: fix to enable RSS
Message-ID: <20250902113310.GC15473@horms.kernel.org>
References: <11AD624D55764BDF+20250902025713.51152-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11AD624D55764BDF+20250902025713.51152-1-jiawenwu@trustnetic.com>

On Tue, Sep 02, 2025 at 10:57:13AM +0800, Jiawen Wu wrote:
> When SRIOV is enabled, RSS is also supported for the functions. There is
> an incorrect flag judgement which causes RSS to fail to be enabled.
> 
> Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


