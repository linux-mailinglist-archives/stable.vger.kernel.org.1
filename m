Return-Path: <stable+bounces-161883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E33BB04809
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 21:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705F24A0D17
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 19:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D30D22B5B8;
	Mon, 14 Jul 2025 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IOPf4sql"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39DE215789
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752522251; cv=none; b=upg+1TCKJhA5uRoBJSrAP5razi5OkluoBENLLEF8x+/LW6XRRm2Y0n8ML/WeSbi7IIBe/ab6aazW7WfbeXq/0KcATwft8HohjgE5QiGw7Jyrz00quJZC8LZuhnPSkwfGUxfrMvtov1peZPYiBvJj8gNlyMQJ3M6upcHNJZzTF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752522251; c=relaxed/simple;
	bh=TwdLIVIcy05ovhCoe0mmnthCimk8eZR9YyC7Mlw5tds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWcxomTYNN/lTtiTCp3j5fy8bMigQRulKeKNq2oTAhtaKo8b5z0t7NX0OEZH9lBLAyy3je3X4VK2TbatiOZU/mtNotLz2qX2ehu5h1O7QpUe3XORHDbFp9EOOFYTiqDbb4jPrNA07w+wqAK5hjXDRmcNdfXbT1iZ6SxRA8jJvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IOPf4sql; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B3ED040E0217;
	Mon, 14 Jul 2025 19:44:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l4Tcj7hETAs7; Mon, 14 Jul 2025 19:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752522242; bh=v2iaT/xyBOp4qp+tsz9TqaF8iMW8dRrmCOXi2e4hFYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOPf4sqleDFW3NZtM6TgCk6+N3PANVdiFnvj4/ZQ4uNz3JbmC+YZCScQA1+rQSjEF
	 IUEtPqKhzuzpe1p+XlBe3v7GgR714sHOcoQzxQdtyJ+Jkje8mRto9cQR808QWhBk7h
	 FaIoYRrxfeRcYA1+FbnAHt1evGbA0MVPQmVbUKtE6ipHb6agckmd4sNk6qxCLOGhd6
	 8NE6UFfermy0xDj0RxFE1yu97x9+B77UWgZRp9zeYt2n3psxaci63o+YG1I9fYE8uR
	 1c6Km1X65Mbh84fM2vvxFlW1cf8MWK5mClRyPbGboq7nzsHR51/dA7MG6Xw4gkk+l3
	 jptx5tB1KYno6TcfK7TWnBFM7FdNm0y75UPNU8dLy1+gC3QXxbJ5JoUSHJZ74Zrv6i
	 WrkGgKUEfmcLN7oLo6/1rDq5JYbKqD6sYuBengae+QXRsYvg9bGm8flrBzyqtcIQGa
	 hSV7qGyjDu0/1of/K+h4vBn1kdJ3ikK8nueEozo9YjX3bdW7AvBnNyv5QIxywD1uFh
	 dWM2nx8Kl7cA6qXq3pul92NjT7hOE8L31JbVqHllOJgDq/OQJsOUEwcuw4MxGCyOJ4
	 fROU4hUrJJKvWCq1/tn0JLxEwOuGoj7CKRxExVTCAQbW//m2Xp1XrXFeGUR+4L0evL
	 ulw5SVJ+ipodPzqjbGIumw3c=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37D4740E0208;
	Mon, 14 Jul 2025 19:43:58 +0000 (UTC)
Date: Mon, 14 Jul 2025 21:43:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [stable-6.1] x86: Fix X86_FEATURE_VERW_CLEAR definition
Message-ID: <20250714194351.GRaHVd98o6K3VDXiXV@fat_crate.local>
References: <20250714193339.6954-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714193339.6954-1-jinpu.wang@ionos.com>

On Mon, Jul 14, 2025 at 09:33:39PM +0200, Jack Wang wrote:
> This is a mistake during backport.
> VERW_CLEAR is on bit 5, not bit 10.
> 
> Fixes: d12145e8454f ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> 
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 1c71f947b426..6f6ea3b9a95e 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -429,8 +429,8 @@
>  #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
>  #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
>  
> +#define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* "" The memory form of VERW mitigates TSA */
>  #define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* "" Automatic IBRS */
> -#define X86_FEATURE_VERW_CLEAR		(20*32+ 10) /* "" The memory form of VERW mitigates TSA */
>  #define X86_FEATURE_SBPB		(20*32+27) /* "" Selective Branch Prediction Barrier */
>  #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
>  #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
> -- 

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Good catch for this and the 5.15 one.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

