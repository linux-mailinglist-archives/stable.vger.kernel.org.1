Return-Path: <stable+bounces-76531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BCA97A7ED
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 21:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762631F260B7
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 19:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED341332A1;
	Mon, 16 Sep 2024 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GDIW3Sjp"
X-Original-To: stable@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A551DFE4
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516140; cv=none; b=BVGSseHJHd+XjVBS8wKWTDWHX0iOr87++64eCaYit9vjVTp9rZcwNrr8QXzJ0/76pCYxvMG5sOHPs4MnO9nWdg698bxSNk+jfFf9CzPiC8+Qm44W7NzW+zgluLr6RRso+YdLor8P9tFVkq0zzi+nSj2gswrdHei1NCNqc7pnzYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516140; c=relaxed/simple;
	bh=zPjHfQdvpqs4TfgpQHEOptnUrlJ+kxZazWeYFpu76r8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APl9oqpcOcvMyoBEw5PSgoCuAfoQ/DuFFDGElMZO0u0WM8nctBtrk2tqMq21sn1tbVxG+z2mpZ0Tj9bynYGqLp+t6aWoKakaVWmxeXmZU6YK4XBg7FTg3meUCPGtWT1HTQdgJ+D+nYhfWPDlbO/mEmWUD6IXIh9TVX3rIaKQEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GDIW3Sjp; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726516136; x=1726775336;
	bh=8j1OBoEq93yzihCTZoTOGp8S4edGbr7k85rO/0srWEw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GDIW3SjpRZoye586ZrXv/+XV7/DLswdYwq/x/1/OrHNMlHpWpQln9jqUQDhbQAphW
	 TZHWVJTs2KgiKyg41HlEwThjWrxWuUvh9JoT9fEKxZF91OjUJijM+Z3qYGNp1yGr79
	 bD5OpMo3rGzTgF5JaGjZrxqOVBbP51/pEXcTIO9fahq7WZNhvn6orT9g3/M1PC349e
	 El9SxH1/GwHAGFDoo0EJP1wrqYaOy8LavX7qDVqAhXf5Iuc91M4d3BkTUuIX6Z216d
	 w8DYZX2mJkbMJzYZ5TYZAuYhZlnrIRMAU5a1afgnia8TiR3kePD1Vt+ixweO3wJ9gj
	 skPjyF3rpsQAQ==
Date: Mon, 16 Sep 2024 19:48:54 +0000
To: Peter Zijlstra <peterz@infradead.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RESEND PATCH] sched/syscalls: Allow setting niceness using sched_param struct
Message-ID: <rdEqY1XYnE6kLSvXRjXReSAey0SEwMDUvqQRqLheIM99LpGH8pmv1ngZsNAkW1-DEHQhERga-rxGfTbuhL6FW_aEdo1DvWaOgncii1KmupY=@pm.me>
In-Reply-To: <e6KW_ypfbIVbenvwbBwGgnxX700e-A68oVmCn1pdJ0834U4wtIWXhh5zfHrQF2dvSL_Vc_heC4KZ0XRzNZ-w7QfF70W0epxCzpph55reOls=@pm.me>
References: <20240916050741.24206-1-mcpratt@pm.me> <20240916111323.GX4723@noisy.programming.kicks-ass.net> <e6KW_ypfbIVbenvwbBwGgnxX700e-A68oVmCn1pdJ0834U4wtIWXhh5zfHrQF2dvSL_Vc_heC4KZ0XRzNZ-w7QfF70W0epxCzpph55reOls=@pm.me>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: 2ea0a1b247a658765daeb7e72ca0ee54c8445048
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

one more detail I forgot:
it actually would not be compliant for niceness as the input...

On Monday, September 16th, 2024 at 15:23, Michael Pratt <mcpratt@pm.me> wro=
te:

> On Monday, September 16th, 2024 at 07:13, Peter Zijlstra <peterz@infradea=
d.org> wrote:
>
> > Worse, you're proposing a nice ABI that is entirely different from the
> > normal [-20,19] range.
>=20
> ...
> ...
> ...
>=20
> Otherwise, we have a confusing conflation between the meaning of the two =
values,
> where a value of 19 makes sense for niceness, but is obviously invalid fo=
r priority
> for SCHED_NORMAL, and a negative value makes sense for niceness, but is o=
bviously invalid
> for priority in any policy.
>=20

POSIX doesn't allow a negative value for the ABI at all:

  If successful, the sched_get_priority_max() and sched_get_priority_min() =
functions return
  the appropriate maximum or minimum values, respectively.
  If unsuccessful, they return a value of -1 and set errno to indicate the =
error.


--
MCP

