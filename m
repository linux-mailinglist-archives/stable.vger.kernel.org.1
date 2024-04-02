Return-Path: <stable+bounces-35534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E290F894AC6
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 07:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08A81F2250F
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 05:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6451802B;
	Tue,  2 Apr 2024 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zMvy71Lr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392817C95
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034839; cv=none; b=Oue4khSinHNTGxaT+Cd72sbfgRelIh/qPbgMvzpVoLnsMTod6+MqW/pf6VSnccQmWyrDPq4osAkvpyy89TmOieCD3FJ7qYTKM5cxk7P4c8Ii9Synhaq8OST7nqWAPhC3MXMr+haarr6NpHFJM+GVgr8jao5+IKw0rojpMZo3H0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034839; c=relaxed/simple;
	bh=6S8kijq+Oysb6k53uD58oNqLvCrKfXIjTpa2nh+Uy8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu4v2fBykA7QgqPJS6Tq03RZENG6jsu2/Q8fwPTxDlQcyr7OOlnq7qMPed744H9jJP4en6s8uzISo29rTEsyc7O2JfgUYNIGvcj68cvUxNC5iyays9ZN4ertKzJywNErSQIv+igARqKIiXevlXoXxaqhbQadrCzp/tFV/8W4lJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zMvy71Lr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD849C43390;
	Tue,  2 Apr 2024 05:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712034839;
	bh=6S8kijq+Oysb6k53uD58oNqLvCrKfXIjTpa2nh+Uy8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zMvy71LraeVlJGIBha1Iv5YJEqvT4yT0u1hyeCBkZqXjT2SVUgAl32ygnjKs1WwH5
	 OSc1oTszO739om4jJNSVWHtnnEbik9wrLjdJ1JYylJfh+RuugX/oRm/UqyTnbfy8U2
	 cHllEeW0TM8Czlqy8A0Sh31Jr5IXXtd5lWZzH78U=
Date: Tue, 2 Apr 2024 07:13:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: stable@vger.kernel.org
Subject: Re: Request to cherry-pick a patch for v5.15 (locking/rwsem: Disable
 preemption while trying for rwsem lock)
Message-ID: <2024040214-unhinge-espresso-0a66@gregkh>
References: <20240401215445.GA91663@darkstar.musicnaut.iki.fi>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401215445.GA91663@darkstar.musicnaut.iki.fi>

On Tue, Apr 02, 2024 at 12:54:45AM +0300, Aaro Koskinen wrote:
> Dear stable team,
> 
> Would you please cherry-pick the following patch into v5.15 stable:
> 
>   locking/rwsem: Disable preemption while trying for rwsem lock
> 
>   commit 48dfb5d2560d36fb16c7d430c229d1604ea7d185

Why?  What does it fix?  Why is it needed there?  And why not cc: any of
the people and maintainers involved in it?

> Earlier discussion:
> 
>   https://marc.info/?l=linux-kernel&m=170965048500766&w=2

Please use lore.kernel.org for mailing list archive links.

thanks,

greg k-h

