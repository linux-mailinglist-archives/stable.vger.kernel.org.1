Return-Path: <stable+bounces-95699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 895599DB642
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 12:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5C92811E0
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C8819415D;
	Thu, 28 Nov 2024 11:08:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE415E5CA;
	Thu, 28 Nov 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.16.41.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792118; cv=none; b=HywkO6prms+2VQGV+Ks9SJYe5zJ6tH7coGM8SvOsmxKno3HvjudC+vEkbWQoMQGV7b5OIXMnOep1rGrcFYACTUrqXYradqwCyuXOcUDLbb8Da51CeQzUxMrs7zcUTtoopfra7lcqmWFk8ELq33SmKvVMGVnEbrbstnIHNVYrt5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792118; c=relaxed/simple;
	bh=/4P4RcwJM674M4v0+AQHt9b81wG/DDUn1Oxs5RzPC8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJaMJCOCCxh5COCW/TxsWeLh3vUO2G0pbJXuTFtGIpjaKhbfG4ZuIQhMcXTMsgmJKWLqEqVu5m/Olxu47DGxZWE4XXzriWHEOYck3oLlGffVLi66B7N9+oh2+YpaS02L5v+0esMW0mjmTvl/t3j3c0xNyKYLswDJTQjHZN9Zf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=195.16.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-msk-a-srv-ksmg02.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id D97A11F9DE;
	Thu, 28 Nov 2024 14:08:30 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail03.astralinux.ru [10.177.185.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu, 28 Nov 2024 14:08:29 +0300 (MSK)
Received: from [10.198.18.73] (unknown [10.198.18.73])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XzYT65Yp5z1gywG;
	Thu, 28 Nov 2024 14:08:26 +0300 (MSK)
Message-ID: <75a9916e-1826-4d27-88d3-60284862f6b5@astralinux.ru>
Date: Thu, 28 Nov 2024 14:08:24 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 0/1] arm64: esr: Define ESR_ELx_EC_* constants as UL
Content-Language: ru
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Christopher Covington <cov@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241106174757.38951-1-abelova@astralinux.ru>
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <20241106174757.38951-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 42 0.3.42 bec10d90a7a48fa5da8c590feab6ebd7732fec6b, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 189477 [Nov 28 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2024/11/28 08:54:00 #26904895
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Just a friendly reminder.

On 11/6/24 8:47 PM, Anastasia Belova wrote:
> Incorrect casting is possible in 6.1 stable release using ESR_ELx_EC_*
> constants.
>
> The problem has been fixed by the following upstream patch that was adapted
> to 6.1. The patch couldn't be applied clearly but the changes made are
> minor.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

