Return-Path: <stable+bounces-64762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F13942D5C
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 13:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5A72870FF
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EED1AE87F;
	Wed, 31 Jul 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bxLoMOPO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB61AE879
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425834; cv=none; b=bwqe8tfisq/8egGWC4d4NVPz4tFkhNlGAWQTHepwUq3s+fkPEbgtrlH718MjBRfH7uVSLpLEP8P2jcMmFYoxrlv7FKsRSvS/3GO9qkEqgIPNBzuYZ3eKpQOJqppxtJBTmS4//o76XW0A/VoHr5Ecu7rvKK+yT+MUO++h2BpzMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425834; c=relaxed/simple;
	bh=gmAAodUXdgnNESvRXNAekJJqooqvvUxv3wuMM+/4RoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNHyTZidrYpvxns6oAoZoxJIi01xAZ0b3k5JqipQEUk3fR9jaXjMMlORewOJhKW+FE1EJ2npSqIB9sT7aK4eq7kR9V3yKZa380/h3eepmgFBeNrk2GczzZWgEVUuywrQHwNNFzg+iirjWvKxqryUVEKGzOtCaaBYzkljZ2zpRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bxLoMOPO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso440034766b.3
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722425831; x=1723030631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iVqiOcI/Lm61Kn6z1In0PhQoNC9BfNgfzLWAbxhDSI=;
        b=bxLoMOPOeudPozRvAPyB7PabtaNkaJp9NcIjy/NUHVUHtZy91XIeOZFdzZEqHTQWgR
         MtUxk5AV7lcG1PbWvNlM5IgjD6iNy1yXFsmlxkuT4AUs1yF5WffguciTZrncOJ4la9TR
         YnI5p6HwgEYW8UjjtNSwuXG2qfKAOMVyQ3/bWbAsiGP8LUIfotLsicQsMs8N9CeyPeti
         ymMXVq94xmEGSpEYKMrQzj1GlB9x9eGADLRR8SxUuZy9RouPx0G15ssbdl4dTK8iEvFt
         QbH8lJT8pSA0UJjyb5oGmX/T5flpOKEkI7sXJzaWW5sh9YXbnhXqil2bD+R6KTzJZtHa
         AcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722425831; x=1723030631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iVqiOcI/Lm61Kn6z1In0PhQoNC9BfNgfzLWAbxhDSI=;
        b=Abq2BXmqOdSRBb5adUDc4RMSPBkXyMR8eLeGvY3o5Jn+ip46wN5jy1JYGr32TGiVwc
         feOMjsLQ9iHytke2GDjV+6oeNWTyWroY+WAfiDSxhUJff41NMu5XVdrhsKApYRl/ORw4
         8wbeFLZyyWjdR8MXeToD4lc5VkN0X6+HzwZ5waD1CwUOE8Rt8rmHhlIex8nwiRB1g2LO
         2Gysgt7j9ZuPck8uxvaYlLHPUeQSoT8A5Ldu0+33pa6OFBGpfBLAqJa3y82UtNFJ6BvH
         oyoQYPerT9ASCPG5UHNYGzYMd+SvR6/efzTjjrcldOpPl1unZjSVm4ipkfQwmBpIF1Ia
         tr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+jfzzVHSpLXRbgxap5ba/3CIJM56ZpXEYdfYlgRs3KyD2cUlyR5lmMwAWLyVd7iIoDsUCP4UDgYYg1g5ADKaGIUB7ntxb
X-Gm-Message-State: AOJu0YzQX61hg2Jm0o0xclgKYp+E5UycMKL+6zzOsqKgdOGRdT9atZhm
	SgTV0NngoSAMmeD82IgS6wZ+KGAg+WLJ0tjRH1iy0a9whIjP0Uao12SJVk5LoBnAJ9WrS5E0r1W
	cqDhP42vRc2D6iGObwy38g8euSAM//+IQoRi9Zw==
X-Google-Smtp-Source: AGHT+IGKzF7L3tGT7YjvoFGJDwdINXnVaS2Vxa/MttoDWTfIP0ZESkvvOTXarzXIGvRKUq2y7x6k6CcvXSEnf4eYun4=
X-Received: by 2002:a17:907:6d1b:b0:a77:e55a:9e8c with SMTP id
 a640c23a62f3a-a7d40128ab4mr796501666b.47.1722425831422; Wed, 31 Jul 2024
 04:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com>
 <3575457.1722355300@warthog.procyon.org.uk> <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
 <CAKPOu+-4C7qPrOEe=trhmpqoC-UhCLdHGmeyjzaUymg=k93NEA@mail.gmail.com> <3717298.1722422465@warthog.procyon.org.uk>
In-Reply-To: <3717298.1722422465@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 31 Jul 2024 13:37:00 +0200
Message-ID: <CAKPOu+-4LQM2-Ciro0LbbhVPa+YyHD3BnLL+drmG5Ca-b4wmLg@mail.gmail.com>
Subject: Re: [PATCH] netfs, ceph: Revert "netfs: Remove deprecated use of
 PG_private_2 as a second writeback flag"
To: David Howells <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, willy@infradead.org, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:41=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:

> >  ------------[ cut here ]------------
> >  WARNING: CPU: 13 PID: 3621 at fs/ceph/caps.c:3386
> > ceph_put_wrbuffer_cap_refs+0x416/0x500
>
> Is that "WARN_ON_ONCE(ci->i_auth_cap);" for you?

Yes, and that happens because no "capsnap" was found, because the
"snapc" parameter is 0x356 (NETFS_FOLIO_COPY_TO_CACHE); no
snap_context with address 0x356 could be found, of course.

Max

