Return-Path: <stable+bounces-26891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0661872BEE
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 02:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67B11C224A5
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 01:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19032CA7;
	Wed,  6 Mar 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="NOLu9Nd0"
X-Original-To: stable@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3570613A
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709686909; cv=none; b=j41hPZqtra8EvyArJvYn/1sqIJQhs0+596u38az1qoNarlsUxUWspW3Bv7n9Rf2C8Mfn9UWSZmuqSy6Ued2efdpYJemF+Yb1lszfT1sMDBzCJTp2DrLpzkzx0T+nHiGLR94D2kh+IhxPAjp7k+hJVGuyZzGdggCAXkTUeWZL0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709686909; c=relaxed/simple;
	bh=5/ZcX9ajZLf4owQGJwX2dlOzBzGOssvyw5Rcw44gWks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOLIsBN5ZJPIWMR0uHX9j5pdobsuN8/S2NNIo3ymsNOcOZvWdhl04yTMQEHPJRsdjWC37ewVbpJcCQMNbZn/nkDy2lZVNNj8oRzya8OP6rc1EiDforNfCOmrKjNfaKJl0+nXJqflIJeW3R2RpfgYPuJmEGW389PQTEamwCOf5K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=NOLu9Nd0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709686905;
	bh=YmcB4bK+MAKOOiOWr/fno4pQrOdfHy3DeEfNvA3NQaI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NOLu9Nd0MJ7pHaMczG24P2AAIjuQhVM3wPtp80cRNUCsBxFuSbZi0rDg8RCJBLKNb
	 XFRzYoSHM3yALoOIr/THxV8/0FuBguR6Vw/I+aqE+cAOBTQWsqEzKwwuhpJ9+IHrpA
	 ju3TWGuhoA0jqbHyAZdTmfzhuopD/JXB+zzZuTG+/vdc/dSRd7hcLWxt+6N9pX2xC0
	 uW4QiRWZncUEoTDNcuOcaOsRjuVp965laKOqAwu2ynMQcFQ8KESP9blQkn9wOOijpi
	 Zrs1DUqcfyz813+tLqBkYHLuGgEysiDhfYakRkusLJe+/O8f4nzAthwOcf1XGuU3qz
	 VUhL8TZ4n22GA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqDfH2BRXz4wc8;
	Wed,  6 Mar 2024 12:01:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Chancellor <nathan@kernel.org>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com, morbo@google.com, justinstitt@google.com,
 linuxppc-dev@lists.ozlabs.org, patches@lists.linux.dev,
 llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc: xor_vmx: Add '-mhard-float' to CFLAGS
In-Reply-To: <20240305224315.GA2361659@dev-arch.thelio-3990X>
References: <20240127-ppc-xor_vmx-drop-msoft-float-v1-1-f24140e81376@kernel.org>
 <20240305224315.GA2361659@dev-arch.thelio-3990X>
Date: Wed, 06 Mar 2024 12:01:42 +1100
Message-ID: <874jdkp409.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nathan Chancellor <nathan@kernel.org> writes:
> Ping? We have been applying this in our CI since it was sent, it would
> be nice to have this upstream soon so it can start filtering through the
> stable trees.

Sorry, I was away in January and missed this. Will pick it up.

cheers

> On Sat, Jan 27, 2024 at 11:07:43AM -0700, Nathan Chancellor wrote:
>> arch/powerpc/lib/xor_vmx.o is built with '-msoft-float' (from the main
>> powerpc Makefile) and '-maltivec' (from its CFLAGS), which causes an
>> error when building with clang after a recent change in main:
>> 
>>   error: option '-msoft-float' cannot be specified with '-maltivec'
>>   make[6]: *** [scripts/Makefile.build:243: arch/powerpc/lib/xor_vmx.o] Error 1
>> 
>> Explicitly add '-mhard-float' before '-maltivec' in xor_vmx.o's CFLAGS
>> to override the previous inclusion of '-msoft-float' (as the last option
>> wins), which matches how other areas of the kernel use '-maltivec', such
>> as AMDGPU.
>> 
>> Cc: stable@vger.kernel.org
>> Closes: https://github.com/ClangBuiltLinux/linux/issues/1986
>> Link: https://github.com/llvm/llvm-project/commit/4792f912b232141ecba4cbae538873be3c28556c
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> ---
>>  arch/powerpc/lib/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
>> index 6eac63e79a89..0ab65eeb93ee 100644
>> --- a/arch/powerpc/lib/Makefile
>> +++ b/arch/powerpc/lib/Makefile
>> @@ -76,7 +76,7 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
>>  obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
>>  
>>  obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
>> -CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
>> +CFLAGS_xor_vmx.o += -mhard-float -maltivec $(call cc-option,-mabi=altivec)
>>  # Enable <altivec.h>
>>  CFLAGS_xor_vmx.o += -isystem $(shell $(CC) -print-file-name=include)
>>  
>> 
>> ---
>> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
>> change-id: 20240127-ppc-xor_vmx-drop-msoft-float-ad68b437f86c
>> 
>> Best regards,
>> -- 
>> Nathan Chancellor <nathan@kernel.org>
>> 

