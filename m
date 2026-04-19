Return-Path: <stable+bounces-238622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JL4bDrpv5GmVVQEAu9opvQ
	(envelope-from <stable+bounces-238622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 08:01:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A34B42335F
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 08:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 934C7301E236
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 06:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED372E6CC0;
	Sun, 19 Apr 2026 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbHbGZUU"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9612550D5
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776578485; cv=pass; b=by5Wyjyo2SX/ihSLH3gSRTeFgw/PpQFEaFT0Fc7mIC8eNJlkeO+gw5SKEieL27dt2a/8WgtjQaTz2ffEqVGhwlZyHl+S21VUDQSnVfKecaV/L2G7v6U6aObV3fWWPxWDMHhVhZXVJkXskKIldYfnkUjopVaYMMdy8qdmrBkW4OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776578485; c=relaxed/simple;
	bh=d56nFxj1OEEy39F5pNR83gTlNRPndNRmNBfo9C84aoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HI9ajorLpQhiICuoMtZP7ua6rPNEyYqFPnXkyAaQp4C9lqSSJtlYNH5XwC1N/LzGW/UYnwWc4I1jydDjvAQS5gBmp0S9ZG2JdY0H2Mh+Tpa8ja8tX89H2IJaALgolAj8dt3nLcrqjaIBen+fuvmIcEGBil3zzWmZS6mQQdWneBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbHbGZUU; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c1a170a50so2414003c88.0
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 23:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776578483; cv=none;
        d=google.com; s=arc-20240605;
        b=CfGY4Mpg3tWa08rvfWAuAg3qZ/wOpOpiNE6iFNgf58I76pDCHOt+svSeTf91Lx7dWv
         Sz0vthYeSNkem//wmNlRdDEKxyRY7FyGQYC4ETX+UK8D9PPhuwdF6hWkpLHeBYKZTITM
         nEbMllYjtOap9IloSp03BU7onMT3eiHTxW9PruDsTxT0e4h7LdHg4Zm9y119W8KQTBFN
         1xYX6dFGeprz9z/67CAZ/F1OHmqkxpKhFWPPdfSJas5UrsXvt6B+cs249DujiCbbaJ8a
         nO5siH+uMMFub6Jx5oJjflHnhws6EWGxZ9wl+FnTfGBTduON+JIWrIrGCNpnFJ93Djzd
         /gqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qnhQK5ByAky3Pfxls7vffmaT8Yl8W5R9qQ6SoWstULU=;
        fh=+G4KM4N3FhtSILiqnfMAfr7xyeNb9dxS+P84v0Da08g=;
        b=QjfIdXSQChq2rFUegnYsKU3EpYargAE+uFUtcs/q34tGC5UKyrYccYrM1aV7fm3StE
         gET6yWGHaNeUh+Gex+eriwqTnnEq0gEIwSHn0ldLq/KqTaY0N9z/JlVEF0hsUsY1Huxp
         U+w+Idjhe4vW1cr4ZFevVxJh5crmOs+vWCEWiSc4ivAKS3aAH8XPmXlTboVnvJU0m+Om
         FFihX201OR9ad88e4bopzU+1aTYXIq5J/ys4SpZgrt0icksbHHuYmBoCatV/i0F+/g2j
         h+VDa/A6ej2frrl5KiZuqi6ek5dUb+q0ktjflRJ3NccPqO6Ox2Tl6xcXzBjFPZtStGB8
         qL0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776578483; x=1777183283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnhQK5ByAky3Pfxls7vffmaT8Yl8W5R9qQ6SoWstULU=;
        b=JbHbGZUUvgQ++jCW1lsHWbqex7yZTxLk955yXc0c0LODRTdamQ0Gaa8aOWOFE1uiFn
         Kb5RsNL8UmTi1QUpt0ZJEkKOgMPNukKbDSDJlc3KzM2nJwubwqvY7bfToLWdxbFb8c1V
         /VX1nhIb6/n+cx7TaZ94/C6/0kVOpZu0mAv9br00PYn+UEZDbIpOu/Mx9744waJgqWR6
         3d1IbIorvqXxBjSNtL5B4LMgY5jazbYF3ZGUmt8aGtHIa/kVtfJwCkL6gvh85LwxicgL
         Z+Ut/wBWAlavVWtV6NW+6JkHjz0quSf/zarGaqZlaLkmw10LrXzSTe03Vm6fknt67NcT
         bgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776578483; x=1777183283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnhQK5ByAky3Pfxls7vffmaT8Yl8W5R9qQ6SoWstULU=;
        b=BmOicImMbC/Fus2XizEYBcO/PGuaXJbvFkAhhfuqJ4CN8wklFovZLnQwy6PLjz12ym
         GPDUjOrPJVJalo1ASxiqfczmkGeZx/D8JHEkQpFBBUhSymgpI8cRvharYvd2N/Fv9jx6
         0tJ/xymxQANexzEnYa47zet/3tIb0f7q/vp66cBeFhDXrTIEy46p520KX3I8HeD/gKhM
         rLP4drx2p0oA0/O1ov35dD9YNJB1yYVt/d0HlW6wX7hqlD4dLP3EJBIbr3IKLqxsiU6D
         8IU7tq4VOt3AGrQK2WI/0InG238nPDZoQpaCmGXXpRUlAH+GHEC2NvV46KyvxJT8ZhNL
         TX6A==
X-Forwarded-Encrypted: i=1; AFNElJ+hNmy6uZkd/WbC6+J/gdzUJoFfe6kPSZEXGNdNagT8Ot/+FDyYzar9xcyWflXgjr+n6vY/ECQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDcAEXmGay5QyuCkWINY3vB9BN0Xh8BxWJyE1RVlHHCDOQaRQ
	EmoLXtsUPJPR9KpqEGxqBRPX/BYeRvUDIjjTOThzZEPeLja4kgxfJze9c75iIQl4JiGy4q2vecg
	2AGSrANgQpH3YHTb09CC9N7LO4ExCmBaEGzEbRXoINw==
X-Gm-Gg: AeBDieuw6T5W1MAu2eN0TgbcmqVXomRkNqTr8uUH/FecR1c/9usBnJkua2LU992fGts
	5ES0kwUnBPvNm4ymsFSNofgDMFBsvafAKRAr572svBtak1LBtrzllc2RkgFzoGEVwxNpmDBnuAd
	qBeOiFOeC4ja4W//2zMD7o4kUUEvt1XcmNiRv9FGrp/ztNlDS9o9RvOYBedhIDJxJVCsFW5OU4Y
	MsdTZSllXSkDwh3gvlFTl/8fZrTCigoX9Kf6iQjIOnnvaQnbLgYjctNq6ELlxIcj1ZXdHcpBXvx
	rQZuFSlS9cR1o5yHVunccK7k4Ht/ljgf0usCtkNtD0BPqJ9AGw==
X-Received: by 2002:a05:7022:6b8d:b0:12a:6a64:81d9 with SMTP id
 a92af1059eb24-12c73f723aamr4145769c88.13.1776578483008; Sat, 18 Apr 2026
 23:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SYBPR01MB7881A5E2556806CC1D318582AF232@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <beca1657-0180-4f9b-8de1-ca7776c9614a@fnnas.com>
In-Reply-To: <beca1657-0180-4f9b-8de1-ca7776c9614a@fnnas.com>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Sun, 19 Apr 2026 01:01:12 -0500
X-Gm-Features: AQROBzDQnuuVEq1d1mA8mMvGyABGnSmWWnn8TcqeJbrCApmUyEZjtQBRIXzxsxI
Message-ID: <CAHYQsXTsX8S52pSbSHAN315nRrNNQxrY2bH80c7dPfhSoS4uww@mail.gmail.com>
Subject: Re: [PATCH] md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
To: yukuai@fnnas.com
Cc: Junrui Luo <moonafterrain@outlook.com>, Song Liu <song@kernel.org>, 
	Li Nan <linan122@huawei.com>, NeilBrown <neil@brown.name>, 
	Jonathan Brassow <jbrassow@redhat.com>, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238622-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[outlook.com,kernel.org,huawei.com,brown.name,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danisjiang@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,fnnas.com:email,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A34B42335F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuai,

This report was reported by me, so Junrui added me as Reported-by.

Thanks,


On Sun, Apr 19, 2026 at 12:43=E2=80=AFAM Yu Kuai <yukuai@fnnas.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2026/4/16 11:39, Junrui Luo =E5=86=99=E9=81=93:
> > setup_geo() extracts near_copies (nc) and far_copies (fc) from the
> > user-provided layout parameter without checking for zero. When fc=3D0
> > with the "improved" far set layout selected, 'geo->far_set_size =3D
> > disks / fc' triggers a divide-by-zero.
> >
> > Validate nc and fc immediately after extraction, returning -1 if
> > either is zero.
> >
> > Fixes: 475901aff158 ("MD RAID10: Improve redundancy for 'far' and 'offs=
et' algorithms (part 1)")
> > Reported-by: Yuhao Jiang<danisjiang@gmail.com>
>
> So again I can't find a report, and Reported-by usually should be followe=
d
> by a Closes link to the original report.
>
> Applied with Reported-by tag removed.
>
> > Cc:stable@vger.kernel.org
> > Signed-off-by: Junrui Luo<moonafterrain@outlook.com>
> > ---
> >   drivers/md/raid10.c | 2 ++
> >   1 file changed, 2 insertions(+)
>
> --
> Thansk,
> Kuai



--=20
Yuhao Jiang

