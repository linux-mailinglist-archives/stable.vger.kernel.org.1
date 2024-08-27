Return-Path: <stable+bounces-70299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D2A96021E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 08:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035B61C212E4
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 06:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB64E757FC;
	Tue, 27 Aug 2024 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwO0/0oh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8B845027
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741152; cv=none; b=aMNC7hiZVfv6b2UYiPQqsqyyYUR7Hm6YsqjDLWhIemVqqgc5UDLqPFWVWBrOzU9WzVfTVu5Xf+wfVcdNbDfqZfuwrTMn8MLiqKl6FeyhShNbkmEXm8i3fbnAI7GcbM2WWFYix2IbYbOup9zO/CUMO/hFOMr85+Nk3gq4pXiuOGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741152; c=relaxed/simple;
	bh=EiUVcNF6E9TNnLaS4UTUqHoP+wRFw8In/Ht8ZAeLPPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTCdxRIMmvPp14DMMHFe+TfRevk1GFr0bubDVWnTCZ/qdqzA7srux8k9oWFa+saQY77xWXhkWDGMB2HZgh4N04PLgyX6t7PWo0qUrUGoFqWbWDpx6h246mi2g6SM4QO8q+pRfyRRd1lIm4CEJ2oV3k+bWQ9S1CgtTzQ6SU6DJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwO0/0oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F97CC8B7A8
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 06:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724741152;
	bh=EiUVcNF6E9TNnLaS4UTUqHoP+wRFw8In/Ht8ZAeLPPU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uwO0/0ohwSgtNpHAIHeBJcBwss2nK0b4VF9AHCXKbvw2HzZ3tb24mApQHm910PXOB
	 SYJkI7IKLoAaU5/3aGaveEKPU+yNq1nQqpgXcvEaINYb4mni+3ZhJsJ9MmNME9jha1
	 vYc1duvKt7lifb/n70+tHby4cDsiC9unUUMeCpank5RjBvkiYm55/UleXJ+1BwntaE
	 0oNP139vHVG8kciMM9+FKLo8gAA5Z3yB8ByNCFVuMEIL9ROU5jTb+3/QjOdJxPYerx
	 kXM3RV3nPmgvayWpxem2zx0nFhFszINC43RaUE1cG8l15H1wYtFWUICn7ykqGCkqcN
	 z66+HWNof6aMg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-27045e54272so3375300fac.0
        for <stable@vger.kernel.org>; Mon, 26 Aug 2024 23:45:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhr9J9STKJNZ6bcFuEQLsA0ctcuyYxRSwYXm2dLOU7GlvSnirduQrvmpcLqaGUMvfhFroL/jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzurBFsLmKUPjeic0YgopCaR7xeOhnp00t+/kdzRZbBpSJvPJ7J
	AdFTX2pqsMF66CuMRAGw2yGbvd6GuS+nqur8tJMYBvENoEkSpcajpyL0gafNUuKSayQe4aFDT6Z
	kl8kX5SchFUqZv4qOXlqBOLMzG48=
X-Google-Smtp-Source: AGHT+IFGmO52mkSVDScler7a8B4/FMWLnaW69spHK6BkNfm26gBsZffc94q7oxN+Qi/sSiC58VKGhpnB8RbVIPHg47I=
X-Received: by 2002:a05:6870:3514:b0:261:88b:36fe with SMTP id
 586e51a60fabf-273e64f5ab2mr12687994fac.15.1724741151351; Mon, 26 Aug 2024
 23:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024082604-depose-iphone-7d55@gregkh> <CAKYAXd_KPR0FAsx+6DrEfU3J-ahnMtfA64gqyxHCOMHS3ZZejA@mail.gmail.com>
 <2024082730-squire-entire-f488@gregkh>
In-Reply-To: <2024082730-squire-entire-f488@gregkh>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 27 Aug 2024 15:45:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_7ipUOCPOOJTGCKWQOzcc34pX4dDHzG=d+O-4+o67kRA@mail.gmail.com>
Message-ID: <CAKYAXd_7ipUOCPOOJTGCKWQOzcc34pX4dDHzG=d+O-4+o67kRA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] ksmbd: the buffer of smb2 query dir
 response has at least 1" failed to apply to 5.15-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stfrench@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 2:14=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Aug 27, 2024 at 11:54:56AM +0900, Namjae Jeon wrote:
> > On Mon, Aug 26, 2024 at 8:38=E2=80=AFPM <gregkh@linuxfoundation.org> wr=
ote:
> > >
> > >
> > > The patch below does not apply to the 5.15-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git comm=
it
> > > id to <stable@vger.kernel.org>.
> > As follows, I have marked stable tag(v6.1+) in patch to apply to 6.1
> > kernel versions or later.
> >
> >  Cc: stable@vger.kernel.org # v6.1+
>
> Yes, but you also say:
>
>         Fixes: eb3e28c1e89b ("smb3: Replace smb2pdu 1-element arrays with=
 flex-arrays")
>
> Which has been backported to the 5.10.y and 5.15.y kernel trees, so this
> is why the FAILED email was triggered.
>
> > This patch does not need to be applied to 5.15 or 5.10.
>
> Are you sure?
Yes, I have checked it.
5.10 : ksmbd is not here because it was merged into the 5.15 kernel.
5.15: smb client developer backported eb3e28c1e89b commit for only smb
client's header.
So it doesn't affect the ksmbd server.

> If so, why is that the Fixes: tag?
checkpatch.pl guide to add Fixes tag if there is a stable tag in the patch.

WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:'=
 tag?

In this case, I should not add fixes: tag...? I didn't know that.

Thanks.


>
> thanks,
>
> greg k-h

