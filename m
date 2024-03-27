Return-Path: <stable+bounces-32435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3505E88D3DF
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 02:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80C31F32341
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 01:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DBE1CD2B;
	Wed, 27 Mar 2024 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Z6QjVvqe"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB1018C36;
	Wed, 27 Mar 2024 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711504132; cv=none; b=XMAYQwD4aWGtU5wZYuMQNJVPBp4IYCd+OMAKJCI3+TD5KdRH13u2l0+bteiz4HMlU+BVQq2EKbHIXhBKC4xV0LhqzdhvjG/IEyNOBHv8PBMyf5NaQ+5KR+B3u5i39P+B1FmXfQUaHoBb6KNutcwITBi6JVTKJMaxyGrNDh62pGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711504132; c=relaxed/simple;
	bh=fFrfUID3FoPj4ulESm6eQcGR52Xjf+9xu4DzdRa+9Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYYYLXcYuhHhLq0cFoY0Y50p8ARPIQvyYxOGXYqQos08GdpQ9r2TMyG2YDZ6+cc8Ky1o/ojvLL0e8ABRi+xNVTbORam9Oeezw5C+hUPh5bRzl6XxlVM93aYwM1y5+WiYmKPHyWwRMBaaVVmj1Hq2J2oxUiyrKBTb3uSx17dowlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Z6QjVvqe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 2CCAC2084326; Tue, 26 Mar 2024 18:48:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2CCAC2084326
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711504130;
	bh=c6MF7OVgjLPc5eNhSluKdKHRKc3xjm8jQ4HvPzRkH0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6QjVvqeEOn+s3jLUSGNB4Pb5hj1Ec95MZ50rQ8prR5SQTSmQEYuUjxJhaip8LriI
	 Xd5FQ2mINa3CxzfFG8gKqoGJxLiBCM2gMhGSLS3fWD/oMdIWP2MbM8hDsfXR51UpjP
	 sAO6yHb9qo8I7ywX14zu4lVzhmhL5AFF7+R81BTE=
Date: Tue, 26 Mar 2024 18:48:50 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.6 000/632] 6.6.23-rc2 review
Message-ID: <20240327014850.GA7502@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240325115951.1766937-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325115951.1766937-1-sashal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 25, 2024 at 07:59:51AM -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.6.23 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:50 AM UTC 2024.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

