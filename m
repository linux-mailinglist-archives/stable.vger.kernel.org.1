Return-Path: <stable+bounces-77750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D6D986BC7
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 06:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77313281F5D
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 04:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB783B298;
	Thu, 26 Sep 2024 04:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="lNREUnnY"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A299F2F5B
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727325691; cv=none; b=ZnscwkFXgITKuH/o/MKkdn/VUrjKGdcrzYeEVcnpwxJiHZH01ODfeYm7O6fK2a6OUf2/yA7O4KIH976y+DFdLc6I8fAh4fOYCWnOSxwO0nG9M3bFlCUNv6Fa7kP7Ytf1nBTarKtpme56eFPLPNTbM5djgQpejT0o7S5pIA4z9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727325691; c=relaxed/simple;
	bh=PgTDS+3qPfli+DcCyIem8ijxADEa48hOnY1G1ktkED8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyInjMF1NjFe0nl2RKbFPsHtAyYwb5uVpS47SCKLHg5tmuore6Wz3DqzUVXYb4jI2QOocYs9g+3Id+E7Wk/78q0vX7IHWjbNBdPWdIeC4Gew1EGzPXCys0/9eUtJHp1pePcZsi9SmWtA+rliSVpgEXCEej+lvQkPF48NwddRCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=lNREUnnY; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1727325679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXNVYHlkZxJlEzWIcuA6ORSjwvt4EmP8BZPb/PclX64=;
	b=lNREUnnYmJ5mC625aDZ6rNj3hsxbq7g7Zs0/PJTwagyHBfuIq2eGwvzlS2SqHh/VCtANdC
	quWyo7zdR4LMfJCA==
Message-ID: <8469b8e1-74b6-45fe-ab11-e36b11d5f9a7@hardfalcon.net>
Date: Thu, 26 Sep 2024 06:41:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "ASoC: SOF: mediatek: Add missing board compatible" has
 been added to the 6.10-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
References: <20240919193644.756037-1-sashalkernel!org>
 <178b4702-101e-4ca4-856a-c9fd5401670a@hardfalcon.net>
 <ZvGr21XDAVwnnAlt@sashalap>
Content-Language: en-US, de-DE
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <ZvGr21XDAVwnnAlt@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[2024-09-23 19:56] Sasha Levin:
> You're right, fixed now.
> 
> I blame jetlag...
> 
> Thanks!


Your're welcome, thanks for your great work on the kernel! :)

