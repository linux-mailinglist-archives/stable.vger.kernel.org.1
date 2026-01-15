Return-Path: <stable+bounces-208750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB7ED26100
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB63A30060E7
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1543BF30A;
	Thu, 15 Jan 2026 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfsPcnhr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161142EC090
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496739; cv=pass; b=Ru4hmeOb6GdFyrUY1N47Bjvax8wK9KtBrPj4sfjXkZynxAifAxEVMnfE22NvLHtgL009SLD6dyFXUfWP8fvCiQVcNvmCwA6nSDfOSrRV/MfoBfuU6QH0FnE4J6s4YBhB2wv6t3ygFm8jOI173NZsqkIcpM1H9+LCwt8OoEL6rnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496739; c=relaxed/simple;
	bh=pPXLxJMYfVMaHXQyHAeqgHOdmMjU1dVPx+zj6HAusMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4jSIZRAjEx9xbRqlj8ILseV6Ehb9Zn1UvuXufboU3uvPFiUajo+/5kip7f5oRNRWI5RBSkwikz7DYZaNKxhhQeDbUtiAaYoo8RjaNnrCU3forbMAmWRez5pPSSrYizjuZ+rXrj48jdBQbUV4qtmFsOTrWzMm+sC/VacnOYaVmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfsPcnhr; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50299648ae9so432031cf.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 09:05:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768496737; cv=none;
        d=google.com; s=arc-20240605;
        b=Odhe6rBlw2n2AqEDW3sDgAVIeAclRQKqtKkiW2QemhalU+FRIO2MoqbrabSnIEflVV
         BpPvCRxakaHLKb7PMZ0+/W85JkJrN81n80REHfcDTJHC8K2M9qi0+lGfvyGA+NIcT8iE
         wj2SN59cNpA8dWl4iYzA7YMdJFyk55cQ880g9/a8y7eSVjzx2YdGklV9BZRmWnrsrZpY
         eW6uEm3OtT/RrCRvysqwAM68G8rE57h6eEgnZ8/3/tQmKkKupVOY/1507T6Gn0wmN8r6
         XLshoN+F3mQEQ91stf3dx7KkomdRHGmc2iou7FlFgiYB/959g5SSTGguU9XdUqhrlwyF
         O6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=54li8Nl2hua4YlG/5pe5hANT9Dk06MGWYeEoawn3DKE=;
        fh=nKl1GFvwtWgN9Xfo4m0dSpIB6KkUwO3tO++nwhGl4TA=;
        b=NlKnwYIgRZaLT7/eP24uGezBbiorE1XiXxrOY5aJYIOXSLwnQac/ZUso9jOjpnyFyR
         6B/pu+oSnicCsU0xa1xQIML20AZnDvG0XDdCJbw11b9rIoRlq6jlVlyhUPlf3phAPJIs
         9RRZ6I9QPgOs/8sGu83sfOI12+o923YN1pnqNh5I+cn63v9mr9M2uJEsWN8tEM5+WSCO
         BMlDjw1O0WsfIyhfMTbvxaBFH7Udbm1I0HTJnSmyf7XAqkyVbzXrAMseAylz3WfFsjXB
         g8o0l65RLS52RlpDCzpHFUxkvvk21tA2O4g9t3Qb4b/QzbHaqlzQx024drOm4X3izJ5J
         7tOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768496737; x=1769101537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54li8Nl2hua4YlG/5pe5hANT9Dk06MGWYeEoawn3DKE=;
        b=TfsPcnhrrmhvZcBjPSro0GVDZZzXXZ2gUEzR961AAmOXn3ULUis4ZRSRmkeZDvzRZl
         ZBzGrJQW5Fb84/QEAaX01ltbuWGsOuY6EFcZ/7g6mSBxdxp7DJo1X819fFRkBncckdxq
         bBIAI45eyER0POtVdp7UCRYdyV3+ZPdyMk3mTs8QsRMPlXzDx6wFF8DeB4yisY7eDZcK
         tN+dbGwbECaeo2sfqpr0ixHVyo3D0owcapiFFBytIlH17qsEeses/6bkpQdU2VGV/DBj
         8NudcB+EpjLPwRnmfNM4doqs5OQ/lU3EMkhhNTOZEiLqQi1EdpyRCI9uc8MDoiD8Qyyg
         g0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768496737; x=1769101537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=54li8Nl2hua4YlG/5pe5hANT9Dk06MGWYeEoawn3DKE=;
        b=wChF503KbulRfQWkvizSiWiiCcYFEp/WBUlmZFf6J1WzX9B0i+z5Q6FFNBqdExB2l1
         ABlIXsiHcmWlMnt+jygLShyU80KuFGs8bkyz6QC/dO6X8HBRWaggk6F/EWdbfY2PYTW0
         tgX6S7cMU6GcQ/ruIfuCUGdvFYijMx/Wcu6eo5BLIicd2jMLCNI+SSMeJvU/l5SVAXpb
         YqdHW1ls6MKII/KGf+mOa9JWfG8RUw/CIS6+y4ALHdQ3n/OxO6DdpS9iiIBy6P3HoCa4
         7XezMoQNTpcPTmFO2dTtygTXtswsWfu61TS//yNI6BS4hVb/cMeRfVb6B6puQCDUbTRC
         24bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJxS2/4yzg+xUHgPiZqfjcAPlFM+L0DyklmLc6xBF6Y46BvJ14ERqEHJePOBM64XdzkMkponU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wZ7HLAnj24UI3Hf9CRy/jBlaoUvmYk+BAnqDH2QOINx8z8AV
	YOOKEZllZoZEWSkD/pkZOR9R0Nfv9rfhTLkBzSzX8ue3awVwgS+e1uhMCD1nDRv7pWwLx9iI7XT
	g2xHkm5PxgZHIO8xkDErW/SdVfNRxIqbaQnhUOgF5
X-Gm-Gg: AY/fxX4wcAS6hmqUv3ZjlHkph/5Gb71INO4yNcr6PpVJ5Syg5X8FFRH9gvl2kOY85zV
	sxx2wObT54XqmwgVbdU8FHQvbRUrfuLAfaiqBsH/0g4qkmA+AV4jQtMMkl96HG4x3GEuYDznlXy
	2FrlWA1nRnZ3gvt0AVVFMEnyyB8+RLKouT6ZlADZO0wuYbLd+0ECGaspvREGcsF0QKbiyGtiKC8
	5iL7vE46tbSWtJdmCUjPSWHzBCxlpAtMJj6SDXIERXaY+ufLGMDdO866g2oJbqLzJcb5OPumGVm
	DtN5RW3Y1DGAM9VnAltL8SLB9Q==
X-Received: by 2002:ac8:7d44:0:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-501eab81d32mr11968081cf.8.1768496736612; Thu, 15 Jan 2026
 09:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115054557.2127777-1-surenb@google.com> <aWiBv4A4QGJ1pr1l@casper.infradead.org>
In-Reply-To: <aWiBv4A4QGJ1pr1l@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Jan 2026 09:05:25 -0800
X-Gm-Features: AZwV_QjrzboZ9bNCbx-dGc7Nl_6nQsBcpSB2Pv5eAnsjMWYU5mH2P1l-S49q7HY
Message-ID: <CAJuCfpEQZMVCz0WUQ9SOP6TBKxaT3ajpHi24Aqdd73RCsmi8rg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Docs/mm/allocation-profiling: describe sysctrl
 limitations in debug mode
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	ranxiaokai627@163.com, ran.xiaokai@zte.com.cn, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 9:57=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jan 14, 2026 at 09:45:57PM -0800, Suren Baghdasaryan wrote:
> > +  warnings produces by allocations made while profiling is disabled an=
d freed
>
> "produced"

Thanks! I'll wait for a day and if there are no other objections, I
will post a fixed version.

