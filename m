Return-Path: <stable+bounces-66091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1C494C6EC
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 00:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2727B210EB
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 22:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A20415D5BB;
	Thu,  8 Aug 2024 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ERDU5KTE"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495215B149
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723155519; cv=none; b=QM/tQZFqpQjcWxS87LevA8pOcYaVBXTxOGfbtS/P8iEfwVE16EEzVY3b+k+Q5Q3OL0Qm6beUbSOS/g8E8fKkl2XJ/DR/8qHpWmgtYalz8z7sHRKy9lG+UICUPP++NSrF2+o8+2dpPaZ83O2oVWFfjyvCXwzEON6sp2TTfgAvDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723155519; c=relaxed/simple;
	bh=g2fz3LHYtQdEh6BMOZKUax+X5tIaOuUHF5RVi3RQXOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnW+wQlLkacM9gvy7imVvLCFC7CC94j+CasUX7DAXl2WYavD3rMQDI62OojMo+Umqyd97SM4ZJQDixsQ7wSSsQgUDPtQV4KdJTIkiiqbyD4jYrpOIZlBkKanPkj0UdIw+z8RxCCD0UbnOyxib2V60OXDZmvcfOplX775XxTINdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ERDU5KTE; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5af7ae388so1235470eaf.0
        for <stable@vger.kernel.org>; Thu, 08 Aug 2024 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723155516; x=1723760316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmPhqf0HgZuuKA5pp1AA1x5CtuO9Z4jjg/RjWI5ogE8=;
        b=ERDU5KTERfpbuFFBRpL4PPK0yDSxs0MAHu7nUTxFXghQpLvaQUDBzOx/rZYHJhJkkv
         rj2Wsn/tkC5WteH9UqSatt7hzDoB69AVrq32Bg5vqWin4IfFkPGdO8uKRsl2ludkceQd
         KvSn08L3QnkzhBzR58zFB3MdN7CeOzaUP9vWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723155516; x=1723760316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmPhqf0HgZuuKA5pp1AA1x5CtuO9Z4jjg/RjWI5ogE8=;
        b=E9Kx9kvZTVD636UMQ/WX3ZKVC0qQI7kotEpQfIIdtQ9esXWwfGfF1nBjDP4UoSBorz
         F8Inbw/9Q26z3TyC4HRJkqqR0FmZLGLTkbt/WChLX0DyqbPbHvdlxcTdArZtJBq5zOJm
         6PqqFq5353fB3dwPgIW1YMRSyjF/faLIQyJ/Rei7g930vCch0w6a2cR8WIYl7l0sFUQg
         geblQ6erjwEuq4/tMOY33BMfUTldGFmy+M+4wBL3ii7kQ5GCGZwqnVubK27vhMG69hel
         9iSkl7UP2hlu95wj/+N9C/QVXZ4LNKlPfzjv5AOrnN3TgJiu1jmpPIpT+02rSqvuraGh
         4j3A==
X-Forwarded-Encrypted: i=1; AJvYcCW761GoPgFj56QGlyHN/X2yoapds3Vk77umP+djpuRtBNGH/hneLt4pUJ05wjzGFP3J2YnXlSaNGJhrW2bQeMwZm35PRwvW
X-Gm-Message-State: AOJu0Yy5UfAQ8Krt3ywX+l8PD7KUwFWUonOxnG5qYY4cFtAGw9cX8eje
	Y+7j3R3TR/Ng8jHn3J/kZgXNd0YRtke/EERKxAlLtOIYPqjdiJxtL7BbNsWMRqEHrcAF92xKp3y
	/VYilL0/kiKdlVdVQofUVYZwtqfP1tFhOYhk9
X-Google-Smtp-Source: AGHT+IFSXb3SPSimp+dHWUKEV5b2WKyupadPDR4lKPd3awPu9sJJeMjHbJgJq4sO0dFWeAhHyA9m+D1SDv4ikPboY5s=
X-Received: by 2002:a05:6871:5821:b0:268:a1e0:79db with SMTP id
 586e51a60fabf-2692d342b92mr1408801fac.14.1723155515884; Thu, 08 Aug 2024
 15:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807185954.1F5F0C32781@smtp.kernel.org>
In-Reply-To: <20240807185954.1F5F0C32781@smtp.kernel.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 8 Aug 2024 15:18:24 -0700
Message-ID: <CABi2SkU+A0dhwkGMPKuHvKaLH=kEcRRemo+tYxa9amuiYZxCEQ@mail.gmail.com>
Subject: Re: + mseal-fix-is_madv_discard.patch added to mm-hotfixes-unstable branch
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, stable@vger.kernel.org, shuah@kernel.org, 
	Liam.Howlett@oracle.com, kees@kernel.org, pedro.falcato@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 11:59=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
>
> The patch titled
>      Subject: mseal: fix is_madv_discard()
> has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
>      mseal-fix-is_madv_discard.patch
>
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree=
/patches/mseal-fix-is_madv_discard.patch
>
> This patch will later appear in the mm-hotfixes-unstable branch at
>     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
>
> *** Remember to use Documentation/process/submit-checklist.rst when testi=
ng your code ***
>
> The -mm tree is included into linux-next via the mm-everything
> branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there every 2-3 working days
>
> ------------------------------------------------------
> From: Pedro Falcato <pedro.falcato@gmail.com>
> Subject: mseal: fix is_madv_discard()
> Date: Wed, 7 Aug 2024 18:33:35 +0100
>
> is_madv_discard did its check wrong. MADV_ flags are not bitwise,
> they're normal sequential numbers. So, for instance:
>         behavior & (/* ... */ | MADV_REMOVE)
>
> tagged both MADV_REMOVE and MADV_RANDOM (bit 0 set) as
> discard operations. This is obviously incorrect, so use
> a switch statement instead.
>
> Link: https://lkml.kernel.org/r/20240807173336.2523757-1-pedro.falcato@gm=
ail.com
> Link: https://lkml.kernel.org/r/20240807173336.2523757-2-pedro.falcato@gm=
ail.com
> Fixes: 8be7258aad44 ("mseal: add mseal syscall")
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> Cc: Jeff Xu <jeffxu@chromium.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Tested-by: Jeff Xu <jeffxu@chromium.org>
    Reviewed-by: Jeff Xu <jeffxu@chromium.org>

In case needed.
Thanks
-Jeff

> ---
>
>  mm/mseal.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> --- a/mm/mseal.c~mseal-fix-is_madv_discard
> +++ a/mm/mseal.c
> @@ -40,9 +40,17 @@ static bool can_modify_vma(struct vm_are
>
>  static bool is_madv_discard(int behavior)
>  {
> -       return  behavior &
> -               (MADV_FREE | MADV_DONTNEED | MADV_DONTNEED_LOCKED |
> -                MADV_REMOVE | MADV_DONTFORK | MADV_WIPEONFORK);
> +       switch (behavior) {
> +       case MADV_FREE:
> +       case MADV_DONTNEED:
> +       case MADV_DONTNEED_LOCKED:
> +       case MADV_REMOVE:
> +       case MADV_DONTFORK:
> +       case MADV_WIPEONFORK:
> +               return true;
> +       }
> +
> +       return false;
>  }
>
>  static bool is_ro_anon(struct vm_area_struct *vma)
> _
>
> Patches currently in -mm which might be from pedro.falcato@gmail.com are
>
> mseal-fix-is_madv_discard.patch
> selftests-mm-add-mseal-test-for-no-discard-madvise.patch
>

