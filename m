Return-Path: <stable+bounces-250444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKTRGz8QDmrB5wUAu9opvQ
	(envelope-from <stable+bounces-250444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:49:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F75A598C3C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AC9332C4E60
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE633A3E60;
	Wed, 20 May 2026 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGEVYHYp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E636F421
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295429; cv=pass; b=EaOysJaL9aWnD1XpbtzJaMQquLki909oXzOQirREwIR+yCEW83xPL64jI5jHBpCee1DqiTgpT1CxPHOT3vmhJbcFKGfPWaZksixrmxwnVNN4Dx6sEL1HSsamjKTJoGS7ud1JLx5L9FaUTpq9QYg5KH2PsWfhR/qT/a4qS2gUStk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295429; c=relaxed/simple;
	bh=K0SmBd3i+Evg01AmybdJImEVnXbgwxW02OAxKC+QiMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCUIHfKjHtnH3SbA7ptYd6PGISuvXue8y8t7mtNPJt1jkskNJCU/WLUtRDcAnLmeScgIDT9+E6tdhseP6Stuils1Izmu8dsHRy630IwVumRs/J3uCriQnYOuxbldZiwNeRtDlytmSN4BRhwiyHfDnmPtJfqxjhHQgZpmyRIGTsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGEVYHYp; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c1a170a50so6446273c88.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 09:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779295426; cv=none;
        d=google.com; s=arc-20240605;
        b=W+96nrYmE6thsJwTSpFpOql6KUFY7aw+/EdV2bSX6u3kB/Ebh6XHmFEjDHB1zzz7oc
         gGjXIRLMj3pFmOcwKCwfsVWxxq/xJBJn6ed9lQ+QnH7bHVbDzpMqDgN9jzuGqnwsp0bv
         To3keU6Z67nBJxOo7pja7Cs9uLtM2KQISersJSW5/V34nnFFNADgCeEm6DUahjF4Wcos
         IxOuqgewT4XtQQ7PvUJiNnrTuCoiEBggQftWswbDLbtjlLSvyorM11mqmSMRXaJZUavY
         7YTnQnohtZE4ZUJlamknjuuGe99C5haMHG0TF2jrnhjqMGbGMOpKsieuKpbX5KoWtFwp
         Um9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=awmx7wqZavYrfGTB2OHvccP0wAddCGzaOcms0KgYzqw=;
        fh=tFuhktYGRSerdBNe5jaX3ULO7sZw4Jq0MK/A2kh1HJc=;
        b=SctFqqTDZuZtFlD36ka+ICFr/H4tknvvdRAl+JSjciT8FEqCXxuwxea17dyBRxibGv
         XTr1c6NFBXaVzbEMcdKzJZJldsmR+qh2lSwvJoSLYwJtrHy/Y7aqxfXBg0hil5j9kib9
         gQQ+wyeifa/3iWeRuG2HBXcHYBvWLZTxLvIRRV3r6Q+TREZMAQPHbnGdIQBfNN9yxMQL
         4/qX2yEWOsTAysKlzFXkk8aGb54yxTQrxOmpx7t7TCvnK0mTGZSePWIwuf8zyWnU8L6i
         5SkTL3x2OWuNFvEZ8mPdWNSqpMMDneE7Wd/tA/101azrQHPQu7hG4csG+wnK2Sx6yu9r
         zWyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779295426; x=1779900226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awmx7wqZavYrfGTB2OHvccP0wAddCGzaOcms0KgYzqw=;
        b=XGEVYHYpEk86uK0aEWdS6+bAG1fijNZQXwmdqVlua5G5j1OIoTFS/OjXfmBzIypqp2
         Wrth8ovNUxl0n1ymgTETqkTlwcKPmWGYxLDpRnmZ6yilRiRUJCqvdiYPFP6CPgNBnbCO
         MKshDq0weY7mpUA1xjx/ldIjyFMRUtoU71GQUiHGmX/GevzzJGBnhGVrq+utrBOP49be
         F9e3f1+d0uu/ZxVJOcyd6ZxpOcTb42vVDeDNj/ug7MyVg8JH0tiNFdfj6Va9vSDazvmD
         AsDDYCk32PBb9ZNo8iF/ONW5OAkt7P0PSCLyVRZDcVZGpFJ3nJTiapTZRbJNBtNLk9Gn
         QLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779295426; x=1779900226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=awmx7wqZavYrfGTB2OHvccP0wAddCGzaOcms0KgYzqw=;
        b=ogYx9lKywEh+R34BrNKQjWxA9mtHV2G4A8MozTPALnPoNE4Ys7PxRhgT8fzuIttkmS
         cGWbNhbv6s3AlNOZgSliPIOA1grTZ7AlPpbRtybGXG3ZaVFnQt+clKMlNxdYd2zqIrSA
         DNMDdLt3oiiGreqJ2DJlN82La5tGLkN/AdY0PgM96/56vglRjzrupKd/z8qVAzEvWCu8
         I9PiuLy5BVjMmWIS0C2/M/3DJO89aDme/nmwvBtVchxAXGmR7f6Twb1tpyAaN274DTsD
         0GGDVYv8e644C7UJOD+1Fs/VbyGr7u4VZHeR32/YE8sevClXdqptNpg44xUAQEHx5Q7k
         /UQw==
X-Forwarded-Encrypted: i=1; AFNElJ8YgsiYd8aFReBcfCZG0+h7yLPtClrIyx9ZCYPeaFc37Z8Qub2Orr4Sg3CVoyHKdFCNL4M07MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmdTtxJ74BtjP7KM3MdgiGAXcWzRtNm+mIs1SBlbCTyuaaHSw
	aTlp5x3jWbvkWsXNkzx9kda3im2REh7fGVE0oT2FNYMlE1LXblX9kYrNCaL45HbcCcnLY8cqV9w
	dNO0Ny1WPYL7kUE8N8DRR2y1UghSN288=
X-Gm-Gg: Acq92OGJrQiVCdMC5BqpTZuHlrJfnwCNaIoTGt0Zh6/XJB0BXfFGJjW3T7K2+ZmcHXr
	eSC67bOz+9r8w5QoQmJCwsxaEB/S7ywIMpTNMUmqUgtczGC8EW+cteKcoLNZOZQhCe/AnJP6Mnb
	Z+FOkbuSEfLE55NoGhBrV7Ki2k+lROTasSLjujYKi53N83604ZtdIksPMY/b3ctZlc3Nud/mb/+
	+Ct08PgtotIzcW9xp7iF/RCWn9MIKLbOev9erW7pAc81Re1YEO8YURaSeoSDPR8eqo5WDHTwGCK
	JzJpuVmiFzscwp1iOm76XlMSXU6jslF66dyPDEGtmPrwSNNzfsw=
X-Received: by 2002:a05:7022:311:b0:12d:b396:eaed with SMTP id
 a92af1059eb24-1350440ae04mr11257475c88.9.1779295426034; Wed, 20 May 2026
 09:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SYBPR01MB7881A5E2556806CC1D318582AF232@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <beca1657-0180-4f9b-8de1-ca7776c9614a@fnnas.com> <CAHYQsXRN6uof4yyDR6qGteQ=wZTt86VUx7km6k=LbNAQ3wxGiQ@mail.gmail.com>
 <282278bc-7d71-4049-89f4-a9f3968504dd@fnnas.com> <CAHYQsXQhTn905RGCrw-qeb--VHsRGR2KEWm5X0ZJEW+krTJaNA@mail.gmail.com>
 <6224b47c-9a7e-4bbf-90ce-4b98691ceaa3@fygo.com>
In-Reply-To: <6224b47c-9a7e-4bbf-90ce-4b98691ceaa3@fygo.com>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Wed, 20 May 2026 11:43:34 -0500
X-Gm-Features: AVHnY4KDm-qnXxJ9KW6U_J1BC5ffsE8cI5knCTNO8d5QEmcndtCLxjNThpU5ufo
Message-ID: <CAHYQsXSy09tmOKok3O-PqJqVKXBFMZB0M4E=s5AQbnbdagCLQg@mail.gmail.com>
Subject: Re: [PATCH] md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
To: yukuai@fygo.com
Cc: yukuai@fnnas.com, Junrui Luo <moonafterrain@outlook.com>, Song Liu <song@kernel.org>, 
	Li Nan <linan122@huawei.com>, NeilBrown <neil@brown.name>, 
	Jonathan Brassow <jbrassow@redhat.com>, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250444-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[fnnas.com,outlook.com,kernel.org,huawei.com,brown.name,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danisjiang@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,outlook.com:email,fnnas.com:email]
X-Rspamd-Queue-Id: 7F75A598C3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuai,

So in this case, how should my name be shown on this security patch?
Because I reported this bug. Most maintainers added my name in the
reported-by tag.

Thanks,
Yuhao

On Wed, May 20, 2026 at 6:52=E2=80=AFAM Yu Kuai <yukuai@fnnas.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2026/4/28 16:37, Yuhao Jiang =E5=86=99=E9=81=93:
> > Hi Kuai,
> >
> > Looks like different maintainers have different rules. :(
> > Can you send me the patchwork resource?
>
> Usually just a link to lore url is enough.
>
> >
> > Thanks.
> >
> > On Tue, Apr 28, 2026 at 4:32=E2=80=AFPM Yu Kuai <yukuai@fnnas.com> wrot=
e:
> >> Hi,
> >>
> >> =E5=9C=A8 2026/4/19 13:59, Yuhao Jiang =E5=86=99=E9=81=93:
> >>> Hi Kuai,
> >>>
> >>> This report was reported by me, so Junrui added me as Reported-by.
> >> This is fine, however, please do not add downstream reported-by tag.
> >> If you want to add the reported-by tag, please report the problem to
> >> patchwork first. :)
> >>
> >>> Thanks,
> >>>
> >>> On Sun, Apr 19, 2026 at 12:43=E2=80=AFAM Yu Kuai <yukuai@fnnas.com> w=
rote:
> >>>
> >>>      Hi,
> >>>
> >>>      =E5=9C=A8 2026/4/16 11:39, Junrui Luo =E5=86=99=E9=81=93:
> >>>      > setup_geo() extracts near_copies (nc) and far_copies (fc) from=
 the
> >>>      > user-provided layout parameter without checking for zero. When=
 fc=3D0
> >>>      > with the "improved" far set layout selected, 'geo->far_set_siz=
e =3D
> >>>      > disks / fc' triggers a divide-by-zero.
> >>>      >
> >>>      > Validate nc and fc immediately after extraction, returning -1 =
if
> >>>      > either is zero.
> >>>      >
> >>>      > Fixes: 475901aff158 ("MD RAID10: Improve redundancy for 'far'
> >>>      and 'offset' algorithms (part 1)")
> >>>      > Reported-by: Yuhao Jiang<danisjiang@gmail.com>
> >>>
> >>>      So again I can't find a report, and Reported-by usually should b=
e
> >>>      followed
> >>>      by a Closes link to the original report.
> >>>
> >>>      Applied with Reported-by tag removed.
> >>>
> >>>      > Cc:stable@vger.kernel.org <mailto:Cc%3Astable@vger.kernel.org>
> >>>      > Signed-off-by: Junrui Luo<moonafterrain@outlook.com>
> >>>      > ---
> >>>      >   drivers/md/raid10.c | 2 ++
> >>>      >   1 file changed, 2 insertions(+)
> >>>
> >>>      --
> >>>      Thansk,
> >>>      Kuai
> >>>
> >>>
> >>>
> >>> --
> >>> Yuhao Jiang
> >> --
> >> Thansk,
> >> Kuai
> >
> >
> --
> Thansk,
> Kuai



--=20
Yuhao Jiang

