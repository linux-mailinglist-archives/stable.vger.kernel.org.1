Return-Path: <stable+bounces-95714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2859DB859
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905D41639EF
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630C1A0BFD;
	Thu, 28 Nov 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WfukNIsV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044E1A0B00
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799527; cv=none; b=hoNkWRuV6SE3An+1YcGAhNprJmXfsev835zl5l7ywE/ArIkR7Mri41I//SwIzWiLc+f+As5mojoESrTsY1bdSxqoOYTvTXvk3bIqaYZwkkcwcXWtJX+K1xksTIq48nEPneJZ0zlbFVc5+lpRz6cZ3/G6c2sIcROAFSWU4UdLRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799527; c=relaxed/simple;
	bh=RSVSJUlGidziblJUxiTLtOwxA2rGIZxQe7Q2HII3bj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnxDa522p0DcMKVkY8Gi8GvUV4QkpHssb4mKIoOMQ3IjHB3bcCUBlaCpRM5mbjtOf2TC+d1tO9NrfnADo3y6uPYLRGAOiMzT0iBKNtv4xx1Xqd//Vdnv8jm/d2AGHsYUlaLKWYYeDBQUqvJBebZqSGQpbcwaa9PqbsJqlJkomv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WfukNIsV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso104596266b.2
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 05:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732799523; x=1733404323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSVSJUlGidziblJUxiTLtOwxA2rGIZxQe7Q2HII3bj8=;
        b=WfukNIsV9w1A3v+mw5nsNNGLg3DrszqV88B17Wa1xUW8EJiUhdVcU//VgGFMj/Jz96
         GF9O2csXZs8Z2kb0JguNrMWiDGhi9wq0dfqxFDDypRsLqium2sIuL86GQ6tiNkroAaYp
         RW1XBGvs56c2Kld6Yrp01H6QCV+pZWsA2oMr4M6XWYkagFtgEXa2bv6FPW8yv8AynsCo
         iYjDaz+qB68GVq7j/Gma7sun0obGNEv7dWWoemReGeySGsabntUoetUZqWgmApVVZzHq
         n8RA0fYpfksyd3AtwwNgzhap4X45hzocTuCln6s7n5s6EPpcml9aV84MnA9lCXFTKVM9
         O0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799523; x=1733404323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSVSJUlGidziblJUxiTLtOwxA2rGIZxQe7Q2HII3bj8=;
        b=Eu2zzHIaLsaetxCmopwCd7cc+5AkF7YoN9eckpKySWttchiBWsI258yWBQg68nnj7A
         olLRZErxfbXqd9Cim5IViNiizSfk6EHy3SP7v8YX303WJ9esP1n70AQwKhogxRSdQfaW
         Qx9vjgqG+A4URCCXxUEn88N8WXJuuqcVpRvlwLw9Sg0ndxGTJs9m7aA10SHEwjL0R/3C
         H56vHIkO8pA+WeWUIjPjOdCNwLV1g2JlnWIeszq4hPGhvTCerz+qfuSMAGjrE/rIPOfu
         xY3wUKaVo4xG4fhWoJfR5q0VyAZyOqQSVIDjux5yb7PUT4wzN0wCLyz+ADmWbQFtXlta
         YgOw==
X-Forwarded-Encrypted: i=1; AJvYcCXoa3VZ5gsFhbh1rGFEVcow8Rr/EWsX9hqWBrEk3DhhwLzbFUxy6cBen5QBRn5jtxxdAp3EwCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhf23o83EK+oYUSqV/beIEd4f6sBpamqUXQPcuaJ8DLdWSOkY3
	i36VSI4M/VvAGfzIiYljkhdSNR31gXN0lRggJxEoQiBHdDVfPRhRE/RBYeA1RByUMwSBkJu8Fom
	o9LYPoxKHAAb7o9QBR/iTRtr92Ql0M/0eB1FVow==
X-Gm-Gg: ASbGnct8Q2RL2pSuyXCqvOYnasB8QVvz14RiFkyFaQC42oWy3Bkx4lIkBtUiuCdYF/x
	AorPqrQVYbu8TfcqpthoLiQ7AR5u7fc14JM6nDMk031X55grFsCAe33Pk59a5
X-Google-Smtp-Source: AGHT+IG1z9xD1ww7s3NzrjYICCANEgPUfErUCJ+27Ulo0O2S8YfixqzsbTMswQj+hKgVIkE2rjhXF92c63MiUh+CN0g=
X-Received: by 2002:a17:906:1db2:b0:aa5:459e:2db with SMTP id
 a640c23a62f3a-aa581062652mr505113866b.53.1732799523286; Thu, 28 Nov 2024
 05:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
 <CAKPOu+-Xa37qO1oQQtmLbZ34-KHckMmOumpf9n4ewnHr6YyZoQ@mail.gmail.com>
 <CAKPOu+9H+NGa44_p4DDw3H=kWfi-zANN_wb3OtsQScjDGmecyQ@mail.gmail.com> <CAO8a2Sh6wJ++BQE_6WjK0H5ySNer8i2GqqW=BY3uAgK-6Wbj=g@mail.gmail.com>
In-Reply-To: <CAO8a2Sh6wJ++BQE_6WjK0H5ySNer8i2GqqW=BY3uAgK-6Wbj=g@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Nov 2024 14:11:52 +0100
Message-ID: <CAKPOu+8H=cGbY4TgoT4bZvWwFPH7ZQ8MioMUey+nJvb0my4xUg@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 1:49=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> The ergonomics and error handling on this function seem awkward. I'll
> take a closer look on how to arrange it better.

Does that mean you misunderstood page ownership, or do you still
believe my patch is wrong?
To me, "pages must not be freed manually" and "pages must be freed
manually" can't both be right at the same time.

