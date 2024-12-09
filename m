Return-Path: <stable+bounces-100269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E55D9EA271
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 00:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24770281171
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D130319EEB4;
	Mon,  9 Dec 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyp3x7nt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45820142903;
	Mon,  9 Dec 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785845; cv=none; b=WAqbhbH7Inz7WGi10288Jt7dyQwZHZ5N4X30CfopRu/bOZ5vQDlZzOA/OVElWD77njXMEQjCKKivnAEpzKXGqE7X5LQyZvw8EX2W4ubkGTElyG9vysY0pqmQdwYiS37vMQPji/JXifofvrhodsJn+9SOfDKnLLDtaxQZxoAJ98s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785845; c=relaxed/simple;
	bh=E2nTtrwCG1RWUGoeVV6buBH3LUJxG/yFAhyZjoMYrGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqvjxVf64HgxsfId0zBxKJcHfGkqXkBh37MsbBV/+VDRCsI/QtneaZyx6Mt1PuCp1SCi1m1Bcd4ryUBqW9GC7Cs/qC5knwm2eaVK/miP4X+ccmaGHMs+vd1vEm6kRNvZ0AXQB2cep/XdRLzM5WqWhwauYHKxNWnsPW9fO5yYMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyp3x7nt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef05d0ef18so865333a91.0;
        Mon, 09 Dec 2024 15:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733785843; x=1734390643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE+fKlDSe7E+kExUzTzdcRgoLew/xvVD6sIuR+E1rNI=;
        b=cyp3x7ntpR7FeY+cZJMnZZ9jaBdE4BatWLqdP/2ok8tQSdrT2NZ633eHAqKfRV0otz
         DH+y95Sy4RZNpTdX5FAb3eniS8B4HnQJN9uMKRXNxNzZ49m1xQTvDv1+mJTV/mKFd7jJ
         2oHa3XzfZ+rHfO0lxkRHZC8L1Pzi5KyJ4NRlOfmfZEWBuvkYfSjpIp/vBTDz4o00u/8K
         QDQmlkgI7cN3xaYLYK6z4ZPnfcqaX5IKYBB41h0jDQAXa0L5CDuHjq/fyTnDkV/u9uYM
         AP9RCf9RhcLyfrrNvaBEJY58aQRjPRMO23toPBvuR9VUJ/Hx+IxGB2z3OJ/REGpL+XlC
         BkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733785843; x=1734390643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QE+fKlDSe7E+kExUzTzdcRgoLew/xvVD6sIuR+E1rNI=;
        b=qMHhIDd+evL81VenU159eSYNgldGmvCpTwXlKr5kHOIqDtG17C1qLcnDDGhTe8LtZD
         u7T0aHZ/AFZAWXoWIwAN55QnbXhYkYCuVH1Asq+ITa6k3hs3RG1L7oIly85ENp0ZaYjH
         QVQ9EF5sQVhptPHCM9o2SHIRu0f7ULCLOj+mkewqGwDyBZt4YYuz4sBUl+/26TWC3M6a
         4X0maeiPlFdWutTzcIg9lZzBmRNWWslBpYAe8WtiTIgjb+FJWL87fmJ0TExMOduf3bGK
         KzbkZqNac+eGv8x0kai1B0AqqxRWfUAjuysL8eLb/Vtdbfyl1RgvbUyzo4DPsXYOHUSv
         R+bg==
X-Forwarded-Encrypted: i=1; AJvYcCVV/0KCSHuOoxY953qWoMhXgcsihNxHBEPIWg6P4YrErLg67YHWZ64Jwk28xZnfwraxq1FBkjz76LphxXk=@vger.kernel.org, AJvYcCWiK0LYyES3OjsLt0AhGTkmoXh6ZNlro8ZDme05ZmQmqp0eJNaZ9DTRx16UEGy1RaW/Js0Ljf0E@vger.kernel.org, AJvYcCXZW6HriLA+PKj1xS7RiVp1iaX8FoSSpw4ALdzqW+HAQiNdZPA/TkW9kwObdFplARFWmIx0QbrUnLa5Xq3cIBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Zmx9avxQ9ueCkICjsIHpf61nhb+AMxPKvSwAKhA95Bz4htQR
	hcEoPeeEFcJwlPjBMeUiTARAQWAvqxzlQQEF5OWfLUhzJT9WUDBdxP14Gr3/RWFs2TQpjCd80NS
	MuuMyia/l8m2m2QgtO7l2E/D0v/A=
X-Gm-Gg: ASbGnctaV2Y0SV46U1qtJyzu4yUWlj98NVi9W4Z/ODQmjIn+GNikqJveso4TdPD1Ylz
	D22BVapZdLvdW8Nx3VHeQ5gn8vCKsb7BPEH0=
X-Google-Smtp-Source: AGHT+IGI8SxF3kv4Towz1Sn0iVeRrBAzBUBXonLAFx+//gR5/lMdXYf3/WqqCG5i0YIC+b+9KFrc1WCKHw6mrXFmPzA=
X-Received: by 2002:a17:90b:4a83:b0:2ee:948b:72d3 with SMTP id
 98e67ed59e1d1-2efd472ea91mr789956a91.1.1733785843572; Mon, 09 Dec 2024
 15:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125233332.697497-1-ojeda@kernel.org> <fe2a253c-4b2f-4cb3-b58d-66192044555f@redhat.com>
 <CANiq72=PB=r5UV_ekNGV+yewa7tHic8Gs9RTQo=YcB-Lu_nzNQ@mail.gmail.com> <e544c1c7-8b00-46d4-8d13-1303fd88dca3@redhat.com>
In-Reply-To: <e544c1c7-8b00-46d4-8d13-1303fd88dca3@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Dec 2024 00:10:31 +0100
Message-ID: <CANiq72m_b4y6bJJ6sB5gUe+rpa51FXtwpwENQy3zGGMtuFJ3Xg@mail.gmail.com>
Subject: Re: [PATCH] drm/panic: remove spurious empty line to clean warning
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 12:05=E2=80=AFAM Jocelyn Falempe <jfalempe@redhat.c=
om> wrote:
>
> You can merge it through rust-fixes. I have another patch [1] under
> review that touches this file, but it shouldn't conflict, as the changes
> are far from this line.

Sounds good, thanks! (But of course please feel free to merge fixes through=
 DRM)

> How do you test clippy, so I can check I won't introduce another warning
> with this series?

With `CLIPPY=3D1`, please see:

    https://docs.kernel.org/rust/general-information.html#extra-lints

Cheers,
Miguel

