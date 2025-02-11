Return-Path: <stable+bounces-114903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AABEA3099A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 12:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EB2188A794
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647831F4E3B;
	Tue, 11 Feb 2025 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfIDxxaK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C81F4E5F
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272410; cv=none; b=HegwMv5QpwORD2go/OSxmjbansDek9hIun9eTXNRsIGdPbR49A+KjO4CIIM0rOqWaTX0nLnI18pUD500yOEapW+PwkR/sxeoKpglAYI20AA0/mOhXIiCqme8DgaDld9kNKqNSxdmCGEaya+uIavhovCAhS11LBkOoSD+u/oIjxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272410; c=relaxed/simple;
	bh=sPXzVviuYgrnFYySqNP4IrASX+EcQWIQ9Md0BlQxLBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uG/CHzrP3G87dojqV4FYJLa+/RKeZLjFzl9Zn7rEL5LON3TQzlhpxapglEzYUcaNhQgFodZUjdfkwtr43BYUjHapGWKlVojKwwmODbpDb3uO82nqwJvKoadjXf78JHZt5EWX/DNyHDijS0C6o7JNw4D2nVpcysq+Gl3pHWJqK1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfIDxxaK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739272407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPXzVviuYgrnFYySqNP4IrASX+EcQWIQ9Md0BlQxLBg=;
	b=HfIDxxaKIF07ez0pVS6f8RMQkSTi1fmRxcHSPFCkoeEerooJHH2a+dbMasPLuLeguQg7Xc
	T1QkD+1E07FUTNxZkG5oBI5lf3wznDD6rtm8RHnPnjZEcOh7yVP9rhT3n+pVIXcGGj8VNd
	LeW6cVkcdWUaBCNlVkgSp7mOYlnX6nY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-ADYOTAJjNVWLN1ll_SOKGg-1; Tue, 11 Feb 2025 06:13:26 -0500
X-MC-Unique: ADYOTAJjNVWLN1ll_SOKGg-1
X-Mimecast-MFC-AGG-ID: ADYOTAJjNVWLN1ll_SOKGg
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6f46924f63eso79650847b3.0
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 03:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272406; x=1739877206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPXzVviuYgrnFYySqNP4IrASX+EcQWIQ9Md0BlQxLBg=;
        b=E2k8JqQSQ52phuyQ4USk6IbUiSAUJjjn4+dAn+HK8bcq9pMwfwI1m9HFA6vYm+dURP
         Y4mEfSmBflWHCZjLhqG278mL9elCgVxm7IL145USOcEkbHA1Xy/S58fOfmjhSxE5qClU
         /n44u3/aZDgVFqKIvlMwcJuqbBO62jidKTp+lFZRHGJqKslkJm/pX/nYcjwvbUBzuN+x
         g+ZLX9q3Te6F5CeFhVyodhd+lFBBlL9fpC3iDuxcomDaGU5C5s/OKLTNsORgPOp+/qg+
         e6UdYVshLlTe0DgSTS+AwPRTS2MfDL9q0CSgY9y3vkcsmmmHQrJMCaHCAokj/U4QXTIb
         28/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxNEF/RE9G32asiYayallALIu+sjCI+wpDHW/EonCK5TuDg9I46U6mpcKStROIAdKomsTRHIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4X1/aRgNUIfapJyDY8vnmQK0aCR8NGLGwL00ur/TeSOq7bsL+
	6l8VNB0xRFVhrSrFyzuJ2JofM3C47YNWUa20zaUF6WbOGA73921LkXnZxp+AGnGBqwF78fIZWpz
	7S2GSBXVoH5mhn7q08xYDpl04md74wtQw/rZ8moL3/FLHtS15qaisIhlJaQ1zV8ALLzMDpJeb6g
	Z8kakH8LqD8AwfuWKno8FbXq8LMk0W
X-Gm-Gg: ASbGncs4vTh5niHBdgecEXmhEtTPttQGisT56ENydtGD0k31WUJpUsH7Yh2KIoj9kNo
	WL6vpMovGYBOm6KVa8adOKfL5fWlSdJnqU5gQczNBX25BWXVDVKYo7PxyVq0=
X-Received: by 2002:a05:6902:2410:b0:e48:a3d7:89db with SMTP id 3f1490d57ef6-e5d944c9c76mr2943002276.13.1739272405992;
        Tue, 11 Feb 2025 03:13:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1HJcYYicNcue17SasHEqwW9ME/khvXiAACPbqlfXkv+uWZMu1iGx1FkYHd4kveLiBEQJAI9R9Kk9qHohLIEY=
X-Received: by 2002:a05:6902:2410:b0:e48:a3d7:89db with SMTP id
 3f1490d57ef6-e5d944c9c76mr2942996276.13.1739272405757; Tue, 11 Feb 2025
 03:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025021142-spearmint-explain-70ac@gregkh>
In-Reply-To: <2025021142-spearmint-explain-70ac@gregkh>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 11 Feb 2025 12:13:15 +0100
X-Gm-Features: AWEUYZlkJCKXCvkQDgM5GQ9wxy-RvFsI3_YVgQfi1hblqsuN86qk-c4YLyKMW6U
Message-ID: <CAOssrKd7+skwZ3e95swzRy56jaVa2s2ihxyyFanzOEmaS4p7jQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] fs: fix adding security options to
 statmount.mnt_opt" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: brauner@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 10:54=E2=80=AFAM <gregkh@linuxfoundation.org> wrote=
:
>
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Please apply the following prerequisite:

056d33137bf9 ("fs: prepend statmount.mnt_opts string with
security_sb_mnt_opts()")

Thanks,
Miklos


