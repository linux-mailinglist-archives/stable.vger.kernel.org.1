Return-Path: <stable+bounces-211911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAyuI9B1eWkSxQEAu9opvQ
	(envelope-from <stable+bounces-211911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 03:34:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68C09C4F8
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 03:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74C7A300CC16
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 02:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3EE2BDC25;
	Wed, 28 Jan 2026 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPm+lA/3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0E25782D
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567672; cv=pass; b=IG71jm35D++Wnm1a1uIEZVgv/OO/PieLQDK++qNRhPQmbMHejMB+VrHBfLqO7Azu4oMFQScJqGHv2DLiDhYVP6VZG4Jj5olU3vNxBBDf0PsUN0OAdv+b+TEFCm8PZU5NLY6DnwYiUj0iD5RzSyDzdt1CWkBxwyOSG5n7ed2kxio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567672; c=relaxed/simple;
	bh=OQ9ERZw0aFH9skiRk7zXjPJIUOYGGWWyYRziXcY7ZWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcKOoqTFxiMWXXGo2qD6gc163ue+so7lH9pj2KJ2xYSOFs1NYFVsIN0q4ZIU0wRsk994WYVqAMxGa1Z4wYUHTyp6viW+XgfiXRxQ49UBgscd21nhXlNe7q40nHbNXoQjfiqUTjPD2T6qBjdeAuudLycE9LZP1ID+/vvIz2Nfmmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPm+lA/3; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso261206a91.1
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 18:34:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769567670; cv=none;
        d=google.com; s=arc-20240605;
        b=OtX8IX+Y4eTF0G4WEgmAcKS6ywEI/i36snRSC0BjYWPCP09oenuHe9PCHOKY6gfxXS
         4L0mqA8+BLkT3wFf9JEsj3FHb4kQgHZqWYURxMPdH3RLgz4Rk1qB0YW7R601CY7ZLDxN
         8Jseicpdz4UtZfba1OOEvqdoJ2BUtVLSLpjr2oytM0jNOQebP5pcldgF9sjAiEG/Grjq
         YQo2Tq/tlWz/iEgFa+nVxSn0fEWiEq6y+Mh7udrstSgraUuSfRHBzYjmkCnk4mmKJB0Y
         iDtt5X901XvKctTUotjcKXj5ULR/rPse5wlqd2AdPyLzGeBEHNF88F0SIoguraoNccdk
         IwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=dGLoE/NeejzA6sB9YstMck4e/gYW8IxT2c4DWJ+XiVc=;
        fh=aio4N3p15xzMEF4Vm6tI8pslVtakGvrl6Hhzf6obP0g=;
        b=PWBATv74N0eLTCwJhRh/HdSfCew4bq3iJWHHiVL8Ec9GksMPRpbISdnvLV6L03J9Ez
         GEacrZ5AMuznyZxDVoAuw/uZf2AKrRhBuX+DHcVtnUv14QRuwzIp3WhaVDN8u+BPkFoU
         3G/p3sshaNww9O/qrtnD9pV9UiQVQTRLgYgI9aVIBCpvRBrJb+9TUzPknPSF4R4QrFHd
         LR7WziW4fGgdn2gkorac/ylCLMoAjerB9wBpdz8e3Cp1h4Vz0cy4AKVAiLY9iOfWJ0u5
         qjyGlOl4nkrrNC4CcfiGklkbFBgneXO03tdpc9iczBL8C+ih/Lt1Xd+JtrsOicVqwZ6m
         1vEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769567670; x=1770172470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dGLoE/NeejzA6sB9YstMck4e/gYW8IxT2c4DWJ+XiVc=;
        b=bPm+lA/3eG9CMpL3S42KL6cR/RUX9wL1DLh5f9amJ5DxvZLYBUrbVip1cGiR4U6V+l
         7/DZlDVQmKrVg7YpozqnCF2lzqmuSvniGPTuMF2SnLvC2uc0yvkXpPHIeOl7f6X43aNS
         szO/P07A7PxS063eTbdchlsOIO+J/Sa0jBdYgwbnBlYVt7jXeGsQSvNL4ebRR5i+YPAi
         j4y+cBqfO5/bxkOdFnTx0SlkG5OrJR9+rgQSuGalgscMtoh2RseausgRamHsaebZ3led
         l6pEIRIErNh0gw0YKuUPEtPa+fqDDKMgnBZQyED7xarUcJ06+tVuxR3NVN8Y6Pvf4IZQ
         9fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769567670; x=1770172470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGLoE/NeejzA6sB9YstMck4e/gYW8IxT2c4DWJ+XiVc=;
        b=ShK8xpEGCye6j2UzlI98TI/ekShmZu6+yK0EO49MUHQ9CTLCjfNILONLjRWQpmEpN5
         pC2vI56AddNz4Z5s07FV0UaDgHCblT/O+KcXaIvhwR41aP6+z2yiYn7LNjtBDJjQPr9J
         mozprWiFIRmJvbv5PpdiRtIR4prfOkqWNQ7vAq+F3l/3909hmyc3iL+aLUnFlSm1y/Du
         c1IQalw136xBNYKASl10Y76nBCYit1e+kWaHoe+of/6sc4ggDz2OzJo1dJLyN5nXEDtt
         KJ06xntmklcyjZvojn3/h8CzFt7WnCKKxkxtUx+Q1o1twrJ8RrQzoBtu5+rWVMRMw7mx
         DUtg==
X-Forwarded-Encrypted: i=1; AJvYcCVh8oALUS31mhGFqLz5I+zhszPAnys28coLLwWHSxoivKLOMYOAUaA9tCj7GuX/3m1E7uY4E+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqMc91la9Mqc+ihOMt4olrhLGGILkz8pDris3stVWVxmbmP9xX
	BnalQ0Fw3kfLSgNQKWnllU6XWlaeeRZW6+40g1I/f6gvbwzOymtrs43w07+5hlzKtW3LWF7BqBf
	/lddQ0GtTq92FQIwj/zsJ0MbBi4KtzWw=
X-Gm-Gg: AZuq6aJiCBoTnA6X0MrQFEBVSh9tI5EeF27gst0ewOJH/piiF/qpnxjCO0sQDKEYQmJ
	jiPlUySTLKCB8bCIN5M+E40GMEqRM/A22DohRC0y2md1zjJ6PRYQYnTfBWuu9HZxksAtvQB1l50
	DiJ2/wAoHDZLpvdBklZkwVycrmQggQs9D36iQvUBCfN0T8TmbYuFVHXqvjHkea3nDlxcEvTuBi9
	Qjdzb67tb1iz/j7N/DxMGjy9agYpJMvUn/KS7spMSl42DTl6mbZ6HrIsIzrMyq7ur3HoA==
X-Received: by 2002:a17:90b:3a46:b0:34c:ab9b:76c4 with SMTP id
 98e67ed59e1d1-353ff78df17mr3373892a91.0.1769567669973; Tue, 27 Jan 2026
 18:34:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117140351.875511-1-xjdeng@buaa.edu.cn> <2026012631-suffice-enforcer-8553@gregkh>
 <qbuccwnfljpnxvpp7vl4weoecx6ujg3cy2lwwgoz42b3ux5o3k@mi5fxhplgrt7>
 <CAK+ZN9r+oCbSNjSf=yKQHGT9=Cqfw02J+TS3eZaUgrd=PfV7tA@mail.gmail.com>
 <2026012758-sacred-slouchy-45ca@gregkh> <CAK+ZN9pBSY1bCbMQMoOj0qNQKvEwO_j=zxLnDcA_4O9AyL+uHA@mail.gmail.com>
In-Reply-To: <CAK+ZN9pBSY1bCbMQMoOj0qNQKvEwO_j=zxLnDcA_4O9AyL+uHA@mail.gmail.com>
Reply-To: micro6947@gmail.com
From: Xingjing Deng <micro6947@gmail.com>
Date: Wed, 28 Jan 2026 10:34:20 +0800
X-Gm-Features: AZwV_QgKuKRcpsXe8dfYdrfpgo1e1IaTnMhWFeHo_x-lnpYaAwu_rh3UTSxMlEE
Message-ID: <CAK+ZN9qAbX0+VeA-6DMJcSY6wehSvOdM9NGu53wRYoM0j5i8sQ@mail.gmail.com>
Subject: Re: [PATCH v5] misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>, srini@kernel.org, amahesh@qti.qualcomm.com, 
	arnd@arndb.de, dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-211911-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E68C09C4F8
X-Rspamd-Action: no action

I got it, I'll note that this is a private static analysis tool, and
I'll release the next version of the patch

Xingjing Deng <micro6947@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=89 10:29=E5=86=99=E9=81=93=EF=BC=9A
>
> I understand the current situation. I need to record which static
> analysis tool I used to identify this issue and clarify that no actual
> testing was performed. However, I have a question: my static analysis
> tool is not open-source, so how should I document this?
>
> Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B41=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=BA=8C 15:10=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Jan 27, 2026 at 10:18:38AM +0800, Xingjing Deng wrote:
> > > I identified this issue through static program analysis. All other
> > > callers of this function validate its return value, so I believe a
> > > validation check should also be added here.
> >
> > Please don't top-post :(
> >
> > Anyway, you MUST properly document the tools used to find issues like
> > this in your changelog text, as our rules require.  Please do so.
> >
> > thanks,
> >
> > greg k-h

