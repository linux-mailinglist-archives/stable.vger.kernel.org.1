Return-Path: <stable+bounces-70094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003DA95DE89
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 16:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB29B1F22438
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7946E17ADE0;
	Sat, 24 Aug 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioPjjMzX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCA179647;
	Sat, 24 Aug 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510749; cv=none; b=DreLhdPDK/Kr8B2RY381JB/gFUOCvtFDGUTVihyIP0eWPqWXVAEJXxEFbDGUNICePVhV0YqWYgoqtlxcgAWiK4mIwhELZjSy1W0L5+Ke2FnKpql8L8Myb7ojHIzjA8LaxF50tBdU2oSSFWh65HmPGXldRK2ydPH1IX7DkpdlGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510749; c=relaxed/simple;
	bh=BqaB1c5ku9RKm94qjn9/66awfeoNmQBryjTJl23s/4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdu4W64B7VtYFGrbVLo0iRXuvfH/jzmrpaXVQCDd73+tkocoWjohHxMXPX9GL9mFRqQtUvc2H3YpdtAuD6NsvrHogjM4gXMWlInPNPofZRlT24KqYA2yIONj162xx4OhGE+yKNNt6VPlyEOi8hLEIoFRuf9ITRwEn2baAA2WJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioPjjMzX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3bc9405c2so346390a91.2;
        Sat, 24 Aug 2024 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724510747; x=1725115547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqaB1c5ku9RKm94qjn9/66awfeoNmQBryjTJl23s/4w=;
        b=ioPjjMzXoIP14Xi9qqjJTlUV0DLO/Ma2mNSbXsiPPNBLC321nYmdEHCLc0f/QyKsvt
         n37FXnobxxJxEqzC0eCxt8kVVYNVp4asTzAVDjr3Yhnr8GY2puIx4OIFN4Io9k+4REXq
         /PPz1ju/X4bq0E7BTp3KMrLsesTZVkGOVdkLc3EabNtFDX8VqQD7C0+0/8NcJbRIWuUp
         atR1y5kUvX85YB3z2uQMHXxboxia+CZBNW6KhAk+O//86Tb1Q7p/XAxLoLl0ABw5KZSF
         sm3ECEbNEonsm4CeBctHNFINed8UyW5HioGG0T8+8fpmhS9PSiwmEU30mkdKh51zBZUD
         ncuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510747; x=1725115547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqaB1c5ku9RKm94qjn9/66awfeoNmQBryjTJl23s/4w=;
        b=DX3kX/LdgE9/ipK7iPVi+luwjab6p9CQLoZ72dSqO9/TQoTSvwewSYUi/n+BQXYJbP
         tL6m7xamALaFCfJBkZPE1xTt5y8Jp6NuGMMKduClbV6n1t+9XTpQnv7WMJAp6g8WzMWu
         5yW0rQsGZR9jzv2Pl+TxKvfeLTvEn5l9HlV1vsyFqBYIscV8h7wci1/GhSLEqyzhosJa
         PA5z6FjDDt7/W46f28BO/2nT50zh9OLEu+GlX+WSKYOIJvvkd73CbzAn/ziJFlUtINfn
         NHLI71RjzVzCKXODBYj/lr26tFxdlGeNBaTCgdN5xhXX/lzIOjyOIx/wwJc9FIebfEdG
         VzuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3uPI4bhvK3hjPfj1xV50e86wOFDtuYdvplF+Y3KL++Sl70sk5kydcYa49xWD7n22By4G4yHqx@vger.kernel.org, AJvYcCWDTSByJdtTijMf6V10rPkn6e7n6pRdZoVNfL145fKPeY69xrrfUt9fIwsBMOzo6jhpJkSo3uzh6uh9L4NVyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbiX95xbq3BUmWxo9qn4EJGCu0Q2JEEtgkt0gQfZl49osErQZ
	8gUaIzFENmV9l+72D5wCi1r/tLPb1ZuZ3TyUs1Nm98udvCIiGOqlPxey9COh5yZg3e5usNP20HN
	pG3NEi5n3P66VbsXxXgh0zXWYZT0=
X-Google-Smtp-Source: AGHT+IHNiuR3ttNVdVTbTyfsF7dQ1ZR3lJ/MURScKL1DVfGQNPDF1qTAnexboTb4uP777SW3kCASFOpdjUOmp6JlKcQ=
X-Received: by 2002:a17:902:c94a:b0:202:4e99:210a with SMTP id
 d9443c01a7336-2039e52c3c9mr42360905ad.6.1724510747206; Sat, 24 Aug 2024
 07:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823140309.1974696-1-sashal@kernel.org> <20240823140309.1974696-9-sashal@kernel.org>
In-Reply-To: <20240823140309.1974696-9-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 24 Aug 2024 16:45:32 +0200
Message-ID: <CANiq72n1_1mF0e5k9LMLCwrgDJVWcuRwhu9ES49qH0knyJUodQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 09/20] rust: add intrinsics to fix `-Os` builds
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun.feng@gmail.com>, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, nathan@kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 4:03=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> [ Upstream commit 02dfd63afe65f7bacad543ba2b10f77083ae7929 ]

Sounds good.

I don't think one can hit this, since we only saw the issue with Rust
1.80.0+ and 6.6 LTS supports only 1.73.0 so far, but it could be that
we later need it or someone unpins/upgrades the version.

Thanks!

Cheers,
Miguel

