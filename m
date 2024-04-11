Return-Path: <stable+bounces-38898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE5E8A10E8
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF511F2CEF3
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B69142624;
	Thu, 11 Apr 2024 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icQGWGxA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F113C9A5
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831917; cv=none; b=Ma6lCQo3v1AIr0vkY4MAvVA+J0GhbSpNXKrwT7g1Y43Bj0pdXq2FpafJhF0zixYqxLSHyDINSYbKz2c9tEZUD/QVGeHmZMK3ROoub+jcaU4tZPnWdF78X9F4Fg0GyItwZmn/KZssSU92mdLa+lwXjlanJlZaINM64ug1bHWqMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831917; c=relaxed/simple;
	bh=MESeRDHPunaASxUaHAPetHb9HjlSRtpxTfy9NZaixs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3hHGLAj3mGHBM9Zl+YlojQSF6EWzS53IlO7103/NSd3+FUYcqzYBpARWje8Edr4rP/BII7Q71BGGB9SCCC5aQNcv69xmCVQXijwJ02fS6SjbT4DxiMoZVB3roRoSj9DbXujf5KPIhc0NBxnkfulsoRWp0liHL+rHxXhKRt07qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icQGWGxA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712831914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eR5GNV+l4scBem2kbMM6ywL7pC+HMBlFnK+oKg3nC0=;
	b=icQGWGxAqBDSa1zZRnNj9+dLNzvUFNqJ1zRo0cCbloYKI8+djk7e2q2YqIZ/nDZZSTXqyJ
	jUO+qXu10ODyJgi8ardcaBqSkgOiOLRaBOuFSty/cCOGz1vGhiKahxVta7Dq6e84rMwzd6
	GEClLZjlZLRRjQlk6ao3JlH5l1I8usY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-lHpMZQnmPrydAml7iIxH5g-1; Thu, 11 Apr 2024 06:38:30 -0400
X-MC-Unique: lHpMZQnmPrydAml7iIxH5g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a5d989e820so1479315a91.2
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 03:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712831909; x=1713436709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eR5GNV+l4scBem2kbMM6ywL7pC+HMBlFnK+oKg3nC0=;
        b=lLF3cfSPY9Y3H51YcUcaEzJ2leuHwYy4hORl7VCRm6Q9u9UH8Hcrj8O8g/bZtQSklI
         vXIO6Z4BGcTcsofaHZsZcmaoOCrbDOfqOCwyEriijANYRkwcy4KJxzIDZYWc7l/bVK0o
         T4hlvfTo0IvSWHTDiW0AaBiV5oTTGGGQKU2SX0z5TMOXebUG7kTg1VjOalXgXTV+2wEz
         yeFkUMR7RfBw/7lll2sGLAqQ58F9/gMfBr34id323wgMxMnLNM0SU5eJEqCKRwPmz2g0
         mhOQwy8ie6yf4JtWftpWAIb422xAzAYlpBX+pB95Vn6uA4nolM76RYP4Q8S7P7GE51ic
         WLgg==
X-Gm-Message-State: AOJu0YyMyIqKvgKi6vwX8sHD0GtK3vGnz5BU5RMv9KEZJk5esqR7GTj8
	8wAL6c21ouclQTgWJP5dF12hjBCcfnNHwUddTSdACDkgNkreOlHOY5DOIxQ8HtTJbsFeL8lFDSI
	aLXAlHDvwFUFOEnGXuRYiDn0VjcCcJZLt0BTLdtmzFgH+jcvi2syMdMNSv5B4gMONw7sUu5N/xa
	03TlOc8k+W2q0EBepqdGesqAKeJA4z
X-Received: by 2002:a17:90a:fe8c:b0:2a4:ad2e:1c5a with SMTP id co12-20020a17090afe8c00b002a4ad2e1c5amr5444733pjb.35.1712831909029;
        Thu, 11 Apr 2024 03:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYG81oDiN+wTKwCsGUjBQEW5injtojjDmF1lTGqvLT/7uNsSF/5crOEW6Z3A5mh2Rjwp8eO8wI6YZpwsipvhA=
X-Received: by 2002:a17:90a:fe8c:b0:2a4:ad2e:1c5a with SMTP id
 co12-20020a17090afe8c00b002a4ad2e1c5amr5444724pjb.35.1712831908682; Thu, 11
 Apr 2024 03:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411095424.875421572@linuxfoundation.org> <20240411095426.249853460@linuxfoundation.org>
In-Reply-To: <20240411095426.249853460@linuxfoundation.org>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 11 Apr 2024 12:38:17 +0200
Message-ID: <CAOssrKfFgJcKK1RGbo4bDy0DkQ57Fe3Q9H89Jwgjh9yVj3qwJg@mail.gmail.com>
Subject: Re: [PATCH 5.4 045/215] fuse: store fuse_conn in fuse_req
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:16=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 5.4-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Max Reitz <mreitz@redhat.com>
>
> [ Upstream commit 24754db2728a87c513cc480c70c09072a7a40ba6 ]
>
> Every fuse_req belongs to a fuse_conn.  Right now, we always know which
> fuse_conn that is based on the respective device, but we want to allow
> multiple (sub)mounts per single connection, and then the corresponding
> filesystem is not going to be so trivial to obtain.
>
> Storing a pointer to the associated fuse_conn in every fuse_req will
> allow us to trivially find any request's superblock (and thus
> filesystem) even then.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Stable-dep-of: b1fe686a765e ("fuse: don't unhash root")

Why are this and the following patch marked as dependencies of
b1fe686a765e ("fuse: don't unhash root")?

I think they are completely independent.   While backporting them is
probably harmless, it should not be needed.

Thanks,
Miklos


