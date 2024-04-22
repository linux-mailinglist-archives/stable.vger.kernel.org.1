Return-Path: <stable+bounces-40413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABC8AD94E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 01:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E169286ECB
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 23:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4C345BE7;
	Mon, 22 Apr 2024 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/zgHj4r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA54437F
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829756; cv=none; b=BJNMriRvr4JMqB2ROAQX0GcLCiJEV2V5InR2VCxVSQKe/+BlJIXdzlk/bGNmnjHBrWm8His7u0pZyk5jwAVm98UdnVvdPnqSK3qgHTXlhxyRb/DWZyn/IqfWHfgm0AJFY7UoqlHE5M/peWrO8vgS4VzYAhxo7TM8suvH5ithDPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829756; c=relaxed/simple;
	bh=B89hhZxu43GrrOYCxRyEAwyXt1xJPeTrlQmT00oYTI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upRr4nVrJAxQ8MEgjdZNx4yR8kiK2BgziPBn1UoD4BrSV0n8cRP950z4eYrLlW7rmqB9ku9GbtfqCyRD8ffVyBup0dQJv6ldnnANkUmEexUkFHLlJVu+8T3HmS2Hi9JrNYUO3yoN1qUQrCIpngCIaojLMJcoEaOdVj44KNa4nsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/zgHj4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B722C113CC;
	Mon, 22 Apr 2024 23:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713829755;
	bh=B89hhZxu43GrrOYCxRyEAwyXt1xJPeTrlQmT00oYTI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/zgHj4rsg/GlzKVW9Dgl4foxJT34hxvNHqY3lwgvPb/SuIDkm4kqr1SSuBLqJ9SI
	 cXhSFtGV7xHCSLqT1QeZM+mCFNj88RhrsC3sW1ooDgzJQnxPfZXRfYth9aZTsP+/WP
	 QTqh4YDgSEAOzzT+s0/GTaZ+jeueCTK3gtDWHC7KbUQiv89bVI/wLQ0ygGWUew1oXG
	 YyxZj2iPepmU0xAhHJvf+TBzgAL6kbvG6CJzWPE2lra7h0y8n2kfWYU0E91nLnWIdG
	 rvwM262kt2VRaVEWNMBnCbUaKERIxHt2C9WALIO0zhi4UNH1eL/fQE+y3RPYKDmgz3
	 Cu/Z7QQ6XqSgg==
Date: Mon, 22 Apr 2024 19:10:33 -0400
From: Sasha Levin <sashal@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Shay Drori <shayd@nvidia.com>,
	"Anatoli.Chechelnickiy@m.interpipe.biz" <Anatoli.Chechelnickiy@m.interpipe.biz>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"oxana@cloudflare.com" <oxana@cloudflare.com>,
	"leon@kernel.org" <leon@kernel.org>
Subject: Re: mlx5 driver fails to load in kernel 6.6.28
Message-ID: <ZibuaWod4Zvj0D4R@sashalap>
References: <ac75aa6b0f2485826bb530ffc7a78016881c7012.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ac75aa6b0f2485826bb530ffc7a78016881c7012.camel@nvidia.com>

On Mon, Apr 22, 2024 at 05:31:25PM +0000, Dragos Tatulea wrote:
>Hi,
>
>  Based on the issue reported here [0], commit 0553e753ea9e ("net/mlx5: E-
>switch, store eswitch pointer before registering devlink_param") is missing from
>kernel 6.6.x due to a missing tag. Could you please include it in 6.6.x and
>6.8.x?

Queued up, thanks!

-- 
Thanks,
Sasha

