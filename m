Return-Path: <stable+bounces-183183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A354BB6AFC
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD029189FC1D
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A570D2EE5FC;
	Fri,  3 Oct 2025 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iE/lJP9F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEBB13C3F2;
	Fri,  3 Oct 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759496180; cv=none; b=povzPYlceoL6vP7TqW8hOyWB1dcY/BBs4BAdHJpeI/chKEAaDoA7U7C583RHeJWsZTs8aVIFZjnwXb6U+jd+G2XqI9wugBaq/bbS1txzgmK5fEvmBikhVtLoo5U41kI1jWkSuJip85GCwU2gkfhHJclVyClhWnTXySk/mht3Cig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759496180; c=relaxed/simple;
	bh=oXLBEGOqYIg7p2YCpfZfUojnR2QVwt3LtlZ6/Lpe/dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCCR8rt9qDQXPpxszWJXKbc/wbD72qEp0q0RXGp6NpCqvu257yHBhQEtWo/5ttqtOoKkn8XVEV6vh3Yqq3bf4jXo9OitixjfOGzby8g8J5ayuOBld9wdfYugUnzL9d1qOkcOkHThSXT2kx0yKrZjLvi+jqfyMCM1zhufxHp2UIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iE/lJP9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51296C4CEF5;
	Fri,  3 Oct 2025 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759496178;
	bh=oXLBEGOqYIg7p2YCpfZfUojnR2QVwt3LtlZ6/Lpe/dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iE/lJP9Fowzq44tVv9WoL/sHGnJEEmYEh429alBpZGiduLS8e9acTlJaeHd7KwKUE
	 OqQ0EIkRRiIjtnCwPMuvmZIpQ3rhLvKm6iEtAHlS8H1d3se2OjAGUVSRI5+E5MUteO
	 FffM/Az3bxK7VA1kxlNd6jXD1JTc7qouGC83F4WY=
Date: Fri, 3 Oct 2025 14:56:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, ojeda@kernel.org,
	wangrui@loongson.cn, yangtiezhu@loongson.cn,
	stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Re: Patch "LoongArch: Handle jump tables options for RUST" has
 been added to the 6.16-stable tree
Message-ID: <2025100345-subject-wing-bfda@gregkh>
References: <2025092127-sprint-unwomanly-fc76@gregkh>
 <CANiq72kEzOa60EhLQ2YnBOD6bsAHc7qA9v9-MP2FtxMa04Q5PQ@mail.gmail.com>
 <3495c3d8.1bf35.199a57c2d8f.Coremail.chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3495c3d8.1bf35.199a57c2d8f.Coremail.chenhuacai@loongson.cn>

On Thu, Oct 02, 2025 at 11:13:22PM +0800, 陈华才 wrote:
> 
> 
> 
> > -----原始邮件-----
> > 发件人: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
> > 发送时间:2025-10-02 01:39:25 (星期四)
> > 收件人: gregkh@linuxfoundation.org
> > 抄送: chenhuacai@loongson.cn, ojeda@kernel.org, wangrui@loongson.cn, yangtiezhu@loongson.cn, stable-commits@vger.kernel.org, stable@vger.kernel.org
> > 主题: Re: Patch "LoongArch: Handle jump tables options for RUST" has been added to the 6.16-stable tree
> > 
> > On Sun, Sep 21, 2025 at 3:05 PM <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     LoongArch: Handle jump tables options for RUST
> > >
> > > to the 6.16-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > ...
> > 
> > > commit 74f8295c6fb8436bec9995baf6ba463151b6fb68 upstream.
> > 
> > Huacai et al.: I wonder if we could get this one into 6.12.y?
> I agree with you, it is better to backport to 6.12.y. But it needs
> "LoongArch: Make LTO case independent in Makefile" as its dependency,
> and need "LoongArch: Fix build error for LTO with LLVM-18" as a further
> fix.

Great, can someone send me backported versions of these please?

> 本邮件及其附件含有龙芯中科的商业秘密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制或散发）本邮件及其附件中的信息。如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。 
> This email and its attachments contain confidential information from Loongson Technology , which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this email in error, please notify the sender by phone or email immediately and delete it. 
> 
>

Note, this doesn't work for public emails :)

thanks,

greg k-h

