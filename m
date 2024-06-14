Return-Path: <stable+bounces-52187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8345D908AD7
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 13:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953E71C221D9
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3DF14B96A;
	Fri, 14 Jun 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="aw3js9TR"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D71195968
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364728; cv=none; b=VqtawiGx1o+jzxBgQxd+8ba9D6uw8JZ2RflVPG+gv4YTLbhcNQbHFXtWtbRrar9I97thDu8C002j17ilTcDiXn9I8gt212e5NuGtvclV9gGNmYF4Pgfmm8JyV8yX1CbSbEFKX5hZ3H2ThPbr3nqW+sS81RMFitoudXqIH7kK6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364728; c=relaxed/simple;
	bh=wj8PgOYgWOt9MgdbKK0EyEFmrSjRnNX3x/vNOHK5yyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KcDsZ6u8fxb3ZcuGrbnMtpX00AE2m8Q9GdcA/I+AY1PBHJLBb7C6Qr7Ts1zYgNzuAdwmL3FouBVxpTpvReRz9JGNtEhqgT0FOi1lTeQ38hQT1szwEKzexH8SmmkXMiL6WdHIuyjDf6+QKDeyzqqND7FkA34ZxHgIHN0O/ohqRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=aw3js9TR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718364725;
	bh=5tNu3JO7F59DfFGw1n42UeUGBbjV9MvLJ3EG+sLnfn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aw3js9TR6y8CLPcEq5EDqVUG+1n5/wlTcwRiLocJdnAvs4PMrUogNcuF1Az61vEsk
	 Hu2p7q5U+zbqkDZcBlpN5JaCpkzwOnU8LS+EtsKZjo7fo1kUHwa89uU1MJPCIr3IOX
	 08VlyMzLeU28nZtJGCtCStkB1lIblUkFB8FkWNMzJhA2oYp+DZ6l6ODqgC4fWAUhIJ
	 LhznFFLrop5JRH57EJVMOfF8dyxf5oh0Pkw8w4wLMiOv1gsafxZkSS5iBUzr3wdwLp
	 gKPCfRz2OVQKO0murUWm4qXUkWZXGkp9CWqch5NmastDbP8CMkv4hct/tz7SIZvNGB
	 3AiiCOc5DXSGA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W0xvS6TNvz4wcC;
	Fri, 14 Jun 2024 21:32:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Please backport 2d43cc701b96 to v6.9 and v6.6
In-Reply-To: <2024061411-hypertext-saline-afb4@gregkh>
References: <87wmmsnelx.fsf@mail.lhotse>
 <2024061411-hypertext-saline-afb4@gregkh>
Date: Fri, 14 Jun 2024 21:32:04 +1000
Message-ID: <87tthvoj4b.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg KH <gregkh@linuxfoundation.org> writes:
> On Fri, Jun 14, 2024 at 05:54:50PM +1000, Michael Ellerman wrote:
>> Hi stable team,
>> 
>> Can you please backport:
>>   2d43cc701b96 ("powerpc/uaccess: Fix build errors seen with GCC 13/14")
>> 
>> To v6.9 and v6.6.
>> 
>> It was marked for backporting, but hasn't been picked up AFAICS. I'm not
>> sure if it clashed with the asm_goto_output changes or something. But it
>> backports cleanly to the current stable branches.
>
> It's still in my "to get to queue" along with about 150+ other patches
> that were tagged for stable inclusion.  It's in good company, I'll get
> to it after this current round of -rc releases is out.

Thanks.

I also just sent three backports for that commit for v5.10, v5.15 and v6.1.

cheers

