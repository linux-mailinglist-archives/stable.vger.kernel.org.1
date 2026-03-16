Return-Path: <stable+bounces-225518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EPdL2bWt2kwWAEAu9opvQ
	(envelope-from <stable+bounces-225518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:07:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB94297ACE
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4BCD30041DB
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEB23822B5;
	Mon, 16 Mar 2026 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfKWq6zm"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C4352FB0
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655650; cv=pass; b=ZJZGMkYBCSQ/MV59yoZPb6GAzyO2TJe5QNoUmBv/hrWkBOJLPVg78Y/PEd5gtPT/bBQf5GyuCbLA/7gAkcc7xT9PwiALntKa97EFL54PxDCLiWsMgaTGUIFkGBrzy8+d7KdcLl0n/A4oihFuYF7290pDOhV13trNAvY3O/FoRQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655650; c=relaxed/simple;
	bh=70JyO49uy89Dc6xapJeJ/Zy2ULUXX9jDSahUfvKIpEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dzd8gXdgkS8aCP780RC3SAVIISSyjWBizznD4K1tkBxP7XkUbK8RRv1lt71ZfCH2gKd1kwCXTKz+jPu+P6WzrMjWD8XLAUp+2pDUvhv89kDsF6IBIJQUPtdLTf+A69My2Voyl/XXR7S4oTPWyCMe41coPfz30zvmPTFWvOa0cu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZfKWq6zm; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40ef10ec84cso2980267fac.2
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 03:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773655648; cv=none;
        d=google.com; s=arc-20240605;
        b=SuSsof1zJSpO1yjdEMBKBWZzxsED1tvB769DcZsH+JAM459Yz8c+8nb4TA6H1Kf/g1
         TdcHB5k3j6ukER6cmCMQ19haH2408HTcsxjkOY2I4IhQIdsCfmQ6c517CfnUk364kwF6
         GDlExQrOw7mPUmiuaHla514uxtFFNv839cuYwhaAHAHVWExbLowBqiA4FJJttt26c8cj
         ld3cx0vWS+g5G2V1ixTbfIJUxddNPZ5FltwO4rv4lgSOgcJ2TDnNFMrfpYJubVDP7oQ0
         UZ76yjxGd0lTscVw7BHgMhcVUc+U/g3CD7olRMsIew2gCXqK8mZx8x7Qyk3is3dx3kYc
         ofug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y2zyurP7v+oHUkH4GMF1iYf/F8XUHnDZsXTn04hLCcY=;
        fh=Zj7J6QZACUl3GL0k0Hj0R/UHkTJ8BIc44IPxI2SGTeo=;
        b=WaaHmk6/0k9HHXKrWzX92dpvU4R8FFr53IInuwlQ9ne6HKf+oqSnKF7DNtAejvH7oE
         QtmPPWloOwxoslGG7PyHJByDWyNq39cW/9SggNmSm0MtlZkb3tKuZ+6Rlp+ez84EQ6L3
         mF/YawTvmYY944Yvge5BZIH5XDkb9ajkSpEIUU2XDck45eafphdfnXJtqrnw35gjtzcO
         UbXOAOquqwH5vUgCLxoY3Jb5wJ/cVqcBIEXSdAPaz+0jLY2b+VFQRNagw+8OlCCSw4Hz
         snmHQf714OcaQ+zomBz0aXR22ZCtzwjPl/I5SMMYmkgWpOLmzSqAsEv0zr2kYDiWvD20
         MDHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773655648; x=1774260448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2zyurP7v+oHUkH4GMF1iYf/F8XUHnDZsXTn04hLCcY=;
        b=ZfKWq6zm8gpHFY4CVj4wa290Nm49i57awYZOhiZaOkgWRRw4MT7huxw+IE9stormqW
         WMwVWsxlZRAblswti+dQlyCGvyYRW8lGlIEeEjDsagAFhngmUApWHZg992JDHTCmKxQb
         iyRaRPDaQhMx5at7V0TbxOl4exmrb+CbDULJRI0D//jRYcYs8TL478YqENrFQCpKqFLC
         ZFeuwcmebcGaEyObqu8lfrtEjAWk8UfTJ6nZpAQMMuNeiNW79PuKCyHi0hO2uBEvzRAS
         aBXtNG63MhMSfh/eW0bm7Dqxtar9khwV931CkBU2+fQmM4PDW99ORNRf1Sp0v0cVXoRH
         4daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773655648; x=1774260448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y2zyurP7v+oHUkH4GMF1iYf/F8XUHnDZsXTn04hLCcY=;
        b=rcwTw8CpsQBrfIvTsVJ8kDWc6Gnek+acZvbwDKu1b/HQEjhbqRatfMQY6O69eaLvGz
         66+a9HmMsOPLVxwuPgSgzmGMPggWcjSdIqCRWuhvsyrwb/hVYwagQqcd0pRLtKQYiVWw
         LLftEj6MMVpjwNwlh7EhRYnRuN0Kv+mIRqDVnqH2INHtxTucoLKk5mlrs7W6Cfn4p2jC
         P4hnUklCAzhZJCMoWtdq1Bb/9lpBRpikHG1V4u8ZeUdufVsu2IyDj8cUV46KRgIRCxEu
         w+IaGGH78sxgwcRub2W5gu5UcyXmb+0k3acYYpWWFLJ+NHT9PylVgDg2cIO3ZYt8bKOL
         +C+A==
X-Forwarded-Encrypted: i=1; AJvYcCWS/YW07j68P2iqqf8bMnUs3DwATP1igKeua+BC/jAqVJtec0uewj1GtXY6C16NcqEVeVpmfAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjFcoK7NwbczWwlkBNBf5FCF62NoaburGu6kOMcKBfN4KeKlzO
	f2qhGdHHFCO7tKLbiwy+gmdRf+ccraUPuyYeA9d9Pm3ipkQuqiiqh/Zzf5Yjzh3bYONLqtQ9iVP
	dPqCBB735YpPeB0tfLeLzHk8vURm0bujboOwIN3FToCFKdDi5wzdgkV4K
X-Gm-Gg: ATEYQzyd7w4WoI34UoO+vIqhXtwLJVjuAJ9TJQUHMVh+AnPgIHTg65jrCyMN6+oNwNd
	WYs5JtvGEmM37CLOuHdbfSGp6IK7wMf2/cmgzJH1eG+MO0lCExLPPaOiBp+1qn9TLMMCN9lEAxH
	bo1nlYmv1F/krl5tm2kGM8L1nofu9oQj5YiTR0on3VbsyL8stx18W2XJ3TTANu+OR9jJRVF4cRg
	4V0kbJg5bKhpM0zXQTJZU112PhZ4fWbhA/ROkUxnwufr85RF0Mnf156q5FG2x8Ea2ye7IM6Ky5p
	TR97it598p1/k1VuCuXCuWYYgSS76hKpwRuo2bXo25TwiYIZEXjttWfw0HoEbbuOgv7DXIiVxbn
	2USQR
X-Received: by 2002:a05:6870:6589:b0:404:15e7:b86c with SMTP id
 586e51a60fabf-417b906d0femr7004842fac.3.1773655647656; Mon, 16 Mar 2026
 03:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216173716.2279847-1-nogikh@google.com> <20260315121855.GAabajrw3ajExgb7kv@fat_crate.local>
In-Reply-To: <20260315121855.GAabajrw3ajExgb7kv@fat_crate.local>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 16 Mar 2026 11:07:15 +0100
X-Gm-Features: AaiRm53Ba7QQYwVjdf-DEp57uFEIRevGs0OU6jI17PKpJD_GXGfunpM0s9gy5sI
Message-ID: <CANp29Y5iLeJ=W5GOfjRVX9_d+sF9KM6=dMG=W-v7VwHrucb8ZQ@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: Disable KCOV instrumentation after load_segments()
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@kernel.org, mingo@redhat.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, dvyukov@google.com, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225518-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nogikh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AB94297ACE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 1:19=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Feb 16, 2026 at 06:37:16PM +0100, Aleksandr Nogikh wrote:
> > Disabling instrumentation for the individual functions would be too
> > fragile, so let's fix the bug by disabling KCOV instrumentation for
> > the whole machine_kexec_64.c and physaddr.c.
>
> Seems like a whack-a-mole thing to me. Why not make KEXEC depend on !KCOV=
?

Some more context:
The problem I am trying to solve is enabling crash dump collection in
syzkaller. For this, the tool loads a panic kernel before fuzzing and
then calls makedumpfile after the panic (which fails due to the bug I
mentioned in the patch). It requires both KEXEC and KCOV.

The most whack-a-mole solution was to disable instrumentation for
several functions called after load_segments(); this particular patch
is more generic, but yes, it can still be fragile. Another approach
would be to add more checks to
__sanitizer_cov_trace_pc()/check_kcov_mode(), but this would also be
somewhat undesirable as it would slow KCOV down even further.

--=20
Aleksandr




>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

