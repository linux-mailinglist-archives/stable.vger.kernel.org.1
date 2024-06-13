Return-Path: <stable+bounces-52050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66044907319
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 15:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A907CB25A6B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A64B142E81;
	Thu, 13 Jun 2024 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPTh+BEX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF21EEE0
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283785; cv=none; b=J/L5Dyy/MLQk61g4zHTvzHwimV8dIPwl/2gaLgxDfbazcAakC3RR8agDQWt6nWY4gEE2RUiY8sYF6FbjUzzjpLu/gduKIl5SBB0cGZjbunXDTfeGVZnxmow5tWVDwjF1rp+KU3t78pRMtuWgcyugKE89xPxQr45Map0z9GoQE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283785; c=relaxed/simple;
	bh=sKGNoMP+lwPXhQbfCPopDvkrZozPiEMdXonWAliL18c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poT+btESo89xDbp8zbi/MvtNCISJDKzyj2h86L+fejkTOg1z3NGG0d7ABnBaxu8d0+9TUTjebQA2cA7C6WZHkggDFCjA8P4D2W1SpyCWqFn48uk27Jf5vDFhncZpb+SF3Oftkbb+b2PtMH+WnM/M6madC0ImfG1Iv41jMQWKOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPTh+BEX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718283782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yH+jWx7YZJFNJzFGP96zaKaLc8ns7bridUA/k1jWf3U=;
	b=fPTh+BEXzmgttpA9yhnOT2dyXwLEeNsSMqNCRFmfs3I+umo3EzpOYgn1s+xHkhj/57oAce
	BIbmFaJZx/I0Xr2pzMN3+r59SYCbpPLZAlPmbVUsP8J314bphkmELFjFBlaTHHhKv9rPog
	cN9rkCw96xhKnz1gbYn58BBeBDNphFU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-6InPFwsbNrGYSmylo30epQ-1; Thu, 13 Jun 2024 09:02:56 -0400
X-MC-Unique: 6InPFwsbNrGYSmylo30epQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c2f9da840bso897343a91.3
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 06:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718283775; x=1718888575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH+jWx7YZJFNJzFGP96zaKaLc8ns7bridUA/k1jWf3U=;
        b=ULNGj2sFTihkiEFo2kuExQVH/tlJWrlAOiFfpkvev/7hhVgJQH/sXx22bR3FUjyyDZ
         ZHzz9MkVtYW+1JYXnlCUVZsXsKqUBzvq1n8B1DKV58ly/yL6EhMtArAalZCiRRi0RGm6
         58XNeqhvni600ersbXqKQTJR9iU1ZXOze3Sr2fMKwCXNs9rNYiKV58MwTi1XbB8bOa2Y
         iQuZaayRkXaJOppogZgmS+u9K64d74fiveEUHxWQRYiJtQ2isFzaXvnD8hq4zRQRjHiy
         c4AMss6FqBUqWsRnIeio1mzLQbA55Ooi4U74E5sxe+8AyGnTnkvnlipbaaXSavr0/al4
         MfvA==
X-Gm-Message-State: AOJu0YzMllaxcqILLHtb+Y2vJTzZlt1I6rRXifhwtMDgRCvCTe1RwGAJ
	rtEkIKr8bCg34mdegEjwK527rEmlFGOSTtpXy5nEIVfDhwsmEvqKIcXn4AnsHqD049f/OYTQeDY
	tWQwXaov2mqitRuKhFAxmd1ZwWZx9rC5UmlBM1dOeGUMhvQs+0CkfwAQxJLQr+TA1jHnqMUmSko
	aY+0UuC+QdPbKg0J9Ev16UJcpos0gS
X-Received: by 2002:a17:90a:4ca1:b0:2c2:cd03:4758 with SMTP id 98e67ed59e1d1-2c4a760a30cmr4616054a91.1.1718283775508;
        Thu, 13 Jun 2024 06:02:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIjH+d+c66ydyxKKWv0UjroQKAiNYbAIfjO+2HQRComC2/nIyrwuIX2YZV2KWKpJB4BwzdJ4ixQxLzH3JxxuI=
X-Received: by 2002:a17:90a:4ca1:b0:2c2:cd03:4758 with SMTP id
 98e67ed59e1d1-2c4a760a30cmr4616020a91.1.1718283775020; Thu, 13 Jun 2024
 06:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113227.759341286@linuxfoundation.org> <20240613113232.007208207@linuxfoundation.org>
In-Reply-To: <20240613113232.007208207@linuxfoundation.org>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 13 Jun 2024 15:02:43 +0200
Message-ID: <CAOssrKfZCxxnRyesXSXUWrCbWRq94ZaDJjt3z9BRm9zki7P5_w@mail.gmail.com>
Subject: Re: [PATCH 5.4 110/202] ovl: remove upper umask handling from ovl_create_upper()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 2:00=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 5.4-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> [ Upstream commit 096802748ea1dea8b476938e0a8dc16f4bd2f1ad ]
>
> This is already done by vfs_prepare_mode() when creating the upper object
> by vfs_create(), vfs_mkdir() and vfs_mknod().
>
> No regressions have been observed in xfstests run with posix acls turned
> off for the upper filesystem.
>
> Fixes: 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers=
")

Hi Greg,

This patch is in fact a cleanup, not a fix (maybe I shouldn't have
used the Fixes: tag).

Considering that the "fixed" commit is from v6.0, I think backporting
to anything earlier than v6.0 is not a good idea.

Thanks,
Miklos


