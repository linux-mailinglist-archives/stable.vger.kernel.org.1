Return-Path: <stable+bounces-197049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0BDC8B5CF
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 18:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB7144E3786
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8C4219A81;
	Wed, 26 Nov 2025 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOcC67sU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA723BD06
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764179934; cv=none; b=bui8PceD8e2qEyarp9tZlUuGZoFiITyovMnVbeWdgPSg/JyR1vZv7zrSTgGj//0P4vcjwOOEeNPlu6mM7nqTi6fCjySuLti2k8Ygb+FMVeItPqp60ehvhc3nmECEe9KRSb2VeOuXXHvKt6o0kfpdLubKnL/WwbU4Xigse0RQ/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764179934; c=relaxed/simple;
	bh=5lTJ8r8pPFEaE7EZ8M4aIH0/lzPnxcj7KdKFi6y0z3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBWBKwSaGlHEc+QKzPJz4aIRmHz2Xrag/CsOw17/9jLKL2qfec8KM9Li8elYC8vm70h8zJAXd1VqSudQs/Dqtr4Ae8cmYvPjea+UaFE4tT9zbU5TywFoPqAAGo/n02jeSdn42FUqGEO1Am25atMKBY3b8ZwjagYUfAm2OvSy1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOcC67sU; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eda77e2358so1128581cf.1
        for <stable@vger.kernel.org>; Wed, 26 Nov 2025 09:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764179931; x=1764784731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lTJ8r8pPFEaE7EZ8M4aIH0/lzPnxcj7KdKFi6y0z3M=;
        b=GOcC67sUFLq9QmzNo81yd3cj9l8Lj5naGq5IWtChgr+OXz6qbPazrM9QpBAMTAgap3
         RUSE8pYyhQ1lJmP6HA/eURmCYcm3sV2svMEt/mxg3yhzsyYgwUI+++S339KqBLhgS6eA
         sJYuYZNG4MAZspoEURjMJif0Mh9FeTi3kKcCIcZ/cmsjd5jL18hHaYQQuBmk+OY0ohyi
         ljupJZt2fHEYoCs6HCdiUHApKElSH6bVQXZEShWPjgUAoF/GEFhG+s2MYmwJIDHV9pt4
         IIvJ9h24ubv/ixmpUDgnUq7X0TADWEQbTujuNo3PiwVTCZiZ5ph6ufgrpZen+blYOKWd
         l28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764179931; x=1764784731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5lTJ8r8pPFEaE7EZ8M4aIH0/lzPnxcj7KdKFi6y0z3M=;
        b=EaYqwl0YH+408L6488Is5M0eMNojcKF0hxExrGYZBGqR0RasQXjBUdXPMhxPa1IsNs
         CDFESYoUje+zkx4WkVRVmhaRKLb5ENpJKPYThJ12+qSRvrvXeqrv2dk8+fl++oiOniBV
         jvr+FQTK7XaT1n8YnNuon9JpqE+8h+Iof2pB+ujJ/oxHNE/H9cHaMx1H9qgMcgTZRCNH
         m947eSM7XeqlNvvu6ECPPxRvjMOhqkw+AQ4IIgX0sGlg6ewYZUX5RIJrKGeEiDoix8cB
         xrVzkpVEZIFh77u+bG33eXEObVX7NtMlUc6D5Bkp753OynrRnO/dIHtqWaKJNLzOjkLZ
         zAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO/L5uoooTE0ygN2uFbqG+XT3tQMM+lCzcnlWvWqu7NaX6Qh38YcWKIW/Scx3Ymww3MeTVnnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZelG00XBQsagySWW4qi7R1CW6cFrmvILgPDRXyxQONYITDWH
	uZpZX5lKzfHf+t9CK2I3WcRyd+E7tR7qEPtaEYGLhoogbFOpfe1Bc33uHxDM2Eh8ptL7WWP2cdz
	UM01HuqGqlKsnht7DZk6bk/Fkhfi1e/k=
X-Gm-Gg: ASbGncvfResTBjdzQcpgshPmY0RjR/ZTuogJ77z1q8eGtO5yMeZwZE1xCrw2kFHQyVq
	GkRVvyGtL3eoMLOdhahtfE/irjr+XsaRr9tJHWupm/9A7M1zBniDzIcHRxyYRFNOkQrcCtkgc0C
	GrVqUp6CHPhS0JJM6LBCOqH4AnXBr/HOv1T7lj9OHto0NT59yIaC6J51Zm5Ig89tT4DlHWm0b0g
	V4JAsVFb0/pD4BdnZbnvzhh0HCtqjwgs291A0Ode4+4rpYSQRolmPspBuWMCV8JeCadag==
X-Google-Smtp-Source: AGHT+IGUMPFl2u4LYkvi5XrfvZZxNf0T7IQ/UmH+m/1OY7Kuxsj34G3KeI/hNPM04GPlwQrdLOPhH+phTrJRXqJlY6k=
X-Received: by 2002:ac8:5f48:0:b0:4ee:1a54:d2bd with SMTP id
 d75a77b69052e-4ee58ab003cmr287861791cf.29.1764179931447; Wed, 26 Nov 2025
 09:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
 <20251120184211.2379439-3-joannelkoong@gmail.com> <5c1630ac-d304-4854-9ba6-5c9cc1f78be5@kernel.org>
 <CAJnrk1Zsdw9Uvb44ynkfWLBvs2vw7he-opVu6mzJqokphMiLSQ@mail.gmail.com>
 <f8da9ee0-f136-4366-b63a-1812fda11304@kernel.org> <CAJnrk1aJeNmQLd99PuzWVp8EycBBNBf1NZEE+sM6BY_gS64DCw@mail.gmail.com>
 <504d100d-b8f3-475b-b575-3adfd17627b5@kernel.org>
In-Reply-To: <504d100d-b8f3-475b-b575-3adfd17627b5@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 26 Nov 2025 09:58:40 -0800
X-Gm-Features: AWmQ_bnpX_M54rPqypc5h1eZeZ6yR9KrguhyZF92GnYk549xbCVZ2NRiunLmtEI
Message-ID: <CAJnrk1a1XsA9u1W-b4GLcyFXvZP41z7kWbJsdnEh7khcoco==A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fs/writeback: skip inodes with potential writeback
 hang in wait_sb_inodes()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, shakeel.butt@linux.dev, 
	athul.krishna.kr@protonmail.com, miklos@szeredi.hu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 2:55=E2=80=AFAM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
> >
> >> having a flag that states something like that that
> >> "AS_NO_WRITEBACK_WAIT_ON_DATA_SYNC" would probable be what we would wa=
nt
> >> to add to avoid waiting for writeback with clear semantics why it is o=
k
> >> in that specific scenario.
> >
> > Having a separate AS_NO_WRITEBACK_WAIT_ON_DATA_SYNC mapping flag
> > sounds reasonable to me and I agree is more clearer semantically.
>
> Good. Then it's clear that we are not waiting because writeback is
> shaky, but because even if it would be working, because we don't have to
> because there are no such guarantees.
>
> Maybe
>
> AS_NO_DATA_INTEGRITY
>
> or similar would be cleaner, I'll have to leave that to you and Miklos
> to decide what exactly the semantics are that fuse currently doesn't
> provide.

After reading Miklos's reply, I must have misunderstood this then - my
understanding was that the reason we couldn't guarantee data integrity
in fuse was because of the temp pages design where checking the
writeback flag on the real folio doesn't reflect writeback state, but
that removing the temp pages and using the real folio now does
guarantee this. But it seems like it's not as simple as that and
there's no data integrity guarantees for other reasons.

Changing this to AS_NO_DATA_INTEGRITY sounds good to me, if that
sounds good to Miklos as well. Or do you have another preference,
Miklos?

Thanks,
Joanne
>
>
> --
> Cheers
>
> David

