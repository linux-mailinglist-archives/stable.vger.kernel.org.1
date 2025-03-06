Return-Path: <stable+bounces-121196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C159A5462A
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035693A0F62
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 09:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41E520969D;
	Thu,  6 Mar 2025 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dfkqdg/K"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E9D20968E
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252915; cv=none; b=UDpyZdXtB9kkXr0xoNZjUuZteNi/iKttoI+z3LgUSI23wJ4OMpG0VlBtsWUVF7kvOjQ48DOKJnSmciGBA0JsDGpF0Ufkmry7+jYdPy//2AjwBi4jn1ah4NVCBL3PLUrI0pqabHpC2qfvSGK6QUa9Ap8iRqiLH6aezE2lMDO6kH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252915; c=relaxed/simple;
	bh=JrJv7UY0NCQva1BcOO8HCWIkIOTM/GmTfwOLyFQyay4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwZPgPGIsxohuyhaldMV0ppTTQnIFOj+XDBLe+SpIwLwRMi5q32mpUxqgXIWVGPLPNFtbKSmSgVlIjzW9gu0TzOtJjWL2p44MvQZKJ6XieAhfKKjKed9MkMEDr/aYxzZNTZT2p6k4qAoQN+IFpXUs8S0vgwwrjNCE6mQpB+qmjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dfkqdg/K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741252913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wSxjuuFj2XW+XA41gJzAF+htyhnE53Xf0kEnMei0AwA=;
	b=Dfkqdg/KDmQx5BGZgTRWqAUuPNKK24F88IZlneYKX141+shs3wUY0qtRIw6/ZADjLeDnok
	l2Cbghcq3+rX/HH0Yoj/Qrla3qURQcLlsQ99SUkLW3reqUN8nepvJeZvF5UtwI0qJpoQkD
	S57FZh0eX9QccxDrLTSpHriLt1RBNAs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-TqwlSWXSNuK2M6EjUSOFTg-1; Thu, 06 Mar 2025 04:21:51 -0500
X-MC-Unique: TqwlSWXSNuK2M6EjUSOFTg-1
X-Mimecast-MFC-AGG-ID: TqwlSWXSNuK2M6EjUSOFTg_1741252910
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso2413415e9.1
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 01:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741252910; x=1741857710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSxjuuFj2XW+XA41gJzAF+htyhnE53Xf0kEnMei0AwA=;
        b=a9/cX7Y0JpbEqePTbUNUXV2Tlusa2JqUy3SS/cb5RzBSoKwl77eCn8VK2OnfHgQVZI
         zDgqAl01vHAKW7TOze68WbLYs11K9Utp2ZyBHkgUjXUcilzi3moRlSeiektwDKjND2zh
         oNlsbkC8jE8bCqNbW3bigjuLiaHd8o0OQJK2PlzrxJEcpMpPI6x4GCp9Mg/s6VWy7+v8
         xChCOyWzKtLpF0hKaT/g9DwRDpfdgJmormmRhdAFIJ4r8NepMX5Zx/HrnxWHVcYGUTqP
         8j+bqeXPTLXnVqg2ZSL3NJwZNDSzP3orS+6Tknrj8AjgCPQsbtZrCwOd03NPtXxaLeo7
         t/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUanZCTqhJ/wg9tV4dI1ULo1ig50OIrc5vY9N1y897b5QM6a6MKZFC5gnZsIx34qUGjvuVbzD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv9X/kdE6da9XyHG35OVqt0FA/U5z8Wwb89BLsjPkBA755VnFq
	lAcDchqX9aFLShAGEdgyglY7AauKGI2nmpZYYqw1qCqlp7OC4AUtDif9AMPT9Kd03Huh9wbEva+
	+UPju+80ZpFbO1Xt99SJLck6d4E7a6Ix8ocsUIzVFyGaI3JxmLbyqjA==
X-Gm-Gg: ASbGncuZxk2416Imksa5JPPDRKLzQiEIvYLDZhcNNLJC4wevGYVmzOiGJKy/5k+rCeq
	m8J3dDCz4CWDlsyjHLxfYcBfQR/6XDZWj4zwKuDpYYe+0Ax/Tt/zLb77B4zn4sO1s4NDVvJ5ngA
	Bw29kPVlfLETAWz94RU88wrCAYUFRU3Ftq3f6M5R8znfe2iw0Zpid581/8ZrW+ey1vlnVNaTH5d
	F+JIxIJxgT9Q7QF9Tev1J1lgs4itJU8u+qFSgZf2YpmVTrlcBpXLHkb6EBQ1c7SU2hziEHJD7lH
	kba/6yse3OjeyZL2TQ==
X-Received: by 2002:a5d:5f8b:0:b0:385:faaa:9d1d with SMTP id ffacd0b85a97d-3911f7b76ddmr6401863f8f.35.1741252910225;
        Thu, 06 Mar 2025 01:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt18p9FCAfM0c3ZyBBVP666IiarA4fQmuLwXbYoZQZ0OuIvboOyguPnL1V7SWnDl4ANEyb7g==
X-Received: by 2002:a5d:5f8b:0:b0:385:faaa:9d1d with SMTP id ffacd0b85a97d-3911f7b76ddmr6401836f8f.35.1741252909819;
        Thu, 06 Mar 2025 01:21:49 -0800 (PST)
Received: from leonardi-redhat ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8dbb4csm13788055e9.23.2025.03.06.01.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:21:49 -0800 (PST)
Date: Thu, 6 Mar 2025 10:21:47 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>, 
	stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Subject: Re: [PATCH 5.10.y 0/3] vsock: fix use-after free and null-ptr-deref
Message-ID: <2fx5pzum52zhb45vp7f2csns5gc7l2pl75mo67gy2ewirofy5e@5yh56gdgyiha>
References: <20250225-backport_fix_5_10-v1-0-055dfd7be521@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250225-backport_fix_5_10-v1-0-055dfd7be521@redhat.com>

+To Greg

Ping :)

This series is also available for 6.1 [1] and 5.15 [2]

@Greg:
In the future, should I put you or someone else in CC every time I send 
a series?

Thanks,
Luigi

[1]https://lore.kernel.org/stable/20250225-backport_fix-v1-0-71243c63da05@redhat.com/
[2]https://lore.kernel.org/stable/20250225-backport_fix_5_15-v1-0-479a1cce11a8@redhat.com/

On Tue, Feb 25, 2025 at 03:26:27PM +0100, Luigi Leonardi wrote:
>Hi all,
>
>This series backports three upstream commits:
>- 135ffc7 "bpf, vsock: Invoke proto::close on close()"
>- fcdd224 "vsock: Keep the binding until socket destruction"
>- 78dafe1 "vsock: Orphan socket after transport release"
>
>Although this version of the kernel does not support sockmap, I think
>backporting this patch can be useful to reduce conflicts in future
>backports [1]. It does not harm the system. The comment it introduces in
>the code can be misleading. I added some words in the commit to explain
>the situation.
>
>The other two commits are untouched, fixing a use-after free[2] and a
>null-ptr-deref[3] respectively.
>
>[1]https://lore.kernel.org/stable/f7lr3ftzo66sl6phlcygh4xx4spga4b6je37fhawjrsjtexzne@xhhwaqrjznlp/
>[2]https://lore.kernel.org/all/20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co/
>[3]https://lore.kernel.org/all/20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co/
>
>Cheers,
>Luigi
>
>To: Stefano Garzarella <sgarzare@redhat.com>
>To: Michal Luczaj <mhal@rbox.co>
>To: stable@vger.kernel.org
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>Michal Luczaj (3):
>      bpf, vsock: Invoke proto::close on close()
>      vsock: Keep the binding until socket destruction
>      vsock: Orphan socket after transport release
>
> net/vmw_vsock/af_vsock.c | 77 +++++++++++++++++++++++++++++++-----------------
> 1 file changed, 50 insertions(+), 27 deletions(-)
>---
>base-commit: f0a53361993a94f602df6f35e78149ad2ac12c89
>change-id: 20250220-backport_fix_5_10-0ae85f834bc4
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>


