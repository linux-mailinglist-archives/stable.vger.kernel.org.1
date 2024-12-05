Return-Path: <stable+bounces-98753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D75D9E4FC9
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 09:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D356281557
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F6E1D45FB;
	Thu,  5 Dec 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Lw6zYR8U"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D1E1D4359
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387568; cv=none; b=mshs2dXiXzzadVhEuLwUqJOiP8zLxI2t2t9AazHpkyMA86WwpBqskvyZzuw/ddq2OxczFyCiQMm5zo0aPPTBOXUmqvG9A7gnICtuJc6l3RgTIp0qWCpuOS2wcu0cyGmeB2u9TtpVhG77CLiDwiVnqkfrC6pL2oyMIZ2FU2ccUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387568; c=relaxed/simple;
	bh=EJPt+tqdGiqNz0PpQpFiRahH0cHhTtaiS3IKrYJT9bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJJKYheiT3CxHvEHOpg2knvufDRGJi9cIWNKaVL1dZhHxl05Cd4xx+b/KneRAT17HFwVz3Ir2vRNosnvoQ3aq9tDcD26xDRse/dgvFZSXlt56wyhjFF8KtJPQn3EaaC3bZ/PBkv16Au4JRUbWlOyyTpJt2X6LLSAWmMN1Disjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Lw6zYR8U; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa629402b53so53230966b.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 00:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733387561; x=1733992361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJPt+tqdGiqNz0PpQpFiRahH0cHhTtaiS3IKrYJT9bs=;
        b=Lw6zYR8U68nIgqAW60VowqgddjDSCaZ55oSvj67SHUBD553XkGx4FeFDutJjgnwADp
         cRaViBRSpDgTjL7VVC2OU0qykFVWFJtZjPLyCh6cXtFW/xuB9AFbSv+tZ6FeuUSL17N1
         +d2r+sF7MB8v1aDEhf1gQbzlLRN7R6/3rmGscaVHt7QRVPsCvuhOBcWupfvuGkNe5ZLt
         VdN/ixqm0gSyxCvQkmVAqUHvyJmb2Zop9EQgWYPqP/42TSVXQ2gCsa6wZn437z7yB+bx
         CmK9u0FZIMSoWMpGNpgwPjF/FX7zu5K08TQ6BPrjbgG359sulb9zenljQJyIu3QNFTJQ
         UiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733387561; x=1733992361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJPt+tqdGiqNz0PpQpFiRahH0cHhTtaiS3IKrYJT9bs=;
        b=FvlscTZHhweB7hyq45+7ZwlaTr96hVYPilmunKD+D/GpRrxTtY75qLDydC6D0B2guN
         WyGfrVuzEINQoxc4sXw6qzrzfSxTXrEXHzaG9fhR30DmV2uDSc5NVnbrlIqiAQ4kdyrs
         CZ3EflWfMuXEV53ttoRWmwPdqMkRWZBQawemjbNixBB1ndpjOB6nRQ1xSRhIsS79gFqa
         qKGV11UxTXPpiz80eQMWKNDLlQOTLzMvedoH2Yn4Fn1dhzFDrCA3YXuKlymn1Gns0IJL
         KRiy2elDywnrqhqXXsJBLL1fUTOJfbhB0FN+4iWrK9NOmi+DfzcFKJPc7i7GIU2q+DoM
         ez1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGFUiHXjw6PVTO54I0sHoiU97uUup0Jt9rYgdU8L0SjK3YBhy5HaHQePIYOny6Z75LqnzV4hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPbj/FKPSt1TwuJCS/Y8TOV0zefJSTkLwefYbtAA2uW0DPCRLq
	/CWkwDLdXGnDWZdvszRU4Lb1ROhxG4SynP2spVnkU09JuaDmxnS+436i+zEsLn3fUHFkRLqvvYz
	xT/GAuv0fY7iYbkrdP3U21fczkjh+p/1u+EsMTg==
X-Gm-Gg: ASbGncupc6YDdoOJ/PieaRrzPFqkNkuGUgCJZrI8Xy0Gp2c8VCpNRAPfb6bL5yLIm2X
	zqeDw3wJbDpVjCW/8WH4qtP+8aHzfrHUfxV/6g38o95rF72vz0zlPgFGu49fO
X-Google-Smtp-Source: AGHT+IEfOOIUAP+qzQLjr/PEbT9YYByWGvZ37kA/qsEDsa9dd02Ei0bVAjizMWSWGf9G5Brf6kG2rT73PAYZKr6E8eM=
X-Received: by 2002:a17:906:9c1:b0:a99:529d:81ae with SMTP id
 a640c23a62f3a-aa5f7f3c39cmr623289166b.55.1733387560655; Thu, 05 Dec 2024
 00:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com> <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
In-Reply-To: <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 5 Dec 2024 09:32:29 +0100
Message-ID: <CAKPOu+-rrmGWGzTKZ9i671tHuu0GgaCQTJjP5WPc7LOFhDSNZg@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 9:06=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Thu, Nov 28, 2024 at 1:18=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> > Pages are freed in `ceph_osdc_put_request`, trying to release them
> > this way will end badly.
>
> Is there anybody else who can explain this to me?
> I believe Alex is wrong and my patch is correct, but maybe I'm missing
> something.

It's been a week. Is there really nobody who understands this piece of
code? I believe I do understand it, but my understanding conflicts
with Alex's, and he's the expert (and I'm not).

