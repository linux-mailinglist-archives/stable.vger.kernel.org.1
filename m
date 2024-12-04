Return-Path: <stable+bounces-98292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4689E3A5F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 13:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3DD281891
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110111B6D1B;
	Wed,  4 Dec 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXNLgNva"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93F1B0F31
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316702; cv=none; b=nrIN8tDYVC12ivU+cik4yp/r822ZeWVal99b03Im+4wW3RjAkVvUSYyQ1Dl0n1T+lJyNF9UaqsfHQ6dIECT/VhvNlHTosLf+7aEbavvSoghpevpfaybB1XBY3W1V9lVDPbsTo6/87lPPFD8KJykUFr0QW0Apyq4iDPjXMlLca0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316702; c=relaxed/simple;
	bh=I9NCyPO4krisSUhdqeg72XRIllo/A9wyK93lujKfyPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rROzh6GJIT1+K34+4co6qWqtNh6v068kpl2/EEiII/M7loQ5DojEL35CszPEoXiDQaRreYwwEJKOBJ6mW7RG7lV3iAfRW+cU32FhpqQBMZaJuS3NhrpiPeCtSaljnU31jpyy6X4TycVyUwrmRJjzRfqgwclC2LuTVlzfLYuzU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXNLgNva; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9NCyPO4krisSUhdqeg72XRIllo/A9wyK93lujKfyPU=;
	b=bXNLgNvadHU22Dt4aXgAM/HcwG6hT3HhVkwvdGFER2vVmHpuFJQXY1FXuGSwRPlxabsIcd
	FvHs0WKvS9boQ9alp/r9EtqAW68NQM3GzBW6PpizRkmGTlmxG0tDNPGKiYlZOjFQaIB8oM
	7NZRohsJtqmmNA0iqlBavFoOPFfNYfo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-JZSV8j_TPDyZe_QaLoPHjg-1; Wed, 04 Dec 2024 07:51:39 -0500
X-MC-Unique: JZSV8j_TPDyZe_QaLoPHjg-1
X-Mimecast-MFC-AGG-ID: JZSV8j_TPDyZe_QaLoPHjg
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d0cd8a0ec5so3119938a12.1
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 04:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316698; x=1733921498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9NCyPO4krisSUhdqeg72XRIllo/A9wyK93lujKfyPU=;
        b=Mo8GFqsiQwM4g0gyv4mOIiWiaqFxyMBXvvmTsNUtCGI9EBJrb1vOZSwqtdXyACbfa0
         9eO7t9DRsnZ7bn1yrY2NQQ/Ev4xa9mxX/8mfKbCZNvbXcFcI6+XKQiNXvxUHVt4cK1Ia
         aa7EsaL8/fs/f83Q5RVvYP1cxy8a7aJbOyHW9fQuPtQZ2hpgsoiDilZU5Moq2gcBhBmi
         kITgXHIvSNVjDa/8ZXkfmHYzB+PHSbQ+7nhCZdcGUW8DoCC60LrTjHbni3sS8TxHYUgh
         YHSi/w0asMcB7pnmxtP4RTJyfddFPD7Nt3ny9O+lo7Bk+nOJxBeGsiA+pG/Qu4gLrE5H
         J4Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUmpWRmwgqcYSYrzRdwv4lR5p5PIMFAgjv5sYHBFptcrVkzUqC2JNQDzaLUhYkLzBy7YxejaaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5jfHAXXQ4arbFzj27AF0lugz6bci0BKaw20yaoRkfYE0X+2b
	MccsAjKgHxsV0IpJumDarW6YjNMmIYCatIeBC5Z+dnKOSq32M25EWQljixl5rQPQ+bp7iBFTzNx
	dvbefLulUqWju9EjtH13sxHK5EQ+wm008uDCS/ZdzVK769MSTsNE3ha9PD1jHRhoFNgjmyc1/aT
	S9/oQbbOjAmOJgultZk9pEVoH80/eZ
X-Gm-Gg: ASbGncu15/Fx5dANfB7+QvSmChNjxJqNtX6PFTiLIJTxTMGSjIZ3bwPbTYf5D4Z4IZp
	QEE8ZcGc8XSbe46o7/B4cp1hP+S3N
X-Received: by 2002:a05:6402:2553:b0:5d0:e826:f0f5 with SMTP id 4fb4d7f45d1cf-5d10cb4d7f8mr6517520a12.7.1733316697963;
        Wed, 04 Dec 2024 04:51:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE20wvu66FctTl9GL0qP1II/9zpj8SnN8HlRgU9qZLjUzSG6Cef4lVTKQt72r7wwVeJdCksU1lfkJH214DU+Z0=
X-Received: by 2002:a05:6402:2553:b0:5d0:e826:f0f5 with SMTP id
 4fb4d7f45d1cf-5d10cb4d7f8mr6517499a12.7.1733316697667; Wed, 04 Dec 2024
 04:51:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222828.240530-1-max.kellermann@ionos.com>
 <CAOi1vP8Ni3s+NGoBt=uB0MF+kb5B-Ck3cBbOH=hSEho-Gruffw@mail.gmail.com>
 <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
 <CAKPOu+-orms2QBeDy34jArutySe_S3ym-t379xkPmsyCWXH=xw@mail.gmail.com>
 <CA+2bHPZUUO8A-PieY0iWcBH-AGd=ET8uz=9zEEo4nnWH5VkyFA@mail.gmail.com>
 <CAKPOu+8k9ze37v8YKqdHJZdPs8gJfYQ9=nNAuPeWr+eWg=yQ5Q@mail.gmail.com>
 <CA+2bHPZW5ngyrAs8LaYzm__HGewf0De51MvffNZW4h+WX7kfwA@mail.gmail.com>
 <CAO8a2SiRwVUDT8e3fN1jfFOw3Z92dtWafZd8M6MHB57D3d_wvg@mail.gmail.com>
 <CAO8a2SiN+cnsK5LGMV+6jZM=VcO5kmxkTH1mR1bLF6Z5cPxH9A@mail.gmail.com>
 <CAKPOu+8u1Piy9KVvo+ioL93i2MskOvSTn5qqMV14V6SGRuMpOw@mail.gmail.com>
 <CAO8a2SizOPGE6z0g3qFV4E_+km_fxNx8k--9wiZ4hUG8_XE_6A@mail.gmail.com> <CAKPOu+_-RdM59URnGWp9x+Htzg5xHqUW9djFYi8msvDYwdGxyw@mail.gmail.com>
In-Reply-To: <CAKPOu+_-RdM59URnGWp9x+Htzg5xHqUW9djFYi8msvDYwdGxyw@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 4 Dec 2024 14:51:26 +0200
Message-ID: <CAO8a2ShGd+jnLbLocJQv9ETD8JHVgvVezXDC60DewPneW48u5A@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, dario@cure53.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's already in a testing branch; what branch are you working on?

On Tue, Dec 3, 2024 at 2:21=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Mon, Nov 25, 2024 at 3:33=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> > You and Illia agree on this point. I'll wait for replies and take your
> > original patch into the testing branch unless any concerns are raised.
>
> How long will you wait? It's been more than two weeks since I reported
> this DoS vulnerability.
>


