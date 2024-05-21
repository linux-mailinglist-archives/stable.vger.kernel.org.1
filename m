Return-Path: <stable+bounces-45521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEBF8CB16B
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 17:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9562841F2
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50AF77F2F;
	Tue, 21 May 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lds5eCrj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7120F26AC1;
	Tue, 21 May 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305635; cv=none; b=io9oRLMgqX8e38ObFZFOUSfsDjr4zs3H0nPu63K/Q7ZBHG2Y59aSyDj+VI9sokpQmEtNQVQ3H/hV0nGYwF4QX/IUgBNwLWSWlIp8dLMK9cULxRZ88zXNeOQNoU3xceQmZQMx5yzSrZlYeR9uFXDEVnzfB7jr4YRVFDAWVrix/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305635; c=relaxed/simple;
	bh=O9XjgHG+T3xbYU7g2Z9jc6upLuBKh2a4UcoeY/vQHG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tunmUpH52h9ljI8eRokFHnQTo5twvizPWpRYa+I7VHYxl1LPg1aKp1cPhNF6JavGrYQ+NjdJMd8+FOd2ydbm1kDBZLDsYFQ6n+lXmF4Fp91Rz+JhoC1nVHTVGecmRCN3wmm9HTUiNJJHaKeX/324cH72kVQuZjloXdtquAdDgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lds5eCrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97900C2BD11;
	Tue, 21 May 2024 15:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716305635;
	bh=O9XjgHG+T3xbYU7g2Z9jc6upLuBKh2a4UcoeY/vQHG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lds5eCrjHulxNnsx7XMbbHqAyYrpvCx0WP3iJrVQf+2fl5JqcvJmXhczkBYKh1XMs
	 bRvxZb5tW8HK9epJdaLTLpGhGD/1SvQp5MRgYocZZpObV2h8xFosEP7KQCID7EHewt
	 jwmvUUkTpFsyUyl7lF8U/9WZPvwGy75xGmNSH/9I=
Date: Tue, 21 May 2024 17:26:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oleksandr Tymoshenko <ovt@google.com>
Cc: srish.srinivasan@broadcom.com, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, borisp@nvidia.com, davejwatson@fb.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, sashal@kernel.org, sd@queasysnail.net,
	stable@vger.kernel.org, vakul.garg@nxp.com,
	vasavi.sirnapalli@broadcom.com
Subject: Re: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
Message-ID: <2024052144-improper-quarterly-0852@gregkh>
References: <20240328123805.3886026-1-srish.srinivasan@broadcom.com>
 <20240521105838.2239567-1-ovt@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521105838.2239567-1-ovt@google.com>

On Tue, May 21, 2024 at 10:58:38AM +0000, Oleksandr Tymoshenko wrote:
> Hello,
> 
> As far as I understand this issue also affects kernel 5.15. Are there any plans
> to backport it to 5.15?

Why not provide a working backport if you are interested in the 5.15.y
kernel tree?

thanks,

greg k-h

