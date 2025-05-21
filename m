Return-Path: <stable+bounces-145768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BE1ABEBD2
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 08:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AED4A603E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 06:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA40022FDFF;
	Wed, 21 May 2025 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiDZO5sD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA321CA04;
	Wed, 21 May 2025 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747808116; cv=none; b=K2SKVt6x2ofchw3DhWZazyOtin4ydEm/LLDM7OpqrYMEX+GVr9cTmmnasdU8aSJ66CJIDPOzkE5BZG1V2f6o3NZJqu9nkfygRlVgv1h+fL080zy8N0WSKRdKHgvXbX71gi8SFdEhyWtz+QyZE+qcYwzvzx5dyYJ6QCf1S3KfXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747808116; c=relaxed/simple;
	bh=sJx91BkV28GYjBSa+iSn7l8WuBagAfyq5b55RI7mlqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9sjVUuggjojzmWBRGIYVa5Yo4G4ZWB1qqtTaNmYEuK+4v7ard+oYN9wWFfgFkrNy04qqYMv3a4iXo9L8onz4O8rt30SwKDJ5hx/AAnJlZ3ecZpJ+CJazOueGN+/oghl+R/y6ylks57N8+KK9NvZwzbS0N3swnQ2rc55kJiUKOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiDZO5sD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B214C4CEF4;
	Wed, 21 May 2025 06:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747808116;
	bh=sJx91BkV28GYjBSa+iSn7l8WuBagAfyq5b55RI7mlqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IiDZO5sDENptMggY5XyI0I8C8XxozG9r+yNJM2a5KQAxiv4QHS1BnMrBQjAuqpBgJ
	 Oz8OuiQTETZjal+MzFxwaNJSxBuPhrpUVsROPmSxJa/x79XWlhwHnVg580NRcOee6c
	 7XiVibWU0e9aXI2t9QT9z4MKMr4H8S+tgJhKDbVEaiB4N8rSoI6pkHhZzXNQOObifB
	 gRXK/PItFwD/pSA/Ey9qPr8b+ekloEJ1Ml2AW6x7j2tTOEML7A0Zmr7zKQwWwMJO2R
	 b8E2wL2hxwE0334B3L3U6B7fz4fibjaExApU4ZhkRe22O8mkT4g5XX9mJhI2dBYXM2
	 IgtWSvUYROowQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32934448e8bso6259961fa.3;
        Tue, 20 May 2025 23:15:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpQu19ECnzPvwR6BXoqob3LmDJm9GRhpvhxOvvMU+mk4wl82g5MKYviGF0FiLVzQZzbLBPKno=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywygr97ctmbQ5aiZk4GxnFDvUzcfhsHx/LCIFS8+Bd6e+JU50Bw
	bt0wp636TflrxfvREUNrFO0StFu2mjv9UJuszJTt71FTWoG4QUpqYEXVEKAUHwedwf/9FxOAAfv
	r755FuOTUXvuOi54rRXSm6grVb32fadA=
X-Google-Smtp-Source: AGHT+IHKLowYz8Gj1JZtUk2LFvTmpyzqjMRzUEWGn1mH8p09HeNHaB4zZ9i/q4x2KqjrxIgDbp7asUplQHc85GLQLF8=
X-Received: by 2002:a2e:b88e:0:b0:30d:e104:b795 with SMTP id
 38308e7fff4ca-328077d4cf2mr65272041fa.39.1747808114433; Tue, 20 May 2025
 23:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505221419.2672473-1-sashal@kernel.org> <20250505221419.2672473-400-sashal@kernel.org>
 <CAMj1kXF6=t9NoH5Lsh4=RwhUTHtpBt9VmZr3bEVm6=1zGiOf2w@mail.gmail.com> <aCyNnFdhBTOby6It@lappy>
In-Reply-To: <aCyNnFdhBTOby6It@lappy>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 21 May 2025 08:15:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGtasdqRPn8koNN095VEEU4K409QvieMdgGXNUK0kPgkw@mail.gmail.com>
X-Gm-Features: AX0GCFvl7zwimDfYOXalOmlQSvkg7hQabYAoQkUZikZA7VlssPaTmLL912vRcT0
Message-ID: <CAMj1kXGtasdqRPn8koNN095VEEU4K409QvieMdgGXNUK0kPgkw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.14 400/642] x86/relocs: Handle
 R_X86_64_REX_GOTPCRELX relocations
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, nathan@kernel.org, 
	ubizjak@gmail.com, thomas.weissschuh@linutronix.de, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 16:11, Sasha Levin <sashal@kernel.org> wrote:
>
> On Tue, May 06, 2025 at 12:32:05AM +0200, Ard Biesheuvel wrote:
> >On Tue, 6 May 2025 at 00:30, Sasha Levin <sashal@kernel.org> wrote:
> >>
> >> From: Brian Gerst <brgerst@gmail.com>
> >>
> >> [ Upstream commit cb7927fda002ca49ae62e2782c1692acc7b80c67 ]
> >>
> >> Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining the
> >> stack protector location.  Treat them as another type of PC-relative
> >> relocation.
> >>
> >> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> >> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> >> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> >> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >> Link: https://lore.kernel.org/r/20250123190747.745588-6-brgerst@gmail.com
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >This patch was one of a series of about 20 patches. Did you pick all of them?
>
> Should we pick them all up?
>

No, we should pick up none of them.

