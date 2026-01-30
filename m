Return-Path: <stable+bounces-212852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAzbB8hvfGk/MgIAu9opvQ
	(envelope-from <stable+bounces-212852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 09:46:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F4FB899F
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 09:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21E90300748D
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576CD31282D;
	Fri, 30 Jan 2026 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFA6DgYZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19C2DF6E3
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762757; cv=pass; b=Dg6xKzuow2qNwDzbIYuPNjchTAV0dvk3IYVBtpWX9Jy4zYbLLTXKupjN7r4twk6v77Gwe/k990Vk9uV+xdF8a4o32rBlEfOlnAcKocxmS2QHsuahgb+dhUJP1CKncvUyZIN+4Rvij0rNy/eG/Y2mIKT2Y3VCcz1IbsmDdSW8sCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762757; c=relaxed/simple;
	bh=mDnGzrchXvJn/pw7nT0cssXOZtkYxKOWE4V2rTMp6oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4XBsRB7pZyn61g8nZ0nf7PsGpm8eocf472s6yoJY64tai4wl0bRQPS9W95kQgzQFaeG5bw3ZFmJtYu4dHdMuQ7w91voVkrsKJu3bWxtpdPooJDWGYifOqbyqAuL5savbFXGlVUdAI82fhLVP/r9/vIfZzxam8PEAv1gr0NrTm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFA6DgYZ; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so1142710a12.0
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 00:45:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769762754; cv=none;
        d=google.com; s=arc-20240605;
        b=Go7MdLvlsxuyn4K7dQCViDtTCnVlKeo717CCEvta61uPt1Da9ccRo/TTkt1DDPoPSp
         DtDa/cVDNsnYYj/xvqm3RDf/bH24AjZHJH/gNm7qsFSYwVw0Hyf+0PooDwKF4icuu3/H
         3nTLvAUiX72Rg4VEHj8UMumfKWimwTQmAy7NF8V2Q4eQIAXU262wukx0fQAlpvIxLqcV
         8hJvZAYto4HPvmlkHpJ/zJj4+PQaMOc6s99KtzeqwIlhEr4/es24s5zcUcGPF6bnxh5J
         O390HfpV5YIgQsvE8RWgIpWd7Kj939J/8jjK1xCmMmc5C/xDW+qB+Q4P9QgNiivc120E
         DnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=eEAW01z9JQWBTM10b2sP0NfwiccdN1/5P+EOzAVhSFs=;
        fh=G6a6tl+S0xx4A95AlbFrbYIqStTEE6KyB7m8s8+BFog=;
        b=RU1XgDuDJTUM/PMn4ppXeHLQJULFE+bnKzWcfV1HBvOKHLo8oK8D9rb5io4yVjTKbG
         yH+udOOIXDz1usZKtv/47hFE7z56LDEIlu3698MArS12YYo9dfSos2KQhHKWMfi8+xda
         Tc+y8yFsIHU+RtkRaCQlHheV//72o0svnOlFRC+pXTdQsGqhJzY3biiOoHkTgLCo1dZv
         tTKdeaDryd1dbijamr8e+d3KvMthDvpsmDxQNg7YaoOYVVkd1GQwYxkFIX8DkB/23ne9
         RQc0+INR4M3I/bMxYhmrtx9saymDuPqIBl1nfKLtQIP1tWqOEkp7LoFhnxwQzH9JKUxX
         ibXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769762754; x=1770367554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eEAW01z9JQWBTM10b2sP0NfwiccdN1/5P+EOzAVhSFs=;
        b=KFA6DgYZh8IMsKDxVagpfW5cDu9Fi5fkDgpVPmUkJcsFF4FfsYB+aJ19iySDE1GtU9
         t74o2G2kpHd18Z/Pn4qRAvP3RtLXu+Rkum/sOp7cTyZzyyWWcgjd9XEG1qR5fG6ElhaI
         pXDL+Kidof+UQ++2vmHAhbtOja1sCJOmVS/xwOJtl2TBW9sojUfKvs3N0IBf18w1SvKo
         J5iHQNdtF9qT569Bc5pE4AKRdI8BzbxPgeZlin2169ULJirMEbRGVujhVwmYRCnws++B
         PjiyYqFpUWoX+o8osH8ujgace+01gyTy4oh//HZNm15jLSeoFplwYSrBzZmhKRc2oqyV
         CLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769762754; x=1770367554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEAW01z9JQWBTM10b2sP0NfwiccdN1/5P+EOzAVhSFs=;
        b=BfwxWWJN7Pp8zt3DHTwq1HZVZ9iEYwtSWkgtjwRjshYgnWKE9aGiEBDHmY3uajVyl1
         wWl90PoB+fC6ok6dPLX7R+N15DJHQN0tN56EZojERxXInipaAAqAPQa6hj4gUqYq4mNE
         X5FGv0wKVnYSsrpL0knX4ZnLcrnrhmoTctFLyiyscPk6p8Em29hV2w1m4rx8708hnphF
         LfKSX/P+doUdIA91h2Qh/vn9KVvqO9fKPTQyy1B9JCq8BFFae+2r4lap8FMSJITKIWp8
         0GqO9AEyxLiZnhgPQvdMw8ztixWCOAT/a+oWcTUSrz7njsgiIBtB3M6fICEjJLuTqtIr
         ToSw==
X-Forwarded-Encrypted: i=1; AJvYcCU0R4gBmtRydb9mlBRag1ecvgfZxB0RF8P6YQrz8nk7GcQqrCfw9giOFsM+I7gMmA1cfutKYpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRbwzlpNAJnj08h240oUoNaYcvlkelMxMPd6lfmYLWvuDGUoGm
	YBYYGMBh9cJc+3sE0XKcxby5M3Cr9wVl+sFDakb95Wb9pPhBdYT4a66DLHhGTzO3Ln2h2meGDiK
	AngxuNEs6pDkT3BzNdPO63ndzeU6FbxEP8FZKgHvgD4NpsxE=
X-Gm-Gg: AZuq6aLJJwXXCaabI3T9BazFlYNsCetaWcopWU1nz0b7rqJcZjsIRcpGxY5vqZAiUfY
	aUohTit42qdohZQDMr+WYB56JWeoJdIfs/e81U+1OSSb2kwQ7FMwEvB+JqZ5KmzT59MyIyZTArB
	pksbMHpVKy9HCvKFXuoaNRACD0/v+0/ET9qyCGTkRhlwiiA8Jph3R9Qv+n9uM/3vYHGH+f7jTzX
	TE05gJG7vcUEY1596PE6j+oyuZvlJC5lYISZYCzbSyvWmoipUk+lOZfWKlVS10/n/jeYkSOveCi
	bUwnWggO1G9oBtqo9Hd5P6GAB6jp
X-Received: by 2002:a05:6a21:a42:b0:334:a11e:6bed with SMTP id
 adf61e73a8af0-392e0053615mr2227722637.29.1769762753855; Fri, 30 Jan 2026
 00:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129233703.407404-1-xjdeng@buaa.edu.cn> <ie3hipmp5nqappyuwnxm2kpgscnl6qe42cwf2sep4inwunb5th@gontu4foua6q>
 <CAK+ZN9oaUh5PPBx5QPCya=hqDM42CQptD2-MrJvMZsypNuZ66A@mail.gmail.com> <4rfalipp5xyejwappzi5gny4muetuzrr2q3sunctfmsvb4juwf@64kdxjrakr5q>
In-Reply-To: <4rfalipp5xyejwappzi5gny4muetuzrr2q3sunctfmsvb4juwf@64kdxjrakr5q>
Reply-To: micro6947@gmail.com
From: Xingjing Deng <micro6947@gmail.com>
Date: Fri, 30 Jan 2026 16:45:43 +0800
X-Gm-Features: AZwV_QiaVUxZYp2r3LsMEsEBTrYjWrRMw1lgAjNb8iVpASaAPEQ6nzSN-ssydZk
Message-ID: <CAK+ZN9pDpvf+29quNptrMKoti_E5m36XHZJP125ctZmBk2w3sw@mail.gmail.com>
Subject: Re: [PATCH v7] misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xingjing Deng <xjdeng@buaa.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212852-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[micro6947@gmail.com,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	HAS_REPLYTO(0.00)[micro6947@gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: B2F4FB899F
X-Rspamd-Action: no action

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
1=E6=9C=8830=E6=97=A5=E5=91=A8=E4=BA=94 12:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jan 30, 2026 at 11:07:38AM +0800, Xingjing Deng wrote:
> > Yes, I found that.
> > I will release patch v8.
>
> You have been notified once already. Please stop top-posting (aka
> responding at the top of the message).
>

Sorry about that, I just replied the email directly.

> > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=
=B9=B41=E6=9C=8830=E6=97=A5=E5=91=A8=E4=BA=94 10:38=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Fri, Jan 30, 2026 at 07:37:03AM +0800, Xingjing Deng wrote:
> > > > In the SDSP probe path, qcom_scm_assign_mem() is used to assign the
> > > > reserved memory to the configured VMIDs, but its return value was n=
ot checked.
> > > >
> > > > Fail the probe if the SCM call fails to avoid continuing with an
> > > > unexpected/incorrect memory permission configuration.
> > > >
> > > > This issue was found by an in-house analysis workflow that extracts=
 AST-based
> > > > information and runs static checks, with LLM assistance for triage,=
 and was
> > > > confirmed by manual code review.
> > > > No hardware testing was performed.
> > > >
> > > > Fixes: c3c0363bc72d4 ("misc: fastrpc: support complete DMA pool acc=
ess to the DSP")
> > > > Cc: stable@vger.kernel.org # 6.11-rc1
> > > > Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>
> > > > ---
> > > > v7:
> > > > - Add the detail description of how the tool detect.
> > > > - Link to v6: https://lore.kernel.org/linux-arm-msm/20260128033454.=
2614886-1-xjdeng@buaa.edu.cn/
> > > >
> > > > v6:
> > > > - Add description of the detection tool.
> > > > - Link to v5: https://lore.kernel.org/linux-arm-msm/20260117140351.=
875511-1-xjdeng@buaa.edu.cn/T/#u
> > > >
> > > > v5:
> > > > - Squash the functional change and indentation fix into a single pa=
tch.
> > > > - Link to v4: https://lore.kernel.org/linux-arm-msm/2026011637-stat=
ute-showy-2c3f@gregkh/T/#t
> > > >
> > > > v4:
> > > > - Format the indentation
> > > > - Link to v3: https://lore.kernel.org/linux-arm-msm/20260113084352.=
72itrloj5w7qb5o3@hu-mojha-hyd.qualcomm.com/T/#t
> > > >
> > > > v3:
> > > > - Add missing linux-kernel@vger.kernel.org to cc list.
> > > > - Standarlize changelog placement/format.
> > > > - Link to v2: https://lore.kernel.org/linux-arm-msm/20260113063618.=
e2ke47gy3hnfi67e@hu-mojha-hyd.qualcomm.com/T/#t
> > > >
> > > > v2:
> > > > - Add Fixes: and Cc: stable tags.
> > > > - Link to v1: https://lore.kernel.org/linux-arm-msm/20260113022550.=
4029635-1-xjdeng@buaa.edu.cn/T/#u
> > > > ---
> > > >  drivers/misc/fastrpc.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > > index ee652ef01534..8bac2216cb20 100644
> > > > --- a/drivers/misc/fastrpc.c
> > > > +++ b/drivers/misc/fastrpc.c
> > > > @@ -2337,8 +2337,11 @@ static int fastrpc_rpmsg_probe(struct rpmsg_=
device *rpdev)
> > > >               if (!err) {
> > > >                       src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
> > > >
> > > > -                     qcom_scm_assign_mem(res.start, resource_size(=
&res), &src_perms,
> > > > +                     err =3D qcom_scm_assign_mem(res.start, resour=
ce_size(&res), &src_perms,
> > > >                                   data->vmperms, data->vmcount);
> > > > +                     if (err) {
> > > > +                             goto err_free_data;
> > > > +                     }
> > >
> > > I think, checkpatch should warn here about unnecessary braces.
> > >
> > > >               }
> > > >
> > > >       }
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry

