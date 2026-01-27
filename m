Return-Path: <stable+bounces-211702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKdDNCwheGk/oQEAu9opvQ
	(envelope-from <stable+bounces-211702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:21:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A1D8EFAC
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C48D3030B06
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189592D63E5;
	Tue, 27 Jan 2026 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcBqqPL7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E852C08D5
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769480463; cv=pass; b=uOytzqs0B9RMJ3WTFkSihkYZztfTVABh5yDcO3uV3+sT0JqfjVRx9TayZqlED0i5HLZ8syAQ3Lu1cN7qFVuYQQ3r4l21z8D9gNyDi+KtRnyQo2Eg9ruG6SdKS95ewH/iy5hX1wlfKzSEoSHVhwCyqCVtPHNwMTjyMCCeYvzuzPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769480463; c=relaxed/simple;
	bh=2xa7t934Gp1isrMfck2AbkuEZPWsTHy8u/nAZgIxRvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTW7b6RkrjUQNHHtlVpEmLxe4JiCILi/XeitZ0X2ywzUy7XNaCCTVieN+SEVrOwd8wQ7RhCWoP3gStHK1EfCHJDq2lxjRK5KDRgc14pQ8I9UBb37GRZ2lTTTmDfAuOQy6aZTi4Q0zU9Eyev0HtyEToyf1GxnD0KVbkQ1d2c7+uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcBqqPL7; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3530715386cso4469276a91.2
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 18:21:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769480460; cv=none;
        d=google.com; s=arc-20240605;
        b=BJfZIF5lffxjqbPBrulSaH4JA8QvFFeUAlsJV2RjnBnMmqaeu5ougB/OtQvzExt4ke
         jEAN0Y8Aasom0eVV1gMQAPXeXcfL5Zf82ZgoK6eoE2xtLknM7iSicya+UUKGc47gznDe
         G9SXN3q9qjUh5d/JlnehXC+KteC7xXGGJaOWbxOKSy7p6HspHDtVMB7qGdOeCBuJifLg
         LKN8sCmip3qSDlp4iTHaYjSVHCUsgyuszE0ZT3JLdU+okrzfmarrd1lAXbsr16MUTcTX
         ExOVKA5fqs0REPQ9Jd2+C42KSq4NnChAsActohZYYsLy8NNZm97JMgFBYJfPTHR7lpjC
         KH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=Bs7nc3TMl9yGEQA4DcUMctl9Wo9oUUnAskd5ppfl7nQ=;
        fh=g+cfmsYf9xmjlR2shD6kSA1gsAteqENyqkrf2B8TFvM=;
        b=HGCJsv8+mIKxfC0mZiwtNH3nlsRN4XpWlyZ+Uy4w+VjZrLORIgzVkASuBk7xafC2kT
         H+mD/Y6wpMaPNEuhl5DWb9M1lDlcopxm3EvXicUqGYkLgBdpp0h/HQX3d5YnZeAO4EgE
         XflDG3AhtETn/unY7wHobn36Gk5ewG8c0xIdAr7EI8VIEV+X3MzkcCin3NcnOEkRnNRk
         vwGm+Bd/8uR6ZmUaocTperuDy42wHz5HPBn7JxwfoEN3vHGflZT+CxAWJm7zMxTlpWvm
         xe1A/63M0aMNFHquzlLJ2KxIPe4zUXSaf+D6UT6/X3grO2lzQZ+fu6Hi1Dra1lYGafq8
         2D/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769480460; x=1770085260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bs7nc3TMl9yGEQA4DcUMctl9Wo9oUUnAskd5ppfl7nQ=;
        b=VcBqqPL7r1TR+i9l2b6geb9l56CCyX2FNE4jOK2V7Q+oyClCJNReH1pKM7dnSqR18v
         Y0ni1STW7+4RGdFwZVt0xa+byNUkZHV2DyzJfaup756SD99C1HZuFDMb93xKSyVZbvoi
         SsxLmzeu5Y3B+z+M6Zf0HHphn2yf4VWkiGqOsK38qQewSKtir653ykOJUW6OqCzX4qA9
         qFsX/LEyLSnBtwstuSFMJ3+Td01i8wYAWRMwanxq3jpHjCZntDRwu3E0grD0hzDKJ4ac
         QoyH/ZtTt+u/kw4Gq/Bd+yIRGUS/YxsZsJTpGoZidYJKlkIIIWBbGPb6gG2s1FR01DnX
         3Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769480460; x=1770085260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bs7nc3TMl9yGEQA4DcUMctl9Wo9oUUnAskd5ppfl7nQ=;
        b=n1dWzqmkOsAt2xpjxkG/1tAufWpRWcd+ih5+loPvHuDhakxCkYKx5G2piO8vlE2lR0
         4KKF+OwNP9yUKkGkcD+KMnmglbFI23jtFFOPyd2uPjFBBJD4BlZpsN+UqzxnZA15fEq4
         GkqBoRdOyYcudMy5VO5w0Zj/GO9sW3XJzt+z59NoFGlswZY6m73wHqUE146trynB4LbT
         WTQSMM9Rhm2aDsxTuxJCbYIvhedkJvwuY76m4CeXZQgd4gdUCnQgvG4RuP6/QzXqNNfd
         wfOW52UnihUSekjCkXCGDeLroLYsGtQUNKsPGrKDRRsM4jSXGCPnN1xGCtbcCsbrtrp5
         Uu6g==
X-Forwarded-Encrypted: i=1; AJvYcCWbgGuwGJzsvaqVYDiLLbh0f1O7VAIx1pyiT/1d27r0mo9E6/6OmOW5kKEBHGmwH5c+AldAbQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1f5lD+c0Suaiek+9CTFk2IBXc86yd0Liax9lU3Abx4Y/u3OL
	bGk0fxBwWCUPal9Ka0+RxcBxXDBvE3ClTx20ZJ5wqgrTUpmfwUE+F+K2PtxuojDnAIl+VvKGyNS
	jzeFvZcRqntuJmQYsM+QAlWymRIf5gks=
X-Gm-Gg: AZuq6aKsd3e1H0RsJuVadY7yeP6rURQ3qWT4tQtxaXQLa5DjQu57hzEQDQS6/b6z+wy
	SuRMGD6DF60nLLF0loqDPnKq4JBtH68C3BBf/KfkvLTA0pKFJBIaZr+IdUhqtzkRbwR0OE2+sO6
	PzSc2B0F1DpdQeMrKinape4TgexOrayJqjcmsW2UrG2GTNQKkWhkd4RL4SsgpTol0kt3dnj20DH
	/NbP7xzHuCo3SgJt7JagUeUoWhlmPZbZDAiYqoVIc4iSUj5R6mdtbsUt6baIL2y+b22zQ==
X-Received: by 2002:a17:90b:1b03:b0:340:bfcd:6afa with SMTP id
 98e67ed59e1d1-353fecba606mr340592a91.8.1769480460426; Mon, 26 Jan 2026
 18:21:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117140959.879035-1-xjdeng@buaa.edu.cn> <2026012641-snazzy-upstate-a815@gregkh>
In-Reply-To: <2026012641-snazzy-upstate-a815@gregkh>
Reply-To: micro6947@gmail.com
From: Xingjing Deng <micro6947@gmail.com>
Date: Tue, 27 Jan 2026 10:19:50 +0800
X-Gm-Features: AZwV_QhVJwE7Qm7Ykz-J0iorTirPRq_UXa-XtAQxlc07yf4858cwfShGkNiGTLU
Message-ID: <CAK+ZN9r57ErbhCxX6hR8_G1G+eTh+UajdNftvKkUnyefYm3BhA@mail.gmail.com>
Subject: Re: [PATCH v3] misc: fastrpc: possible double-free of cctx->remote_heap
To: Greg KH <gregkh@linuxfoundation.org>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xingjing Deng <xjdeng@buaa.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211702-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	HAS_REPLYTO(0.00)[micro6947@gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51A1D8EFAC
X-Rspamd-Action: no action

This issue was also identified through static program analysis and
subsequently verified via manual inspection. I believe I have
uncovered a potential risk of abnormal execution here, hence I=E2=80=99m
reporting this problem.

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B41=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=B8=80 23:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Jan 17, 2026 at 10:09:59PM +0800, Xingjing Deng wrote:
> > fastrpc_init_create_static_process() may free cctx->remote_heap on the
> > err_map path but does not clear the pointer. Later, fastrpc_rpmsg_remov=
e()
> > frees cctx->remote_heap again if it is non-NULL, which can lead to a
> > double-free if the INIT_CREATE_STATIC ioctl hits the error path and the=
 rpmsg
> > device is subsequently removed/unbound.
> > Clear cctx->remote_heap after freeing it in the error path to prevent t=
he
> > later cleanup from freeing it again.
> >
> > Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> > Cc: stable@vger.kernel.org # 6.2+
> > Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>
> >
> > ---
> >
> > v3:
> > - Adjust the email format.
> > - Link to v2: https://lore.kernel.org/linux-arm-msm/2026011650-gravitat=
e-happily-5d0c@gregkh/T/#t
> >
> > v2:
> > - Add Fixes: and Cc: stable@vger.kernel.org.
> > - Link to v1: https://lore.kernel.org/linux-arm-msm/2026011227-casualty=
-rephrase-9381@gregkh/T/#t
> >
> >  drivers/misc/fastrpc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index ee652ef01534..fb3b54e05928 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -1370,6 +1370,7 @@ static int fastrpc_init_create_static_process(str=
uct fastrpc_user *fl,
> >       }
> >  err_map:
> >       fastrpc_buf_free(fl->cctx->remote_heap);
> > +     fl->cctx->remote_heap =3D NULL;
> >  err_name:
> >       kfree(name);
> >  err:
> > --
> > 2.25.1
> >
> >
>
> How was this found and tested?
>
> And randomly setting a pointer to null doesn't really document what is
> happening here, what would you want to see here if you were to look at
> this code in 5 years?
>
> thanks,
>
> greg k-h

