Return-Path: <stable+bounces-95388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C69D881C
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14C328D077
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 14:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377831B0F22;
	Mon, 25 Nov 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrfPLDME"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C21B0F1D
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545191; cv=none; b=T4MxcanXhQ5sZQNgz4W0gFoPqf+qLsF9dkF09MdAYvPTCMMWfdYwpaE1jKfvCUzyUUNktL2zuBP4IJdSVuQeP6lHQDa//mzBGaziEC9WW5UePo/SLfUXYxqonuilVWlcsRQZdbrlX+uaFXqWy8WD5bS8yLO31ajuRI+Cmgllj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545191; c=relaxed/simple;
	bh=Qn+b6ULbHlpt1jjPuozeG76v5+tmKAZ3os+xCJI2X84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDYF2FMaTVXgPemIIyPIJElMIe54A6/KFgrRl1SjI7jy1apLF4nRJToXkxQYfaa0o5wZpr+3GhsB7v8h9xdanWa4cT1Bg7HEMfOGro80QKWIYdl2bQ+ob/Fk8G/bDqV5qhklYss7UMhJ8jzUGH/URPp2txTRn7YJp4TNxkel1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrfPLDME; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732545188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qn+b6ULbHlpt1jjPuozeG76v5+tmKAZ3os+xCJI2X84=;
	b=QrfPLDMEGeEVSqFkQadgCGzcpbHGqjY4wMllQDUZ/oA3PScG0rnEO9+IEKDC5HQbde+azS
	78GrHp8kPqUUdQzOq6Pylk2hKkGOU1SF62odjTGoqxzbWjCBu0aevRuDjSXkZdOTZMO6aw
	JD6v4tg9zXInDL04HnTJ/fxzyUBuvfs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-h5QIdqRmP76HgzPs5EnZjg-1; Mon, 25 Nov 2024 09:33:06 -0500
X-MC-Unique: h5QIdqRmP76HgzPs5EnZjg-1
X-Mimecast-MFC-AGG-ID: h5QIdqRmP76HgzPs5EnZjg
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5cfc0df81easo4644081a12.0
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 06:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732545185; x=1733149985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qn+b6ULbHlpt1jjPuozeG76v5+tmKAZ3os+xCJI2X84=;
        b=QsFkfOe6ckV/i3wuVRpH+5IVrovvEI3PI4NFKDXH9tjbPk3YlrDWlrBj510ejsDyL0
         C0edxLrwHxafvp3DSLustvWXXl8IqriyrbIMR9sKK9OmLQXShCkNvRRuQkD/qzofZ+Gl
         kOoGKwZdKupFVnIpr/4Oqp5UUPka/ESHKg8QJ2OhpVkmo7VALWJjDAiGVJw8hu+ziKkc
         M/MbJ7nUiiZ0tpIjdSVmoaiS5ZooakX+lfgrIWIj5P1Cjq+rN4MFMZro/KU6VXRr+00g
         1Pg6Wdd71X7avgCs5WSV2K54YxisA/29JLd1xMzkTLl5SCDDlwXhyaxoI1qmP/V/VJBk
         5m4A==
X-Forwarded-Encrypted: i=1; AJvYcCU1L3Wm0k6swFgNQmrnsF52lyh8XDPFbCzxZ06suCrcEdMvI06qvG5wj/w/GFuMXG2MQMymaG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DeBdVMAHe6NDpaFwuaY1GQsPL2ZfcupCFC9vBKpdPB6Gvn7B
	hMP7ih0IdNLb97sUq4YYlW+DtIZqbgNl3/JnPsUihIAVXxW9RHL5KLqO5F/NfmDY7YNQjp6CnOM
	3FQ/9ylB5VccbJHcrKJ61EYk1RzKO+1rj880XAI0ggM/EZ2N+uht2q0LWbdlCGySH7u7CvNy8Qq
	JCoPirpHqH1qVtkbovcVF8Ld4dnEB7
X-Gm-Gg: ASbGncv7OeTKIjXCCRJeV8a74NYRYP+fH9xEVz8pQ50P8ijH3+dIcizhPejGZtab7io
	uOpPHsE9TNgmyOh6QCNddv53HRFGw
X-Received: by 2002:a05:6402:2686:b0:5cf:d341:dfec with SMTP id 4fb4d7f45d1cf-5d0073daa0cmr17638322a12.0.1732545185579;
        Mon, 25 Nov 2024 06:33:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdCqEdULNd6cF7hPz8sD3hmROqZwCvCy3SMA6nukUKDBvFTRfZbusOR8nHOeyYxuqRGri9L1xRDyGB9J+PRK8=
X-Received: by 2002:a05:6402:2686:b0:5cf:d341:dfec with SMTP id
 4fb4d7f45d1cf-5d0073daa0cmr17638292a12.0.1732545185266; Mon, 25 Nov 2024
 06:33:05 -0800 (PST)
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
 <CAO8a2SiN+cnsK5LGMV+6jZM=VcO5kmxkTH1mR1bLF6Z5cPxH9A@mail.gmail.com> <CAKPOu+8u1Piy9KVvo+ioL93i2MskOvSTn5qqMV14V6SGRuMpOw@mail.gmail.com>
In-Reply-To: <CAKPOu+8u1Piy9KVvo+ioL93i2MskOvSTn5qqMV14V6SGRuMpOw@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 25 Nov 2024 16:32:54 +0200
Message-ID: <CAO8a2SizOPGE6z0g3qFV4E_+km_fxNx8k--9wiZ4hUG8_XE_6A@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, dario@cure53.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You and Illia agree on this point. I'll wait for replies and take your
original patch into the testing branch unless any concerns are raised.

On Mon, Nov 25, 2024 at 3:59=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Mon, Nov 25, 2024 at 2:24=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> > Max, could you add a cap on the retry count to your original patch?
>
> Before I wrote code that's not useful at all: I don't quite get why
> retry on buffer overflow is necessary at all. It looks like it once
> seemed to be a useful kludge, but then 1b71fe2efa31 ("ceph analog of
> cifs build_path_from_dentry() race fix") added the read_seqretry()
> check which, to my limited understanding, is a more robust
> implementation of rename detection.
>
> Max
>


