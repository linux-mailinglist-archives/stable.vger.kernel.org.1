Return-Path: <stable+bounces-91958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE6E9C218B
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 17:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2201C2448A
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B6742AA2;
	Fri,  8 Nov 2024 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="lJjM6bvv"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4EA1BD9DB;
	Fri,  8 Nov 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081917; cv=none; b=qLJeOcnZpzioxtl5qcTjsvPUgpvXgRKXjEWtv/gY65yEFhgKsgitht3kE7J51jmW/LDYswoIGG8Ki8ZvW+9teQDJNDV3+LVaOFGuKmq6Pfl+WwRRfgsG3jnrgjYXCOW1H5HyZyK2Pkqx1dwJtuPnuUUjQFYZDuMvbxwEb6InU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081917; c=relaxed/simple;
	bh=G9/zEVcoWJwH0oHYX9nwcHzbeFEXbem9ghC8taRi25g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwbq79/ojTELS9A2ybLMH5y7nabRhXbrygtfoi2TNYEJ4+XuytN71soKBNA/Hs/+bE/LHHEcZVJatIOC8A6qZBZtmsA/bTihYXFVKgueAVONBsPLSdKN4xJLmMUcNkR1eOOQVmaoj8Twbdj7o7K8ScegmiVWlc2gYZ/LC+p90yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=lJjM6bvv; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Fri, 8 Nov 2024 16:58:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1731081518;
	bh=G9/zEVcoWJwH0oHYX9nwcHzbeFEXbem9ghC8taRi25g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=lJjM6bvvf2l1TYyo+s0ogi21EHnOwudFrP8MnVizDy/38SZ13sEvnR4vg+N+zUqhV
	 IjIZ4nTBzRVDGGxa0GK38A2y236Ql5PcsnZftTT2dpIbE6AOjB+cO4BZ9CM91NUEZ2
	 MFDDcZ6/ay+G/HGefXPgfjE/syHKGnzyG49JnCAIJ2eqDAPsVtYIe6Q8PBxxnw2wYk
	 h7pweBT8yZ1azBFf6OCb6siszaILf8NP8aUG3TjSOQsjnsI3B9s38wNxUcQ1Vpe81A
	 ZCM+Q61miLfKp6EU5cM0Dojn0/DLc2yPNgtJqm8g7+FnfLfzstCfVEfePf+93SlZPw
	 gCwXiudIhfP9w==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.11 000/249] 6.11.7-rc2 review
Message-ID: <20241108155837.GA20613@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241107064547.006019150@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107064547.006019150@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.11.7 release.
> There are 249 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 09 Nov 2024 06:45:18 +0000.
> Anything received after that time might be too late.

Hi Greg

6.11.7-rc2 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

