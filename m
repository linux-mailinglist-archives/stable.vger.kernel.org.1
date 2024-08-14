Return-Path: <stable+bounces-67700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1F5952225
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 20:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5FA1F23BB4
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 18:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DDA1BE23C;
	Wed, 14 Aug 2024 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="e9JkOX6I"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FFD1BD514
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660980; cv=none; b=dgxL1IIphSgY6lkzOvgezrYQgYOIhFi+MljsJU3GYMP8Mw4gWDF/ihLkuLu8mV7MI1b3FmCGkSaF5C+dbkCu/DqXLWeVCM8ZZaQtPyjU33CbHwq7173BRNTF+9CWdxebLI88MnuAWQ3o46E45fjcVwHgp/8FZou/QCmd+0zFJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660980; c=relaxed/simple;
	bh=/l49U/wxdV2hskoBO8oUszPFooh438tGs40jvUIlB9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2TEk7I8FEd6CcPjwT4yzclwvNUuoz0+CZy0rr27mVMSOuugSYGUlXXiS2baltujKn91cVoz58AuxOW2J31sUOj9Km5GTm57cGFwi+JIWoMq5nfum+bDMlk44nE9jgj8lB3tGusGlu+pkITuyczlbBLd2sQO4WYs2Q4V1pc8Bcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=e9JkOX6I; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7093abb12edso99224a34.3
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723660977; x=1724265777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l49U/wxdV2hskoBO8oUszPFooh438tGs40jvUIlB9k=;
        b=e9JkOX6IWBf+ChF3nnfw3wZkX0loVWADFNfKR1E6EF9dI/Y6+5etqTKNRjQHs+PMr6
         Psgs5EuWDdMVjkThorjTTyGJld/bTrZY9w0J7npZqHFjU4rQ9vQT25xnezkkEBR6S2ra
         XnCwSB1p1aM5MTWeLAy2WK5p1Cuhw7Bj4oAAioPbdEZmerYJeyOWQa2Y2RFqLiuwGY47
         OpikZ6wUlilJ/oxbqTjF2+xnteXoshdrKCgykaRjAmuzX0EfuXZNwqjmpegDSAup/DMR
         ivwRRgkknEszpV6AZX6Hai67UtQyN19wKkAtlqqTFw1j8Fo2R1l8vFlRMuxPtONb0JIl
         VL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723660977; x=1724265777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l49U/wxdV2hskoBO8oUszPFooh438tGs40jvUIlB9k=;
        b=IOVntUD1uatwggmTrPqO5XuTky68y90q69/UipeTiO3nJRtgprvfd8zmCaP4e2yvBd
         gf+8barSuVpZfZj8Wdme/ZmQOcUD50YUYjrNyXF87VvX0DHqetIV3Y1uqUi+UK8oI1NM
         tJDTx/cQdCKeWAT1r4Pj8DGxib6ryQON59ocNDTR+pNpEEKPIQK0is/0xFwcgEpPTDJ2
         oXMlHdElPPzihXORx0NzizkF/P+p4BpQ4k3biQusT4GPP9eMXbD52faCtOW8o9o7fmEd
         wRoBtoK//j3cfBJh1UTs35/5E01XGfcLNnuFLPE9sskPWmTai9HtnP8FuRvVJfNvdK3z
         U21g==
X-Forwarded-Encrypted: i=1; AJvYcCU4TzH+d0lWs0eYXdQfFH04g+B/eU/d4637nIgUXTuO3CadFyiBVcfuWYqLWJ8KQYeC+khjnGa1Vt2XlF+Zp40BZf8Tmor5
X-Gm-Message-State: AOJu0Ywj1i67yxQjnhoca2tR9Xl3sWpUGf0LTXWmfuSg5V42Uolf3IEn
	lVA1Ak1LMBsLIkYv0JLLzt7pl2bKS/Y7cl24chn2+dryMS8H2HBGtvdlo0I62MK88h/GKS9Or9v
	+QIXvk7bPGZoe6Yt6sD3i7y0wyCK5ynCBOO0gmQ==
X-Google-Smtp-Source: AGHT+IF8wcHTAzyZP47djK/jxXQWyvawwUBnhudvKFNvL5Or8b6sQKz1htUdOL48QnhCh+43PeAg8Zrl5zPb3/iHg88=
X-Received: by 2002:a05:6830:3812:b0:703:6988:dbed with SMTP id
 46e09a7af769-70c9da243afmr4702408a34.34.1723660977004; Wed, 14 Aug 2024
 11:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813150758.855881-1-surenb@google.com>
In-Reply-To: <20240813150758.855881-1-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 14 Aug 2024 18:42:20 +0000
Message-ID: <CA+CK2bBzRv70ECqkQOtvpPBuxKo=iAePgO5+UGuA7c9TwEfPqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] alloc_tag: introduce clear_page_tag_ref() helper function
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, david@redhat.com, 
	vbabka@suse.cz, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> In several cases we are freeing pages which were not allocated using
> common page allocators. For such cases, in order to keep allocation
> accounting correct, we should clear the page tag to indicate that the
> page being freed is expected to not have a valid allocation tag.
> Introduce clear_page_tag_ref() helper function to be used for this.


Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

