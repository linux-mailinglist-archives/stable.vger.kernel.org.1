Return-Path: <stable+bounces-60550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB899934D38
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 14:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33B41C21DFF
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7CC13C3C2;
	Thu, 18 Jul 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="V1w4xwbr"
X-Original-To: stable@vger.kernel.org
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B02C13BC05
	for <stable@vger.kernel.org>; Thu, 18 Jul 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721305797; cv=none; b=ckH8muVIsEz6xpEiNrfVSaZKZ2tWzD4vvXDPPyDzPGkj1KtrjperlYZDi73tnL7YbDl1ddzvtVmigGDCJ2j0CmmyJDIR8ieUS2C9sJJRyJf0mXCcVfrX/RNgQtJjWKOu965vuQMZaTn1xzDEre9pNpzVvy5Hpr8StKymxFpTVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721305797; c=relaxed/simple;
	bh=m2SEt3T2kjY4+Ov8IvCoLE+6CrWGgIA8XpgFh7Ia6F8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EfX+kKBqequOnAlTVuUdKHmF05EWxLQ9IfClSB8RBGCLa9zPvDK3B26cfPw6i/ylN+HCyZNoe9+x6FgmUzVeIS0lfhh00I5UChZPrBeBDLD6OMpN+nd1/9O8FIgw30e+ht6yr33Q73QMB69b4uUEYoKICleWAXD0cJdWaE/qnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=V1w4xwbr; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721305792; x=1721564992;
	bh=m2SEt3T2kjY4+Ov8IvCoLE+6CrWGgIA8XpgFh7Ia6F8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=V1w4xwbrMQF+JCXkyERuIUisNW9QTc4Unf7CXh0/e85N2QHUU4Us0I8LSfDGBc2NI
	 SjbRq14bYsFRluZjAfv/Tsd6YXDTavqdfw6ab0qbVlYqeC3N4zNIddOV8yL3rPGKBE
	 GBb+T1ivmsH71PFGNV6Hqwti28hIGWRt5tIXZjVZZk3A5qB2KKylOOH0nHznTyd7J/
	 YWhHKpohOtzPGHAphYWAnAT0CYiLXiv3KHDacX/b6KeJ4QiUwKqvnTKAaBfvGalDeL
	 b88/xKqFJQxSfuEH7DFvPRIYwrEV/n8BjycbJpKczBGP99+VSkRaswFpSkY+pjAoVo
	 DuBboQteGgY7w==
Date: Thu, 18 Jul 2024 12:29:48 +0000
To: stable@vger.kernel.org, alsa-devel@alsa-project.org
From: "edmund.raile" <edmund.raile@proton.me>
Cc: regressions@lists.linux.dev, o-takashi@sakamocchi.jp, tiwai@suse.de, clemens@ladisch.de, linux-sound@vger.kernel.org
Subject: [REGRESSION] ALSA: firewire-lib: heavy digital distortion with Fireface 800
Message-ID: <n4jdkizinqfoztqn2cwv7uqqqnvkyu2xk32qebazqznh74b3d3@r23skt4k7mqe>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: 813c186901566fe7b46392b8d79e9e54e51d48d8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Between the kernel releases 6.9.9 and 6.10.0, something changed that causes
heavy digital distortion on playback from at least ALSA and PipeWire.
The rhythm of the music is discernable in the output, so it isn't just
random noise.
It sounds a bit like bitcrushing, but not quite.
The generated overtones appear to be dependet on the sample rate.

I am sorry I can not be more specific, there are no kernel messages this ti=
me.

As Mr. Sakamoto recently committed all these changes to firewire he might
be able to identify the issue easily, which is why I'd like to ask him to
look into it.

Kind regards,
Edmund Raile.

#regzbot introduced: v6.9.9..v6.10


