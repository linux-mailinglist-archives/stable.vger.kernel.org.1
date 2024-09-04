Return-Path: <stable+bounces-73067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D996C066
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E728EE10
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549ED1DC041;
	Wed,  4 Sep 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SBVJG8bu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0261DC049;
	Wed,  4 Sep 2024 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459970; cv=none; b=HfgayF5N/ub5ao0q8pO4xujV2ysmzZLRUlJZdwvQ6iUVN/hFW/epq+LR2EhjRhoelBqaTcq7W7nLOjnloOAobOdUCJx5EAsb6OaoRHetddeTG8/6ie9ibokSIa7K4gsSK4IUPCJ2BDhXSx1rnIfVsEqUOI177OUh8vhte0lZOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459970; c=relaxed/simple;
	bh=rrhYaamXW46ZA8J1vfl8UZPveYwzIsw/ibTYbzfoa4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXNqgRCfuEGrQFuLMySBi761ft9blG9zMp41lUlYAmNIuBPQz2Bzwr8fcdPll02bsYLe/YbKKhzFWmOuyyGd2ywofX3t80WWZZEAOBFWg5yM5ax/avCQNVeLXo94VGEpTCNSnMFJ1o67xGnyEDoKYxKbpaM2v1TYmyxtwEgNySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SBVJG8bu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293ADC4CEC2;
	Wed,  4 Sep 2024 14:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725459969;
	bh=rrhYaamXW46ZA8J1vfl8UZPveYwzIsw/ibTYbzfoa4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBVJG8buCkTtJGLpLYQk7e4EXklcg3IjAoJ0WMUG8cAYnVNqIi4Fi+D0D4xiX0aVQ
	 RyUXe1ApNkWoOar0Q+HV5cE4g0cJ3nfjWkTfLbXpiJA1WSaiUiELBa98qRrXVB3AMY
	 QeOqd3eDbx65bIGS4yRcpRnJDNGkQi/H/n3mOUvc=
Date: Wed, 4 Sep 2024 16:26:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shivani Agarwal <shivani.agarwal@broadcom.com>
Cc: stable@vger.kernel.org, jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	chenyuwen <yuwen.chen@xjmz.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1] f2fs: fix to truncate preallocated blocks in
 f2fs_file_open()
Message-ID: <2024090457-frosted-snowdrift-5483@gregkh>
References: <20240902092616.5249-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902092616.5249-1-shivani.agarwal@broadcom.com>

On Mon, Sep 02, 2024 at 02:26:16AM -0700, Shivani Agarwal wrote:
> From: Chao Yu <chao@kernel.org>
> 
> [ Upstream commit 298b1e4182d657c3e388adcc29477904e9600ed5 ]

Now qeued up, thanks.

greg k-h

