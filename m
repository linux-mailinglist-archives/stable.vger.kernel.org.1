Return-Path: <stable+bounces-45369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D620C8C839E
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 11:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EFE1F21608
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 09:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC2929437;
	Fri, 17 May 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1Nv9yrN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C872BD00;
	Fri, 17 May 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938369; cv=none; b=ph+uXAZQ7cbLQE/JPP79gKZv6NQYzXYauEdmO4wnGyEsfEonKjYi6rcE4riTkqexHVp0hdRBOaA/1INpWSJIIErPUovuJA9XnwdzC+oqqqjB2LVvI4Sn2n/t1LTdfTL7IBb6iYMWgX29e45dn59f12Q0M+n9OoztNfjQq7KGPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938369; c=relaxed/simple;
	bh=BIeOajTDnTE0oWk2OSRXZfKHkGcTs4mjiK2NQMCf3VY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aocVbJiPt8+TFZpToHaOsB/dkh9DPsoOQftrzHcj+KhgxetpbRzVK57ivdPwA37J+EW9n7Q5eRQJZrLoHC8WNFeK4CNPBiM405mNFEVgc/BtcG72aUra1hyNKzQizRT3LnC10EJSexLkzXEX/3MnLVO8PWPyqgg9o72mq+aE6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1Nv9yrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0D2C2BD10;
	Fri, 17 May 2024 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715938368;
	bh=BIeOajTDnTE0oWk2OSRXZfKHkGcTs4mjiK2NQMCf3VY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=S1Nv9yrNxdMNqknT7GMWrpBVRpZ1CpK5jotvkS29S8Khz6S2OpYe85lV5aMywTvKC
	 BS22zRHAHeRH463OmY/3wWqfNsHb9mEehp9uIx5KXiXApSKZBc5CnbTLeFBJbtD99y
	 bFwQ3q0AoxGszEKw5iNq/XvWeXztQlXP2zu60MI5lFez9PHKntkhv1BFUj5XNKNGf0
	 QvedZHd3GcSMfVCQ3vZflychi3F3O47N6RT6qbubI0mUkgZ12aWHnNdPZ0a0lWVIFK
	 lR1nnTenM+DOyh+sRycfbW+4cD3G/qJNBXU5kWmh9fL5BdgeNhWCB1nZsX5Bhw0b4n
	 wN/qHNX1/1eRA==
From: Kalle Valo <kvalo@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>,  Rafael Beims
 <rafael.beims@toradex.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  tsung-hsien.hsieh@nxp.com,  David Lin
 <yu-hao.lin@nxp.com>,  stable@vger.kernel.org,  Francesco Dolcini
 <francesco.dolcini@toradex.com>
Subject: Re: [v1] wifi: mwifiex: Fix interface type change
References: <20240510110458.15475-1-francesco@dolcini.it>
	<171593306296.3274748.4179889716794962474.kvalo@kernel.org>
	<20240517081312.GA7974@francesco-nb>
Date: Fri, 17 May 2024 12:32:44 +0300
In-Reply-To: <20240517081312.GA7974@francesco-nb> (Francesco Dolcini's message
	of "Fri, 17 May 2024 10:13:12 +0200")
Message-ID: <87zfsog4w3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Francesco Dolcini <francesco@dolcini.it> writes:

> On Fri, May 17, 2024 at 08:04:24AM +0000, Kalle Valo wrote:
>
>> Francesco Dolcini <francesco@dolcini.it> wrote:
>> 
>> > From: Rafael Beims <rafael.beims@toradex.com>
>> > 
>> > When changing the interface type we also need to update the bss_num, the
>> > driver private data is searched based on a unique (bss_type, bss_num)
>> > tuple, therefore every time bss_type changes, bss_num must also change.
>> > 
>> > This fixes for example an issue in which, after the mode changed, a
>> > wireless scan on the changed interface would not finish, leading to
>> > repeated -EBUSY messages to userspace when other scan requests were
>> > sent.
>> > 
>> > Fixes: c606008b7062 ("mwifiex: Properly initialize private
>> > structure on interface type changes")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
>> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>> 
>> BTW I removed the Reviewed-by from the commit message, I don't see the need to
>> have both Reviewed-by and s-o-b.
>
> Sure, I was in doubt about this, in the end I added it because I have seen
> this done in other subsystems, e.g. commit 6a4020b4c639 ("drm/bridge:
> tc358768: fix PLL parameters computation").

Heh, yeah we all do things a bit differently :) In my view s-o-b implies
that you have reviewed it as well but clearly not everyone think the
same. I'm fine either way, this is cosmetics anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

