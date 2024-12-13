Return-Path: <stable+bounces-104007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C53F9F0AA6
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DC916146C
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ABF1DC74A;
	Fri, 13 Dec 2024 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NKnLQgGD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0DC1DB34B
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088504; cv=none; b=fpju5zOU9OrBuGiGME+/8+PuTqVQoPIJy/QdUTGuqL3D9U+DE8xF9QczH2XIix+YhQ4ErojBdnwP48jhZnIYRSVjEuRMKKKcdS4dE6w6aKCKME3sM02yQckUd/ts7C1ZvS3pdOsuwGtad6bkUUBqzOOOwtXPwJo3p6ZUKsFpo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088504; c=relaxed/simple;
	bh=TO3hTDG7ecjwU9kl2RyNwzGT5YQXnk59qnG3ku/yVvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYyTvK3K5zngetNXjLAjN6BBoDVIdI6Hl9OHIDw6e5sYr9oxXx6tXdkMx3ACHVC7RfxucJrW9sm40YsX+Zh5nlBQosbVhabNyTZ76rLEyxhs3WIBWKNJGh46M5W7YepZK5yz6IT50HGQnWnanAZ2DM34xj9r8barxA3T3LU11bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NKnLQgGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2960EC4CED0;
	Fri, 13 Dec 2024 11:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734088504;
	bh=TO3hTDG7ecjwU9kl2RyNwzGT5YQXnk59qnG3ku/yVvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKnLQgGDWcWISrIS7Ioiz0eCk9qXY35g/pq7lgiuFELNvboWvptFjNtdkTiBCy985
	 19nG8lvilQNExaFaQij+TwBHSmSIEnlyvKUeomJNobXxlo6HLH3uR7qN5MmK58NnDM
	 3D0womQ+IvD23LHlV+RNxnos3xt8INppZn59gBCs=
Date: Fri, 13 Dec 2024 12:15:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: bin.lan.cn@eng.windriver.com
Cc: stable@vger.kernel.org, alexander.stein@ew.tq-group.com,
	u.kleine-koenig@pengutronix.de, andi.shyti@kernel.org
Subject: Re: [PATCH 6.1] i2c: lpi2c: Avoid calling clk_get_rate during
 transfer
Message-ID: <2024121353-ancient-unwoven-d540@gregkh>
References: <20241213064314.3560854-1-bin.lan.cn@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213064314.3560854-1-bin.lan.cn@eng.windriver.com>

On Fri, Dec 13, 2024 at 02:43:14PM +0800, bin.lan.cn@eng.windriver.com wrote:
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> [ Upstream commit 4268254a39484fc11ba991ae148bacbe75d9cc0a ]
> 


Now deleted, please see:
        https://lore.kernel.org/r/2024121322-conjuror-gap-b542@gregkh
for what you all need to do, TOGETHER, to get this fixed and so that I 
can accept patches from your company in the future.

thanks,

greg k-h

