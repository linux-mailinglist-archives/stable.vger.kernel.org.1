Return-Path: <stable+bounces-96201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F34B9E1672
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F83B226D5
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D136E1BD9EB;
	Tue,  3 Dec 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m7aHGmja"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB818FDC9
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214192; cv=none; b=aeLs3IXh58Fr3VqmFiGaSaieHYl6BfOwTEE45+VagutaHUZZNR15n9XlXwhqpijFMS9Lm/GauqbQqJbd2zHdl329QlAeG98xsSdu/IBEgb3+9Fci9wq75wHoZDUff13UwvesnF+ipEuA8Kpn3L9lodnrzTlNqYDE82dz7xG84pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214192; c=relaxed/simple;
	bh=MdjvM5YFpZrzKgiARwW5K5xMgMidZEOE54Z50clgLjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/+Dbb0sZP7+G9df+GTF3oiXH0XznfZkx583FsA9EwSEHd8mcKaWY0AbJPeMNc2XctVW8CJorovs4oLl3WSOHi7e6gEFWpiOaJ8g21afH8TStxLU1tXPereguHQdzGQHfg6X7PhOTllACt0/K/SxtSCEjph7MJsB6tGyEDE07aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m7aHGmja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CB8C4CECF;
	Tue,  3 Dec 2024 08:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733214192;
	bh=MdjvM5YFpZrzKgiARwW5K5xMgMidZEOE54Z50clgLjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7aHGmjarq2qcwyMXxertWr4CsvEs35KxHGy53FCv+JZBDxbdsHYNlAKV4iyzF4co
	 efsX0ZVKc4Fb/FEf946txDSe2p0PJjVa/FfF6VYVXuu7rNmhQbG8x8s+yHAbV9osNQ
	 vivr9xd2u77G/tBueRiYCpysXUaTKBR9kvtsPdwo=
Date: Tue, 3 Dec 2024 09:23:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: bin.lan.cn@eng.windriver.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6] crypto: starfive - Do not free stack buffer
Message-ID: <2024120340-vessel-pelican-1721@gregkh>
References: <20241203065213.67046-1-bin.lan.cn@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203065213.67046-1-bin.lan.cn@eng.windriver.com>

On Tue, Dec 03, 2024 at 02:52:13PM +0800, bin.lan.cn@eng.windriver.com wrote:
> From: Jia Jie Ho <jiajie.ho@starfivetech.com>
> 
> [ Upstream commit d7f01649f4eaf1878472d3d3f480ae1e50d98f6c ]
> 
> RSA text data uses variable length buffer allocated in software stack.
> Calling kfree on it causes undefined behaviour in subsequent operations.
> 
> Cc: <stable@vger.kernel.org> #6.7+

The cc: says 6.7 and newer, and yet you are wanting this for 6.6.y?
Why?  Why ignore what the author asked for?

thanks,

greg k-h

