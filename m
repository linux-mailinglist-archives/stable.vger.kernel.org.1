Return-Path: <stable+bounces-164681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6EB110F9
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9828D54800A
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF8D21771C;
	Thu, 24 Jul 2025 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="szqke3zh"
X-Original-To: stable@vger.kernel.org
Received: from smtp70.iad3b.emailsrvr.com (smtp70.iad3b.emailsrvr.com [146.20.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18B2046A9
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382224; cv=none; b=kPZnVg3PXMnMBhL+eSyNSkwlF9jK+VF0DaXqobmsLyViRTGOINiW3PnH5r+pL0HJ7B35g9E6ozgIycEW+gxC3OGF9keS09Uf8G9L4Qm27xIUS6fgbfmTelmLmJnAn8b2kzz30Hy+mH2pomx4GPRVakkHSyfU1ilma4wRcwIveGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382224; c=relaxed/simple;
	bh=DggKBaV31TqvUSM8IInoemySsGdwBdQNPakz4ZCG/AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rb0SQl9HpXeMvym5I9GubpwNftZRGTVqwhmlEuTfpC11D46/S2TTQyMv23Uwa7NOatJcRh2XqAt1FffNbigDohSNG0nVLixZhP+FI6cqo6FIwndwIBuaJiDsm3y28JH4NkKhcnZUHoHL1iNgQ4xRJro9mtLTpNJT0ZFox90puow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=szqke3zh; arc=none smtp.client-ip=146.20.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753381317;
	bh=DggKBaV31TqvUSM8IInoemySsGdwBdQNPakz4ZCG/AE=;
	h=Date:Subject:To:From:From;
	b=szqke3zhPmji4a2pLuWdS+zJsHFxMxUSjaQpIFCJcChJeFhd0qzx/J7fN8pL1QrlA
	 zbc6gWJ6Cm53s8nxv8xn1gaGcaneKYM0R3cU6nU1n9tPCwXvpIgAFNrRkw/waaxkVv
	 SRRjdfjGrvtNswW7GSv1Ua4ip0zez2nQ4HjBlhIk=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BC69A601CD;
	Thu, 24 Jul 2025 14:21:56 -0400 (EDT)
Message-ID: <97a56f6d-ab63-46ae-bc26-ceae411ae7c8@mev.co.uk>
Date: Thu, 24 Jul 2025 19:21:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] comedi: Fail COMEDI_INSNLIST ioctl if n_insns is
 too large
To: stable@vger.kernel.org
Cc: syzbot+d6995b62e5ac7d79557a@syzkaller.appspotmail.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250724181646.291939-1-abbotti@mev.co.uk>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20250724181646.291939-1-abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 9e4cc56d-878d-417a-b14b-207adf33dbcf-1-1

On 24/07/2025 19:16, Ian Abbott wrote:
> [ Upstream commit 08ae4b20f5e82101d77326ecab9089e110f224cc ]
> 
> The handling of the `COMEDI_INSNLIST` ioctl allocates a kernel buffer to
> hold the array of `struct comedi_insn`, getting the length from the
> `n_insns` member of the `struct comedi_insnlist` supplied by the user.
> The allocation will fail with a WARNING and a stack dump if it is too
> large.
> 
> Avoid that by failing with an `-EINVAL` error if the supplied `n_insns`
> value is unreasonable.
> 
> Define the limit on the `n_insns` value in the `MAX_INSNS` macro.  Set
> this to the same value as `MAX_SAMPLES` (65536), which is the maximum
> allowed sum of the values of the member `n` in the array of `struct
> comedi_insn`, and sensible comedi instructions will have an `n` of at
> least 1.
> 
> Reported-by: syzbot+d6995b62e5ac7d79557a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d6995b62e5ac7d79557a
> Fixes: ed9eccbe8970 ("Staging: add comedi core")
> Tested-by: Ian Abbott <abbotti@mev.co.uk>
> Cc: stable@vger.kernel.org # 5.13+
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> Link: https://lore.kernel.org/r/20250704120405.83028-1-abbotti@mev.co.uk
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Apologies for accidentally sending the same set of 9 patches twice!  I 
meant to send a set for 5.10.y, followed by a set for 5.4.y.  Oops.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

