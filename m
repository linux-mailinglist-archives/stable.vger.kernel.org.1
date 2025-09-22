Return-Path: <stable+bounces-180954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63E1B915F3
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592393ACCB0
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225D3139D0A;
	Mon, 22 Sep 2025 13:20:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF87283FE9;
	Mon, 22 Sep 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547237; cv=none; b=lwuzU00tW/mRXR+4d8BLtfZcY4IdfMbFrUDy+lcoIK04hIeuKgo5hbk9XHyxjbNtICJv8SYfZy3Pi07478n5ygVAhr+6pcVn2F3CM/ChAOXSdZi8qSyqBeAcDd38tXrJ1+YwyUQppG0CDEKRbq+1HYf8F1YZoU9mMnNiyNKVzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547237; c=relaxed/simple;
	bh=Di2C1Ys5tuVP7X8hQVa1CuDN026SgfTLTiOxfvoYc6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2pgv8ac86/w9q5v1JoipDTv7iuW2JBb9mMKdzlwJSrREEDbvaygG8NodRN+ualsGnPAiRSxqQGsap1ZFwdGdm2zLmQn+KmeM5Jfq0K/hhqm6cTepi3tkLNF7B1nmdzcYL/1DUlzZL3/ORVurEgxtweCdV/maijBeSVe2HJRdN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cVk243pDkz9sSm;
	Mon, 22 Sep 2025 15:08:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id paqhIbTdsh7r; Mon, 22 Sep 2025 15:08:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cVk242s07z9sSg;
	Mon, 22 Sep 2025 15:08:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4EF2B8B768;
	Mon, 22 Sep 2025 15:08:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xlgcRaQB3zpm; Mon, 22 Sep 2025 15:08:28 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FA3C8B763;
	Mon, 22 Sep 2025 15:08:27 +0200 (CEST)
Message-ID: <2fa11e77-0844-4432-8514-0d1e1b2222c9@csgroup.eu>
Date: Mon, 22 Sep 2025 15:08:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/Makefile: use $(objtree) for crtsavres.o
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel@vger.kernel.org, Peter Marko <peter.marko@siemens.com>,
 stable@vger.kernel.org
References: <20250919121417.1601020-1-alexander.sverdlin@siemens.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250919121417.1601020-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 19/09/2025 à 14:14, A. Sverdlin a écrit :
> [Vous ne recevez pas souvent de courriers de alexander.sverdlin@siemens.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> ... otherwise it could be problematic to build external modules:
> 
> make[2]: Entering directory '.../kernel-module-hello-world'
> |   CC [M]  hello-world.o
> |   MODPOST Module.symvers
> |   CC [M]  hello-world.mod.o
> |   CC [M]  .module-common.o
> |   LD [M]  hello-world.ko
> | powerpc-poky-linux-ld.bfd: cannot find arch/powerpc/lib/crtsavres.o: No such file or directory
> 
> Fixes: da3de6df33f5 ("[POWERPC] Fix -Os kernel builds with newer gcc versions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

This change is already done it seems, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20250218-buildfix-extmod-powerpc-v2-1-1e78fcf12b56@efficios.com/

> ---
>   arch/powerpc/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 9753fb87217c3..a58b1029592ce 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -58,7 +58,7 @@ ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
>   # There is a corresponding test in arch/powerpc/lib/Makefile
>   KBUILD_LDFLAGS_MODULE += --save-restore-funcs
>   else
> -KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> +KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
>   endif
> 
>   ifdef CONFIG_CPU_LITTLE_ENDIAN
> --
> 2.51.0
> 


