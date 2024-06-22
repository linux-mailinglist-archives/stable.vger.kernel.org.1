Return-Path: <stable+bounces-54853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED73791319C
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 04:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A856B23F20
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 02:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F579DF;
	Sat, 22 Jun 2024 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsWurPlR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352912119;
	Sat, 22 Jun 2024 02:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719023118; cv=none; b=i7hk2rkBPA/J4hYu7cEOKevRe/xpiriE7hEvRTsmtBZx5uZC7RNlfC5vQbnFevmWfixKEBDKdmHJAugRmoCilOEPvx4gnKwSVke3flSfA7z8LzEN/poDYToJJIbVydI2OoRmkVjVAI8S97DQzqSBZhMcTMMOl9Y6ld3BL/Lohok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719023118; c=relaxed/simple;
	bh=GcsQc9ikcH+AJbdBZArT/RxNy3TLtgnk1xbAAfnItBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY5Jb0L19Z5qKbzUO/ITweSCI/2vfcDCt6eZ47ZMqj2wKe4BwCoofm89vrGM2KP8hsNNBl+UcF1IXVL8qqypQdc8dCzs9rBdP19fj3JKi2P3Gl1xgIeGtoWnXwP4/tpm9sbO8vkNUJGJ2CLGTO54cJMjKXo6qm4H920efccRKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsWurPlR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f7b785a01so293006066b.1;
        Fri, 21 Jun 2024 19:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719023115; x=1719627915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoLoLenO2hn+yBjuCLcTOSia4khLZOUwCxfFgSKuOrc=;
        b=LsWurPlR3TL9k97cHcdF/WDLxpQkbwtKTL5qHKPBriW6khQ9oPGa9PmTCMXr+phbyV
         r3Tq0ECAft0jTeE/Rlwdw1Hx3Z5CjFj3T1yugeWtWAOvEwr3TX6IwYd+hDLsirvsrZR8
         BPc5vkeIRjCuAS16zAGS1puwgtv8q7KUg/nGMJynJR6nY8AvY/BCfKESBUZQm+wjLHUZ
         K8bgGqB5SwofkbdmN1WglISQwbNdMm860PFbj1C03TMkEFoUGYhunRXoLYzbl3rKI6sn
         oA2qi1aiOAw2RqTy2vtCj9FvUmBo6qFA44GtJjnS0+vb4+RQrWZcp6icmrkL2DZiStmO
         pAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719023115; x=1719627915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoLoLenO2hn+yBjuCLcTOSia4khLZOUwCxfFgSKuOrc=;
        b=YN/sBa4xCba839BREVBfpROBqlSioIkSsQEb3+PIAHYmJ8gil73eNvmQ0HXvx5uXeu
         sOnYtNew847s7OeUCp2RMCbuZp505j0SPNotnS7MSzKSgb1aK+zCDdb5XwcKwrEy+f9M
         9btQk2uUkZnnqTAGZOZptVygz0XzZbyDYzsi/vMTJ4p1zXlGu078gsExBr7sYwjSi8oi
         VMEpUj1Pxv+fCL+DfZTkgzUlL09x83NGODrHFECon968ZFoccinYSMCYRVmvDIGIoG3a
         u6YiGycw+PQUVT6j4IrrXg9reAr1kOjhtzX/knsqadYH4OhU34YcZi/j4el+hEwJx5s5
         z1fA==
X-Forwarded-Encrypted: i=1; AJvYcCWWmKsLozlhh2DC1+MxI1CCF0vsOTaKx7jTa2RwTsvXObhHoVlo9St8KRE57g5LZI6iyV3OoUXyi03O/U9TUoLtjC+DhLmiQYGVw7FU4xoYREgFQvzZzMb5UpzprQ6t7sGbXZWs
X-Gm-Message-State: AOJu0Yxj338rCjg/2HODUtmtQup+e5R1IHtMUIsHENc12NXX4/OPzh/D
	rseD7K3mz/3nrHqBmdpxLdhHPjdUpawaLiwfMBraW+go+p2CNcjhuzp6XNE6C1etU5DjRnwlcNw
	T1HXeB8G9Ep+sA0uc7vyzMQPeSDSdZOSVIBvxlg==
X-Google-Smtp-Source: AGHT+IGqzP7BZpP7VUAnHz9SkGuXTFi3N5BNWqoIKPnVV15CHSzOWqVEK6BFwL2z9M5eh6vtIgyJmGbibXlXL5xBKlE=
X-Received: by 2002:a17:906:cb1:b0:a6f:f7c:5c7a with SMTP id
 a640c23a62f3a-a6fab7cd635mr495493666b.67.1719023114713; Fri, 21 Jun 2024
 19:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612070106.2060334-1-chenhuacai@loongson.cn> <87y16ym966.ffs@tglx>
In-Reply-To: <87y16ym966.ffs@tglx>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sat, 22 Jun 2024 10:25:02 +0800
Message-ID: <CAAhV-H7w+iHwXXzxVHzer7MiAVgU7v3DFuoWuKm5UWkUQoqeQA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-liointc: Set different ISRs for
 different cores
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Tianli Xiong <xiongtianli@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Sat, Jun 22, 2024 at 2:40=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Jun 12 2024 at 15:01, Huacai Chen wrote:
> > In the liointc hardware, there are different ISRs for different cores.
>
> I have no idea what ISR means in that context. Can you please spell it
> out with proper words so that people not familiar with the details can
> understand it?
ISR means "Interrupt Status Register" here, I will improve the wording.

>
> > We always use core#0's ISR before but has no problem, it is because the
> > interrupts are routed to core#0 by default. If we change the routing,
> > we should set correct ISRs for different cores.
>
> We do nothing. The code does.
>
> See https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#ch=
angelog
Let me try my best...

>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Tianli Xiong <xiongtianli@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> This Signed-off-by chain is wrong. If Tianli is the author then this
> needs a From: Tianli in the changelog. If you developed it together then
> this lacks a Co-developed-by tag.
Yes, here we lack a Co-developed-by, thanks.

Huacai

>
> See Documentation/process/
>
> Thanks,
>
>         tglx

