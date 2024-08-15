Return-Path: <stable+bounces-67757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823E6952B40
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 11:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FC41F21EE5
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55319DF5E;
	Thu, 15 Aug 2024 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h7qBb/3O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE745CA62
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723711071; cv=none; b=bJ0NnMg8916akkcDrgDeJSv+RmYRwGhtGoC2C+YY6LxoTUbYZK4mdUn/eKC0PZpIAxbcsHbpaifBi9aFqQiVj6oHS6dkAXn+wSHUSj3e/fp4VIrOKJ4yrZrtEI7b1l2GhTr1awAfQIWRE1br5UwTIdoudNcu2eEAbu4ApjYzE6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723711071; c=relaxed/simple;
	bh=K1HUIAbx5uWdA2IoET2LAWLNM5lvys+hiNzw1IYRIbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOFecjcGbSh58d+ChjOllfpn0sd48ZxXjZw13lO8FHd+3xfh51gfryhgDh6AwIGq16A9OpGpTrkC2TjoVnw2cKq4hdLrNrie04b78jAlNHXh/ZQPaxwkwDZPv2rP6m/bVDlZwqsl/KMdkieypVjnLnu6M3uOlfy4i+feU3RnwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h7qBb/3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE93C4AF0F;
	Thu, 15 Aug 2024 08:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723711071;
	bh=K1HUIAbx5uWdA2IoET2LAWLNM5lvys+hiNzw1IYRIbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7qBb/3OlL455e10CDiuTlOktMMkDAFCtigrEd+dU9GOxFyF6bRTjzJB2cMIaN7fa
	 Iv/oYU7+mo8nz2m3AWXaCWGA3KVSdReh5bbXMPSAKaGEjEQpGo4Ks9Bgl6QgkO2Fie
	 ICjTUCN3fggYJ9lbUYdjjX+nw+W0R3bF285sS3+o=
Date: Thu, 15 Aug 2024 10:37:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: David Stevens <stevensd@chromium.org>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH 6.6 0/2] Two patches related to CPU hotplugging
Message-ID: <2024081536-corral-daylong-4838@gregkh>
References: <20240814182826.1731442-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814182826.1731442-1-bvanassche@acm.org>

On Wed, Aug 14, 2024 at 11:28:24AM -0700, Bart Van Assche wrote:
> Hi Greg,
> 
> Please consider these two patches for the 6.6 kernel. These patches are
> unmodified versions of the corresponding upstream commits.

Now applied, but what about older kernels as well?

thanks,

greg k-h

