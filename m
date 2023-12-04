Return-Path: <stable+bounces-3837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EB8802CFD
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126001C209F6
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 08:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3929AD527;
	Mon,  4 Dec 2023 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kuQEMk9l"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C35BD3
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 00:19:09 -0800 (PST)
Received: from pwmachine.localnet (85-170-33-133.rev.numericable.fr [85.170.33.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id A4C2320B74C1;
	Mon,  4 Dec 2023 00:19:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4C2320B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701677948;
	bh=zNdiGCp8zALVe6anH5p9izkP9vscRPIigBaZb0WK6BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kuQEMk9l8v7JF9AXyXVJ/JqDiw7+nRzQ4n0rwzRvenh+BIyJH2BSPcPdNHvNp+WP9
	 0vTm8z5FeGc7dVeM4AUfA1kSY8+OsudNprYY/I0zh+8oFynBvDNC+RIMzAcdONaoeE
	 HStxpGDkh7I+N6o8OlQLpsiy6H8CXiTw6p6xwhBs=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Christoph Hellwig <hch@lst.de>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 5.15.y v1 1/2] kallsyms: Make kallsyms_on_each_symbol generally available
Date: Mon, 04 Dec 2023 09:19:05 +0100
Message-ID: <2709501.mvXUDI8C0e@pwmachine>
In-Reply-To: <2023120247-unsocial-caress-14fe@gregkh>
References: <20231201151957.682381-1-flaniel@linux.microsoft.com> <20231201151957.682381-2-flaniel@linux.microsoft.com> <2023120247-unsocial-caress-14fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi!


Le samedi 2 d=E9cembre 2023, 00:02:58 CET Greg KH a =E9crit :
> On Fri, Dec 01, 2023 at 04:19:56PM +0100, Francis Laniel wrote:
> > From: Jiri Olsa <jolsa@kernel.org>
> >=20
> > Making kallsyms_on_each_symbol generally available, so it can be
> > used outside CONFIG_LIVEPATCH option in following changes.
> >=20
> > Rather than adding another ifdef option let's make the function
> > generally available (when CONFIG_KALLSYMS option is defined).
> >=20
> > Cc: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > Link: https://lore.kernel.org/r/20220510122616.2652285-2-jolsa@kernel.o=
rg
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >=20
> >  include/linux/kallsyms.h | 7 ++++++-
> >  kernel/kallsyms.c        | 2 --
> >  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> What is the git id of this commit in Linus's tree?

Sorry, the commit ID is [1]:
d721def7392a7348ffb9f3583b264239cbd3702c


Best regards.
=2D--
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
commit/?id=3Dd721def7392a7348ffb9f3583b264239cbd3702c



