Return-Path: <stable+bounces-241500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNi4IJx08GngTgEAu9opvQ
	(envelope-from <stable+bounces-241500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:49:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 259764808F7
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41E9A3007E20
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FF43D6673;
	Tue, 28 Apr 2026 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE2oA4l8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0F3D8121
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365443; cv=pass; b=DDsi0bsMbaQ9prckj3H8vgGmyNK3oEPwnfEB5CyYoGbk7iyN76a1XO4L9urM9cF/O/2z/CSQdbTc+ZxVrikDKS9mIryKK9XGd85tI9hTgQPN2KAwSTSWRDXc/+5F2qoMKrRuEPtanYk6IooIfvbee9CRkSg9sMh/6CiLotybpCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365443; c=relaxed/simple;
	bh=hpvgtOg9/72WktrpHYSd2IOOAUVZlL5xFX3l3yMfNhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnZqesrLirK1B9EhGzhhZ2i9ZMaLnRt0etr4EJimkYKckgmMvu+dnjupkRdGFsZN17SwspMFPuzFloTEO1LYh+/70T4YkgRhxTQuG2qtvwqEuzLpFbVIMdjIiIhlu2VEfFN3KvagYrpE8wG2LMTQtWI9p4JCEtd06EhKJ+KP8T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DE2oA4l8; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so16858259a12.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777365441; cv=none;
        d=google.com; s=arc-20240605;
        b=lmDdUw0T+wectWYYoFDR4RSSVrDRBivEam25qfGN4F+MogmBpFnkMeSs1NzWy+jT1t
         wR/ITq+/mJfegPELPSKERLIremHrAdcreUSff3qqFWgmxzuT2YeKIZuUpBs+1Ylq2gRL
         kKhJbolk/Q13K3TIMkKkiDu39pnicWY0UVZwJ3bImsQYnOGQ/0GL9BYFbZAVsLazX1bG
         cje3o/aPuHplUf1gVmZNg0MyzKowPDRarkYArJm5/hhfU1tRhz6MAiVmhp8K+n49A9Q5
         UQ0uqMiTPjPkM4CuqxbOO6Z5ZahFfOpH4vmbZMkhEQn4OLY9wXZ1qRvGJ0MFQJNijXtA
         5u0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n6G+qgWYTC+CrZljToWIHCOWqzYHmS+9O6T1Mv+lOQ0=;
        fh=Kre2QpJ8Ua3lHwHImTWggyXr7Q8iLljbrMZxbd7sDrk=;
        b=CdAytCHd1K9Cq3eI5w4emZ04rlX+lhJJDre2Rt4rtSSlnEIV+OpHy/ScNSf1S/ahx6
         7l4LhecOAPiQS7oqB9Mwm4VF3W82ueG87NMtYVqDRjDPRG8BG6Wt82BaBdyCdAQaR4No
         p24fcg5d0j+RfpjnwcMBzNC8CfSEH2JESrtHaw8Sm2RiLz1fwN2PLBpEvii0zcdZVMkL
         lYaLY5ZIEurMn8ItJ8iuLwRs0M6SRwAKJQuT4/vw22S+MZ4FTm1Bv/71WetjQsLo5q/V
         +hUhdl8QZ38RUVx2RiS/3QR3WcbMABS/Q1Uxa8G/ls+Qtxo2uNH5pAPsI1cXFphfb3OK
         pdGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777365441; x=1777970241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6G+qgWYTC+CrZljToWIHCOWqzYHmS+9O6T1Mv+lOQ0=;
        b=DE2oA4l8Nij5hZLXmK6d868tHE+w74wNr2mQV7XYPaKddTT09LpoYmjxvDmJW7xKue
         LecRBeRZCh3hUp5C6aEU2/DqK+Pp1g1aKo9F989pdlspjUncAb+AoZergWvcMdTZeior
         tgeFaosxjvVJrwWAzfQr5H16CyPdTFjXzVrZsy7QlT3Z1mAn/nadBTfp+E1XrlZlWad6
         lPM3tSbmYYVU9iw0Wq8lYmrdH/ncjraPhxiaHQpHBndQ5gTgD9I/nG5V8W5SU8sv/GMf
         sMuFruj/BDmfKJQEyFG6avpjaZscpYz//2IlQNghYA1f1LU0a5VNBgxmkelO6j96u0TZ
         VQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777365441; x=1777970241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6G+qgWYTC+CrZljToWIHCOWqzYHmS+9O6T1Mv+lOQ0=;
        b=rGXOiiPwBcNBlXfHw4YRXNf4RtRuMegoEhZqYTDhdmcmVD25BrAfZl+3PthoqDwRUw
         1CeJzEyH9X7SBHLYpLKsWXXBOR1e4jFusrTBV/+5bs0VSdJw1HEB8FmF6dio+7fk8Pp6
         wDwQtRuuJB0AYYEohyanE+xZXaliGZQwmdFhYDZpK4pTxQn8zK8pctvWg/BCpPm4Fy2l
         mV5vvnCT6MMZBXBc32I5tKdr5jqAlnWfbQAQFPOZfg6lhVtXzIgCVPVylOu5/p7Xdnx7
         P/4Lw2tBtyEQ8n2k34zl3svp4yDDfJrcAHf7h22YWh6QSeg74icR6RF28Qee5kE51eMo
         6M/w==
X-Forwarded-Encrypted: i=1; AFNElJ8GMK7l/zf7BaHXBfeaX7UdGQWpBC9OeIIHk+GdbEaElIZSzjiEl28FkoBepgJXnhBCpEVfBNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi5omPKh67fAQ9rlCOjTRFSNYoP1MJqzSaNkI3qWwxYdN1xymU
	D0voabyeRRZINC/oqh4pCwMZ3qPNLyprRNPxqO+Q+YzRy013BJtIMfgPEQF/M7PFNxrFxqKB+fc
	l22dx7hbrIBxqfOxERDwob7VHPGtmKiQ=
X-Gm-Gg: AeBDies2Njs8SLFeMm/L6rFPhJozfZKC1HbIWGzHQrUvshaF3xfJV6NABtAbAQBSYLw
	dsDA2dUnSu0cOSQQqKiwB253iAjuWxHFgnMrti4JQMPZusjMdTmF2xq9UbvkrbXvh7whjJ7ZIc+
	5mJILKJY78owoFo0BDCTYPlJc//WzCnmA2VM+hkfrWBRGezQfW+XRdMKSnf9AXtE40XHGsBSfAM
	u8N536Nhudw3q9vhS2t8pZhfecDRiz4+92g96D/c98haQk/RP3JW2mK5Mx5mgxw/KTaxvWv+/Kf
	Urj9oOnBsnHt7atq8pXMMitjLomonSerRJhLs9OWAP1sIgV7UwI=
X-Received: by 2002:a17:907:a781:b0:ba6:cfb2:c048 with SMTP id
 a640c23a62f3a-bb80443da14mr129972366b.43.1777365440349; Tue, 28 Apr 2026
 01:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SYBPR01MB7881A5E2556806CC1D318582AF232@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <beca1657-0180-4f9b-8de1-ca7776c9614a@fnnas.com> <CAHYQsXRN6uof4yyDR6qGteQ=wZTt86VUx7km6k=LbNAQ3wxGiQ@mail.gmail.com>
 <282278bc-7d71-4049-89f4-a9f3968504dd@fnnas.com>
In-Reply-To: <282278bc-7d71-4049-89f4-a9f3968504dd@fnnas.com>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Tue, 28 Apr 2026 16:37:06 +0800
X-Gm-Features: AVHnY4KvGt5v1k39WjxDYGhlTLfgOcqclOaOgzkAnTnKKabHIzkk4zX7G2Tvvbk
Message-ID: <CAHYQsXQhTn905RGCrw-qeb--VHsRGR2KEWm5X0ZJEW+krTJaNA@mail.gmail.com>
Subject: Re: [PATCH] md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
To: yukuai@fnnas.com
Cc: Junrui Luo <moonafterrain@outlook.com>, Song Liu <song@kernel.org>, 
	Li Nan <linan122@huawei.com>, NeilBrown <neil@brown.name>, 
	Jonathan Brassow <jbrassow@redhat.com>, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 259764808F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241500-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,fnnas.com:email]

Hi Kuai,

Looks like different maintainers have different rules. :(
Can you send me the patchwork resource?

Thanks.

On Tue, Apr 28, 2026 at 4:32=E2=80=AFPM Yu Kuai <yukuai@fnnas.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2026/4/19 13:59, Yuhao Jiang =E5=86=99=E9=81=93:
> > Hi Kuai,
> >
> > This report was reported by me, so Junrui added me as Reported-by.
>
> This is fine, however, please do not add downstream reported-by tag.
> If you want to add the reported-by tag, please report the problem to
> patchwork first. :)
>
> >
> > Thanks,
> >
> > On Sun, Apr 19, 2026 at 12:43=E2=80=AFAM Yu Kuai <yukuai@fnnas.com> wro=
te:
> >
> >     Hi,
> >
> >     =E5=9C=A8 2026/4/16 11:39, Junrui Luo =E5=86=99=E9=81=93:
> >     > setup_geo() extracts near_copies (nc) and far_copies (fc) from th=
e
> >     > user-provided layout parameter without checking for zero. When fc=
=3D0
> >     > with the "improved" far set layout selected, 'geo->far_set_size =
=3D
> >     > disks / fc' triggers a divide-by-zero.
> >     >
> >     > Validate nc and fc immediately after extraction, returning -1 if
> >     > either is zero.
> >     >
> >     > Fixes: 475901aff158 ("MD RAID10: Improve redundancy for 'far'
> >     and 'offset' algorithms (part 1)")
> >     > Reported-by: Yuhao Jiang<danisjiang@gmail.com>
> >
> >     So again I can't find a report, and Reported-by usually should be
> >     followed
> >     by a Closes link to the original report.
> >
> >     Applied with Reported-by tag removed.
> >
> >     > Cc:stable@vger.kernel.org <mailto:Cc%3Astable@vger.kernel.org>
> >     > Signed-off-by: Junrui Luo<moonafterrain@outlook.com>
> >     > ---
> >     >   drivers/md/raid10.c | 2 ++
> >     >   1 file changed, 2 insertions(+)
> >
> >     --
> >     Thansk,
> >     Kuai
> >
> >
> >
> > --
> > Yuhao Jiang
>
> --
> Thansk,
> Kuai



--=20
Yuhao Jiang

