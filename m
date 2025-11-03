Return-Path: <stable+bounces-192145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AE7C2A054
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 05:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A1E9347FDA
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 04:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C70D271443;
	Mon,  3 Nov 2025 04:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS2jkXwv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2RDpdia"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C0D86334
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 04:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762143176; cv=none; b=KN22+9rqBJfmwvMSuHVTaW1N+xd8TKUKavec8J+nvUidmd+sJbTIOWkbzlqGFO+cikVdjCFymKrBNs04twkICN+f3mjLMwEN/ypmm1e7nHMCwJcz/9r+4dBn9X6Vxuzwou3WGYeawEqeeUMNQNdrVXv4WGz5Ed9OfbHHMSwOe1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762143176; c=relaxed/simple;
	bh=KN+TO5EXEG6rXknFXdUGFg3Ct0/f03Jh7oOqpXz1gqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHunK68ztBRV6jC/Zxtdb90oeC3MEIZKpM5j6qsO8NNseFp5b8ED3T0YqDOqymFDyaTwD4irzZV3HgsJdlBNnDbYQ+3O36/7pWOKCHf2HV9oLaiv+6xZHX3pPoQeS6EjXq+V4cD+7Y7w0ONPIwUjq6bktihgQba3mt4PsGik0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JS2jkXwv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2RDpdia; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762143174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KN+TO5EXEG6rXknFXdUGFg3Ct0/f03Jh7oOqpXz1gqU=;
	b=JS2jkXwvJ3z6/SJUD1/N7n1HqNNQtVTp/sbh7KQxayNyYhjfWMsRBP49dF+qetFUTMXCt4
	K4XWhC3McmdZ2mGJaKjmHEdjLdpcIio5W2W4n0GF6hz/Wr35S/aKUykNGarFo/B0IlsDvr
	AHRztMhHBqzwuy1kVtxx62LgMFHtIyE=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-wj_UlragPP-PtlfNSxEvrw-1; Sun, 02 Nov 2025 23:12:53 -0500
X-MC-Unique: wj_UlragPP-PtlfNSxEvrw-1
X-Mimecast-MFC-AGG-ID: wj_UlragPP-PtlfNSxEvrw_1762143172
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5b736eca1c7so9488137137.0
        for <stable@vger.kernel.org>; Sun, 02 Nov 2025 20:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762143172; x=1762747972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KN+TO5EXEG6rXknFXdUGFg3Ct0/f03Jh7oOqpXz1gqU=;
        b=F2RDpdiak5iN4njG9RROSMPuLbS6vEE8O2W2hDJOXhO7qrG8OyKp/HxrHeeS9tccPv
         /MU7zLUsd+3h9fGevpumDUIibOiRiQ17p5MfQDsFvf3oib4QzbMXTjrlhmecF6PVKkOS
         Zax3p//P2yOUA5CgbkCcbTHujzpNEAhot70cU44z6WNPTB6JRE+Rj+oyrmK/5K29wlkw
         pV+HgtEvZjnDekWW/nyA0WjrANQmqqUNoALytXq8x6cVmqajEXaNiYWIdtaKK0klFpEG
         TmJlCrZJb9htPXZ27I1Q60WnilLOfEfB7Vd9Y9nFAnV2aGZzloBrCzhlCXnTCooUnhff
         veHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762143172; x=1762747972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN+TO5EXEG6rXknFXdUGFg3Ct0/f03Jh7oOqpXz1gqU=;
        b=sTqTcwqnFEsxjnfezRRo/5hVHLCOEA6Bb83VtevWfw4AlfRNVLhDcanCJFWClILVv+
         MkKnj2Opuyfne23GdrySEWSWXMV7sD2yxu06ocmwIQpmcDFheTcWsI3cpn7oEs8uAUeT
         PgUsfpPnoGZ+wUha1yG14VSrt9zFwPJlnBZD5VgkhrWBBMGcPYL3fpDS3x+1Q8at1j94
         BFY2OQfOvemwZgb145OLoG1vUyaX+p1uAAj8cPxTc3HjkoWffJckZseILvRgh43CNEhP
         NhWdyqUsPUSEgNHJIAHGNhQfAHxf3LBhZwRySBlNlcQp8ienfAvuu+t6FT73ifmQPesw
         wcKw==
X-Forwarded-Encrypted: i=1; AJvYcCXOL50LJZPmaFK0c1bfkdVTrRtXHT5nmQvmoDn0x5FVpF30xxSLDYrXD/XzlWSIkVXtYZ3jaPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4waUPSsv0hZB2bAa9p32p6F4hs3CdwkFu+zjzhnI9pQYUM+ou
	wP1f99zrOs7Q5dZLFW2FHkFoUMm5QPU7Yf+2wgVNl1o+GzEDzXNWyft+6w2ipmQLHum8xPD4mqB
	zeqUrxGyIGkotFIhpVRGJhP+S5vyc3xwwScZkNVRk+FciGCLpo0qUmEvlw9V9aZ0CNBpPS4BUzq
	b2yBVB6K46q4v0Fn+zMwKFkJY4yi/RgUz+
X-Gm-Gg: ASbGncv1CncgPADXc7DBW/g99OEnSdNhL7cAABRABumI25xpIVumMSEcHAFErziMhb6
	V0ZMdKEAo6wXhXlOhyiJ3amgMGsywVAK6PJ29PNVTc3SzAGL21lu+YALie1OqpsJM4PTy8ZUTM0
	oa0QxB6RpK64nA5DeqiDEvx2FRkjfod1V5MZXMHNolaE3ESJKPIhr6z/n1
X-Received: by 2002:a05:6102:c8a:b0:5db:ceaa:1dbe with SMTP id ada2fe7eead31-5dbceaa21e1mr1492749137.29.1762143172505;
        Sun, 02 Nov 2025 20:12:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwDkt+ubg64eT5kGK1eDIVI/O9sWszvBtfRlJSK167ZaNYK6Kshtfh+QKTZn7iqj5TgGrCmpoV04GNq8YCLfQ=
X-Received: by 2002:a05:6102:c8a:b0:5db:ceaa:1dbe with SMTP id
 ada2fe7eead31-5dbceaa21e1mr1492742137.29.1762143172194; Sun, 02 Nov 2025
 20:12:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030172417.660949-1-bvanassche@acm.org> <befb4493-44fe-41e7-b5ec-fb2744fd752c@linux.ibm.com>
In-Reply-To: <befb4493-44fe-41e7-b5ec-fb2744fd752c@linux.ibm.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 3 Nov 2025 12:12:40 +0800
X-Gm-Features: AWmQ_bl0Zz4CsOHgn8YBsWzj1ge39bPHWAEOup3xt7h3Y5s2M8CAljrLL0JnfE0
Message-ID: <CAFj5m9+-13UHPTKToWyskQ5XGiEFEEBFjgQzkkuDa=VBKvF7zQ@mail.gmail.com>
Subject: Re: [PATCH v3] block: Remove queue freezing from several sysfs store callbacks
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Martin Wilck <mwilck@suse.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
	stable@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 8:40=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
>
>
> On 10/30/25 10:54 PM, Bart Van Assche wrote:
> > Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue(=
)
> > calls from the store callbacks that do not strictly need these callback=
s.
> > This patch may cause a small delay in applying the new settings.
> >
> > This patch affects the following sysfs attributes:
> > * io_poll_delay
> > * io_timeout
> > * nomerges
> > * read_ahead_kb
> > * rq_affinity
>
> I see that io_timeout, nomerges and rq_affinity are all accessed
> during I/O hotpath. So IMO for these attributes we still need to
> freeze the queue before updating those parameters. The io_timeout
> and nomerges are accessed during I/O submission and rq_affinity
> is accessed during I/O completion.

Does freeze make any difference? Intermediate value isn't possible, and
either the old or new value should be just fine to take.

Thanks,


