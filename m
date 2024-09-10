Return-Path: <stable+bounces-74108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2438997285B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 06:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA31D1F247E7
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 04:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06D114387B;
	Tue, 10 Sep 2024 04:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vBDDcxGb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6266825776;
	Tue, 10 Sep 2024 04:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725942890; cv=none; b=j81Acw1TTAQB0z659CpHG5OxD5pSU2HNRzMXK+8G6gz2Hj/dihqMxjJCWSS8L5NK87LxCRu6mXopiASs53lK3JeTTTAEuID7Bm+p8cDd6Ybh6vJ1zlwnbkxvTiM7Ya0v8ijKTujFb09I/x6emCnyZXx3dD97Fyk2IE+MhOYKdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725942890; c=relaxed/simple;
	bh=3587sqqY/wwTbxnJwLDhJbp/AHFqJfYDcLQvEY0EFrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuF7u+XD7MtUxu775vHWHbvggNgyZVk/JT13FensOnZ5XCVYXT9RILNHSK99wjlBI0Wq4fbMgOqvpJS+tQEpP3HNY3agcgORjMkcwM3dlCPdzVQ0mrV+tuvUpCtJ/0U0FcZbLa5OEVWds1jQhb0ZBAWyCXWLu3kSIKLEtvXDvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vBDDcxGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410D6C4CEC3;
	Tue, 10 Sep 2024 04:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725942889;
	bh=3587sqqY/wwTbxnJwLDhJbp/AHFqJfYDcLQvEY0EFrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vBDDcxGbmPyjEWYVOO51V3SNRpVYdGG3cHhzra4LgXQLrtugZG4zZDLuCv3J8PIyi
	 9CCeGja502BTIdGquBDgKLOfydZRwyhYUsFwtzky3eFtOCwT1U0QDYmfanoAljP9m2
	 6wdpImjokvBj5TiS0/K6SroJ6G1DglBiplua+5+I=
Date: Tue, 10 Sep 2024 06:34:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org,
	nsz@port70.net, mst@redhat.com, jasowang@redhat.com,
	yury.khrustalev@arm.com, broonie@kernel.org, sudeep.holla@arm.com,
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.net
Subject: Re: [PATCH net] net: tighten bad gso csum offset check in
 virtio_net_hdr
Message-ID: <2024091024-gratitude-challenge-c4c3@gregkh>
References: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>

On Mon, Sep 09, 2024 at 08:38:52PM -0400, Willem de Bruijn wrote:
> Cc: <stable@vger.kernel.net>

This is not a correct email address :(


