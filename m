Return-Path: <stable+bounces-111713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E6BA23161
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 17:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA63F3A2C1A
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A691991CD;
	Thu, 30 Jan 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="amR0X3t5"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E901DA5F
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252896; cv=none; b=IiPi1fmHyh4NTcowND+xspFH14WMufnOw/HIZ+RgJ61AQ85jELrT0UMY3yxXAxW/fXRs0ebURaU5T6fx9/EnCO/G/OuFOqexqls+Nu94dYAD+s2zcIvKJ9AkchMAd3oWU+MGvbxCeybvOMvUglfXD5NJQ+v4jjlln+EoVumiu5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252896; c=relaxed/simple;
	bh=eq21U/Dg94xJnWiq7YcITSQpXnWF/FY8R73ukjIytk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkA8a6SMuGpIvWlXJe8bTsP2vhbDrE7hcO71tJLFjhz5AHErpp1i6WiBDBJ75D9iyRQPE2R1nVDoqWhwAf0s0D1DQDLmAOGAdHsphzg80tGQq4k+Bjw5q2Fi4EBEoqt0uDtXRMjhQuBDrPGom04MiNmqCe5Z058dfSMC484HQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=amR0X3t5; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eaf0535a-3ebf-457f-bc07-2e182a0a6625@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738252887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+gIOroV8ttoAGu1IVEuZ9I1EJiIOrgR6ZHSJiwijEs=;
	b=amR0X3t5qByj5bf6SOmKN7NZUCJ9TWfCH078Kp5LjFs8KXX3OnJB/lmtHP/h994qviTPyp
	1Cy0K7jugT3pqYJVWhH4nhjA5eDmG4MyZKfziSK4Or6VjXbU6FXfud98jIhSrWDbsvZaJw
	7YvRPqmxLdVTXvTt9HtVM/2T+IDaY1Q=
Date: Thu, 30 Jan 2025 11:01:23 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.1.y v2] gpio: xilinx: Convert gpio_lock to raw spinlock
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, bartosz.golaszewski@linaro.org
References: <20250121184148.3378693-1-sean.anderson@linux.dev>
 <20250121193205.3386351-1-sean.anderson@linux.dev>
 <2025012905-oasis-babied-261b@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <2025012905-oasis-babied-261b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Greg,

On 1/29/25 04:14, Greg KH wrote:
> On Tue, Jan 21, 2025 at 02:32:06PM -0500, Sean Anderson wrote:
>> [ Upstream commit 9860370c2172704b6b4f0075a0c2a29fd84af96a ]
> 
> For obvious reasons we can't take patches just for older trees because
> if you update to a newer stable/lts version, you will have a regression.
> Please submit backports for all relevant versions and then we will be
> glad to queue them up.

The upstream commit is in 6.13 [1]. Additionally, you have posted patches
for 6.12 [2] and 6.6 [2]. This just fixes the patch for 6.1 [4].

--Sean

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9860370c2172704b6b4f0075a0c2a29fd84af96a
[2] https://lore.kernel.org/stable/20250121174536.648642765@linuxfoundation.org/
[3] https://lore.kernel.org/stable/20250121174525.472060737@linuxfoundation.org/
[4] https://lore.kernel.org/stable/2025012027-shaft-catalyst-2d69@gregkh/

