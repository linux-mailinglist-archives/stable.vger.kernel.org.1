Return-Path: <stable+bounces-2763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E33F7FA329
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 15:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D6EB210E2
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 14:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E841DDE7;
	Mon, 27 Nov 2023 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gDp6+dZP"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30825E1
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 06:41:35 -0800 (PST)
Received: from pwmachine.localnet (85-170-33-133.rev.numericable.fr [85.170.33.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1C7F920B74C0;
	Mon, 27 Nov 2023 06:41:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C7F920B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701096094;
	bh=qDo7UN+/1b6h0VVSur5hRgS4MIoh0bNHp/01HdpBVJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDp6+dZPoTXV+4nbrkpgtYX6rUKzbAAVJiwl0nd5oII5GgsD99OG+MOoFXkyhWFkU
	 gRTs5tSwtlg2BbqBdscOz6YKbjkOLJ7vNCMEtMK1Xs0bLiqo2P6iScrd6pLG7JnfjH
	 63d0fARG72nDaSDBIs9Zp71EAfRgFF6QXgdSWeT0=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 4.19.y] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date: Mon, 27 Nov 2023 15:41:31 +0100
Message-ID: <5993767.lOV4Wx5bFT@pwmachine>
In-Reply-To: <2023112447-prevent-unbalance-4448@gregkh>
References: <2023102138-riverbed-senator-e356@gregkh> <20231124122413.95544-1-flaniel@linux.microsoft.com> <2023112447-prevent-unbalance-4448@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi!


Le vendredi 24 novembre 2023, 17:17:04 CET Greg KH a =E9crit :
> On Fri, Nov 24, 2023 at 01:24:13PM +0100, Francis Laniel wrote:
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
> >  kernel/trace/trace_kprobe.c | 48 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
>=20
> Again, we need a version for 5.4.y as well before we can take this
> version.

I sent the 5.4.y patch some times ago, you can find it here:=20
https://lore.kernel.org/stable/20231023113623.36423-2-flaniel@linux.microso=
ft.com/

With the recent batch I sent, I should have cover all the stable kernels.
In case I miss one, please indicate it to me so I can fix this problem and=
=20
ensure all stable kernels have a corresponding patch.
=20
> thanks,
>=20
> greg k-h


Best regards.



