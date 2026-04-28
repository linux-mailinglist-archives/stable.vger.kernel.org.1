Return-Path: <stable+bounces-241498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPP1GV9z8GldTgEAu9opvQ
	(envelope-from <stable+bounces-241498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:44:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B27ED480678
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0786130E1A25
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3CB2D0614;
	Tue, 28 Apr 2026 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="unl/eBBR"
X-Original-To: stable@vger.kernel.org
Received: from va-2-27.ptr.blmpb.com (va-2-27.ptr.blmpb.com [209.127.231.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC4AD24
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365165; cv=none; b=hRbnIeagI7MFp7Z/1wW44ZxPQ9mztoPLdM1GDUJhC6QcpJHuFD3alp6u+wyhJ/pzKNVlnrSRbWb6IeDXH4jNCPclMKe/eRXusWf2cjxDqJzkH6lo/naJ00L1iusNBD3AxfKUxY7E6aNgfPokn56sHJzSfAQeYSf3ETKAol30lpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365165; c=relaxed/simple;
	bh=pIHABbnrYjWnvGwVzXPoI/1xvnAjltrRfmLWH7wlwzU=;
	h=Date:Message-Id:Mime-Version:In-Reply-To:Cc:Subject:References:
	 Content-Type:To:From; b=QgojUBAmEtX3cwiASy99X5Gp/7ZGO8i2B/IhIU28lhtFlZEW6Er7F69zKVig/+yjwqxpvq7y9DWkRsS1ShZxEF12IO+oh6ydozZ6XkEEm51jaFUfC1KEdIEraSAiCyCKchu22PtLoen7fBbxy4CqDBgyI9R2nrw+9ZcMrdB3fR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=unl/eBBR; arc=none smtp.client-ip=209.127.231.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1777365159;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=BLxleqeaahmG3ULXVbRao6S+XTlDw3HS+ySLo7Slhn0=;
 b=unl/eBBRnYMyZHpS7qeIXppSb/qpiNdntf5Efnq+78WRHqSR7V2OPb/uaUgTy5GsLJDjl4
 P/KTBgN+ExPio6qwMlZdjYeR6zj3oFRMgDJsZrts5KeLMfIOIQ8Is5hamATsIQRNpbkubH
 5cBdu+cZ/RVXf8XGUcNFvBBi+ULUlTmJgk+agScs6X8DgmfiMaU67EPSUp7YF5ek5hzerz
 iYuLOqvgHi7gUgfxFgz3aZcScBpO+1n4otom2QD0QEKKupSuY/hsdwIVQLyp59yEeJa5II
 bo/u0sCO3cwnFq40XFSvbjfUVyo0/GAnzkFiwdBq+2WS4PUHlmkhiGqPjK+Y4w==
Date: Tue, 28 Apr 2026 16:32:33 +0800
Message-Id: <282278bc-7d71-4049-89f4-a9f3968504dd@fnnas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.183]) by smtp.feishu.cn with ESMTPS; Tue, 28 Apr 2026 16:32:35 +0800
In-Reply-To: <CAHYQsXRN6uof4yyDR6qGteQ=wZTt86VUx7km6k=LbNAQ3wxGiQ@mail.gmail.com>
Reply-To: yukuai@fnnas.com
Cc: "Junrui Luo" <moonafterrain@outlook.com>, "Song Liu" <song@kernel.org>, 
	"Li Nan" <linan122@huawei.com>, "NeilBrown" <neil@brown.name>, 
	"Jonathan Brassow" <jbrassow@redhat.com>, <linux-raid@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	<yukuai@fnnas.com>
Subject: Re: [PATCH] md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
Content-Transfer-Encoding: quoted-printable
References: <SYBPR01MB7881A5E2556806CC1D318582AF232@SYBPR01MB7881.ausprd01.prod.outlook.com> <beca1657-0180-4f9b-8de1-ca7776c9614a@fnnas.com> <CAHYQsXRN6uof4yyDR6qGteQ=wZTt86VUx7km6k=LbNAQ3wxGiQ@mail.gmail.com>
User-Agent: Mozilla Thunderbird
Content-Language: en-US
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
To: "Yuhao Jiang" <danisjiang@gmail.com>
From: "Yu Kuai" <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+269f070a5+597f3d+vger.kernel.org+yukuai@fnnas.com>
X-Rspamd-Queue-Id: B27ED480678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241498-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[outlook.com,kernel.org,huawei.com,brown.name,redhat.com,vger.kernel.org,fnnas.com];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	HAS_REPLYTO(0.00)[yukuai@fnnas.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fnnas-com.20200927.dkim.feishu.cn:dkim,fnnas.com:email,fnnas.com:replyto,fnnas.com:mid]

Hi,

=E5=9C=A8 2026/4/19 13:59, Yuhao Jiang =E5=86=99=E9=81=93:
> Hi Kuai,
>
> This report was reported by me, so Junrui added me as Reported-by.

This is fine, however, please do not add downstream reported-by tag.
If you want to add the reported-by tag, please report the problem to
patchwork first. :)

>
> Thanks,
>
> On Sun, Apr 19, 2026 at 12:43=E2=80=AFAM Yu Kuai <yukuai@fnnas.com> wrote=
:
>
>     Hi,
>
>     =E5=9C=A8 2026/4/16 11:39, Junrui Luo =E5=86=99=E9=81=93:
>     > setup_geo() extracts near_copies (nc) and far_copies (fc) from the
>     > user-provided layout parameter without checking for zero. When fc=
=3D0
>     > with the "improved" far set layout selected, 'geo->far_set_size =3D
>     > disks / fc' triggers a divide-by-zero.
>     >
>     > Validate nc and fc immediately after extraction, returning -1 if
>     > either is zero.
>     >
>     > Fixes: 475901aff158 ("MD RAID10: Improve redundancy for 'far'
>     and 'offset' algorithms (part 1)")
>     > Reported-by: Yuhao Jiang<danisjiang@gmail.com>
>
>     So again I can't find a report, and Reported-by usually should be
>     followed
>     by a Closes link to the original report.
>
>     Applied with Reported-by tag removed.
>
>     > Cc:stable@vger.kernel.org <mailto:Cc%3Astable@vger.kernel.org>
>     > Signed-off-by: Junrui Luo<moonafterrain@outlook.com>
>     > ---
>     >=C2=A0 =C2=A0drivers/md/raid10.c | 2 ++
>     >=C2=A0 =C2=A01 file changed, 2 insertions(+)
>
>     --=20
>     Thansk,
>     Kuai
>
>
>
> --=20
> Yuhao Jiang

--=20
Thansk,
Kuai

