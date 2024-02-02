Return-Path: <stable+bounces-17767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B188479E9
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 20:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E911F2592C
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A0280601;
	Fri,  2 Feb 2024 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YidB8HPf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35715E5AE;
	Fri,  2 Feb 2024 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903413; cv=none; b=G6WP/dOdz2sZ7YckAoF0q/w3XUCJ12dscOT8pY9ix99CpOA8VHIFHoLKiimj4PXmvOiaCHoF9uXvx3350UCiF4st3ynx+wupE3lGBkMVg28Qql9EzJpWBQPppro78RpY4EJzvMyzZffKHpmDukfx8PKRGtYFgyjKgw1dYbiVBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903413; c=relaxed/simple;
	bh=YcqAb0eeG1UQfU4RQ4w69QvxJUQXnoH0wE5ZB5Uatb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cau+wz1Msy+QBHIdP3eVnu63lNXKYxDi77ExuK2Digq/MGCEbuVu8vRpV6qYhyXJR1DvJNgtETKPsaTnzI8Z5ApWtUxpBVfhqm0ledLB9RLujfWlBZkFT6OLWni64ROoNgaxwcJu4s+yELlwIHMWhYnpTxJp7KhAXa12KCuPJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YidB8HPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95CAC433C7;
	Fri,  2 Feb 2024 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903413;
	bh=YcqAb0eeG1UQfU4RQ4w69QvxJUQXnoH0wE5ZB5Uatb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YidB8HPfaMzk1DQCxQDxYti2FrCpVS5hh8CSjsQIcrRNuXC/utJCu57kxm8TUftjz
	 J4mAiQK8KNEFuwzcPAntEeE2LROLqEumT5oRgcFIwZuGbLWR2YJVBAlxYL/+/YrszE
	 CqzMUq3gcqHWdpOu55u9t/l4z7I9fRk/409B7VyzHXav5s2J5LhiuP6X+nFZ7Z+MN+
	 LquKa4cHWYSUOEClkmOFS7hAahIdBmzFz2VdEgC0hu9E/HeOnezYbDHQW6PaQqVxk1
	 ax9F43G1Dw01P7fEuRVIZo/N/D+MHux6OVqK3NS3AtrOOApwRzyUBORMW6ESvEKaXd
	 9FCoMokATyttA==
Date: Fri, 2 Feb 2024 14:50:11 -0500
From: Sasha Levin <sashal@kernel.org>
To: Tim Lunn <tim@feathertop.org>
Cc: stable-commits@vger.kernel.org, stable@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: Patch "i2c: rk3x: Adjust mask/value offset for i2c2 on rv1126"
 has been added to the 6.1-stable tree
Message-ID: <Zb1Hc48F3ssUPOjw@sashalap>
References: <20240201172757.95049-1-sashal@kernel.org>
 <1698d0d4-8637-4723-b2b2-5e06d5410e5f@feathertop.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1698d0d4-8637-4723-b2b2-5e06d5410e5f@feathertop.org>

On Fri, Feb 02, 2024 at 07:10:29PM +1100, Tim Lunn wrote:
>Hi,
>  This patch should not be added to 6.1 stable since support for the 
>Rockchip rv1126 SoC was only added later around 6.3.

I'll drop it from 6.1, thanks!

-- 
Thanks,
Sasha

