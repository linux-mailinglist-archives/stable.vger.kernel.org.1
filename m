Return-Path: <stable+bounces-79775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B900398DA21
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722DB1F27C6F
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665911D043E;
	Wed,  2 Oct 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OpuJGCpg"
X-Original-To: stable@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C61D04B4
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878430; cv=none; b=XqESenOoqGKjiNih95llOlcb3Ce1Rw4wJMDdb614JW4PcjGmSVhau7iWn+bOHn92A98fg7Dfjp+70dDQ/D2wLlAJ16HbdOOMvoNN8Z3NOspHjwPKdNdCHw1Ieh4fXvzw27+VMdX+KgMkP8J+i6RU8DHTlI9J5BC15a+XCqs+zR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878430; c=relaxed/simple;
	bh=1eYswYBLwcmow2Wl7uxaLSwrya9NyE/eofF1H1fHLpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aV3m0EheTxvoKxsX2wJfBd13uqytR5Y0ANnRHbJhR2PrHDyxNGZ6n6vbqUoTcoCRHHI/J/zW319iHZpXwfUElVf36uJmn1y51utOvl55/EcywXs7saLBqKu+PuH5ZyBQlUJp0gyAnukOIjsp5UfBa8MJ+Nx6hbTL+9bGGQSRPOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OpuJGCpg; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9F0D388F7B;
	Wed,  2 Oct 2024 16:13:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727878427;
	bh=3/3lsBduf8XJjpdE+482gIVDoroD3XX+x+zxEEdrG3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OpuJGCpg+wVmnr6uHEzGuS2BoSzowJueiJAHEwRYeGXyI0rvB5wvDlVIi/wBsXJ+Q
	 VWqyxiHNmqw7GmzeZYKS2Hl9zyn3xx1mHs4HejJhOwPaCZV+GNsTQUYeXOW/82ApYq
	 pmHw1fAdaQgIlSCN5bBWe8AkytJMKODf2L1iE2CcA+W4erETlRRuZn8oAqbiesUTZs
	 zWvo0eSY5LgdfVtPOUmT0J+bEdUu72jggfRINgkrcjjTS4HiDCTJBOioZdPrPjlHL3
	 9NurdmK9B+OYqblI3cRAqE8Y5ZqlaqIgamsgA2NXeS1riEAwfRFE+d11Zy2TWeu+Xd
	 b1cw7NGFetrUA==
Message-ID: <931314b5-b232-4cc7-b258-ce1e5f6e0b1a@denx.de>
Date: Wed, 2 Oct 2024 16:13:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 339/634] leds: leds-pca995x: Add support for NXP
 PCA9956B
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Pieterjan Camerlynck <pieterjanca@gmail.com>,
 Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20241002125811.070689334@linuxfoundation.org>
 <20241002125824.484582935@linuxfoundation.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241002125824.484582935@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/2/24 2:57 PM, Greg Kroah-Hartman wrote:
> 6.10-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Pieterjan Camerlynck <pieterjanca@gmail.com>
> 
> [ Upstream commit 68d6520d2e76998cdea58f6dd8782de5ab5b28af ]
> 
> Add support for PCA9956B chip, which belongs to the same family.
> 
> This chip features 24 instead of 16 outputs, so add a chipdef struct to
> deal with the different register layouts.
This seems like a feature patch, not a fix and not a stable material, 
right ?

