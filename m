Return-Path: <stable+bounces-114906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31702A309F9
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 12:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807F11888FFF
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62111EEA38;
	Tue, 11 Feb 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWKF5rWP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F8D1B2182
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273559; cv=none; b=qFZ5ILuELHTgTsZ/y9Qxv/2MxNwqbGmtEE2GhS2z7WIGw1CU+u1HweWL5XtoJt7Mq2MsKy0kZrSTzPsvx+NSIP01NEzQWwLKw0xWPJ/grsPirqrKgm+07kk7bSwuAaUVLdBJy9XdUCllg8KQqMY6yp1HGtkfnwL7fwrhCM1OOqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273559; c=relaxed/simple;
	bh=EO4/jQobuhPn7Cmiwwj02NLiQtDBFVdjPBMev3aXkm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxp1fOq4Xco7I6ZEYC4xVmmXcREIE3xwDEfjJomRKXOmlPq/+WHau99Fo4x8/3yZGwgGLAPbEaS13IlzG7PbtsKP1Z80MqSu2OnUHCT3op3ZBPnhsZkgP89kRyDTcoNr81sGuRjg0P3BAlQ/XDfkwIwKWwaKQduOfNnmOhz/M0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWKF5rWP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739273557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EO4/jQobuhPn7Cmiwwj02NLiQtDBFVdjPBMev3aXkm8=;
	b=eWKF5rWPmV3XwCpxLnu2/alfbZM10l4bgVouD3cVJEZGydAenWiKXAzBMDNwIuNMzyiQO5
	KLxRmG938MdGp3pKW3Ai+elWgmKrSPTAW2ohmIipKUCcepJ4f0cyCyJEAELTJz2Im7IHwq
	1qzVExByBU08lZIsWQqLfnTMF8YW0rA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-l_aKqD6IPVaEIVM4rJATSQ-1; Tue, 11 Feb 2025 06:32:35 -0500
X-MC-Unique: l_aKqD6IPVaEIVM4rJATSQ-1
X-Mimecast-MFC-AGG-ID: l_aKqD6IPVaEIVM4rJATSQ
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e5b4b8d71easo5194584276.2
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 03:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739273554; x=1739878354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EO4/jQobuhPn7Cmiwwj02NLiQtDBFVdjPBMev3aXkm8=;
        b=OFkJyDMpIUsoLTU9IGXid/BiERsq0QD8b/7nPwwsDLgH68bm66gNO6Hco+efRxb5nI
         +UTBG1vlt1F5V0XwI0hS5bbr1MpCgvCJzUnxMLuvz88zI6f5qT+ExczOtSaF9DOrdZpA
         2nKXjerlZBtNxRuBvrOzKyxzPHJFOI+oloJKSSXxj8GGLPD2YqQsT+5W0LlEg/CWZc6+
         rBYWTkaaBAWn+KWDCgOfoDi1fzK/TZNMireDuoFpqEaPS3D6aJmW/NIC9APi3UI+rIeT
         AIrw6TlcVR96a3hag+uiZ/1H5T3TfRYS/AiBCTsjvZrssnemW9di565onw8BkTJFOBye
         kLwA==
X-Forwarded-Encrypted: i=1; AJvYcCWIGQEVE7chlBDSIvnSKzsOnrXy4GzMuBGyK+ZUai7tWi3LB7SHgXvKQo6OBDHDtXleAdJsRfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaXQTzE7EVeV993wnno5c1tNrnWMyN8p9YMBQM+sDHuTwcLzBJ
	4SyUPHIREctP3f+jHKyvEndqZ8UpditoekMpikmKRyPgZQW8DLIKe75BwDo/D2l7i/M1hkdOeSY
	THGqsqhnTH+QMbxnrQxFWckEnn4tigRNWOMe0I487m3SEJCOKcE18XDrDjbhbvwsETN4sn9Wkxa
	mwtSXt+lbm4vujCwGO/huUWxB2pkaX
X-Gm-Gg: ASbGncviKLPb0j7FHuBCeBs1pVdHBGBE8DWHzb6bzX7BOOa5OuxKkANKolEDSLOkQog
	DlV3G622Aca2MLUgLoC2tVhMyxcZwaHD2FbPvT4+YVsXBkfXPt7ZkB+JHalU=
X-Received: by 2002:a05:6902:2682:b0:e5a:e8e8:b1c3 with SMTP id 3f1490d57ef6-e5b4616d3c4mr12397252276.9.1739273553948;
        Tue, 11 Feb 2025 03:32:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaXPvSr/r7GJKXBCTZ8mvFwo5y7ehet60QHmF+NGIwE1ut+FV+epCEC5e5wZciV9VP531RTF3EI5Zdh7v+oOI=
X-Received: by 2002:a05:6902:2682:b0:e5a:e8e8:b1c3 with SMTP id
 3f1490d57ef6-e5b4616d3c4mr12397240276.9.1739273553698; Tue, 11 Feb 2025
 03:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025021142-whoops-explicit-4d75@gregkh>
In-Reply-To: <2025021142-whoops-explicit-4d75@gregkh>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 11 Feb 2025 12:32:23 +0100
X-Gm-Features: AWEUYZnmLtOifRY_-G8oySsswdCBZq-5431KW3ptxFllYuRueoB9HPE_RnHjueY
Message-ID: <CAOssrKc8gxsOoDUL3DVa6hgOiuZ533aF_TMLkbVe3XfJLRYBow@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] fs: fix adding security options to
 statmount.mnt_opt" failed to apply to 6.13-stable tree
To: gregkh@linuxfoundation.org
Cc: brauner@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 10:54=E2=80=AFAM <gregkh@linuxfoundation.org> wrote=
:
>
>
> The patch below does not apply to the 6.13-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Please apply the following prerequisite:

056d33137bf9 ("fs: prepend statmount.mnt_opts string with
security_sb_mnt_opts()")

Thanks,
Miklos


