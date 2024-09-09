Return-Path: <stable+bounces-73947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 222D3970C9F
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 06:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD05B21A44
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 04:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED71ACDE1;
	Mon,  9 Sep 2024 04:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0071ajW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E10522098
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725854757; cv=none; b=UtitxVaYSYSG/o4TMZnUuYE1KaQVIcqZtpe3NtQIEV2e8CpgHXyKEP2eYBOK3e0us6UyPHwCVTFBL6TfZ14m0aicj8qOUsiSClJOAxgpPDPEzIE31TjI3rtpSU0K4k/2izT/cZMsM3xoL+Dy53x7JMpqig6ebQ1cXbkxCd98BhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725854757; c=relaxed/simple;
	bh=7CambRdxJl72z45osL7W3fqqVzpgMRyRPNU6hNJpNIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJRqNBvjz0jEnDPHtA8w7pF4zGrRJOifUO7Jxi4OlqhnRT8AJYZCyrdtLMujQW1oVO99x78a0RyrTXDWJ9AS6pEgLHdwroNxgujxs6shDXRkqfzYtM1unTJu7A1dr0eiIeebKfSHEfaIEx9px8Td05N8NE4HThZ6O6A/ucv43nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0071ajW; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6db4b602e38so22590087b3.1
        for <stable@vger.kernel.org>; Sun, 08 Sep 2024 21:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725854755; x=1726459555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y2XZicmIZualwCUhlDFNpSmFy2HjzR6Yh2gdcKw5gw=;
        b=N0071ajW9r2Xg21qH62Dw8FKVcyd4/lEhzkOWdXLqUVd5r73SFxpcN/uVpg21Vq6OB
         tSwVg98wSWtMtikq2PyUlS9UiiEAMMu7hXMtlhxMsylnhyJKIfZrvLqT6WvT5imrtvtH
         hEPy9JSX8IgjNzYjp3Nmv3IRMRPk+rracYbvJl/n90pjdaDzld5MkqflugkBSWGSbkpj
         QGktE+UTZPsqPNUvLJDM3aqSEp9KoPFz13vYGhAmAqXkQfFo8a1pCjI3pSbvxF8G+TzJ
         HrwEx+8EB8Qx/xv+hyKA7v9qGoGoRnJ9aek0AWZnyN1pVSoMlae1oD1T9s1dodyMt2Pk
         ZGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725854755; x=1726459555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Y2XZicmIZualwCUhlDFNpSmFy2HjzR6Yh2gdcKw5gw=;
        b=t1/x3z5p/sABhbsMfikoo+jNpAp0ENhS4O/5XEkospQtJ0OwVBtDM8cKr4bA4aRjIe
         CC3Zmxuum4XNRgAkgBqsV+lhvG45gkVRuKKghx4rrxsjLHHC/tELpo5W8eh0CcssIslg
         uHGIDQh1PL2KfUO9ywmD2hcJUPrZE1UMpy5in+9U8ZxY7mg7p5hI4B+hj+UBYG1avQa/
         gr6GneS8mq3+iGQlOMGzGkz48EKCE8+hk3xaaR4/1IGRaqHRBx9ZY7adWaVvEJ1LE7fv
         Q6f1ZBglzxKBadiCQ4zbYdbSyY+vYs5zeZ5jKlsATCnt+nhOeSMSYQPSUflsthSEsZW3
         sxRA==
X-Forwarded-Encrypted: i=1; AJvYcCXedbiUoxrpKVSnUryaklEY+u96UqUhHBVK+VGRWMDu9Aa3hGI8jVPU7r1mhra/yNkNLnYjIeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPrievDIctOB6QkqKgnb/SjvnRKtuICBRP5eBrN3afXpsV1Ln
	9zOFkzyDneG9TV6wTeCXMEjP6mlSB95tMljIw7B30iLv73ne51NzvHeimP0tbN93sWEM5NpJ+5Q
	ELcBhAmtFF5w8mh000rHxZBZUon6toGwtIaSy
X-Google-Smtp-Source: AGHT+IEaDecNSAZTuzUTKcjIfed8c+2zGuiy9Snz3OkvQ9Wfl/mmUdiCogvvHJc2dP7/xkD/6w5lUbKgCgjZaSjV9BU=
X-Received: by 2002:a05:690c:5203:b0:6be:2044:9367 with SMTP id
 00721157ae682-6db44dc6b5fmr77199477b3.15.1725854754798; Sun, 08 Sep 2024
 21:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89503333-86C5-4E1E-8CD8-3B882864334A@theune.cc> <2024090309-affair-smitten-1e62@gregkh>
In-Reply-To: <2024090309-affair-smitten-1e62@gregkh>
From: Willem de Bruijn <willemb@google.com>
Date: Mon, 9 Sep 2024 00:05:17 -0400
Message-ID: <CA+FuTSdqnNq1sPMOUZAtH+zZy+Fx-z3pL-DUBcVbhc0DZmRWGQ@mail.gmail.com>
Subject: Re: Follow-up to "net: drop bad gso csum_start and offset in
 virtio_net_hdr" - backport for 5.15 needed
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christian Theune <christian@theune.cc>, regressions@lists.linux.dev, 
	stable@vger.kernel.org, netdev@vger.kernel.org, mathieu.tortuyaux@gmail.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 4:03=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Sep 03, 2024 at 09:37:30AM +0200, Christian Theune wrote:
> > Hi,
> >
> > the issue was so far handled in https://lore.kernel.org/regressions/Zsy=
MzW-4ee_U8NoX@eldamar.lan/T/#m390d6ef7b733149949fb329ae1abffec5cefb99b and =
https://bugzilla.kernel.org/show_bug.cgi?id=3D219129
> >
> > I haven=E2=80=99t seen any communication whether a backport for 5.15 is=
 already in progress, so I thought I=E2=80=99d follow up here.
>
> Someone needs to send a working set of patches to apply.

The following stack of patches applies cleanly to 5.15.166
(original SHA1s, git log order, so inverse of order to apply):

89add40066f9e net: drop bad gso csum_start and offset in virtio_net_hdr
9840036786d9 gso: fix dodgy bit handling for GSO_UDP_L4
fc8b2a619469 net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation

All three are already present in 6.1.109

Please let me know if I should send that stack using git send-email,
or whether this is sufficient into to backport.

The third commit has one Fixes referencing them:

1382e3b6a350 net: change maximum number of UDP segments to 128

This simple -2/+2 line patch unfortunately cannot be backported
without conflicts without backporting non-stable feature changes.
There is a backport to 6.1.y, but that also won't apply cleanly to
5.15.166 without backporting a feature (e2a4392b61f6 "udp: introduce
udp->udp_flags"), which itself does not apply cleanly.

So simplest is probably to fix up this commit and send it using git
send-email. I can do that as part of the stack with the above 3
patches, or stand-alone if the above can be cherry-picked by SHA1.

Thanks,

    Willem

