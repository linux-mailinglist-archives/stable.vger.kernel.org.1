Return-Path: <stable+bounces-183439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A4CBBE5F8
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 16:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC2294ECECA
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6212D541B;
	Mon,  6 Oct 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im4Ifywn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD040283FD4
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761616; cv=none; b=Csovosbfk42CYrAMOBOJq01Zj062Ew2AP5CMe/T/52Pgzkjo7W3jvnn6CK5lSSztA/oHFZRNRYi5DPA9Zdn4EuS9cKqhHD+bC1OkM6kZQr9zZmbKvVXEivoazZ44cKMO3f50vcx0OGAqdQrGLzLM7iQBbrvyJPM45doRg42Mtdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761616; c=relaxed/simple;
	bh=EkR1H7X+TDjtCRI9KWYEwXGW5NBq3MyXaQ39Dh/nn3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzzDfUPhqtLUzimOz30NGVrkEGN6C1qOqJq1VuGWAfQ+ZV6oPqGtruGzGn/qfxy7dDtuyyQ4jXkexBPTFueWXANtUsJn2VZzJxuEyNG2/VbltPfMRKjuf1y4GGNzlceCRyuUtjX1eaemgTPieNWHmidYeLv5FFdSdUQD5lDF94E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im4Ifywn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso11141097a12.1
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 07:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759761613; x=1760366413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkR1H7X+TDjtCRI9KWYEwXGW5NBq3MyXaQ39Dh/nn3M=;
        b=im4IfywnSfxkP83dl8psGq2Rk2Z21zYb4jvP9nKF9vr9f3Nn2L6JqohFlgdCpyT4ui
         SNFRCjB8yvFMI7CGKmJrS/VXB1bWBqMIfcJZvFZa4qnDartVwNwBa4dvznfG7eOUJ1HF
         G2e2ITptWjR30EYsV02Yg1H2TFrHGR8XbQi4bC9NxRJveiRU75yQl8kSw1uObnrbT0gL
         l3FSe1dS2uheXAxUp25AiVvk5wG/pXZVqk6Rk14JRX9GSF9Uy4mN4pSI+oWS04AF5HJ4
         orYYatd8sXLkae2RL6M3y4FiUyhBU8oM39Kgc71VZqj5Hxpph6tb0+CvSu/njymjp636
         yNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761613; x=1760366413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkR1H7X+TDjtCRI9KWYEwXGW5NBq3MyXaQ39Dh/nn3M=;
        b=umrlu2m5JsKRHR5nGFqAQkutfgGoRQG4NxrqOiUzMka7H0nFc3UOQW2xn2DanHbkH2
         ubOsuGVrQIZr9DVgT2zXIoPYPblA9xkHyo29oC2y2jp+39cHW8xduQXC5geskeaExSzw
         3yONGjRPv2Ut6M8MDSUxQosPfQyx2eWtEcxLtH2rNXhJBH+hbwkpjB8XBZG8eCKkBmhm
         atKqwMZqLM7t1Oed9GdSts71XDlKtAP+DJj5hs7tPZHaN0OZf9IppPNT6l2o3MQ9bS7v
         uN7TCdQGFvk56jkb0KqJ56bfYUWeRJUp59KXd0ZYYruWPlPJ35x5+cIPzJL0E6yYixmS
         SkNA==
X-Forwarded-Encrypted: i=1; AJvYcCXTyDJzAhVycScvzr9RUKbRe9d3lG3Yz5NL/v0lYP51fealSNQmHdbIHHcITryvObywRJhxwJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylyZOjOSJXxVoEVAGS2JJBB2iuyv/+5pYv0IVKXw/mJefxh7jg
	QYK8D4kynfpI0vR2T0qKeq2je2Fx7WUrlLS7USrD/ssCmv7dKZY0OkAaUA9WZz99W8iEHNWCBg5
	qAYd9b88jFf6zWYtCWB+su3AhMPFqF9w=
X-Gm-Gg: ASbGnctHNss3v2LuE7NdKkSHQ6Q4Gu4/xIX+gaPGa0ZAG3WMCCyQ79pBwL23Fk2bvK7
	7kINBj2tkZWi8jPSxuJa9s9QcbZeHPiRl+c4yWXMS1g4vIF1TlL0A0oBwN3CS6IF7kCIZKkcKCU
	5G9TTiPMAsN4+TXA2jF1nctfrQEDlUnwaYzr+CFKIdF+oLpW0e62esrOTV/+RfsP20Uz6+/WJCO
	PHQ2Jic/MxpM+x67FkTsUmsnahf944qd8ZVAWBiE3OxtfLirmsHIfUYWN8kKik41PnrcVY1tclF
X-Google-Smtp-Source: AGHT+IG7l9FcW7nFH5wcnGqf94SKHFIJbD02eMTFgXIso7ems2/RZwPOGR76iL5Jz5L+CD+kbTGEfLyCiPawWH7oe0s=
X-Received: by 2002:a05:6402:520e:b0:634:8c41:c299 with SMTP id
 4fb4d7f45d1cf-6393491e788mr15011143a12.19.1759761612739; Mon, 06 Oct 2025
 07:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003155238.2147410-1-ryan.roberts@arm.com>
 <edc832b4-5f4c-4f26-a306-954d65ec2e85@redhat.com> <66251c3e-4970-4cac-a1fc-46749d2a727a@arm.com>
 <989c49fc-1f6f-4674-96e7-9f987ec490db@redhat.com>
In-Reply-To: <989c49fc-1f6f-4674-96e7-9f987ec490db@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 6 Oct 2025 16:40:00 +0200
X-Gm-Features: AS18NWBuQFyxsQau3P8JL_AyINiEL_Ybt3_UNKcM6OGOrGzarzlxxcIDC21sR04
Message-ID: <CAOQ4uxh+Mho71c93FNqcw=crw2H3yEs-uecWf4b6JMKYDTBCWQ@mail.gmail.com>
Subject: Re: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 3:53=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.10.25 14:14, Ryan Roberts wrote:
> > On 06/10/2025 12:36, David Hildenbrand wrote:
> >> On 03.10.25 17:52, Ryan Roberts wrote:
> >>> fsnotify_mmap_perm() requires a byte offset for the file about to be
> >>> mmap'ed. But it is called from vm_mmap_pgoff(), which has a page offs=
et.
> >>> Previously the conversion was done incorrectly so let's fix it, being
> >>> careful not to overflow on 32-bit platforms.
> >>>
> >>> Discovered during code review.
> >>>
> >>> Cc: <stable@vger.kernel.org>
> >>> Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
> >>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>> ---
> >>> Applies against today's mm-unstable (aa05a436eca8).
> >>>
> >>
> >> Curious: is there some easy way to write a reproducer? Did you look in=
to that?
> >
> > I didn't; this was just a drive-by discovery.
> >
> > It looks like there are some fanotify tests in the filesystems selftest=
s; I
> > guess they could be extended to add a regression test?
> >
> > But FWIW, I think the kernel is just passing the ofset/length info off =
to user
> > space and isn't acting on it itself. So there is no kernel vulnerabilit=
y here.
>
> Right, I'm rather wondering if this could have been caught earlier and
> how we could have caught it earlier :)

Ha! you would have thought we either have no test for it or we test
only mmap with offset 0.

But we have LTP test fanotify24 which does mmap with offset page_sz*100
and indeed it prints the info and info says offset 0, only we do not verify=
 the
offset info in this test...

Will be fixed.

Thanks Ryan for being alert!
Amir.

