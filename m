Return-Path: <stable+bounces-23888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87726868DA0
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CE32873EC
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC3D136666;
	Tue, 27 Feb 2024 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ATNcotiI"
X-Original-To: stable@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570153376;
	Tue, 27 Feb 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029877; cv=none; b=GJarLS7it+/UQKNnzlIgABI7DK3f6yRt8851CXNZKy1VjRxIIToTzo/BEN3XAjLhFKKct75biYtQShRfq8s9D8E+uURAKzdDc7BadNY7K9EFxgX9y5/qjgfd89Nj3HPZRMWwWTv8Gk35SUjuXn5REZ3pU+x4fqcHh7bIUR/jDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029877; c=relaxed/simple;
	bh=UZPA+oW2ED27diOEsEHoW3DjwrWTidPv6l7VZbUw6+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TctXAVZPZFuxy8wS090iAewYOSDLgKCjuCee5tb1on6KLzIujIy3usI6+yND0H+SZi334RtVVabVIMKm3OxK6TBY1aQwLV2DFQWrNj4YGozauzY9tfFHvJLEinZIyfSH6ZA98L4+xhAcqiykOt7Kx3Bor6azndW8mYxapRewam0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ATNcotiI; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 015872087B;
	Tue, 27 Feb 2024 11:31:06 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lgn6WFSWJChe; Tue, 27 Feb 2024 11:31:05 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6CC9B207E4;
	Tue, 27 Feb 2024 11:31:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6CC9B207E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709029861;
	bh=36X9HieMWPjDOQ3pURbAUKsOVyclcZ1ePVR/QDpPb64=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ATNcotiIoTEVWQzHRSgqNfIlxyXxbx/Nh/Zeqv9ROdcZ2fR5fKHS0cQHitc7dzP1O
	 /sXU6NP/SlMqGWteyY7NvxveZK09TUKUCCp2lpu1KlrBw70tqj/hjXeo9Tr6ddmUFq
	 T2tbj/prS5r2qujOj1s/Y39G0rQX4dEJTxhW8iwps6ICybjWVB7Te6F5Z9v+WUzsPj
	 TXby2SX0AIk4xuetrcUtD9mte+rXWPUrDjP0wEHlAPMorghetrjnDXD0Z/GBEajYfV
	 CqfvtUO8RGlGMALHvGCQJBGduT44RyFDYCGBs5LV3ggR/OZTCSyS3XJNHdsnWnoiyD
	 LPyYaiESYkeUw==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 5DD6A80004E;
	Tue, 27 Feb 2024 11:31:01 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 11:31:01 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 11:31:00 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 5DDDB3182503; Tue, 27 Feb 2024 11:31:00 +0100 (CET)
Date: Tue, 27 Feb 2024 11:31:00 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<morbo@google.com>, <justinstitt@google.com>, <keescook@chromium.org>,
	<netdev@vger.kernel.org>, <llvm@lists.linux.dev>, <patches@lists.linux.dev>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: Avoid clang fortify warning in
 copy_to_user_tmpl()
Message-ID: <Zd255JYau84UHfpo@gauss3.secunet.de>
References: <20240221-xfrm-avoid-clang-fortify-warning-copy_to_user_tmpl-v1-1-254a788ab8ba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240221-xfrm-avoid-clang-fortify-warning-copy_to_user_tmpl-v1-1-254a788ab8ba@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Feb 21, 2024 at 02:46:21PM -0700, Nathan Chancellor wrote:
> After a couple recent changes in LLVM, there is a warning (or error with
> CONFIG_WERROR=y or W=e) from the compile time fortify source routines,
> specifically the memset() in copy_to_user_tmpl().
> 
>   In file included from net/xfrm/xfrm_user.c:14:
>   ...
>   include/linux/fortify-string.h:438:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>     438 |                         __write_overflow_field(p_size_field, size);
>         |                         ^
>   1 error generated.
> 
> While ->xfrm_nr has been validated against XFRM_MAX_DEPTH when its value
> is first assigned in copy_templates() by calling validate_tmpl() first
> (so there should not be any issue in practice), LLVM/clang cannot really
> deduce that across the boundaries of these functions. Without that
> knowledge, it cannot assume that the loop stops before i is greater than
> XFRM_MAX_DEPTH, which would indeed result a stack buffer overflow in the
> memset().
> 
> To make the bounds of ->xfrm_nr clear to the compiler and add additional
> defense in case copy_to_user_tmpl() is ever used in a path where
> ->xfrm_nr has not been properly validated against XFRM_MAX_DEPTH first,
> add an explicit bound check and early return, which clears up the
> warning.
> 
> Cc: stable@vger.kernel.org
> Link: https://github.com/ClangBuiltLinux/linux/issues/1985
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied to the ipsec tree, thanks a lot!

