Return-Path: <stable+bounces-100552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E658B9EC6BB
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA48167400
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1321C5CD6;
	Wed, 11 Dec 2024 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sTWumnAL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5982E1C1ADB
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904935; cv=none; b=lVWI+lHPRmDkyX7bZyy4AS0DLAfHlke7ZBn1HO9nucGOqt/3rfgkUC+nthEltyPxW0bsDOm7FZUnlgexBLOG4L6ZR4UBt+dlfjOHxfhVpqYposXnElO6CvTAneBAv2oh2WYI2pNnCNfcQEq+acRtWBuKJtJUv76c7P3wQU7ow7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904935; c=relaxed/simple;
	bh=aBxiHQkiLGoKyhhLjGxC+qVeM3Xh980wPSWtEsXLaG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGX86Et0uKoNKFg+PtmvvmBQfp1DM1bQ3mg2djdNl127VgeWVPOJ9RDiKo54HSsjRazgvnmqPQJ0RZGDT249SCRs4sXBKRiI6lEpyuJ0veLytDHscj8WRSaLgvZe9w9CUGkSQq1JgLS5lCaGU/mxWpFPrO3pvqJ5bfyvAEvCoP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sTWumnAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A500C4CED2;
	Wed, 11 Dec 2024 08:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904934;
	bh=aBxiHQkiLGoKyhhLjGxC+qVeM3Xh980wPSWtEsXLaG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTWumnALmUNjWuahvfhsrRoLBAq+g/fezWpcuuuC1SxELPE0Y/JV7gF99qO7AMlDe
	 bQ9npyYxCFH7sIOaXyYH06+2QoexFbbGnae0iMb1137RaiHawqFBO95R2VMSe4TCRC
	 UvIfrqN0tINxnKXrK7V9vXCtcAR1ZWrxXRfPamh0=
Date: Wed, 11 Dec 2024 09:14:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: n.zhandarovich@fintech.ru, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] drm/amd/display: fix NULL checks for adev->dm.dc
 in amdgpu_dm_fini()
Message-ID: <2024121146-sensuous-ungreased-24eb@gregkh>
References: <20241206033119.3139154-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206033119.3139154-1-jianqi.ren.cn@windriver.com>

On Fri, Dec 06, 2024 at 11:31:19AM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> 
> [ Upstream commit 2a3cfb9a24a28da9cc13d2c525a76548865e182c ]

Please cc: all relevant people on backports.

