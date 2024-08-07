Return-Path: <stable+bounces-65555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013B194A987
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C32B29708
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCA32C69B;
	Wed,  7 Aug 2024 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dzSVlq6+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C91DDE9;
	Wed,  7 Aug 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039945; cv=none; b=hhaIWLDmze3unCYu2/I0VdNIhgQjjqyr4ZiuTSB1To9oZhnkoSzqQgnfsdRngIRdm7bG/LwQegnr9rfeO6tyuSaEJdZh5hPYPRY8TBV7yMwJET2/KK8SNdBOWNWV3GVKDCUUVOf6eDG3d/QgL3A+W/ASMABEcpRgnnL1uPCEFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039945; c=relaxed/simple;
	bh=XBmNQ8weta4OapGv1VXkI53EvLFoX3mkpQ9DnfG/nB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDebDXGLdUTD+1BIeAM3CrGrhnZaUHONARjn8mfSL9EqypEC0ujEhrRlU/6oLuVyJXcaOYE+VR/5cnX2324Z2DyamsrNwVzOVEgzcGrK3QQDwx1dlNApL2ZxtDz+rJ0Ufmgn7c/a50iT3A7kyVCuT76vSg8NyfckwRRWXhe450M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dzSVlq6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFF0C4AF10;
	Wed,  7 Aug 2024 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723039944;
	bh=XBmNQ8weta4OapGv1VXkI53EvLFoX3mkpQ9DnfG/nB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzSVlq6+E4x+IyyrKRzF9XTZcGq28MC/b0Zu23aVQ031kghessoV1TJDo6OoqOZnT
	 ea8MRJKuRmnfSJtn6fZZc8wE1scHUqg4SVAbdfwQr4cEfmJce1lqI4F6WnN5foPWaT
	 5wT6L8DzCtbiZHJlksInOcDkEJL9G+CRXtjLeRJI=
Date: Wed, 7 Aug 2024 16:12:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: avladu@cloudbasesolutions.com
Cc: willemdebruijn.kernel@gmail.com, alexander.duyck@gmail.com,
	arefev@swemel.ru, davem@davemloft.net, edumazet@google.com,
	jasowang@redhat.com, kuba@kernel.org, mst@redhat.com,
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
	willemb@google.com
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <2024080703-unafraid-chastise-acf0@gregkh>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <20240805212829.527616-1-avladu@cloudbasesolutions.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805212829.527616-1-avladu@cloudbasesolutions.com>

On Mon, Aug 05, 2024 at 09:28:29PM +0000, avladu@cloudbasesolutions.com wrote:
> Hello,
> 
> This patch needs to be backported to the stable 6.1.x and 6.64.x branches, as the initial patch https://github.com/torvalds/linux/commit/e269d79c7d35aa3808b1f3c1737d63dab504ddc8 was backported a few days ago: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/linux/virtio_net.h?h=3Dv6.1.103&id=3D5b1997487a3f3373b0f580c8a20b56c1b64b0775
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/linux/virtio_net.h?h=3Dv6.6.44&id=3D90d41ebe0cd4635f6410471efc1dd71b33e894cf

Please provide a working backport, the change does not properly
cherry-pick.

greg k-h

