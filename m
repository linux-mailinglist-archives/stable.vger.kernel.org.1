Return-Path: <stable+bounces-95347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A856D9D7BFD
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 08:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 101AEB21AE6
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 07:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A5680038;
	Mon, 25 Nov 2024 07:34:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from isrv.corpit.ru (isrv.corpit.ru [86.62.121.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B72119
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=86.62.121.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520049; cv=none; b=jvIhP1dbOEwG/KJzKbQc4pk5TXNbJLXZsHlfR6uqMKeVw+eLrAZfh+0ZWl7Cvxowq+VE3/bygoYSCfKO8ncaAr0sFO4N4eNLb6MAPyPpo+/WAB55Rz3/xpIus9zDv35C3MqF8M8b4kf4p7ft1n+CxVmlq+3zIR9GPrI2/QOOaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520049; c=relaxed/simple;
	bh=3i+hb0dpqIChIc7BsIeCmoA79KIGxuCmrrfIMoPPHCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pcUF54P7/wsyeTjwW2j7MPygI66YhcwtOggyvCkc1TUZGvMFCRvhOhQi4zqzV4YhkxVF2MTQVEp7W0vN4ErZ18/kXdayoFNa03xwphyxtcTC7FdgblbP8gDP2VJLJQ5kEgNMtJsqP0lwv/1hYrwso0kH3b6CFHTKzayUZHgkmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru; spf=pass smtp.mailfrom=tls.msk.ru; arc=none smtp.client-ip=86.62.121.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id AB3F9B0411;
	Mon, 25 Nov 2024 10:25:58 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
	by tsrv.corpit.ru (Postfix) with ESMTP id 7756B1791A3;
	Mon, 25 Nov 2024 10:26:12 +0300 (MSK)
Message-ID: <4ef74a1c-a261-487b-891c-56c44863daea@tls.msk.ru>
Date: Mon, 25 Nov 2024 10:26:12 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: please revert backport of
 44c76825d6eefee9eb7ce06c38e1a6632ac7eb7d
To: Kees Cook <kees@kernel.org>, stable@vger.kernel.org,
 Dominique Martinet <asmadeus@codewreck.org>
References: <202411210628.ECF1B494D7@keescook>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <202411210628.ECF1B494D7@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

21.11.2024 17:33, Kees Cook wrote:
> Hi stable tree maintainers,
> 
> Please revert the backports of
> 
> 44c76825d6ee ("x86: Increase brk randomness entropy for 64-bit systems")
> 
> namely:
> 
> 5.4:  03475167fda50b8511ef620a27409b08365882e1
> 5.10: 25d31baf922c1ee987efd6fcc9c7d4ab539c66b4
> 5.15: 06cb3463aa58906cfff72877eb7f50cb26e9ca93
> 6.1:  b0cde867b80a5e81fcbc0383e138f5845f2005ee
> 6.6:  1a45994fb218d93dec48a3a86f68283db61e0936
> 
> There seems to be a bad interaction between this change and older
> PIE-built qemu-user-static (for aarch64) binaries[1]. Investigation
> continues to see if this will need to be reverted from 6.6, 6.11,
> and mainline. But for now, it's clearly a problem for older kernels with
> older qemu.
> 
> Thanks!
> 
> -Kees
> 
> [1] https://lore.kernel.org/all/202411201000.F3313C02@keescook/
Unfortunately I haven't seen this thread and this email before now,
when things are already too late.

And it turned out it's entirely my fault with all this.  Let me
explain so things become clear to everyone.

The problem here is entirely in qemu-user.  The fundamental issue
is that qemu-user does not implement an MMU, instead, it implements
just address shift, searching for a memory region for the guest address
space which is hopefully not used by qemu-user itself.

In practice, this is rarely an issue though, when - and this is the
default - qemu is built as a static-pie executable.  This is important:
it's the default mode for the static build - it builds as static-pie
executable, which works around the problem in almost all cases.
This is done for quite a long time, too.

However, I, as qemu maintainer in debian, got a bug report saying
that qemu-user-static isn't "static enough" - because for some tools
used on debian (lintian), static-pie was something unknown and the
tool issued a warning.  And at the time, I just added --disable-pie
flag to the build, without much thinking.  This is where things went
wrong.

Later I reverted this change with a shame, because it causes numerous
configurations to fail randomly, and each of them is very difficult to
debug (especially due to randomness of failures, sometimes it can work
50 times in a row but fail on the 51th).

But unfortunately, I forgot to revert this "de-PIEsation" change in
debian stable, and that's exactly where the original bug report come
from, stating kernel broke builds in qemu.

The same qemu-user-static configuration has been used by some other
distributions too, but hopefully everything's fixed now.  Except of
debian bookworm, and probably also ubuntu jammy (previous LTS).

It is not an "older qemu" anymore (though for a very old qemu this is
true again, that old one can't be used anymore with modern executables
anyway due to other reasons).  It is just my build mistake which is
*still* unfixed on debian stable (bookworm).  And even there, this
issue can trivially be fixed locally, since qemu-user-static is
self-contained and can be installed on older debian releases, and I
always provide up-to-date backports of qemu packages for debian stable.

And yes, qemu had numerous improvements in this area since bookworm
version, which addressed many other issues around this and fixed many
other configurations (which are not related to this kernel change),
but the fundamental issue (lack of full-blown MMU) remains.

Hopefully this clears things up, and it can be seen that this is not
a kernel bug.  And I'm hoping we'll fix this in debian bookworm soon
too.

Thanks, and sorry for all the buzz which caused my 2 mistakes.

/mjt

