Return-Path: <stable+bounces-161777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D5B0318A
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 16:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEC417C593
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E9277CBC;
	Sun, 13 Jul 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="Hz3Nv4MH"
X-Original-To: stable@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66113D521
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417309; cv=none; b=gb4zoW7UKrYYcJVuCb31v33p3wbu+klPdP6oazscb4/yyAxevQxykAkYGKhYdbszx/whhs1Fh1u4NkDqWdKjy3rMCgUIOb0mLXsJ9NUAj0HsRc/GhTE19VKYlSOlyja5S8/NxBpEfPMBqgWzFciglpOHhNL7/5fxlPNty0iSThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417309; c=relaxed/simple;
	bh=Scv+BmfH8ti8FboD4RvN1a7cMUJrqve0N05x+sk5aQk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qvNBOizwx1NXLK0NfPBeTdGzTGk5KIJFIeOKUUCevdhfWIo0KOjEAq2lKMTiwxjpCa7xtVp6N1TWZJ8+62go5CPcCNjlg99fnlb5RV2Bi4byHblClbH02tHSJWMTqIxBLdPZIQ8ugC13ppHSmbYh8nuZPzFEthODE9kcSd4FXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=Hz3Nv4MH; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id 7B2F07D32D;
	Sun, 13 Jul 2025 16:27:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1752416859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ST1VO26hMWUaJQgRV2GfJQN4cStKr62H+bCfXFTtfA=;
	b=Hz3Nv4MHVJzk4qRWXLsvF8BHLb+2uNiW9wFvQHMyv1rJCtpzuoug7jwRm6uMqZqih0G5lx
	18Gtosk40PQT8aeCVUraWGf/5VS7Phc+MKmfDRo2UKJn2zE7CFRDzZ8QyBGmuuWgw8A/3u
	6V54OO1G9Wl1f9JpylQl1kuEXN/dqjQ=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 16:27:36 +0200
Message-Id: <DBAZXHXZCG1H.2PHV0NWGFKJQ6@pwned.life>
Cc: <stable@vger.kernel.org>, <regressions@lists.linux.dev>,
 =?utf-8?q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 "Achill Gilgenast" <fossdd@pwned.life>
Subject: Re: [REGRESSION] v6.12.35: (build) kallsyms.h:21:10: fatal error:
 execinfo.h: No such file or directory
From: "Achill Gilgenast" <fossdd@pwned.life>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Natanael Copa"
 <ncopa@alpinelinux.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250701141026.6133a3aa@ncopa-desktop>
 <2025070104-ether-wipe-9c19@gregkh>
In-Reply-To: <2025070104-ether-wipe-9c19@gregkh>

On Tue Jul 1, 2025 at 2:26 PM CEST, Greg Kroah-Hartman wrote:
> On Tue, Jul 01, 2025 at 02:10:26PM +0200, Natanael Copa wrote:
>> Hi!
>>=20
>> I bumped into a build regression when building Alpine Linux kernel 6.12.=
35 on x86_64:
>>=20
>> In file included from ../arch/x86/tools/insn_decoder_test.c:13:
>> ../tools/include/linux/kallsyms.h:21:10: fatal error: execinfo.h: No suc=
h file or directory
>>    21 | #include <execinfo.h>
>>       |          ^~~~~~~~~~~~
>> compilation terminated.
>>=20
>> The 6.12.34 kernel built just fine.
>>=20
>> I bisected it to:
>>=20
>> commit b8abcba6e4aec53868dfe44f97270fc4dee0df2a (HEAD)
>> Author: Sergio Gonz_lez Collado <sergio.collado@gmail.com>
>> Date:   Sun Mar 2 23:15:18 2025 +0100
>>=20
>>     Kunit to check the longest symbol length
>>    =20
>>     commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.
>>    =20
>> which has this hunk:
>>=20
>> diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_de=
coder_test.c
>> index 472540aeabc2..6c2986d2ad11 100644
>> --- a/arch/x86/tools/insn_decoder_test.c
>> +++ b/arch/x86/tools/insn_decoder_test.c
>> @@ -10,6 +10,7 @@
>>  #include <assert.h>
>>  #include <unistd.h>
>>  #include <stdarg.h>
>> +#include <linux/kallsyms.h>
>> =20
>>  #define unlikely(cond) (cond)
>> =20
>> @@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
>>         }
>>  }
>> =20
>> -#define BUFSIZE 256
>> +#define BUFSIZE (256 + KSYM_NAME_LEN)
>> =20
>>  int main(int argc, char **argv)
>>  {
>>=20
>> It looks like the linux/kallsyms.h was included to get KSYM_NAME_LEN.
>> Unfortunately it also introduced the include of execinfo.h, which does
>> not exist on musl libc.
>>=20
>> This has previously been reported to and tried fixed:
>> https://lore.kernel.org/stable/DB0OSTC6N4TL.2NK75K2CWE9JV@pwned.life/T/#=
t
>>=20
>> Would it be an idea to revert commit b8abcba6e4ae til we have a proper
>> solution for this?
>
> Please get the fix in Linus's tree first and then we can backport it as
> needed.

The patch now landed in Linus's tree as a95743b53031 ("kallsyms: fix
build without execinfo"). Please backport it into the stable trees.

