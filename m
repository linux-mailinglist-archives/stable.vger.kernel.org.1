Return-Path: <stable+bounces-161781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED0FB031AF
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 17:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F573189DC19
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 15:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DFB2797A3;
	Sun, 13 Jul 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="N/ApaWs3"
X-Original-To: stable@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F58149DF0
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752419516; cv=none; b=ggvH6VmzWjylmwpxKl9HNswlsMgL6+FNfdhXTZrMfuo8eKSQY79ST721UX5BFL3I/mhTDhDmdFrrnZCmIy5IXWzWypOF25Khtb+u+YVs8S/bneGAO73eAKlrqqn3JdvzbH7xU/RuoB8cFnb1FCmP7rFLHDxWXK765Tw+MKPSUaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752419516; c=relaxed/simple;
	bh=PfTjSv++iWs3nsnLdZ+RAXwaBaheZhBmfHoz0CqUMPc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NtQhHjiaClqmcTQyJY+5PbxidyLAdgn/EFRUxmjKoNxUBwQVPWK+dIZwxS9o9I9pP+Vlrs0cqRItu6nmdW4uJcsJoWKHkFoBAgFjDHPWNYXzZQrpkWDTnaNauYvbDiF1TvP254eXsip1KvFeXK8+DmZ0ujcBlJrdJGCT1b0gyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=N/ApaWs3; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id 2970E7D32D;
	Sun, 13 Jul 2025 17:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1752419512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QV6ytnbZ9xmU9afl8WRFWceOCnE372hzW6oLlYuoxeI=;
	b=N/ApaWs3h5NTsqvgeAeYjsm2X+XckC+aA84lOJWjUORwmKrbx+jo5vXidLssyl4xZOnWh/
	a/qX4UOeOFngth4LhcHmlpdUjEdC9GhDH7PwM1Z0SjE4NwvSLicxO0eOOs6UHztq4cSP1H
	+0bHRZNQF6Sgx77zBu3yWIWqf7y9ntg=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 17:11:49 +0200
Message-Id: <DBB0VCNJ51WM.3562BZU969YMN@pwned.life>
Cc: "Natanael Copa" <ncopa@alpinelinux.org>, <stable@vger.kernel.org>,
 <regressions@lists.linux.dev>, =?utf-8?q?Sergio_Gonz=C3=A1lez_Collado?=
 <sergio.collado@gmail.com>, "Achill Gilgenast" <fossdd@pwned.life>
Subject: Re: [REGRESSION] v6.12.35: (build) kallsyms.h:21:10: fatal error:
 execinfo.h: No such file or directory
From: "Achill Gilgenast" <fossdd@pwned.life>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250701141026.6133a3aa@ncopa-desktop>
 <2025070104-ether-wipe-9c19@gregkh> <DBAZXHXZCG1H.2PHV0NWGFKJQ6@pwned.life>
 <2025071349-enforced-darkroom-164c@gregkh>
In-Reply-To: <2025071349-enforced-darkroom-164c@gregkh>

On Sun Jul 13, 2025 at 4:38 PM CEST, Greg Kroah-Hartman wrote:
> On Sun, Jul 13, 2025 at 04:27:36PM +0200, Achill Gilgenast wrote:
>> On Tue Jul 1, 2025 at 2:26 PM CEST, Greg Kroah-Hartman wrote:
>> > On Tue, Jul 01, 2025 at 02:10:26PM +0200, Natanael Copa wrote:
>> >> Hi!
>> >>=20
>> >> I bumped into a build regression when building Alpine Linux kernel 6.=
12.35 on x86_64:
>> >>=20
>> >> In file included from ../arch/x86/tools/insn_decoder_test.c:13:
>> >> ../tools/include/linux/kallsyms.h:21:10: fatal error: execinfo.h: No =
such file or directory
>> >>    21 | #include <execinfo.h>
>> >>       |          ^~~~~~~~~~~~
>> >> compilation terminated.
>> >>=20
>> >> The 6.12.34 kernel built just fine.
>> >>=20
>> >> I bisected it to:
>> >>=20
>> >> commit b8abcba6e4aec53868dfe44f97270fc4dee0df2a (HEAD)
>> >> Author: Sergio Gonz_lez Collado <sergio.collado@gmail.com>
>> >> Date:   Sun Mar 2 23:15:18 2025 +0100
>> >>=20
>> >>     Kunit to check the longest symbol length
>> >>    =20
>> >>     commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.
>> >>    =20
>> >> which has this hunk:
>> >>=20
>> >> diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn=
_decoder_test.c
>> >> index 472540aeabc2..6c2986d2ad11 100644
>> >> --- a/arch/x86/tools/insn_decoder_test.c
>> >> +++ b/arch/x86/tools/insn_decoder_test.c
>> >> @@ -10,6 +10,7 @@
>> >>  #include <assert.h>
>> >>  #include <unistd.h>
>> >>  #include <stdarg.h>
>> >> +#include <linux/kallsyms.h>
>> >> =20
>> >>  #define unlikely(cond) (cond)
>> >> =20
>> >> @@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
>> >>         }
>> >>  }
>> >> =20
>> >> -#define BUFSIZE 256
>> >> +#define BUFSIZE (256 + KSYM_NAME_LEN)
>> >> =20
>> >>  int main(int argc, char **argv)
>> >>  {
>> >>=20
>> >> It looks like the linux/kallsyms.h was included to get KSYM_NAME_LEN.
>> >> Unfortunately it also introduced the include of execinfo.h, which doe=
s
>> >> not exist on musl libc.
>> >>=20
>> >> This has previously been reported to and tried fixed:
>> >> https://lore.kernel.org/stable/DB0OSTC6N4TL.2NK75K2CWE9JV@pwned.life/=
T/#t
>> >>=20
>> >> Would it be an idea to revert commit b8abcba6e4ae til we have a prope=
r
>> >> solution for this?
>> >
>> > Please get the fix in Linus's tree first and then we can backport it a=
s
>> > needed.
>>=20
>> The patch now landed in Linus's tree as a95743b53031 ("kallsyms: fix
>> build without execinfo"). Please backport it into the stable trees.
>
> Already all queued up!
>
> Thanks for letting us know.

Nice, thanks!

