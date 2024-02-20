Return-Path: <stable+bounces-20869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACF585C449
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A31287037
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 19:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0B78B51;
	Tue, 20 Feb 2024 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpC+9U/7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167EC44C94
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456054; cv=none; b=eTG7tXxZVKv/FB7XDSXV6HzsfAUr1THwEmvnEF2HEt8SfL5+0Jhn5LI1wqD4zU6/lFvmtVoR+dNZLLVQIPD7ZPBbdtZKdO+4xcj9jyzKOdfPFjfAu859JEN17iVwhnwz1LmRzjH9NKcOwZKV8sPJKYZpw8FcZaCqMOgxAGLWS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456054; c=relaxed/simple;
	bh=nkEIHh/a10xMQFQ0kBEKGDlg5mn/OlAnHeRjgtJTWIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fg4eT1BFF/ieChVEK3hCcprTEw4xVYFMAjdyGqvUQRJsfSvtAHNGAIaPNr13W8NZzesDI+5Vq+dv9fe8v2lzgOhquPfuIqJ+vu9rtVUxvGMwV7wkg7xmDpeJbw/440N4NjKVCJWS4P8zIsvoqnQQUoN2uen3wwrgU1XZTEIQRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpC+9U/7; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6080a3eecd4so38149557b3.2
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 11:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708456052; x=1709060852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq9cwZVWYbfqQqgOgW6JJVutttQMZgouq4X3pj3iIZQ=;
        b=JpC+9U/7oBbbgKuNDvRgXocpe4kI77oNw6lHeGFCU6QA7HRs5IhsfbpqLh/Cq+Qi/Z
         +Ct/aPB9IK9yJvMzbMF0CF3Md5s527lcXX+JI9K1U2f0Vl/D5Mho9v120N8lar95TMgL
         FW4/CFj/ADkVSrvZzMInV1kpqh2GC+CqdNVOTf/kZ+mTpZG717cWzJZdzoJUjlB9k0qn
         Nq0x1cXr75FqsFU/qY8xz7ef3Clj3UR+yFZa7Sksg5MmhsUhxzOUcqzxW1jOvfDRRDpg
         nHJktvEMANyW6tKgjDKurgchxt5cEMlGqBU/Dqdx0cVATKf3z7NbE4KCOucpk7HCDkRM
         9QPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456052; x=1709060852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zq9cwZVWYbfqQqgOgW6JJVutttQMZgouq4X3pj3iIZQ=;
        b=GMoWwe7QgFUZL2xvcgA+RALT/isvLrZ4Rcqv93UtZhPULBTrf6UQVGa7WPK9nBH+v/
         nWzjDsk9rCWI1ofvAoBo/rfehuqEf/kMtUe35+rsGIJUzlomeFbAleK20nbz0n3eGujV
         bVaybxnujgIqfijA5SuHhLR49GfsYihDzSsdHO4FH7rfjbWh30/R22tOHUlAn1ECiTws
         vpXELQyqNfsAXZttizevXactIy9ZKdTjgZBfliVRE+Myq93pEsPNb5HN14yIBPy2Z3le
         SXaVzTdR0zImFQFvcpdaUrR8ec0hkCTA9HcjYlkqvAqnzPgoKxBxFKup4d5jz5kx2NgQ
         ttMA==
X-Gm-Message-State: AOJu0Ywtz/4Omfb2Cs6aQEITdAC9HYeqzU0TSjrvi1cZgOtMSrGrHJAM
	jZh6T7yxTH2eEMSk3uWoekgvjVpAAdz3UE54wSDi2fX9vCgUxc0PYIfOy6gnRnT1r8TFosnqYVZ
	XoJ+O3LSkUoI9puXTH+38zFP7X6bbZ4EbbJNL2YZAiGtub9vpMuWY
X-Google-Smtp-Source: AGHT+IGjb2vzN+GfLrnJkTrLFlOe4PMyKwPkwyd9d2gZz3JAup5L7OSArMWF+tRcr+Ssvbk+gDBi8n49ngVyW/R3kd8=
X-Received: by 2002:a81:8507:0:b0:607:6fe9:f55a with SMTP id
 v7-20020a818507000000b006076fe9f55amr16717395ywf.35.1708456051617; Tue, 20
 Feb 2024 11:07:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024021921-bleak-sputter-5ecf@gregkh> <20240220190250.39021-1-surenb@google.com>
In-Reply-To: <20240220190250.39021-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 20 Feb 2024 11:07:20 -0800
Message-ID: <CAJuCfpGV0RSw6NTTbfGQo9zU3Ckqq-9GBA=GMWDvMW6Xe96m2Q@mail.gmail.com>
Subject: Re: [PATCH 6.7.y] arch/arm/mm: fix major fault accounting when
 retrying under per-VMA lock
To: stable@vger.kernel.org
Cc: Russell King <rmk+kernel@armlinux.org.uk>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 11:02=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> The change [1] missed ARM architecture when fixing major fault accounting
> for page fault retry under per-VMA lock.
>
> The user-visible effects is that it restores correct major fault
> accounting that was broken after [2] was merged in 6.7 kernel. The
> more detailed description is in [3] and this patch simply adds the
> same fix to ARM architecture which I missed in [3].
>
> Add missing code to fix ARM architecture fault accounting.
>
> [1] 46e714c729c8 ("arch/mm/fault: fix major fault accounting when retryin=
g under per-VMA lock")
> [2] https://lore.kernel.org/all/20231006195318.4087158-6-willy@infradead.=
org/
> [3] https://lore.kernel.org/all/20231226214610.109282-1-surenb@google.com=
/
>
> Link: https://lkml.kernel.org/r/20240123064305.2829244-1-surenb@google.co=
m
> Fixes: 12214eba1992 ("mm: handle read faults under the VMA lock")
> Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Sorry, missed the prerequisite patch. Please ignore this one and see
the next patchset I sent with 2 patches in it:
https://lore.kernel.org/all/20240220190351.39815-1-surenb@google.com/
https://lore.kernel.org/all/20240220190351.39815-2-surenb@google.com/

Thanks,
Suren.

> ---
>  arch/arm/mm/fault.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index e96fb40b9cc3..07565b593ed6 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -298,6 +298,8 @@ do_page_fault(unsigned long addr, unsigned int fsr, s=
truct pt_regs *regs)
>                 goto done;
>         }
>         count_vm_vma_lock_event(VMA_LOCK_RETRY);
> +       if (fault & VM_FAULT_MAJOR)
> +               flags |=3D FAULT_FLAG_TRIED;
>
>         /* Quick path to respond to signals */
>         if (fault_signal_pending(fault, regs)) {
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

