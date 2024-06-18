Return-Path: <stable+bounces-53652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F193790D645
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 16:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E407292944
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30F313C67E;
	Tue, 18 Jun 2024 14:52:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0B768E1;
	Tue, 18 Jun 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722361; cv=none; b=VQ5GUdNHJQ6c0YOkTvGi7cLY8SHuEzgqc8yviLpnSR++/d8JIUCLBLoXvL3/e5EEgbvvHpb4CwIcQ//Gkqu4/NlCjesoJ4tUQrWYYYySeXto3fQlMrBO4wKihho0ZkKVIqYmFOHdJxUW7WhHIPg5xjUMuZ0/9n1uQLhcoUwv20g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722361; c=relaxed/simple;
	bh=TguY3CMuPmfVcYMtx2cC7kMtEqG6rcQyTG5JioFScNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoN54gXO8UQMKF11NrWLX4w1L3sTRJQPw7/8m5HgKCQt0MC54rDkD2nB1Uur5xy5ULMdGGGzf4AQX67hBc6B9S5ORU3FFLrykA14k+GMAPcldmunNDmG5l5qB5lD2aXV1j53wUJUkgSMsrDXolytI0wHV7lRSZW3Ccn8WLtc0GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9345FC3277B;
	Tue, 18 Jun 2024 14:52:40 +0000 (UTC)
Date: Tue, 18 Jun 2024 10:52:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?= <digirigawa@gmail.com>
Cc: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Linux regressions mailing list
 <regressions@lists.linux.dev>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
Message-ID: <20240618105239.1feda53a@rorschach.local.home>
In-Reply-To: <CAE4VaRFwdxNuUWb=S+itDLZf1rOZx9px+xoLWCi+hdUaWJwj6Q@mail.gmail.com>
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
	<5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
	<20240527183139.42b6123c@rorschach.local.home>
	<CAE4VaRHaijpV1CC9Jo_Lg4tNQb_+=LTHwygOp5Bm2z5ErVzeow@mail.gmail.com>
	<20240528144743.149e351b@rorschach.local.home>
	<CAE4VaRE3_MYVt+=BGs+WVCmKUiQv0VSKE2NT+JmUPKG0UF+Juw@mail.gmail.com>
	<20240529144757.79d09eeb@rorschach.local.home>
	<20240529154824.2db8133a@rorschach.local.home>
	<CAE4VaRGRwsp+KuEWtsUCxjEtgv1FO+_Ey1-A9xr-o+chaUeteg@mail.gmail.com>
	<20240530095953.0020dff9@rorschach.local.home>
	<CAE4VaRGYoa_CAtttifVzmkdm4vW05WtoCwOrcH7=rSUVeD6n5g@mail.gmail.com>
	<ceb24cb7-dbb0-48b0-9de2-9557f3e310b5@leemhuis.info>
	<20240612115612.2e5f4b34@rorschach.local.home>
	<CAE4VaRFwdxNuUWb=S+itDLZf1rOZx9px+xoLWCi+hdUaWJwj6Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 10:32:24 +0300
Ilkka Naulap=C3=A4=C3=A4 <digirigawa@gmail.com> wrote:

> ok, so if you don't have any idea where this bug is after those debug
> patches, I'll try to find some time to bisect it as a last resort.
> Stay tuned.

FYI,

I just debugged a strange crash that was caused by my config having
something leftover from your config. Specifically, that was:

CONFIG_FORCE_NR_CPUS

Do you get any warning about nr cpus not matching at boot up?

Regardless, can you disable that and see if you still get the same
crash.

Thanks,

-- Steve

