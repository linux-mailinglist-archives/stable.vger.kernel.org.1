Return-Path: <stable+bounces-69032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E33795351F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B920D28293D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9054F19FA90;
	Thu, 15 Aug 2024 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="GoSmb/Dy"
X-Original-To: stable@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D341DFFB
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732448; cv=none; b=K5TjVSBnWCidGQcEvNlcuguQ+Gpi9ohUn/kto/ZhocmwtRX9/fU3hyTO75vhgnkf1Ap+Fe/1NS3mqS4MlHO+uBLw+tu8Qbw4pC+6kpA4uoSic6h1KzkQsAUiK61/4sQ5HWY3uul+lma7W8lqtZLTi1uipvRnGzK2OeWIl/LJoB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732448; c=relaxed/simple;
	bh=BO0n+O7EJs1I9dLjyqNtz6bJ9wBbUzVxEOeDNvtyjUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfAbLxRnVckSXL21/ezUFODNmkPxbH3kckAkWLwCVjEEnUoTDffFRPyOQttK9qTFODF0Bh33tcf6Jr26ckfKt0QjYZ8e6rJPCXzcYn9Kkue/QrDcDhBEuenF9Jkyjz1ygWsi31SXIQ0N9oGDf4IcPD0uDtNU/dk85GE5ZzSrgZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=GoSmb/Dy; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1723732444; bh=BO0n+O7EJs1I9dLjyqNtz6bJ9wBbUzVxEOeDNvtyjUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GoSmb/DyL2TyxpsisZ9X4Wp4Ht4nEfTToj9biyMxrnLNLPp2LtOM1XtzcS0+ZlQR0
	 qgmoY7RWZzSzrRP4d7fneHWB1wA1zYOmOiZqcVgViYLX07o16gkj+KDATAunLncmWj
	 ZrezKja9QKqspeLowCXaGs52tfpbicpi8dbG61bM8hikAOVi8PHXh6j6evqPnwsqBE
	 kUyNW18AH62jyV0wsGuiChZnyfKLfcOHo/+6EcfQDixCjHWVo1YqeOHeiEfd/UGxg0
	 fytb9p3mGSLuSo7QEWtk3iyLUUYe8jgyQ/PcfrfpRiwI6RVlBqBjsWYlPaEjF+7R7h
	 T1FQWW/YSekzg==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 3EAB1100104; Thu, 15 Aug 2024 15:34:04 +0100 (BST)
Date: Thu, 15 Aug 2024 15:34:04 +0100
From: Sean Young <sean@mess.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 068/352] media: dvb-usb: Fix unexpected infinite
 loop in dvb_usb_read_remote_control()
Message-ID: <Zr4R3E207yZPKYjB@gofer.mess.org>
References: <20240815131919.196120297@linuxfoundation.org>
 <20240815131921.871240885@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815131921.871240885@linuxfoundation.org>

On Thu, Aug 15, 2024 at 03:22:14PM +0200, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Zheng Yejian <zhengyejian1@huawei.com>
> 
> [ Upstream commit 2052138b7da52ad5ccaf74f736d00f39a1c9198c ]
> 
> Infinite log printing occurs during fuzz test:
> 
>   rc rc1: DViCO FusionHDTV DVB-T USB (LGZ201) as ...
>   ...
>   dvb-usb: schedule remote query interval to 100 msecs.
>   dvb-usb: DViCO FusionHDTV DVB-T USB (LGZ201) successfully initialized ...
>   dvb-usb: bulk message failed: -22 (1/0)
>   dvb-usb: bulk message failed: -22 (1/0)
>   dvb-usb: bulk message failed: -22 (1/0)
>   ...
>   dvb-usb: bulk message failed: -22 (1/0)
> 
> Looking into the codes, there is a loop in dvb_usb_read_remote_control(),
> that is in rc_core_dvb_usb_remote_init() create a work that will call
> dvb_usb_read_remote_control(), and this work will reschedule itself at
> 'rc_interval' intervals to recursively call dvb_usb_read_remote_control(),
> see following code snippet:

This commit causes problems and has been reverted upstream.

https://git.linuxtv.org/media_stage.git/commit/?h=fixes&id=0c84bde4f37ba27d50e4c70ecacd33fe4a57030d

Please don't apply.

Thanks,

Sean

