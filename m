Return-Path: <stable+bounces-2744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA097F9E69
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 12:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D771C20CE7
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 11:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6516199A3;
	Mon, 27 Nov 2023 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mDvHCvzL"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC38E135
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 03:21:53 -0800 (PST)
Received: from pwmachine.localnet (85-170-33-133.rev.numericable.fr [85.170.33.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id AB17C20B74C0;
	Mon, 27 Nov 2023 03:21:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB17C20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701084113;
	bh=1MNpfvevMpOZ0QF4Jt1hjD7DmpYPzzA1J9VGy9HnMb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDvHCvzLe8IALM9ho3PcZKijOIq9owrqz6nIXha2pP0TcekkvjzZRxSQRMRXXv52U
	 Z5vTuQ+VVlUkDu75jZz1pAOXg3yjLfSzydziPsD+pijIK6S2TSRI0pxPUTNzUH7jqq
	 1odEjlISrT6iYjcSKGhuTuf5SbOU6rnjo+D3W4JQ=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 5.10.y] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date: Mon, 27 Nov 2023 12:21:50 +0100
Message-ID: <12330827.O9o76ZdvQC@pwmachine>
In-Reply-To: <2023112415-salutary-visible-1485@gregkh>
References: <2023102135-shuffle-blank-783e@gregkh> <20231124130935.168451-1-flaniel@linux.microsoft.com> <2023112415-salutary-visible-1485@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi!


Le vendredi 24 novembre 2023, 17:16:43 CET Greg KH a =E9crit :
> On Fri, Nov 24, 2023 at 02:09:35PM +0100, Francis Laniel wrote:
> > When a kprobe is attached to a function that's name is not unique (is
> > static and shares the name with other functions in the kernel), the
> > kprobe is attached to the first function it finds. This is a bug as the
> > function that it is attaching to is not necessarily the one that the
> > user wants to attach to.
> >=20
> > Instead of blindly picking a function to attach to what is ambiguous,
> > error with EADDRNOTAVAIL to let the user know that this function is not
> > unique, and that the user must use another unique function with an
> > address offset to get to the function they want to attach to.
> >=20
> > Link:
> > https://lore.kernel.org/all/20231020104250.9537-2-flaniel@linux.microso=
ft
> > .com/
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 413d37d1eb69 ("tracing: Add kprobe-based event tracer")
> > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > Link:
> > https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@ke=
rn
> > el.org/ Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > (cherry picked from commit b022f0c7e404887a7c5229788fc99eff9f9a80d5)
> > ---
> >=20
> >  kernel/trace/trace_kprobe.c | 74 +++++++++++++++++++++++++++++++++++++
> >  kernel/trace/trace_probe.h  |  1 +
> >  2 files changed, 75 insertions(+)
>=20
> We also need a version for 5.15.y before we can take this, you do not
> want to upgrade and have a regression.

I sent the corresponding 5.15.y patch some times ago here:
https://lore.kernel.org/stable/20231023122217.302483-2-flaniel@linux.micros=
oft.com/

If this is easier for you, I can resend it without problems.

> thanks,
>=20
> greg k-h


Best regards.



