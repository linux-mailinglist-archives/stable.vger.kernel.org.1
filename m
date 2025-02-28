Return-Path: <stable+bounces-119943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9B4A49A43
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 14:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4067188EB76
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB62525E471;
	Fri, 28 Feb 2025 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzfurLTC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E20256C8A
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748234; cv=none; b=jOfEAPoPTAthOOD02Hdf1dtFpEo4WSkG/jI6Ol9K0RaFSqyieMI4R8jN0CKZ1fK35ire3Im+qaGkPsW0LT4pqvROq4ayhWRbk8VC6/qlBWoVAwmy59Br2ZRmKK1491VgOvL+0/qWdt2eAgbvJrclWjKYXUsp3ks/Z2Xk9hXm3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748234; c=relaxed/simple;
	bh=nNKm37pTedRGkKL3CSVbX/6QfYCfTv2OcavtXSX2YqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naDCPvQMRVAsjRG2PVLBTlJZtLfbh+ig110djgFEIdqCT6B3JO3g6k4I3QaYYA1OR/CjnTENLvZiezEeuMmN6moigfGsPiTI40DEcXMnATdNEXHdZtSK6B+XC9Q8q6OoeH8WFDKryaUIZv0OQ+fm4lHqZvczck0vp+654dzWT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzfurLTC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740748232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xY8SiQV5tHdZKzdn7RL0HG5hPe77UW5vPZ/HBWYTjPM=;
	b=OzfurLTCjDsDfNj6jq34EWRAn7uHnD3SKvh7az73d14ebL/dxVL9+pwWCJ5Jv1bPqhFg2m
	xZNtfAP36/4pn2HPLRRieH5AHInmpoqxaaun2qJHUjed11qKoztaTGWFR9rL8nCEoGD6Oj
	nixhy5Dhaby/ojCgLmg5HopJVCQ6WKY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Z4YBhWbTOr-_ETe_VBK7Mw-1; Fri, 28 Feb 2025 08:10:30 -0500
X-MC-Unique: Z4YBhWbTOr-_ETe_VBK7Mw-1
X-Mimecast-MFC-AGG-ID: Z4YBhWbTOr-_ETe_VBK7Mw_1740748229
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abb7e837a7aso240466966b.3
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 05:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748228; x=1741353028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY8SiQV5tHdZKzdn7RL0HG5hPe77UW5vPZ/HBWYTjPM=;
        b=IdO2VwkCxywumfySJmpZVPTeYoyxoNsR+byZ9MUCZE9r6BwqvuuFuSXkds6CFC3a6F
         nesiGXVdzmMjesaFhr8RGu2bOR0LJoGE3pjm28ScZIPuOjW0CJj+j9fPFhVhFscJ8R09
         wwp3qB6nymrezWKa+papmUQjGdawuC7SS/m2rOv42ATBjWU0iaweQz81hdiLPAlWsUXH
         LNVUbMX14ycLu88TOpSmSj6i0vm4bpWdEISgGp9+Maa3fYj7uSSCVhCNYJ5Fc5IgOmFo
         /6mwCEcxHd7FsyibqPwZjU749wnPj0I5q+hpwoMDUhyCOpPe4aPTTineafjkx/cSbPWU
         PbfA==
X-Forwarded-Encrypted: i=1; AJvYcCUYrhMiZPDapucCbTEbvMvIvRA/YpiGz/68y0aQCLDK6cFZT+4eA2T0s/byDbuPtrCikA3QG70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3vnhBwX42ovEcQRNSnpAJn2nzOfj2xEi2TppUCRbk/PlPLXhu
	A1LMsMCwgZtT2Hm4Nzvd8NxwvSkxphzZfAPTQNMr1WisvhDTk9R0TuBNdgC1eSzVeiZkFa4nHdo
	PQAG0GfBehYYSARyvW8T2WWV0S9wxY5amwAGQT7sseUA2tow/9hdZ3l4hMrQq6/aBwXaUPLDbGk
	jifvomgRiLGCuipU7K8974dLRC4EORiAkm9w9Ritc=
X-Gm-Gg: ASbGncupROyduLDAWBV9t3WS99gggeILH5qerY/195TFEumcvqXXmkWko7tz4bo+Jbf
	teOrWZHtAUkHuV6JQU7N/fWpvWsPk9aKhFTrqzYbWaWXgzGK1l7Rl/MSOP8EFvDFQrz45Uf+qS1
	fsrOt+UhOwHAtMuoun3EI5rRdGVXs=
X-Received: by 2002:a17:907:7fa3:b0:ab7:d361:11b4 with SMTP id a640c23a62f3a-abf25f9053bmr323721466b.7.1740748228403;
        Fri, 28 Feb 2025 05:10:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxqJlsMpan4nacTTwOGSKIqwfyVZ37fp84It1X7TYyN1w3ZfIt/JHtN6UJrRD5WolUYmAo+myWrdb/WV6xSe0=
X-Received: by 2002:a17:907:7fa3:b0:ab7:d361:11b4 with SMTP id
 a640c23a62f3a-abf25f9053bmr323717666b.7.1740748228003; Fri, 28 Feb 2025
 05:10:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <98eaf5f0-3a3b-46e0-87a1-33fda0e754cc@cesnet.cz>
In-Reply-To: <98eaf5f0-3a3b-46e0-87a1-33fda0e754cc@cesnet.cz>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 28 Feb 2025 14:10:15 +0100
X-Gm-Features: AQ5f1JpEzpLJANPRvBwLeiapKwNeptjpcb8qAb7hRyYOJOK6LPJBPhAs10W_184
Message-ID: <CAP4=nvRtE52WGxyEwEj+qEG9woyR62bzaYjKfPxbcGfhK0mqCw@mail.gmail.com>
Subject: Re: v6.6.78 regression: rtla/timerlat_top: Set OSNOISE_WORKLOAD for
 kernel threads
To: =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Guillaume Morin <guillaume@morinfr.org>, 
	Wang Yugui <wangyugui@e16-tech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

p=C3=A1 28. 2. 2025 v 13:55 odes=C3=ADlatel Jan Kundr=C3=A1t <jan.kundrat@c=
esnet.cz> napsal:
>  src/timerlat_hist.c: In function =C3=A2=E2=82=AC=CB=9Ctimerlat_hist_appl=
y_config=C3=A2=E2=82=AC=E2=84=A2:
>  src/timerlat_hist.c:908:60: error: =C3=A2=E2=82=AC=CB=9Cstruct timerlat_=
hist_params=C3=A2=E2=82=AC=E2=84=A2 has
> no member named =C3=A2=E2=82=AC=CB=9Ckernel_workload=C3=A2=E2=82=AC=E2=84=
=A2
>   908 |         retval =3D osnoise_set_workload(tool->context,
> params->kernel_workload);
>       |                                                            ^~
>  make[3]: *** [<builtin>: src/timerlat_hist.o] Error 1
>
> A quick grep shows that that symbol is referenced, but not defined
> anywhere:
>
>  ~/work/prog/linux-kernel[cesnet/2025-02-28] $ git grep kernel_workload
>  tools/tracing/rtla/src/timerlat_hist.c: retval =3D
> osnoise_set_workload(tool->context, params->kernel_workload);
>  tools/tracing/rtla/src/timerlat_top.c:  retval =3D
> osnoise_set_workload(top->context, params->kernel_workload);
>
> Maybe some prerequisite patch is missing?
>

Yes, this is my fault, I missed in the patch review that
params->kernel_workload is not present in 6.6-stable, which uses
!params->user_hist or !params->user_top instead. There was some
discussion last week [1] [2] after which I thought Wang Yugui will
send a revert [3] and then I can follow up. It seems like I misread
the conversation, I'll send both the revert and the patch myself
instead.

[1] https://lore.kernel.org/stable/Z7XtY3GRlRcKCAzs@bender.morinfr.org/
[2] https://lore.kernel.org/stable/20250224182918.C75A.409509F4@e16-tech.co=
m/
[3] https://lore.kernel.org/stable/2025022439-moisten-crave-b6a5@gregkh/

Sorry about the inconvenience.

Tomas


