Return-Path: <stable+bounces-178039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F330B47B35
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 14:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A443C49D0
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8334F2690C0;
	Sun,  7 Sep 2025 12:11:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3D1F790F;
	Sun,  7 Sep 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757247108; cv=none; b=UKcTTQsmraHRmljd+hTriXesqacJz7st5gDEWPfIzBfFogh3rWzwtQBu8cvw1kqbXPMwlyi8iv7tkNTXVJeZyN56w0CGt5ucRPlJkYvsXLN9fPANukiv7ikruda4DteR7akYD/KFA2GcsR/BrGHv260Zgy76WbGNgMHGs3znudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757247108; c=relaxed/simple;
	bh=cgAxQBAtlyy5G8nvniEuTZ4LNLKZCNhktySPWsin7J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkMWF85P4AVa7O5C6W7HUk37YSe9TzU7knI0rBDOXwNjg0V5ZWC6pua7QNCaIH8M6NZYIXFGRXjRnYrfHYBqS1+WgV+0PhWt1zm0rAyUbGmSR5nPHqkVp5cDdcgur5YKuNrWNr2H2ZOKWEo6FlbVrC77eL6UXeJtyURUgTHPf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EC6C4CEF0;
	Sun,  7 Sep 2025 12:11:47 +0000 (UTC)
Message-ID: <27d10a83-903b-4ffc-976b-10973f72a617@kernel.og>
Date: Sun, 7 Sep 2025 07:11:47 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY
 address
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, dinguyen@kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241121071325.2148854-1-iwamatsu@nigauri.org>
 <CABMQnVJVTmnsx3RNYK01ikZ-jnn_y4pbrNAeZaKPzz0N_YFz5g@mail.gmail.com>
 <CABMQnVJsK3wNRQfGjomggKcwL5zaqBchoAKajbVb+ZXmrwn2iQ@mail.gmail.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.og>
In-Reply-To: <CABMQnVJsK3wNRQfGjomggKcwL5zaqBchoAKajbVb+ZXmrwn2iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/25 10:12, Nobuhiro Iwamatsu wrote:
> ping?
> 
> 2025年1月14日(火) 22:50 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>:
>>
>> Hi Dinh,
>>
>> Could you check and apply this patch?
>>
>> Thanks,
>>    Nobuhiro
>>

Sorry I missed this. I've applied it.

Dinh


