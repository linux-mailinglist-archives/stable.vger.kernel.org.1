Return-Path: <stable+bounces-81205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62323992283
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 02:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045E01F218DA
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 00:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEDCC156;
	Mon,  7 Oct 2024 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GH5n06Ig"
X-Original-To: stable@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C882320F
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728262091; cv=none; b=e9FNuy3XXUuNIHBWZk/x7vZwC+Z9icEFApvpm8FoYBpoDcOrqJYwHSVL5xD7VOCRVD7z6exe6qmCWr9rwThfomsy9EFkqlELU27veJteYv1QCRYdNDqKADxQLPDdXi4Y/LV8lSfwCYyPzAO/VMHJSWbpvZkqPfFZghFWdUb17t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728262091; c=relaxed/simple;
	bh=tKTe9QeUYOyMA4+JdAVr/rrMP9zIqXcn1Vj1lBOLGps=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoDQa64BBGQIheCq2BJmstTNiNw/WzPJ1AV8aHlSZqQdm9+z1Kv4W2YgD8GFJwv4D92MpNcyUr2i3OOWO8dypu88C4UNcN13j2UbbxyCSueo7JWJFAL5Z2tI8XY2HPjXvtspmP7GfZ0RQdBhFhakqcihOkzY97dr1uT7j3Lvidg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GH5n06Ig; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728262088; x=1728521288;
	bh=tKTe9QeUYOyMA4+JdAVr/rrMP9zIqXcn1Vj1lBOLGps=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GH5n06Ignz+kyr0QJroUGXUHeSxS2T+RZyttU0w/LLl/G8CA9mL4NwQ/Rf7JvEnJW
	 ZDRBLu5QC+faCEjtjd5VBJpdUD1pheqcf2GkcDaz5DCvYZ9uBc85WlwVEfzGNGO3U4
	 b4h2RqFPycXaSEFq6RyrIaaK1s+RB2Vc5sW1YWq6z4+hQ59F4pJB0nA5CvwLkIk1UC
	 V7B5QD9aFEd4T+ujxWUtrxUol+PbsFAzqnZflvwlrV7Z6p0UR+Rl9wd09iwqS/M4Et
	 ep9U6n9lAJ5XZyGF00gw4BMeKrTVcv4LHQY2wvUKdv7KW5p1UoxwCWi0fv5RT4JMUQ
	 T1Ac8fOwg38UA==
Date: Mon, 07 Oct 2024 00:48:04 +0000
To: Peter Zijlstra <peterz@infradead.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RESEND PATCH] sched/syscalls: Allow setting niceness using sched_param struct
Message-ID: <AtJ8bVeW6K8aXAFMtYW-Ml-HEP0RuugWjDr9P9O9B3SPNVaL-gl0FjK7AI64AJ6j8l5PmzLKdGUxFOhpT65twtth2huCrLQKDBu0sWaufdk=@pm.me>
In-Reply-To: <20240916111323.GX4723@noisy.programming.kicks-ass.net>
References: <20240916050741.24206-1-mcpratt@pm.me> <20240916111323.GX4723@noisy.programming.kicks-ass.net>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: 1dca41b235aa37dc0fe8d948ee924473e5f89996
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone, again,

I'm still waiting for a serious review of this very short patch after about=
 a month.
I'll be getting ready to send this a 3rd time, and to more people, if I don=
't hear back again.

I believe that I have correctly addressed Peter's concerns in my replies,
and that my patch is still appropriate for inclusion into Linux as it is no=
w.

If I'm wrong please let me know why instead of just silence.

--
MCP


