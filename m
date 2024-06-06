Return-Path: <stable+bounces-48305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2998FE76A
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5CF28500C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95234195FF2;
	Thu,  6 Jun 2024 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8lZ6UH6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217B645;
	Thu,  6 Jun 2024 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679828; cv=none; b=UUKECt61sCy9oEiFZp6W+EpBZfPCB9dPFQo2I2mTm9YDNqjlq1GuIn5HVsd80Kw58n+B0A04Rlta27XIxgOAq5ES6phS5L5siAC1v3mjcYI8RcJPLyzKVP5s4oXFyiWjaPYhtJu/qH2ZVb3/d5Q85vHfioXziJxix6pIaSyC9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679828; c=relaxed/simple;
	bh=xmqQ5OEZ/njp5uZnyebDO8eh/n6MP0/KBUgRGG2r04M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+1r4t2sfcWhheLyIn4RkJgYuYcxCBL9o06Z1fJ9mI2Ylss6LK1XJcS8/8IhiktZuaXnA2ASZ0GtoZJtTbHq1Xs1i0hM5mN/dBziioccA4NU5yKwZ1Iw4fPJONWidYkqhlifVnDAGE7uOunCUcX6pPEKpl3I2lC1VpkTaE+pfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8lZ6UH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FC1C32782;
	Thu,  6 Jun 2024 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717679827;
	bh=xmqQ5OEZ/njp5uZnyebDO8eh/n6MP0/KBUgRGG2r04M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q8lZ6UH61Ap+rI7RQy1X7CdzWii75z47r85A7+exbvzom0HoYeENquzYELnB+EOIm
	 Kakfk5+jJsiMo3DhZUtRmlupjtSwy6Qj8O879bSLjhsfaB1W9Y7p4yUH/Zj/LLUwgL
	 vs38Mx8hImjRQTqpDMaOWNor8FL7FJfHxZ3bNTMhF/N+r4Zupn2IU+YkaaUn952wha
	 MfZN4D3aijOFGDk3q/jXI4a7ifeFGR7gA6Y2750/7U7VhSHDi8l4n4/77uMTX/2YYP
	 sxL3uV1w+4AJ9Tj+YH8UYmY9Uu/zn3oxSs6GMQcefCenjxkZ0f1HHhDWdcmJY7j/53
	 kqb9hwvP7xnlg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b976b5d22so1377362e87.1;
        Thu, 06 Jun 2024 06:17:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOu4ToeGY+E/5VS9RgfGiOplLlD5kmxcrek9GQmFjEdpdhpHCzRUG2jIoYZV4tfwrmdNF9bVYd/4ES88BMWvOqFT4mxTBB8rUv26HMUxw=
X-Gm-Message-State: AOJu0YxM06WjsaiCqY8oh/t5boF9xAp9lC9jZtC8sZs/YSmdyQ/C0sIu
	VwhL8Ikqqaj+/Fi+JdXm7xKiMBEzJhKbu1Ije+xwWWTu3REffyw+yFLXwUv2VlCC5t8ET6/QPkd
	gS6b/3M6WvRBluZd9xXs+AhBpDF0=
X-Google-Smtp-Source: AGHT+IH9wXjs51gq7xEvANGLDJaa//5qqgxlQRI1y7Lkqve6Ke+/WsPeTPIzqwotV4EIgNgpsvIA2DQAXozWIsnf4nY=
X-Received: by 2002:a05:6512:108a:b0:52b:c9a:148 with SMTP id
 2adb3069b0e04-52bab4b7c95mr3746604e87.14.1717679826313; Thu, 06 Jun 2024
 06:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605231152.3112791-1-sashal@kernel.org> <CAMj1kXHrpZzJvvi+4RaMVV5_tsEU62_EC-7MboHBbR1hTMgTcg@mail.gmail.com>
 <2024060619-drank-unheard-bd84@gregkh>
In-Reply-To: <2024060619-drank-unheard-bd84@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 6 Jun 2024 15:16:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGFZZT8XQaUdfH1FOaSzU+jp-_cBZa=i180Wx+Tm_3Snw@mail.gmail.com>
Message-ID: <CAMj1kXGFZZT8XQaUdfH1FOaSzU+jp-_cBZa=i180Wx+Tm_3Snw@mail.gmail.com>
Subject: Re: Patch "arm64: fpsimd: Bring cond_yield asm macro in line with new
 rules" has been added to the 6.6-stable tree
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 15:14, Greg KH <greg@kroah.com> wrote:
>
> On Thu, Jun 06, 2024 at 02:42:09PM +0200, Ard Biesheuvel wrote:
> > On Thu, 6 Jun 2024 at 01:11, Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     arm64: fpsimd: Bring cond_yield asm macro in line with new rules
> > >
> > > to the 6.6-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > >
> > > The filename of the patch is:
> > >      arm64-fpsimd-bring-cond_yield-asm-macro-in-line-with.patch
> > > and it can be found in the queue-6.6 subdirectory.
> > >
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > >
> >
> > NAK
> >
> > None of these changes belong in v6.6 - please drop all of them.
> >
>
> Ah, I see why, it was to get e92bee9f861b ("arm64/fpsimd: Avoid
> erroneous elide of user state reload") to apply properly.  I'll drop
> that as well, can you provide a backported version instead?
>

No, I cannot, given that it fixes something that wasn't broken in v6.6
to begin with.

