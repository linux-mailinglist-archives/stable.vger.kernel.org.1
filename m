Return-Path: <stable+bounces-81471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9CB99356E
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEA31F2520A
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3688C1DDA24;
	Mon,  7 Oct 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j7tcN/R2"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4641DD897;
	Mon,  7 Oct 2024 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323632; cv=none; b=jD1JPrdcy7nDM1PgKEub3E++i6OEdS9MuyiSmogUsXVPL1uGu3LOSu3hnULnT4N9DumoS3FvriThOdXmsZ3jkDvAZ2rNkHThV3prth+rBiijgzyeNx3XWUXXd4ZdSarkr3WWZaHPkVD1ZjJQG6aFiwCGf7MwW5e6MlZdBScvdD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323632; c=relaxed/simple;
	bh=owqZqe6SOcjF+x2nZEWaHQai9s/XpwQaG6SBFH1peuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXBFD8v865c8A+Y786k2fwKQ1BfOr3JGRA1MiktctlXPLq/ONcc9wmQyQ8C2ruf4QCVgUQtPsOTaMMuEiqm/DtN3tH6JSM84v4MCtipcjInBV8/BEU9hw2Nlekgl1bb3gS+Okqw5SAlkQitUeG1mJgvEaOmSxgaVIfB+4I0b6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j7tcN/R2; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=e0zWvVAwuNjFVyvqZcLjrFil652es6+3ZXlaMDiTv9Y=;
	b=j7tcN/R24zRx6XS8AZidhSws4nde4t98wWW9XX4xKYyEaudIM1hwKRYPXyT5FD
	PH4Pv/uWHD+fYPfls6lIAkcT2c42BbHgD9TnWLlwfim6nfKd9wNUbUtXlpZEuZTY
	UiT3DKskIEAJ75HvGvdtUmjoCc55EB6SAFT1pWtc39R9A=
Received: from localhost (unknown [223.104.83.8])
	by gzsmtp4 (Coremail) with SMTP id sygvCgCXrl5mHARnIWhxAw--.4001S3;
	Tue, 08 Oct 2024 01:37:42 +0800 (CST)
Date: Tue, 8 Oct 2024 01:37:42 +0800
From: Melon Liu <melon1335@163.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux@armlinux.org.uk, lecopzer.chen@mediatek.com,
	linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ARM/mm: Fix stack recursion caused by KASAN
Message-ID: <ZwQcZvU41vcD-Gkt@liu>
References: <ZwNwXF2MqPpHvzqW@liu>
 <CACRpkdZwmjerZSL+Qxc1_M3ywGPRJAYJCFX7_dfEknDiKtuP8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZwmjerZSL+Qxc1_M3ywGPRJAYJCFX7_dfEknDiKtuP8w@mail.gmail.com>
X-CM-TRANSID:sygvCgCXrl5mHARnIWhxAw--.4001S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtry5ArW3Cw43WFyftF47Jwb_yoWkWrc_ua
	9Y9F17C345J3W7GwsYkFs3Zr4q9rn5K345GayDt39agFn7t39rCFs5AFZayws5WF45ur95
	ZFs2qa4xtw1qgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjuOJ7UUUUU==
X-CM-SenderInfo: ppho00irttkqqrwthudrp/1tbiNgJxIWcEDJjSDgAAsP

On Mon, Oct 07, 2024 at 12:25:38PM +0200, Linus Walleij wrote:
> On Mon, Oct 7, 2024 at 7:25 AM Melon Liu <melon1335@163.com> wrote:
> 
> > When accessing the KASAN shadow area corresponding to the task stack
> > which is in vmalloc space, the stack recursion would occur if the area`s
> > page tables are unpopulated.
> >
> > Calltrace:
> >  ...
> >  __dabt_svc+0x4c/0x80
> >  __asan_load4+0x30/0x88
> >  do_translation_fault+0x2c/0x110
> >  do_DataAbort+0x4c/0xec
> >  __dabt_svc+0x4c/0x80
> >  __asan_load4+0x30/0x88
> >  do_translation_fault+0x2c/0x110
> >  do_DataAbort+0x4c/0xec
> >  __dabt_svc+0x4c/0x80
> >  sched_setscheduler_nocheck+0x60/0x158
> >  kthread+0xec/0x198
> >  ret_from_fork+0x14/0x28
> >
> > Fixes: 565cbaad83d ("ARM: 9202/1: kasan: support CONFIG_KASAN_VMALLOC")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Melon Liu <melon1335@163.org>
> 
> Patch looks correct to me:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Can you put the patch into Russell's patch tracker after some
> time for review, if no issues are found, please?
Ok.

Thanks!
> 
> Yours,
> Linus Walleij


