Return-Path: <stable+bounces-45258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3578C7381
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 11:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A771F21385
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119814373D;
	Thu, 16 May 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U0MVCXlE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9E4143728;
	Thu, 16 May 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850685; cv=none; b=nQ+WILth8KVu8GdbLvgoOMBsmoDOSwiIfZz1m+B+0HaYF/3fCnDtpTch9FF3LyHb52noXX00lfq6vbc7/IqFaPlMPN+12eyX5KG1TWpw4Q+mhPpS+qsJDSZKfZ9iXrGcpZY48cfhwoFBXAowDiSRF8XojuZqr/uez8+eXQ8vzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850685; c=relaxed/simple;
	bh=vG5kKb/YoqJlCegU8O9wLF/fmY+pjYrwWr1TmEYaH4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofpP+nvTfbcm0GVpQXkoblr0NmEuRJZ8CtrlYXY/6XTxRJlioS/VVy9KjjL/Ha25Xm+OybGAGkuf9Gb/dEkYvQw14aqW0fe46JZVtDzHWWTKeDCwQ4TMjWwqxXpJxmPg6XBnES4az0qpkZEDvDABg2/1CXba6W3n5kaacNj/Ejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U0MVCXlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73318C113CC;
	Thu, 16 May 2024 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715850685;
	bh=vG5kKb/YoqJlCegU8O9wLF/fmY+pjYrwWr1TmEYaH4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0MVCXlE2q2eMlFv26BpXqYLgStP+7BUr9SjSYCKSo9laEul2+vverGAz2DBkSp6G
	 AdVoD/JK6HVQ/RHWXliIP8o/++SsYPsRXNqVUPNhRs7xHZQBh0drJ3wcA5e1assWAj
	 i8Kc32vyj+EF+rmPzG6ZzirEBjiw46PXuHpJ5ZS4=
Date: Thu, 16 May 2024 11:11:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM GENET ETHERNET DRIVER" <netdev@vger.kernel.org>,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1 0/4] GENET stable patches for 6.1
Message-ID: <2024051605-unknotted-donation-810f@gregkh>
References: <d52e7e4a-2b60-4fdf-9006-12528a91dabf@broadcom.com>
 <20240515170227.1679927-1-florian.fainelli@broadcom.com>
 <9a9dc83e-b218-4f64-86ee-d93ed3592480@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9dc83e-b218-4f64-86ee-d93ed3592480@sirena.org.uk>

On Wed, May 15, 2024 at 06:35:55PM +0100, Mark Brown wrote:
> On Wed, May 15, 2024 at 10:02:23AM -0700, Florian Fainelli wrote:
> > This brings in a preliminary patch ("net: bcmgenet: Clear RGMII_LINK
> > upon link down") to make sure that ("net: bcmgenet: synchronize
> > EXT_RGMII_OOB_CTRL access") applies to the correct context.
> 
> That seems to resolve the issue on 6.1 stable for me.

Great, thanks for testing and letting us know.  I've queued these up and
will push out a -rc3 now.

greg k-h

