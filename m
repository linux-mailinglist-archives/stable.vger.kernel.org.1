Return-Path: <stable+bounces-136832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B72CA9EB6F
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5923A6A2C
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3F24EAAB;
	Mon, 28 Apr 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf0mTGVw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF8B672
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745831163; cv=none; b=UqsZQYhvAjxw1X5tH7UOYINIalHdEa4OZ+ARzAwtwQAwcxeCdyEakEYot8fDNjPqfNjcXJwTDtS9lt8PxE1wqSW+S8rHpz+A6TMt8mg6EAbguSOSyxM8AQbQbtsr+4Wm9/YvV/tb5I9IVQsDNa/NUQB7xNBGYSbqODs2TpTFGpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745831163; c=relaxed/simple;
	bh=1h/9ckQWf9Pc4Md7/Yqbc8mEeGIe4ns3eSc4++bxm+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLaMWn0figGu0X5dRr78Z5P+gXZsq+O0A869FbpclNkMxLCJTWvXFdltY5RCwmXmxrNWw0URuLI5F1Mm7OEbDHkOLP0d5J1AGLSdo8+AE6oXy/TSPp6x5hm+2NwqklKZjkliG7TfWOAg4iPWqBF5kUSKeXNdBeMOhgPxk0R6uOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf0mTGVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E508DC4CEE4;
	Mon, 28 Apr 2025 09:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745831162;
	bh=1h/9ckQWf9Pc4Md7/Yqbc8mEeGIe4ns3eSc4++bxm+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cf0mTGVw6SK1Y7NkoO73eL74TXwsKGiFA6Q+O2C4fwrAMDaPSlDiQYHNcXwIuBFYV
	 zT0nSsv00LFE5iqP2Kf9nznopwdAPhC9C75lDmntZmRulHRZr0Vh3YG/MsGbu9Pfxn
	 3uaYnt2wKcT9DUS5MLLH9sIZI8HdAtV9fsraVwtvATfkkvyUd5xZuPMaWPSIHE4gkA
	 naBSfsoofYEvTS9LNyOnPNy3hjPGubPOS+yJQoaFcw28QFPrtNMz0BjzIgGpVQbCju
	 eRBM+XCibzsjJmOwLqkIOtp+faTDxaVQJe52xxHocE0/nKs8D9ohyftr8OKz1UOXFM
	 0sHxqZamRN8Dg==
Date: Mon, 28 Apr 2025 11:05:58 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 6.12.y 1/5] Revert "net: dsa: mv88e6xxx: fix internal
 PHYs for 6320 family"
Message-ID: <mzyqlyur5bqrdu6l2sm4dqidumor7efsuzflok5drjbn7fmcge@hfb2k3xnmymx>
References: <20250428075813.530-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428075813.530-1-kabel@kernel.org>

Sigh.

I used my local versions of these patches, without upstream tags
(reviewed-by, signed-off-by, link).

Should I resend as v2?

Marek

