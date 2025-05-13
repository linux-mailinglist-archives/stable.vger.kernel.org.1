Return-Path: <stable+bounces-144113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C9CAB4C54
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BCC16A7D7
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1DF1EC01F;
	Tue, 13 May 2025 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y4QsfWXR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WNJrczGZ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968803214
	for <stable@vger.kernel.org>; Tue, 13 May 2025 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747119211; cv=none; b=Qsy5S7/Y5xjoaS8n2TJed481/1T+CKXyOb7Rpsrh8nrOTxBkpv/+UY6LidbU/c9LL3k0znphqkfAWKU8nzVeNsXapNPFm2oowUXAAJHyGjpkQXLSBpX50QhzIzDpvW1Gf+Zh/kP38MVJ7qK003DXUeFzg9+pdo8YNWUgjbCJqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747119211; c=relaxed/simple;
	bh=kNazzWVzmo+sg3QhIT28EXt/bS7rl83yCNGSj5Y13cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXYCaJK3uFpRiwKXiSGvue2idhLXHhv3EaEuOWCqaDr90XNvth/0Q7FqlWI1U2b2c8ww3ZbOFjoOzX38qTdutklBOaxgfM1gaVJUmXVO8Thbkx8L5BneSEesHS6tivOiwXAB1sBr9xVJEvBVxfMDmrsbSu4T3Lm6HwyLIZoM98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y4QsfWXR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WNJrczGZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 May 2025 08:53:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747119207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNazzWVzmo+sg3QhIT28EXt/bS7rl83yCNGSj5Y13cs=;
	b=Y4QsfWXRXBPE8U+KPdtk+3WNlx26pLzS1Ag2kFBsng0QBI4T7w2l+Lo/L3mCbg/TG71xRK
	9e3cyGCsGHzcJNBMCLeQTCnaRjsikohTcpEu8YtZIp/aGoHZuofj30VfgJoAH5qeVidkk0
	6vw1FcpEpwvMw1ZFM3U07u2WzjaFr+OYgDRyg4RxF1s6QofRuqPJyW0CfaQJAMV+3Sxgl1
	2Wl6dimha7S8jLJf9jb3mt7sPQR9ixwZGPvYVJsvV7C1DfUKiugXF6IKvDNy373Nd+UQWc
	3JH+eX6RnBbERlw8DqErWlb18mlgtP9Cp9GddBWy1ToGH6T96XrtlGqhrGCE/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747119207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNazzWVzmo+sg3QhIT28EXt/bS7rl83yCNGSj5Y13cs=;
	b=WNJrczGZAZCisJa9anVgeiRm2CwWW15Nk1Nb104RHvFd/uoYtUH8DOTXVLmGtSp3VTNkYd
	ZnIMTi+NURMmLpAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: gregkh@linuxfoundation.org
Cc: tglx@linutronix.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clocksource/i8253: Use
 raw_spinlock_irqsave() in" failed to apply to 6.1-stable tree
Message-ID: <20250513065326.frlx-qtR@linutronix.de>
References: <2025051256-encrust-scribe-9996@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2025051256-encrust-scribe-9996@gregkh>

On 2025-05-12 12:31:56 [+0200], gregkh@linuxfoundation.org wrote:
>=20
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 94cff94634e506a4a44684bee1875d2dbf782722
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051256-=
encrust-scribe-9996@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>=20
=E2=80=A6

I performed these steps and the patch applied. The diff is the same so
git did not attempt to resolve a conflict on its own. HEAD was at
v6.1.138 at the time.

Sebastian

