Return-Path: <stable+bounces-70080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F12395DA74
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 04:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847861C217F6
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 02:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F1BEEC8;
	Sat, 24 Aug 2024 02:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OAIFGqyf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4AF8494
	for <stable@vger.kernel.org>; Sat, 24 Aug 2024 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724464964; cv=none; b=DV3etOzwL2IPdIqqPzVHaWl79dicNUMs31CgfenzHrq+wszCkI/zfEuvfozlO9O3w3SD613EsgH530WxfragaRcgfWg6TIslfmxvImhZjyI3jYl6M31EYP81FkkBpQ6+vhpkO+oH0U3RyCMXXz85jqxhNRGHgINcL2rH9w0JRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724464964; c=relaxed/simple;
	bh=PvxEnZaFii/sPRVmM5l16yEI1y18EcLbXmugTXFTBi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opKyQe6Xw6ngFbApZNYfXIXF33Z/wqnfZiLgbbqdh2XjH+XdbEz1B8CF7+W2YnaNkR+C01fFm2o1ze/UyvqteKevwZqLUidfljKUcQIIIpwUJTSYYD9JVVP97zfxqicbzq7wzz43n5NAxmLNeoTU3E47drEvOS5n/A+PximXM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OAIFGqyf; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-533488ffaebso2863432e87.0
        for <stable@vger.kernel.org>; Fri, 23 Aug 2024 19:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724464960; x=1725069760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ym980CqYxCsLXdz14ErVB+ivOLKtukT0tUKXVKCXag=;
        b=OAIFGqyfxnVCFKl+BQXAJlIpyu3PF5R3RB4gsf2TRCpuq6xO/KAg4//rQ3VCLx3Ij0
         mZfYPIvdd/0+yjCsvNEiiwVuZynA+U4F31H4m8RIoYAlTpgVuCmXtwHj4B7UTNfG0a3C
         b2FSY9PEgPXwyns/95IezhwmMzrIq7qSX9eTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724464960; x=1725069760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ym980CqYxCsLXdz14ErVB+ivOLKtukT0tUKXVKCXag=;
        b=M99DkJ2WOY2vtoDMEJhlmh300MNvCfKPiA6P8A2aZf0QfFSVVAVZvCfAV/0ldM6QV3
         5vn/WBzCMrSVllJ08qvH93LfoBpOuJ8R5skedJ8yfjARwdko1YdTiSz//4JCfoXfyQP2
         eGd/55kuUEL48LE6B2DRh2jhk3OkKIW8woowtgAdYkA/2WWwl8w8gKR1bRIU0pN+6JXK
         IRHjnYH7Lc3mBcNg7YufoQJ31eiF9/I95Za0/FqTMovAaMgTTVm8+Yzr4nbWOnqNVc0G
         uFQi0pB29lb5uNSYBVMFoZrza7iaGFFuRxGNbA1F5+netgPF5i+gm62dGbLJYs5doX/6
         1Wxg==
X-Forwarded-Encrypted: i=1; AJvYcCWTrQF0kwlYhpraWb4UCR7ybEMAms5nVygb1hn8M36Jxs4ruzjyxTwShcq+yj9P19a3rwWFiq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9GMWw8G0j6zvx2fVDr/LfvgP7z0GbrKHwA2lcCMVEfNbjRTwm
	cp1XTeZdk/Fc3+4W1tQld923bE8S9p3adt0dow9PFWFj1vhFi+IL882qHXcte1++2MS4KLTWe30
	0DkhIBA==
X-Google-Smtp-Source: AGHT+IF81nVREP5u1Z/XjVAlE6nqwvU65Wi/BbKiXSZ6gJaAA5Jj4NFrLbFRWO/STOVI8SWoGQEarQ==
X-Received: by 2002:a05:6512:6cf:b0:52c:cd4f:b95b with SMTP id 2adb3069b0e04-53438773dc4mr2721330e87.22.1724464959819;
        Fri, 23 Aug 2024 19:02:39 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea297casm698501e87.39.2024.08.23.19.02.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 19:02:39 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f43de7ad5eso27018641fa.1
        for <stable@vger.kernel.org>; Fri, 23 Aug 2024 19:02:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtsJSlxIU0vhKNvCiCoCxWqh43Zwc+z1VV6HSFcK8Bf9h8yXuUKpceD+EAnYZNy1tMz7A5Xfg=@vger.kernel.org
X-Received: by 2002:a05:651c:32c:b0:2ec:500c:b2e0 with SMTP id
 38308e7fff4ca-2f4f4901deamr21932221fa.22.1724464958055; Fri, 23 Aug 2024
 19:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-firmware-traversal-v2-1-880082882709@google.com>
 <Zsj7afivXqOL1FXG@bombadil.infradead.org> <CAADWXX_zpqzYdCpmQGF3JgsN4+wk3AsuQLCKREkDC1ScxSfDjQ@mail.gmail.com>
 <CAG48ez2_Gs=fuG5vwML-gCzvZcVDJJy=Tr8p+ANxW4h2dKBAjQ@mail.gmail.com>
In-Reply-To: <CAG48ez2_Gs=fuG5vwML-gCzvZcVDJJy=Tr8p+ANxW4h2dKBAjQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 10:02:21 +0800
X-Gmail-Original-Message-ID: <CAHk-=wh2rRLv5hu4BaJ_8JGRrX+UiOA6x4mPtUHp12oNhnWJWA@mail.gmail.com>
Message-ID: <CAHk-=wh2rRLv5hu4BaJ_8JGRrX+UiOA6x4mPtUHp12oNhnWJWA@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: Block path traversal
To: Jann Horn <jannh@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 09:49, Jann Horn <jannh@google.com> wrote:
>
> One other difference between the semantics we need here and
> LOOKUP_BENEATH is that we need to allow *symlinks* that contain ".."
> components or absolute paths; just the original path string must not
> contain them.

Yup, fair enough - a LOOKUP_NO_DOTDOT (or LOOKUP_NORMALIZED) flag
would only affect the top-most nameidata level. Which makes it
different from some of the other nameidata flags.

Not really fundamentally harder, but different - it would involve
having to also check nd->depth during the walk.

> (For what it's worth, I think I have seen many copies of this kind of
> string-based checking for ".." components in various pieces of
> userspace code. I don't think I've seen many places in the kernel that
> would benefit from that.)

Yeah, the kernel usually has trusted sources for the (relatively few)
pathnames it follows. The firmware case is probably fairly unusual,
with other sources of kernel path walking tend to be paths that have
been set by the administrator (eg the "fw_path" part that is set by a
module parameter).

I was indeed thinking of user level possibly finding this useful,
having seen a lot of "clean up pathname" code myself (git being one
example).

                 Linus

