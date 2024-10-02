Return-Path: <stable+bounces-78653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C1298D370
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8160282563
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9CB1CF5FD;
	Wed,  2 Oct 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cDsd5CI6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F11CF5F8
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872779; cv=none; b=q2Qd7zi3L6zxN2jJnFVxFi23JHPHclbpJpaEGSoitmVgTbPY7Gxt0ndOlCYGStuhsLasog0zz2tBp3gxA8UetzMPDL1Ahyvm5e1WYxtqAzawYVU4dQrXBZM9y6ZeNFMez02ysw/Bmngq75RTvAHxxBBoNbmO4RPaxndXFm9r+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872779; c=relaxed/simple;
	bh=f9wr5vdOJLJBZlTmR++dikWs1XCnFEtT3MVMCQvhd60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0EyXsUhFXfEpemQLmZ1QeBFSv+chixjMCYMXrnaVFSS9KRaUJQcu4wSV2KZqYXKezYDWX9BJEXeRpfmIddURVI2gbj21/eduy2MQ0ZJCtJ6N9u27op010TWP/uQdqUYc4wzQv9x3/A6KNE2v2tf9kY6CJSW8XOUB7XgP6M0LQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cDsd5CI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97926C4CEC5;
	Wed,  2 Oct 2024 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727872779;
	bh=f9wr5vdOJLJBZlTmR++dikWs1XCnFEtT3MVMCQvhd60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDsd5CI6YNRjCW2NZoACFYWsd0IJdNvki3HDnS2Lftf7eCAn9ltdnqgd/wDzv2P7K
	 ycvR4OyvJSxwGpd+7fLnt0DAaS5Swvo3am6UlFpa6ZJhUVunCT19sAuj2tNA4AEpdT
	 nNEkWPR9UuzsnJh80sK7v9owMw4fXuZCjxgWRE/E=
Date: Wed, 2 Oct 2024 14:39:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georg =?iso-8859-1?Q?M=FCller?= <georgmueller@gmx.net>
Cc: stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Helmut Grohne <helmut@freexian.com>, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: mt76: do not run mt76_unregister_device() on
 unregistered hw
Message-ID: <2024100217-sighing-rehab-b6fd@gregkh>
References: <2024100221-flight-whenever-eedb@gregkh>
 <20241002120721.1324759-1-georgmueller@gmx.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002120721.1324759-1-georgmueller@gmx.net>

On Wed, Oct 02, 2024 at 02:06:24PM +0200, Georg Müller wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> commit 41130c32f3a18fcc930316da17f3a5f3bc326aa1 upstream.
> 
> Trying to probe a mt7921e pci card without firmware results in a
> successful probe where ieee80211_register_hw hasn't been called. When
> removing the driver, ieee802111_unregister_hw is called unconditionally
> leading to a kernel NULL pointer dereference.
> Fix the issue running mt76_unregister_device routine just for registered
> hw.
> 
> Link: https://bugs.debian.org/1029116
> Link: https://bugs.kali.org/view.php?id=8140
> Reported-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
> Fixes: 1c71e03afe4b ("mt76: mt7921: move mt7921_init_hw in a dedicated work")
> Tested-by: Helmut Grohne <helmut@freexian.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Georg Müller <georgmueller@gmx.net>
> Link: https://lore.kernel.org/r/be3457d82f4e44bb71a22b2b5db27b644a37b1e1.1677107277.git.lorenzo@kernel.org
> ---
>  drivers/net/wireless/mediatek/mt76/mac80211.c | 8 ++++++++
>  drivers/net/wireless/mediatek/mt76/mt76.h     | 1 +
>  2 files changed, 9 insertions(+)

What kernel tree(s) do you want this applied to?

thanks,

greg k-h

