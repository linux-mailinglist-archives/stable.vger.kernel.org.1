Return-Path: <stable+bounces-152397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 946ABAD4A8D
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871AD179D1C
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7CF226556;
	Wed, 11 Jun 2025 05:50:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1977218AC7;
	Wed, 11 Jun 2025 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749621037; cv=none; b=UAS64srYa/hb3pgdbtq1UptZEQbidR9xROkgVrLRIDQIBRUot2giavdWhz+pwGNpllU1zJwXo9Xd8zdAN3qU9W2eiz1HRngGZR2D9XFCnHCKxKG0OT2vgUdlKwb1KJmvYtYRN7KHaoA2jom8eeRL9CFhyScH+eaO1NHkCgOXbFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749621037; c=relaxed/simple;
	bh=ndq1OniZPBYfUSjmaheprfQngbdgr+TRmbTdQkuM4bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwsJxLlOrHLSjUktRwy8vH1o+YACFNHGYIw6suvfpLIdDYtQoKai+Q9pB6MQNwLAONFpD/mE+4l7xa84fd1AC7EBLBqvr/BOKXJzAP2nJ02POQjDX3My4RwEjeDabHuBSt7BP07tYg5gumjDOKh6O8xMZWXBZK5mxwcOseEUqzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bHDxv2zs6z9sZD;
	Wed, 11 Jun 2025 07:39:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lqSJzO4FXAI2; Wed, 11 Jun 2025 07:39:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bHDxv2DRwz9sZ2;
	Wed, 11 Jun 2025 07:39:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 480B28B76D;
	Wed, 11 Jun 2025 07:39:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4RoeSFg0AWwk; Wed, 11 Jun 2025 07:39:47 +0200 (CEST)
Received: from [10.25.207.146] (unknown [10.25.207.146])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 164798B769;
	Wed, 11 Jun 2025 07:39:47 +0200 (CEST)
Message-ID: <784650aa-80e5-4f1a-8a7f-6e61c3225e77@csgroup.eu>
Date: Wed, 11 Jun 2025 07:39:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "powerpc: do not build ppc_save_regs.o always" has been
 added to the 6.15-stable tree
To: Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org,
 stable-commits@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
References: <20250610115602.1537089-1-sashal@kernel.org>
 <1b88323e-8d79-4a79-9e6a-ea817a9e056b@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <1b88323e-8d79-4a79-9e6a-ea817a9e056b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/06/2025 à 06:15, Jiri Slaby a écrit :
> On 10. 06. 25, 13:56, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>      powerpc: do not build ppc_save_regs.o always
>>
>> to the 6.15-stable tree which can be found at:
>>      https://eur01.safelinks.protection.outlook.com/? 
>> url=http%3A%2F%2Fwww.kernel.org%2Fgit%2F%3Fp%3Dlinux%2Fkernel%2Fgit%2Fstable%2Fstable-queue.git%3Ba%3Dsummary&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cf9c2453dd6154212e43a08dda89ea845%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638852121563909145%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=ckwC5j7O2j%2FATCggT3jwcKl3K5HRVpwA7DxjZUGnwZg%3D&reserved=0
> 
> Please drop this from all trees. It was correctly broken. The whole if 
> was removed later by 93bd4a80efeb521314485a06d8c21157240497bb.

Isn't it better to keep it and add 93bd4a80efeb ("powerpc/kernel: Fix 
ppc_save_regs inclusion in build") instead of droping it and keep a bad 
test that works by chance ?

Christophe

> 
>> The filename of the patch is:
>>       powerpc-do-not-build-ppc_save_regs.o-always.patch
>> and it can be found in the queue-6.15 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit 242c2ba3f16d92cd81c309725550f6c723833ae3
>> Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>> Date:   Thu Apr 17 12:53:05 2025 +0200
>>
>>      powerpc: do not build ppc_save_regs.o always
>>      [ Upstream commit 497b7794aef03d525a5be05ae78dd7137c6861a5 ]
>>      The Fixes commit below tried to add CONFIG_PPC_BOOK3S to one of the
>>      conditions to enable the build of ppc_save_regs.o. But it failed 
>> to do
>>      so, in fact. The commit omitted to add a dollar sign.
>>      Therefore, ppc_save_regs.o is built always these days (as
>>      "(CONFIG_PPC_BOOK3S)" is never an empty string).
>>      Fix this by adding the missing dollar sign.
>>      Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>      Fixes: fc2a5a6161a2 ("powerpc/64s: ppc_save_regs is now needed 
>> for all 64s builds")
>>      Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
>>      Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>>      Link: https://eur01.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fpatch.msgid.link%2F20250417105305.397128-1- 
>> jirislaby%40kernel.org&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cf9c2453dd6154212e43a08dda89ea845%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638852121563928665%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=z4VKRS6xdEjQb0KWlyAaZD7Oykeqdou4ji8bb56yShY%3D&reserved=0
>>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
>> index 6ac621155ec3c..0c26b2412d173 100644
>> --- a/arch/powerpc/kernel/Makefile
>> +++ b/arch/powerpc/kernel/Makefile
>> @@ -160,7 +160,7 @@ endif
>>   obj64-$(CONFIG_PPC_TRANSACTIONAL_MEM)    += tm.o
>> -ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC_CORE)(CONFIG_PPC_BOOK3S),)
>> +ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC_CORE)$(CONFIG_PPC_BOOK3S),)
>>   obj-y                += ppc_save_regs.o
>>   endif
> 
> 


