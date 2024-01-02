Return-Path: <stable+bounces-9168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B560982189B
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 09:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37E21C21625
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 08:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35D153A7;
	Tue,  2 Jan 2024 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FJVcEG+x"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767D6CA66
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from pwmachine.localnet (85-170-33-133.rev.numericable.fr [85.170.33.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id C3E0C20ACED1;
	Tue,  2 Jan 2024 00:46:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3E0C20ACED1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704185194;
	bh=gjFkDbYE1pM02+6S548ZYRSs+wDA7q0OA6FMoPWMhko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FJVcEG+xYAnxncT0A1iMehRnrwMm1kd/CCfRAQOnMF0INsr0I7sl+42yex1g1CiyW
	 eJfSt8KotAu9MjZRhyF31DhDHzrE9n6avTAgyV9m8IhgFTSshHWyvssNjTiOb801Zp
	 UnijA6mVkSinLymgkFiIQS3gpmCGv+rJUftVQDoo=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: gregkh@linuxfoundation.org, Tee Hao Wei <angelsl@in04.sg>
Cc: Andrii Nakryiko <andrii@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Song Liu <song@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] tracing/kprobes: Fix symbol counting logic by looking at modules as well
Date: Tue, 02 Jan 2024 09:46:30 +0100
Message-ID: <12353213.O9o76ZdvQC@pwmachine>
In-Reply-To: <279de9e4-502c-49f1-be7f-c203134fbaae@app.fastmail.com>
References: <2023102922-handwrite-unpopular-0e1d@gregkh> <20231220170016.23654-1-angelsl@in04.sg> <279de9e4-502c-49f1-be7f-c203134fbaae@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi!


Le dimanche 31 d=E9cembre 2023, 14:09:36 CET Tee Hao Wei a =E9crit :
> On Thu, 21 Dec 2023, at 01:00, Hao Wei Tee wrote:
> > From: Andrii Nakryiko <andrii@kernel.org>
> >=20
> > Recent changes to count number of matching symbols when creating
> > a kprobe event failed to take into account kernel modules. As such, it
> > breaks kprobes on kernel module symbols, by assuming there is no match.
> >=20
> > Fix this my calling module_kallsyms_on_each_symbol() in addition to
> > kallsyms_on_each_match_symbol() to perform a proper counting.
> >=20
> > Link:
> > https://lore.kernel.org/all/20231027233126.2073148-1-andrii@kernel.org/
> >=20
> > Cc: Francis Laniel <flaniel@linux.microsoft.com>
> > Cc: stable@vger.kernel.org
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func
> > matches several symbols") Signed-off-by: Andrii Nakryiko
> > <andrii@kernel.org>
> > Acked-by: Song Liu <song@kernel.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > (cherry picked from commit 926fe783c8a64b33997fec405cf1af3e61aed441)
>=20
> I noticed this patch was added and then dropped in the 6.1 stable queue. =
Is
> there any issue with it? I'll fix it ASAP.

=46eel free to send me this updated patch privately, so I can also test it =
to=20
ensure everything is correct before sending again to stable.
=20
> Thanks.


Best regards.



