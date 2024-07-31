Return-Path: <stable+bounces-64777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9AF9431F3
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 16:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD36B287291
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6521AE868;
	Wed, 31 Jul 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="QvUL4ABB"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB8A1B580C
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435783; cv=none; b=kt+DbZzksY0IBv4q+S4+fxLdfxEY/dsCVs/7l+F2ajMbCtvGY40hFd5k3DrlntFO027krwUXUPIHAgrSV6dgEJuNgRHh1/k8PuxXjYlseKjZ6Awk13UAahJLNgAfTeMTW97TZ2CsqJtlG1zLS3f/PtZ/dvtbgs1ySr2YOY8w8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435783; c=relaxed/simple;
	bh=fOaj5y/F4hF2tW8PoKwST6yBYB27qSYGz2/n6O27sxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JhQaT5KMLedRM8DZTyeg1SWaVdnND5kzCnLQhmWjfUTWU1UK7UEGG1Sp90rRXWezzsquPfBNY7/xvKHPvHLKQsOiy1FZGIlt0ceG3C3br+G0htHayRjKejWDdSN3tyw4WRLakE2jTAP8KBViGr+PcG6UG7A4RNWKAa4Bi2lbF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=QvUL4ABB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1722435771;
	bh=/GGL+wXv2axHl1vUEele1Kgydzhn2gXewxtldoRpqKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QvUL4ABB2rLUBOW0YWwbdvmctTxvZI84t9QmKoVgTU2/oRtLoV/nUWlolkje6MTcv
	 eW60ycX/5ZhnPHxKBN5ecOY0SdkNT9+rlV+Z9uVxCy8yuU8JtNrwUSEkLjnzNYjMVP
	 7aXzp0M4SNZkLZgjr24zKAc6fFJkRIaV9cfhAFWH78O3Pa8lsSO/B1cGVNzWJrtKYC
	 hbaqemtYcmKkKLXoG+U5RfwOcXrhkaEk9fCiNGmFs+NAgWxPaSkEXZzeaft8jQBJo5
	 82CwvuXhsuvuGyN6cnMxQZCnKXwm9dPul8VnJnszZX8zFXpzjuEC9JFx39e2slXxqQ
	 5l34wYBEH16Sw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WYvSq07wKz4wcl;
	Thu,  1 Aug 2024 00:22:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 patches@lists.linux.dev, Russell Currey <ruscur@russell.cc>, Andrew
 Donnellan <ajd@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 189/440] powerpc/pseries: Move plpks.h to include
 directory
In-Reply-To: <20240730151623.255648651@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
 <20240730151623.255648651@linuxfoundation.org>
Date: Thu, 01 Aug 2024 00:22:49 +1000
Message-ID: <874j85prnq.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 6.1-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Russell Currey <ruscur@russell.cc>
>
> [ Upstream commit 90b74e305d6b5a444b1283dd7ad1caf6acaa0340 ]
>
> Move plpks.h from platforms/pseries/ to include/asm/. This is necessary
> for later patches to make use of the PLPKS from code in other subsystems.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://lore.kernel.org/r/20230210080401.345462-15-ajd@linux.ibm.com
> Stable-dep-of: 932bed412170 ("powerpc/kexec_file: fix cpus node update to FDT")
 
I don't see why this is a stable-dep of that commit?

0857beff9c1e and 932bed412170 apply with some fuzz, but otherwise seem
fine, and build OK for me here (only tested a few configs).

I'm not sure about backporting these plpks commits without some further
testing.

cheers

> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  .../powerpc/{platforms/pseries => include/asm}/plpks.h | 10 +++++++---
>  arch/powerpc/platforms/pseries/plpks.c                 |  3 +--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>  rename arch/powerpc/{platforms/pseries => include/asm}/plpks.h (94%)
>
> diff --git a/arch/powerpc/platforms/pseries/plpks.h b/arch/powerpc/include/asm/plpks.h
> similarity index 94%
> rename from arch/powerpc/platforms/pseries/plpks.h
> rename to arch/powerpc/include/asm/plpks.h
> index 07278a990c2df..44c3d93fb5e7d 100644
> --- a/arch/powerpc/platforms/pseries/plpks.h
> +++ b/arch/powerpc/include/asm/plpks.h
> @@ -6,8 +6,10 @@
>   * Platform keystore for pseries LPAR(PLPKS).
>   */
>  
> -#ifndef _PSERIES_PLPKS_H
> -#define _PSERIES_PLPKS_H
> +#ifndef _ASM_POWERPC_PLPKS_H
> +#define _ASM_POWERPC_PLPKS_H
> +
> +#ifdef CONFIG_PSERIES_PLPKS
>  
>  #include <linux/types.h>
>  #include <linux/list.h>
> @@ -93,4 +95,6 @@ int plpks_read_fw_var(struct plpks_var *var);
>   */
>  int plpks_read_bootloader_var(struct plpks_var *var);
>  
> -#endif
> +#endif // CONFIG_PSERIES_PLPKS
> +
> +#endif // _ASM_POWERPC_PLPKS_H
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
> index d54188a355c9c..1c43c4febd3da 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -18,8 +18,7 @@
>  #include <linux/types.h>
>  #include <asm/hvcall.h>
>  #include <asm/machdep.h>
> -
> -#include "plpks.h"
> +#include <asm/plpks.h>
>  
>  static u8 *ospassword;
>  static u16 ospasswordlength;
> -- 
> 2.43.0

