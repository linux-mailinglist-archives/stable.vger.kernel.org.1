Return-Path: <stable+bounces-76080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80BF978076
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E21B23DD2
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535321DA2FE;
	Fri, 13 Sep 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZZKn1WSi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A641D9354
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231847; cv=none; b=a5BfB7y9QzKqVf0pf72gqwpgF/N/7SUsBEiUP9TYyEi1HXYOQcmaCBJDK6TDuM9s415hYW4+emJiW1aqcXTryimn1jNZ4zO8SWAswQuxdYbjdbf2rwnA1DCTlhw5Gb4RUjxw22gZsv4qNbngPsaEahQRT7knvqgPfqD+vj4YKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231847; c=relaxed/simple;
	bh=Pc81ZaUEdBdqV7LA4gRMGUB7p/6ccWNYndkX/on5ZQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBQ6yRmsF/OEDR+NvQ8iewmdnHolfZDPs/XfifMyb6KmbRlfYAHDqSC5ITz5Y9UEIXpLeYy03GrhhtMVC+aZbE1wIkxRjf/qkT8pAQJEvTFIhoLydEn7y2rKdvU8RsL3Ontk97BctnQ0pdBsEaiyo0qQvN9FkYZm8iXcAikgQ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZZKn1WSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4300DC4CEC0;
	Fri, 13 Sep 2024 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726231846;
	bh=Pc81ZaUEdBdqV7LA4gRMGUB7p/6ccWNYndkX/on5ZQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZKn1WSi1OPBtQeiZ+wFFGgszdT1/ja13a8gfXQMzSM7UZEpGySlG2sJvjxS+LG/Q
	 mmIN6aQ59Sx1gh72CQPK28Ko3bUNV+NcAeY/K+tvmPcKGgY1x4bnM0QUb7n5+J0pUZ
	 9zO3vKvQRD6slp7z7GqdQlwfNegh0osmHis71tgw=
Date: Fri, 13 Sep 2024 14:50:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1] soc: ti: omap_prm: Add a null pointer check to the
 omap_prm_domain_init
Message-ID: <2024091335-bridged-uniformly-0f1c@gregkh>
References: <20240912075119.3682507-1-xiangyu.chen@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912075119.3682507-1-xiangyu.chen@windriver.com>

On Thu, Sep 12, 2024 at 03:51:19PM +0800, Xiangyu Chen wrote:
> [ Upstream commit 5d7f58ee08434a33340f75ac7ac5071eea9673b3 ]
> 
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Link: https://lore.kernel.org/r/20240118054257.200814-1-chentao@kylinos.cn
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> [Xiangyu: Modified to apply on 6.1.y]
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> ---
>  drivers/soc/ti/omap_prm.c | 2 ++
>  1 file changed, 2 insertions(+)

Now applied, thanks

greg k-h

