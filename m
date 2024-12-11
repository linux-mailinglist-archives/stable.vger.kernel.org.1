Return-Path: <stable+bounces-100543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A899EC67B
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6615B281AA1
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10EE1D4610;
	Wed, 11 Dec 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pdv2BeO3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3321C760A
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904215; cv=none; b=IXpdrjsGBeRQoBjh9lT284RacezTd+7IBA65YtZDfJykfX7J+dU0QDahdzjzwAlA3Y5sLB0m6GfrweDJSB3/CYZ2mWjn9dAZVeCttZFk2xqBhNq1wrH46/Qp0560MJhlxFnxxPm8WSkbroE6uUjBHW7FBgheaZEs8PH52aj3hMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904215; c=relaxed/simple;
	bh=D3JIzLr3FAS21QcV4c+UCS5ytDKNbxurNJJcnt90S2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+UhL4qwfNfVfVo4Sn8OZjQxdIPpSJS+obx8KhBspHehQt0s5A1tbOG5BWRi0lKdWIVSwhuwrmA8/kjnzVJz63ju/zeok9dx40V6SCgF+55XI9yLq2HbRnLpywiLkjxiSErJddA7H5lYFO4w1RnKNMgGVSucJz+SWlOJnGBr2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pdv2BeO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45C7C4CED2;
	Wed, 11 Dec 2024 08:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904215;
	bh=D3JIzLr3FAS21QcV4c+UCS5ytDKNbxurNJJcnt90S2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdv2BeO3OHG6pOIwIHC2a46yDqs5A9SKKhwGKa6qZatX3C72AvPONNBdXsnQwGCG6
	 iUCavGKHvlKW97D5TARKoMjG124WtEV9MHWnQLzbo/TeUCWeG6rsROxZaqDefvBUn4
	 Bg82DP9mopkePXf8F3gRCIBkAZ0rSR1s04tbacds=
Date: Wed, 11 Dec 2024 09:02:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guocai.he.cn@windriver.com
Cc: juntong.deng@outlook.com, stable@vger.kernel.org
Subject: Re: [PATCH][5.15.y] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Message-ID: <2024121140-worshiper-buddy-1799@gregkh>
References: <20241211075458.3346123-1-guocai.he.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211075458.3346123-1-guocai.he.cn@windriver.com>

On Wed, Dec 11, 2024 at 03:54:58PM +0800, guocai.he.cn@windriver.com wrote:
> From: Juntong Deng <juntong.deng@outlook.com>
> 
> commit 7ad4e0a4f61c57c3ca291ee010a9d677d0199fba upstream.

No it is not :(

And why did you not cc: everyone involved in this change?

thanks,

greg k-h

