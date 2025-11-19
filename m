Return-Path: <stable+bounces-195188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42163C6FD71
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 16:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 510D62F410
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBF83A1D09;
	Wed, 19 Nov 2025 15:50:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F393570DE;
	Wed, 19 Nov 2025 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567437; cv=none; b=D7Q7Qfb5Q6TcoT7eRN27iYEunxXoFZrZqM1evIBHGdiGFKclLIE5+W5HQEAC+4YS8otL3fn1ncksd7YdBZskOIShhz0bfk59ATeHbwW/lQP1Kl/LzCOsQRA4TrrOqzQzqx23zqhX0WK+zEpzfcHWR7h3O+J0udTsZUph6w+QZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567437; c=relaxed/simple;
	bh=A2T9h19zDOA0NtxG4phPcuK/llzYhFV82mZ3UhuqEZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSnoT9KiX4UH8WJYa0igtj1YfgPbBCyOgTi0R24qwGvaV3gsCNkag7+zzQrH13k6kXs6rFtvucm1oGPG5UnyU4iwxVDO5Rs/5icoqGpdztL5OQ7Ym4pfEgbeSYiGS2EhvsIiIsPUeqGizmi+atfsLrku2ZBQnBItPVECTYWeOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4dBQbr4LWxz9sTm;
	Wed, 19 Nov 2025 16:38:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jOnRrJ5A7_EN; Wed, 19 Nov 2025 16:38:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4dBQbr3btHz9sSn;
	Wed, 19 Nov 2025 16:38:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 690918B76D;
	Wed, 19 Nov 2025 16:38:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id u265QodWAVzI; Wed, 19 Nov 2025 16:38:00 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E5AC98B763;
	Wed, 19 Nov 2025 16:37:59 +0100 (CET)
Message-ID: <657c8574-8844-48ef-93e1-e0df8e9cf91a@csgroup.eu>
Date: Wed, 19 Nov 2025 16:37:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/warp: Fix error handling in pika_dtm_thread
To: Ma Ke <make24@iscas.ac.cn>, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, benh@kernel.crashing.org, smaclennan@pikatech.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org
References: <20251116024411.21968-1-make24@iscas.ac.cn>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20251116024411.21968-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/11/2025 à 03:44, Ma Ke a écrit :
> ***ATTENTION, Sopra Steria Group cannot confirm the identity of this email sender (SPF record failure). This might be a fake email from an attacker, if you have any doubts report and delete the email.***
> 
> ***ATTENTION, Sopra Steria Group ne peut pas confirmer l’identité de l’émetteur de ce message (SPF record failure). Il pourrait s’agir d’un faux message, à détruire si vous avez un doute ***
> 
> pika_dtm_thread() acquires client through of_find_i2c_device_by_node()
> but fails to release it in error handling path. This could result in a
> reference count leak, preventing proper cleanup and potentially
> leading to resource exhaustion. Add put_device() to release the
> reference in the error handling path.

It is not really an error path, it is the termination of the kthread.

> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3984114f0562 ("powerpc/warp: Platform fix for i2c change")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/platforms/44x/warp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
> index a5001d32f978..6f674f86dc85 100644
> --- a/arch/powerpc/platforms/44x/warp.c
> +++ b/arch/powerpc/platforms/44x/warp.c
> @@ -293,6 +293,8 @@ static int pika_dtm_thread(void __iomem *fpga)
>                  schedule_timeout(HZ);
>          }
> 
> +       put_device(&client->dev);
> +
>          return 0;
>   }
> 
> --
> 2.17.1
> 


