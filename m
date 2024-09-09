Return-Path: <stable+bounces-74064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733A6971FF5
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 19:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8835EB238ED
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D016F900;
	Mon,  9 Sep 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mqbQoK1V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DD16DED5;
	Mon,  9 Sep 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901484; cv=none; b=owZ+6u2OqTrpenQ5k697at7nGiRvhLJKSZ4xSXxSUaiKbWmW1RSKje1+EddiyZysiKCxBkXbpekWvH+342RjAYZleH2hGxzhineup7P9vtmj34WJ7eiWaNH12PyNeQrs0qosOG+zeOCEAGJQxBI42ewJDe0F4u3hqYTnosV1rs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901484; c=relaxed/simple;
	bh=OfHok9I0g2Q9pMsZai4NU4WsEMttyfpengP9eJGtiwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQ3wWkDg29v8QyGWnI/jlRNcq5c+Auk33xHF0rUk9p6XSwN+HwG/xgWHZ2mMpogx4PkHOV/0bYY/7aOfip8ZQwU5aW1vhwGH9xy3CG5ewSdMBV3/9Ce1/AMesmDSJmxHNLiExBT1lqKmSd6N8l3vWkUj63vhvlmFGiwQmbeyU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mqbQoK1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2BAC4CEC5;
	Mon,  9 Sep 2024 17:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725901483;
	bh=OfHok9I0g2Q9pMsZai4NU4WsEMttyfpengP9eJGtiwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqbQoK1VDTk69prxzGdAo7gvxCiuQXmxKp+svunOCTKnsusNVX6sox3PDaIn1GQCB
	 n+N6th6fIP9AOg5OwMjkJfqwVdIbvAcnCwAVX+bIBaqzQeogEQQhkVWkSJJ7Hj7bBD
	 qFpRDbbd5lfowqBDHfZ3rYHYB8fXusr6RaVhSXH0=
Date: Mon, 9 Sep 2024 19:04:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, william.qiu@starfivetech.com,
	emil.renner.berthing@canonical.com, conor.dooley@microchip.com,
	xingyu.wu@starfivetech.com, walker.chen@starfivetech.com,
	robh@kernel.org, hal.feng@starfivetech.com, kernel@esmil.dk,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH 6.6 1/4] riscv: dts: starfive: add assigned-clock* to
 limit frquency
Message-ID: <2024090915-footpath-agenda-5a55@gregkh>
References: <D200DC520B462771+20240909074645.1161554-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D200DC520B462771+20240909074645.1161554-1-wangyuli@uniontech.com>

On Mon, Sep 09, 2024 at 03:46:27PM +0800, WangYuli wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> In JH7110 SoC, we need to go by-pass mode, so we need add the
> assigned-clock* properties to limit clock frquency.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

What is the git id of this change in Linus's tree?

Please fix this up and resend all 4 patches with the needed information.

thanks,

greg k-h

