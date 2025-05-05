Return-Path: <stable+bounces-139694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA823AA94D2
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44274177E59
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17572505AF;
	Mon,  5 May 2025 13:50:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AB02C859;
	Mon,  5 May 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453036; cv=none; b=YVSTatQPn9CbuvLhtFKfAhKuswM5utaTCceFlPXPJ/JNqdKpQNSS8aBUvIFyPe+JbGfTEWzMF3m5l+FJangUtPY1PL2MRjx7rSYZiK+1XRfRrNbxxh6qCKeDHXxTBLjIW8i0AJH2UkakEHW2qPwl/jFrBwIIfJ5MxvgHKSxW51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453036; c=relaxed/simple;
	bh=XLgnTOfAEcs+Sa0AV1fC/vsFbvAUlOTDV7O6VFjhOO4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=slBfapPAEZuTJxSh8igOtonCzUHVF+xaE9jrGGt7aJY9/teDTqqW9is9ug8FYRlyMtodWXZm9eDJHtMIRCzkG+qe+2K7awrWvFMqqApWxXnTzv1CLSxXd+Dcc/XhDzTSAZ3V1Um17cSUg4LzBU5yG16yubr20pIqyUDn+LaX1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Zrj4Q3Fs4z9s92;
	Mon,  5 May 2025 15:27:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5kpxdDcfFAh5; Mon,  5 May 2025 15:27:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Zrj4Q2XkLz9s36;
	Mon,  5 May 2025 15:27:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5267C8B76D;
	Mon,  5 May 2025 15:27:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id fDy8D7qNz4oI; Mon,  5 May 2025 15:27:18 +0200 (CEST)
Received: from [10.25.207.144] (unknown [10.25.207.144])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 332A48B768;
	Mon,  5 May 2025 15:27:18 +0200 (CEST)
Message-ID: <8e6c91c0-6780-414e-9cf6-1cc2a058be0b@csgroup.eu>
Date: Mon, 5 May 2025 15:27:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: Please apply to v6.14.x commit 6eab70345799 ("ASoC: soc-core:
 Stop using of_property_read_bool() for non-boolean properties")
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>
References: <7fb43b27-8e61-4f87-b28b-8c8c24eb7f75@cs-soprasteria.com>
 <2025050556-blurred-graves-b443@gregkh>
Content-Language: fr-FR
In-Reply-To: <2025050556-blurred-graves-b443@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/05/2025 à 15:10, Greg Kroah-Hartman a écrit :
> On Mon, May 05, 2025 at 11:48:45AM +0000, LEROY Christophe wrote:
>> Hi,
>>
>> Could you please apply commit 6eab70345799 ("ASoC: soc-core: Stop using
>> of_property_read_bool() for non-boolean properties") to v6.14.x in order
>> to silence warnings introduced in v6.14 by commit c141ecc3cecd ("of:
>> Warn when of_property_read_bool() is used on non-boolean properties")
> 
> What about 6.12.y and 6.6.y as well?  It's in the following released
> kernels:
> 	6.6.84 6.12.20 6.13.8 6.14
> 

Ah ! it has been applied to stable versions allthough it doesn't carry a 
Fixes: tag.

So yes the 'fix' to ASoC should then be applied as well to stable 
versions to avoid the warning.

Note that it doesn't cherry-pick cleanly to 6.6.84, you'll first need 
commit 69dd15a8ef0a ("ASoC: Use of_property_read_bool()")

Christophe

