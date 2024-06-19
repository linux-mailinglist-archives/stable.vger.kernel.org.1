Return-Path: <stable+bounces-53814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC490E881
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECB7283CD0
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0311312FB31;
	Wed, 19 Jun 2024 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYskMU8Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC8875817;
	Wed, 19 Jun 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793759; cv=none; b=KceUJxpvKlQW0YcxBHE+qRP4T5Ujmsdez7lRDVJ5oUO2CrAxI9qRtKPVlj0g2Ihc4XDCkq5mt6G62vhuwNzOVUNTwVkGAEOz/3GPgV03DqvusVGd3AUtl6u4QYRDTsLMdYZ6g1pRlU6ELlM4Ud+R588J46f9ohFtOD8prR7IGQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793759; c=relaxed/simple;
	bh=OH4j8K0eAER0yzFR+JWb3wfzjQkXj5AVKQoulvr5dpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQ059KXwlENxYxLADbFn7Nx+fAr6AGnKo0DBu2jgRwZWEWUTfCpDh07P4c8+AOy15mVF1fsvaDA/vLhAklKRUgpQSZucjwzXgOaX9KjCAN1vQfGPplsuoYHybiehEObxDRoyC6Q1P0H3UDNB5BVAWYUb9bRhdqIquheDQDVcD8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYskMU8Z; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso69187881fa.2;
        Wed, 19 Jun 2024 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718793756; x=1719398556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytdGjGo0KSXMtOisu6BpBfldVzFpmCfYA0zu/R+JQKg=;
        b=dYskMU8Zd1/33az224pw63ttxRNo5HE3fKPwHZ05G8S4eTWQeF0uCKj7tEHmNpduAW
         StKYCUZB+3H9ojWOywQq/qGuZQf65MYAER460aRgqMkdxSgtWvstqJz1Y9v5ACFZjS/u
         7LSXFICiBAXFab1iUIdbRQ+/ePa69Lm5L9deE+30irxFCYxToxyTVDdqGViP1bSBGzVr
         MkYZgC7hLb9yt5sf/+KtiRxGuEHS5GQ+5/c8GLjqahOtr9UxW3WfB1SnGuikw67Kpobv
         UprqOvwH/7BSdeDTOOW8trTxFRHf38Mo5FivQMIiqR7PXPkynTXweckz2yGS9mhq4jlS
         OJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718793756; x=1719398556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytdGjGo0KSXMtOisu6BpBfldVzFpmCfYA0zu/R+JQKg=;
        b=qeDL4fEIf11ZaPSkUtJuFCHdE1isu7EXR1lF4n92fRCs+4l0lPvwGHSwCLfcIshKWk
         ruofPAQcLoSy7LRl5q6d2/OYmdpnBoubwzkh17CFQEP6P4Do2v7E8OsTT7n+jclIQpj/
         0A2V8eOHxmLtfvUuyUgH5HFNSs5wU85l52boZ2J4/b6GhVStC1DHFgwpEH7z6TNnmKHX
         niL1zyCrLQilndl4snmlnY/kWushV4LFu2PPN0R8msYfPKDaxHOzRr9AHhFwSSwIcyQX
         NeE+lCfjpzP/8PmI/Hk0RdkNdW2oA89/vqUw24lyafaGfyc88iwG8z/Iws0jRgeL0L7z
         X/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV6H4mq8WAvSWf5Xq0LEsXkmU+p3iUkFjwW1iGjA2fROSSf5FPOajA0byQnbkGqTOFmMEiNmrg9Bmm3+xtkmLN3xmIV+R+381QvkFv72RipdxbaSZQTEEsHjt0WcFRcOCEJQu+wi9gouWbGO/iccpYI1+Ozt8nmlsNEya5FmBKuffv0vYOJ8LzS
X-Gm-Message-State: AOJu0YyAlmesVAtcs887FBf6pdwvrBHJU5yELFkxQwphkZtJPjJfLC6g
	mmVptTCiboMt+2LSX2yzLpq2y4TXGS80JUiVZGCnFLdRHCe5wYKGzxFxn++dC4CH47xUjrJw807
	RWN1V8pBWvs7zRnlv2YKDNZkAVuo=
X-Google-Smtp-Source: AGHT+IHizWCLJBVqkpMdTL/7gDJs+2m1dqzDpctk/052EPRcJ501DymTi7m4cUMUPe446g68hjRydPkMddzEEwoP6K4=
X-Received: by 2002:a2e:7e0b:0:b0:2ec:2508:f370 with SMTP id
 38308e7fff4ca-2ec3cfe1cb4mr12648381fa.51.1718793756074; Wed, 19 Jun 2024
 03:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
 <5b79732b-087c-411f-a477-9b837566673e@leemhuis.info> <20240527183139.42b6123c@rorschach.local.home>
 <CAE4VaRHaijpV1CC9Jo_Lg4tNQb_+=LTHwygOp5Bm2z5ErVzeow@mail.gmail.com>
 <20240528144743.149e351b@rorschach.local.home> <CAE4VaRE3_MYVt+=BGs+WVCmKUiQv0VSKE2NT+JmUPKG0UF+Juw@mail.gmail.com>
 <20240529144757.79d09eeb@rorschach.local.home> <20240529154824.2db8133a@rorschach.local.home>
 <CAE4VaRGRwsp+KuEWtsUCxjEtgv1FO+_Ey1-A9xr-o+chaUeteg@mail.gmail.com>
 <20240530095953.0020dff9@rorschach.local.home> <CAE4VaRGYoa_CAtttifVzmkdm4vW05WtoCwOrcH7=rSUVeD6n5g@mail.gmail.com>
 <ceb24cb7-dbb0-48b0-9de2-9557f3e310b5@leemhuis.info> <20240612115612.2e5f4b34@rorschach.local.home>
 <CAE4VaRFwdxNuUWb=S+itDLZf1rOZx9px+xoLWCi+hdUaWJwj6Q@mail.gmail.com> <20240618105239.1feda53a@rorschach.local.home>
In-Reply-To: <20240618105239.1feda53a@rorschach.local.home>
From: =?UTF-8?B?SWxra2EgTmF1bGFww6TDpA==?= <digirigawa@gmail.com>
Date: Wed, 19 Jun 2024 13:41:59 +0300
Message-ID: <CAE4VaRFuZWEBEoNfApQL8SuUDxod9FcWhgzP1joTzDecf74B+Q@mail.gmail.com>
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During Shutdown/Reboot
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

disabled  CONFIG_FORCE_NR_CPUS option for 6.9.5 but the trace + panic
still exists. So that one didn't help. I've also been bisecting the
trace but have not finished it yet as the last half dozen builds
produced non-bootable kernels. Anyway, I will continue it soon(ish)
when I have a bit more free time.

--Ilkka

On Tue, Jun 18, 2024 at 5:52=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 13 Jun 2024 10:32:24 +0300
> Ilkka Naulap=C3=A4=C3=A4 <digirigawa@gmail.com> wrote:
>
> > ok, so if you don't have any idea where this bug is after those debug
> > patches, I'll try to find some time to bisect it as a last resort.
> > Stay tuned.
>
> FYI,
>
> I just debugged a strange crash that was caused by my config having
> something leftover from your config. Specifically, that was:
>
> CONFIG_FORCE_NR_CPUS
>
> Do you get any warning about nr cpus not matching at boot up?
>
> Regardless, can you disable that and see if you still get the same
> crash.
>
> Thanks,
>
> -- Steve

