Return-Path: <stable+bounces-41594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080D68B5027
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 06:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363AAB22685
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 04:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF758F6A;
	Mon, 29 Apr 2024 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="a1dDkDsV"
X-Original-To: stable@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180ECD51D
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714363668; cv=none; b=VJE9kKzM6WV/37mbRwvgK5aYks1vUCnZZLxd6LDzlAUsWb8j1QCYJRLE/ac/XjoxOf6cbCAB72PdSzAZzpwEIOLnGJ+grpFmHq2NwvZg7gMjMhRsdMhKqfFd05mJ+6UkZcJoCp3OEUUEbNPe5UU4HDTRcpmqRnYev2uFJ+3191s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714363668; c=relaxed/simple;
	bh=Qsy4StcuyHRThWup94FbZ07TVhrnqEjZTBqbdRznwaI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dACoIlqnOs88GQHzKVf4u+t7j6nNcCho0RWcvXwRbZQ4B2UPIvvLM0SDOx0J7g6xFO/3u1xeGEDIFNnXWqzWS6QZrkGrgADpeU+xC7FK/YGrQ+Zfkih0LCgJquJiV8gaw5VUexsu1oFW+LMff4Ukl8CCGJRfTgB5evQCNTrwhaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=a1dDkDsV; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 9E52EE26340E7;
	Mon, 29 Apr 2024 07:07:40 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id mLU7gwOM1KH1; Mon, 29 Apr 2024 07:07:40 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 56A90E2883FF7;
	Mon, 29 Apr 2024 07:07:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 56A90E2883FF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1714363660;
	bh=3uW4Kwchi90ybF5Qddm5zzn1I0/3PSx21165HfL5X+c=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=a1dDkDsVIeXWxZT44lwigAlAPK21AdhyS04aikQNqv4//FVxSOAKsnxOUp7Q9k4xk
	 8T/E0KwKfdDsRZgsNmqV4LwUZ0bEQkKp5m48zej9JlB3poElOCNVDUDY7wRxnNNSmV
	 eIEC8ZW8NNpKwHG7Cn0ZBfsNmV7OW4hpn/Jo+7/k9xiIYA0LKn2SGoJAlJNnQMUQLk
	 Ufn2DNDF9ucw/Cvfgzda2XEMJRsCH8+ufZt+epmQLKyzXL1o12oTyC1s4mx8Du6ba9
	 YGXVehtHVmVCC5YTTAoRyv9/HoCqFMiPQ/xewQg8SKGy9/I0c+6mlYaYlncNNDUqkQ
	 +p8s9MhYGA9LQ==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gl6KnPSW0REL; Mon, 29 Apr 2024 07:07:40 +0300 (MSK)
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	by mail.rosalinux.ru (Postfix) with ESMTP id D9297E2883FF4;
	Mon, 29 Apr 2024 07:07:39 +0300 (MSK)
Date: Mon, 29 Apr 2024 07:07:39 +0300 (MSK)
From: =?utf-8?B?0JzQuNGF0LDQuNC7INCd0L7QstC+0YHQtdC70L7Qsg==?= <m.novosyolov@rosalinux.ru>
To: Matthew Wilcox <willy@infradead.org>
Cc: riel@surriel.com, mgorman@techsingularity.net, peterz@infradead.org, 
	mingo@kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org, 
	sashal@kernel.org, 
	=?utf-8?B?0JHQtdGC0YXQtdGAINCQ0LvQtdC60YHQsNC90LTRgA==?= <a.betkher@rosalinux.ru>, 
	i gaptrakhmanov <i.gaptrakhmanov@rosalinux.ru>
Message-ID: <134159708.2271149.1714363659210.JavaMail.zimbra@rosalinux.ru>
In-Reply-To: <Zi8MXbT9Ajbv74wK@casper.infradead.org>
References: <1c978cf1-2934-4e66-e4b3-e81b04cb3571@rosalinux.ru> <Zi8MXbT9Ajbv74wK@casper.infradead.org>
Subject: Re: Serious regression on 6.1.x-stable caused by "bounds: support
 non-power-of-two CONFIG_NR_CPUS"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - GC122 (Linux)/8.8.12_GA_3794)
Thread-Topic: Serious regression on 6.1.x-stable caused by "bounds: support non-power-of-two CONFIG_NR_CPUS"
Thread-Index: EYn4uAsdPHMuy5xc0am+u86zmX4xhg==

(Resending in plain text, sorry for accodently sending in HTML)

----- =D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D0=BE=
=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 -----
> =D0=9E=D1=82: "Matthew Wilcox" <willy@infradead.org>
> =D0=9A=D0=BE=D0=BC=D1=83: "=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB =D0=9D=D0=
=BE=D0=B2=D0=BE=D1=81=D0=B5=D0=BB=D0=BE=D0=B2" <m.novosyolov@rosalinux.ru>
> =D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: riel@surriel.com, mgorman@techsingularity=
.net, peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org,
> stable@vger.kernel.org, sashal@kernel.org, "=D0=91=D0=B5=D1=82=D1=85=D0=
=B5=D1=80 =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80" <a.betkhe=
r@rosalinux.ru>, "i gaptrakhmanov"
> <i.gaptrakhmanov@rosalinux.ru>
> =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5:=
 =D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D1=8C=D0=BD=D0=B8=D0=BA, 29 =D0=
=90=D0=BF=D1=80=D0=B5=D0=BB=D1=8C 2024 =D0=B3 5:56:29
> =D0=A2=D0=B5=D0=BC=D0=B0: Re: Serious regression on 6.1.x-stable caused b=
y "bounds: support non-power-of-two CONFIG_NR_CPUS"

> On Sun, Apr 28, 2024 at 05:58:08PM +0300, Mikhail Novosyolov wrote:
>> Hello, colleagues.
>>=20
>> Commit f2d5dcb48f7ba9e3ff249d58fc1fa963d374e66a "bounds: support
>> non-power-of-two CONFIG_NR_CPUS"
>> (https://github.com/torvalds/linux/commit/f2d5dcb48f7ba9e3ff249d58fc1fa9=
63d374e66a)
>> was backported to 6.1.x-stable
>> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D428ca0000f0abd5c99354c52a36becf2b815ca21),
>> but causes a serious regression on quite a lot of hardware with AMD GPUs=
,
>> kernel panics.
>>=20
>> It was backported to 6.1.84, 6.1.84 has problems, 6/1/83 does not, the n=
ewest
>> 6.1.88 still has this problem.
>=20
> Does v6.8.3 (which contains cf778fff03be) have this problem?
> How about current Linus master?

6.1.88 - has problem
6.6.27 - does not have problem
6.9-rc from commit efdfbbc4dcc8f98754056971f88af0f7ff906144 https://git.ker=
nel.org/pub/scm/linux/kernel/git/broonie/sound.git - does not have problem

6.8.3 was not tested, but we can test it if needed.


>=20
> What kernel config were you using?  I don't see that info on
> https://linux-hardware.org/?probe=3D9c92ac1222
> (maybe my tired eyes can't see it)

Kernel config for 6.1: https://abf.io/import/kernel-6.1/blob/bcb3e9611f/ker=
nel-x86_64.config
For 6.6: https://abf.io/import/kernel-6.6/blob/7404a4d3d5/kernel-x86_64.con=
fig
6.9-rc was built with copypastied config from 6.6 (https://abf.io/build_lis=
ts/5028240)

