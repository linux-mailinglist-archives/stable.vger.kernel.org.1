Return-Path: <stable+bounces-4650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC71804E2C
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 10:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D51C8B20C02
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD97041748;
	Tue,  5 Dec 2023 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BgvYMMd1"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29841A9
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 01:42:57 -0800 (PST)
Received: from pwmachine.localnet (85-170-33-133.rev.numericable.fr [85.170.33.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2481920B74C0;
	Tue,  5 Dec 2023 01:42:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2481920B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701769376;
	bh=8ZmE98l/s85SLkrttawvYRT4wTeuwINXsDUXmzf+O0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BgvYMMd1E4x4ufJscSosuYjyfa/ozGJEUVPXg7iFTuR3t9u7kdta8VIYO0ndMt3Zd
	 UMYSFRsw1Kd3ybapNEmeykeE4XhVhFeI8oN0TqM7OwHUEvABWTGYtnecf7SdZsjwES
	 7sDmmrmo3ueVurxlBkmJeSAKLzZI9MaQRs/4NbPU=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Christoph Hellwig <hch@lst.de>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 5.15.y v1 1/2] kallsyms: Make kallsyms_on_each_symbol generally available
Date: Tue, 05 Dec 2023 10:42:52 +0100
Message-ID: <5996228.lOV4Wx5bFT@pwmachine>
In-Reply-To: <2023120533-washtub-data-f661@gregkh>
References: <20231201151957.682381-1-flaniel@linux.microsoft.com> <2709501.mvXUDI8C0e@pwmachine> <2023120533-washtub-data-f661@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi!


Le mardi 5 d=E9cembre 2023, 00:58:38 CET Greg KH a =E9crit :
> On Mon, Dec 04, 2023 at 09:19:05AM +0100, Francis Laniel wrote:
> > Hi!
> >=20
> > Le samedi 2 d=E9cembre 2023, 00:02:58 CET Greg KH a =E9crit :
> > > On Fri, Dec 01, 2023 at 04:19:56PM +0100, Francis Laniel wrote:
> > > > From: Jiri Olsa <jolsa@kernel.org>
> > > >=20
> > > > Making kallsyms_on_each_symbol generally available, so it can be
> > > > used outside CONFIG_LIVEPATCH option in following changes.
> > > >=20
> > > > Rather than adding another ifdef option let's make the function
> > > > generally available (when CONFIG_KALLSYMS option is defined).
> > > >=20
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > Link:
> > > > https://lore.kernel.org/r/20220510122616.2652285-2-jolsa@kernel.org
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > ---
> > > >=20
> > > >  include/linux/kallsyms.h | 7 ++++++-
> > > >  kernel/kallsyms.c        | 2 --
> > > >  2 files changed, 6 insertions(+), 3 deletions(-)
> > >=20
> > > What is the git id of this commit in Linus's tree?
> >=20
> > Sorry, the commit ID is [1]:
> > d721def7392a7348ffb9f3583b264239cbd3702c
>=20
> Please send a new, updated series for all branches that you wish this
> series to go on, and MOST IMPORTANTLY, some sort of proof that this
> actually works this time...
>=20
> In other words, you need to test-build this on all arches and somehow
> run-time test it as well, good luck!

I will take a look at TuxMake to ease this process [1].
But if someone has other tools to advise, feedback would be welcomed.

> thanks,
>=20
> greg k-h


Best regards.
=2D--
[1]: https://tuxmake.org/



