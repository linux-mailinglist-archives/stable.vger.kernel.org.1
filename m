Return-Path: <stable+bounces-23560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 161548623B8
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 10:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63F11F245B5
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0757218037;
	Sat, 24 Feb 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ohPs78bK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07DA10A24
	for <stable@vger.kernel.org>; Sat, 24 Feb 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765881; cv=none; b=H56ghs06IZuaBhft9y/OT1bhA6t7e6J/aGZeLK/1Pln+TllHkVGAbO9Ky/tnsFaNq7pPXaJ/GBg3551qn7UtozJnZNb19btX5GDHiz3wpZ91QH/S2czc+4Uamm/1iTHbG93k/vNerKqkGX31X2wQD3r/Q4smTrUjA8+yI6ZC924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765881; c=relaxed/simple;
	bh=0I6OhW4DnzYbcZv9ZE+8cPWvufW+HcUayUwChdBjJfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuzMRvyOKPU92sWn3KBmX34udKLKLjtuNz06Nkd2J5aWWnRfd7gKlUr+AIKTb+A7ykzx3gVM75HgNXcImGOIwOTaVJk9yQ+WjSuNeM16fNzITgx/RaKcQ36gnmPu3M6cMBJ1fRIfax4gy2VJfIbSLBozbeDfMnWmB5oHeb9bdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ohPs78bK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE6FC433C7;
	Sat, 24 Feb 2024 09:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708765881;
	bh=0I6OhW4DnzYbcZv9ZE+8cPWvufW+HcUayUwChdBjJfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohPs78bK/g7ZvYxeNJk6568DBlZMb1XBqNh9xsGLU63Qb38/jfrka77TEPc53OgPY
	 Azcct11SL82dUtqr1Vejik5b251WMMs6pRDNhnPqoecl7KT8w6BapPYuo2f1/NMDnP
	 9qbNNHvP7Mqj9Xp+AfWXMkrga9kgcduo7j4+bHMY=
Date: Sat, 24 Feb 2024 10:11:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	'Roman Gilg' <romangg@manjaro.org>, Mark Wagie <mark@manjaro.org>
Subject: Re: [Regression] 5.4.269 fails =?utf-8?Q?t?=
 =?utf-8?Q?o_build_due_to_security=2Fapparmor=2Faf=5Funix=2Ec=3A583=3A17?=
 =?utf-8?Q?=3A_error=3A_too_few_arguments_to_function_=E2=80=98unix=5Fstat?=
 =?utf-8?B?ZV9sb2NrX25lc3RlZOKAmQ==?=
Message-ID: <2024022453-showcase-antonym-f49b@gregkh>
References: <0ca1f9f0-6a09-4beb-bbdb-101b3fc19c45@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ca1f9f0-6a09-4beb-bbdb-101b3fc19c45@manjaro.org>

On Fri, Feb 23, 2024 at 11:18:40PM +0700, Philip Müller wrote:
> Hi Greg,
> 
> the issue might be due to this patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/releases/5.4.269/af_unix-fix-lockdep-positive-in-sk_diag_dump_icons.patch
> 
> 2024-02-23T15:39:05.6297767Z   CC      kernel/sys_ni.o
> 2024-02-23T15:39:05.7583048Z security/apparmor/af_unix.c: In function
> ‘unix_state_double_lock’:
> 2024-02-23T15:39:05.7586076Z security/apparmor/af_unix.c:583:17: error: too
> few arguments to function ‘unix_state_lock_nested’
> 2024-02-23T15:39:05.7588374Z   583 | unix_state_lock_nested(sk2);
> 2024-02-23T15:39:05.7589913Z       |                 ^~~~~~~~~~~~~~~~~~~~~~
> 2024-02-23T15:39:05.7591564Z In file included from
> security/apparmor/include/af_unix.h:15,
> 2024-02-23T15:39:05.7593341Z                  from
> security/apparmor/af_unix.c:17:
> 2024-02-23T15:39:05.7594989Z ./include/net/af_unix.h:77:20: note: declared
> here
> 2024-02-23T15:39:05.7596733Z    77 | static inline void
> unix_state_lock_nested(struct sock *sk,
> 2024-02-23T15:39:05.7598516Z       | ^~~~~~~~~~~~~~~~~~~~~~
> 2024-02-23T15:39:05.7600862Z security/apparmor/af_unix.c:586:17: error: too
> few arguments to function ‘unix_state_lock_nested’
> 2024-02-23T15:39:05.7603177Z   586 | unix_state_lock_nested(sk1);
> 2024-02-23T15:39:05.7605189Z       |                 ^~~~~~~~~~~~~~~~~~~~~~
> 2024-02-23T15:39:05.7606765Z ./include/net/af_unix.h:77:20: note: declared
> here
> 2024-02-23T15:39:05.7608497Z    77 | static inline void
> unix_state_lock_nested(struct sock *sk,
> 2024-02-23T15:39:05.7610208Z       | ^~~~~~~~~~~~~~~~~~~~~~
> 2024-02-23T15:39:05.8002385Z make[2]: *** [scripts/Makefile.build:262:
> security/apparmor/af_unix.o] Error 1
> 2024-02-23T15:39:05.8005077Z make[2]: *** Waiting for unfinished jobs....
> 2024-02-23T15:39:05.8094726Z   CC      crypto/scatterwalk.o
> 2024-02-23T15:39:05.9082621Z   CC [M]  fs/btrfs/sysfs.o
> 2024-02-23T15:39:06.2502316Z   CC      kernel/nsproxy.o
> 2024-02-23T15:39:06.4094246Z make[1]: *** [scripts/Makefile.build:497:
> security/apparmor] Error 2
> 2024-02-23T15:39:06.4207119Z make: *** [Makefile:1750: security] Error 2
> 2024-02-23T15:39:06.4208636Z   CC      kernel/notifier.o
> 2024-02-23T15:39:06.4210296Z make: *** Waiting for unfinished jobs....
> 2024-02-23T15:39:06.8604827Z   CC      crypto/proc.o

Odd line wrapping :(

Anyway, what config options are you using?  I can't see this here and
none of the CI systems caught it either.

thanks,

greg k-h

