Return-Path: <stable+bounces-100244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B3A9E9E4A
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 19:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31101883B1D
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 18:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9303315535A;
	Mon,  9 Dec 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cqykk7co"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310613B59A
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770033; cv=none; b=m2ed+uDxCNsrrlC8gZgddP2rHc+1hVelHRfcenvYtDC7tOI7lFVJDGYH2p86K48JjHzEfS37fEabmMMMFiUscjZEeuixL2LysZjThUpeWpbcoCE2NzXyXeQEoM0xwILzExfJ7V5nnZ5nrrxvbD6+qDqtPo62ieDHAMa2GsBz7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770033; c=relaxed/simple;
	bh=9G16gAoAMc7A2UM3rUvTgDSLZ72ECSrug8mcdIft3aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faLF+2e5mQ93lFtEDcx/bivn1SAi+XnhTr4A2zMjMRKqzz7FJIVKyFg/FVyq0KDTVoATs3fWbk8H4yEk5m/zzKwo+NPTCYZIPojgYmWwRFUJ0q0Cq3wqPXEtVqhf6/wDpQ6bd/FvgbAHozsYilNBjFYHGYYlUKMWnh3392nDJmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cqykk7co; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434f150e9b5so89385e9.0
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 10:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733770030; x=1734374830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neoaeVH1QU0Kx+v88QabnAOKd9ehMbKeZU4rydxwqAc=;
        b=Cqykk7coNDVJTco6J2cuLUzQnqyFaJBmjOdrHhX5jlxgNZ9XAUO3KIrC3ECWpoh/6e
         LZiefSojpiD+3jOH7WzK3n3STCIOWH5CLuMJn/pp9KKhSXkpYv3lLnheA65/QQwRPzgn
         1qRcBl1Wox8j+RKORVvP6cPe8JzTSyl/Fh9oKB6KzmoWtPwPECPsLxc1y6TmtXnUw72V
         xB3ZTd90sVLzS7cSkxwiWIBkyO3IVL03RhOqxrQyHbNBMpNQ6gVOEeVokQup5TspfcZB
         qKAygpPTU9OIW9CZxZoNuxH7vCEEcsCxWg9JytxgbmfZLzfLrsSiECJMBcbtWd7S9P72
         OYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733770030; x=1734374830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neoaeVH1QU0Kx+v88QabnAOKd9ehMbKeZU4rydxwqAc=;
        b=Ub/81vibe9Tb1qr5VU0U4NcVDujXRh+8FtDNeC9Bemmwln5CfPA2MYPDZP7VGrS1DB
         LSrbgEE6Cm+B3rIRbnG2Pzsec9cw3bfAyIK61N7lMDxVXcPkQUltzmA9mXn+VBuAWXyw
         RwImmq1PZSLOTiZvAlhFl5zXN/1A9osD7LrAoJCurJFV8dH86STV3hh7aIGNoAVxUxfa
         mg9F3OOwUWJjuydy0D0iNfGJyxiQeLSLT1HKt/ObcR1DtjlJ+JQHxKGg3pHfwDZ3YXSm
         cZhuVbFJ4aBX+d5HviUoa15zAy6e8jf0Wb3vq4mrtyFqvnCn8ueG0WONOUTTcJXmrQcm
         zemg==
X-Gm-Message-State: AOJu0YxdbHyAoYpzaBIuV4YxNrv06mSAROrMTs9PdfI0WxKftA1Naeao
	rE7UW9jx/63Srg/+AJZlM/UEMB8G8sTpnJULubOPGr6uk7ncPbrRRL1bQtoDx3c/naUMe0hilnq
	8PJq8GOp7rC7obd1zFAGUDRCLs21e5TsSwdHA
X-Gm-Gg: ASbGnctY1nLoEceEukOAQz7J9pxFmp9Cmm7xKG24bfubPVxL79Z+PSKh2irjxStyGPy
	JJnwTwE+Vc4tcIzbfQluZqL9xWSZqcAi61740RgoVcDDWVh8/qvdv2OCNXQ==
X-Google-Smtp-Source: AGHT+IHSNo4rvPyKddkyMItLYlnY896E3EjgpEWYNiy8JVIdr8f6JeuA0I/tQemV8OcKHDxZ+t+z6HP52U3zCKG0jO8=
X-Received: by 2002:a05:600c:458b:b0:42b:a961:e51 with SMTP id
 5b1f17b1804b1-435026ae5bbmr44405e9.0.1733770029845; Mon, 09 Dec 2024 10:47:09
 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126191922.2504882-1-ziweixiao@google.com> <2024120216-gains-available-f94f@gregkh>
In-Reply-To: <2024120216-gains-available-f94f@gregkh>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Mon, 9 Dec 2024 10:46:58 -0800
Message-ID: <CAG-FcCPpEOEyeFUH7FGFQmsnS-eZi6CLq_FqPkJ6aKQ-+p210w@mail.gmail.com>
Subject: Re: [PATCH 5.15] gve: Fixes for napi_poll when budget is 0
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, pkaligineedi@google.com, 
	hramamurthy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 1:46=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Nov 26, 2024 at 07:19:22PM +0000, Ziwei Xiao wrote:
> > Netpoll will explicitly pass the polling call with a budget of 0 to
> > indicate it's clearing the Tx path only. For the gve_rx_poll and
> > gve_xdp_poll, they were mistakenly taking the 0 budget as the indicatio=
n
> > to do all the work. Add check to avoid the rx path and xdp path being
> > called when budget is 0. And also avoid napi_complete_done being called
> > when budget is 0 for netpoll.
> >
> > The original fix was merged here:
> > https://lore.kernel.org/r/20231114004144.2022268-1-ziweixiao@google.com
> > Resend it since the original one was not cleanly applied to 5.15 kernel=
.
> >
> > Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
> > Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > ---
>
> No git id?  :(

Sorry for missing that. Here is the commit id:

commit 278a370c1766 upstream.

Do I need to resend a V2 to contain the above line? Thank you!

