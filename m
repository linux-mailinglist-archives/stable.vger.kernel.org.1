Return-Path: <stable+bounces-189977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C026FC0DD8A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425D219A7287
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4192868A6;
	Mon, 27 Oct 2025 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jBA31kvc"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC6DF6C;
	Mon, 27 Oct 2025 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570030; cv=none; b=cQiy2nEg8SCmdqa2zqcA50SLGm2CTGFaEYcxYfDahP36Fu+ButJPFAY77ZM7VHxvzPyhzQ52c45LwFvl9yC96wPwSkVP9b4nSztGd7K+/Vdjgq4WQ3Vw0UcikLlQ9fo4yeilAvHOCqLmP0JYuJaWoGc5nzUwp/3tvYRgDct5tPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570030; c=relaxed/simple;
	bh=5788PWM/VBgk1tGTTY2kWxTv5vFa3dzGCv9B4Lw0uE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ViP3VV4XmZ4eNG7IFhbcSnHVbfPnywCY4IcxNZU+NXCDDLemjDhNWRjTwSA1Mbh03k4nPEmzclp6xpzk2DP8TP0Ok6sy6C5/bV3ONwnX9sUDn2iTZ7xX0wJefDYj1mmXq67exsE7IO2SdLdUmkHjA6L+S1IC5Tbk0226fSdBtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jBA31kvc; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwDBc5hb1z9str;
	Mon, 27 Oct 2025 14:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761570024; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5788PWM/VBgk1tGTTY2kWxTv5vFa3dzGCv9B4Lw0uE0=;
	b=jBA31kvc5mDtFmdGEQ/0gMKqXWZI5B3jOZpTnCIzzdlnOK2i9w4bYVF4vCiCdoP/FLcmzA
	kLdB03QzkgKDb2rJt+PeEoiffmkTcsbXaMz7Y1pAwiDW+pHzO9A3g1hUrGva46WUhn7yzK
	lZFdfqpLxTyD4XcJ+hqCNkpN8DkmNwdjaBoy/Pzu1ks94NZJKPkkuhltGUdYAsNwDbuL0t
	M4ZxgcqMme5UasmeV1iF0784ST9VdAiMAhEfyHR1uS31C2/Gvx0HrNteRUpqdaQ4f5kOC4
	hiUgqT8oJeuFzT5HnGwo4b5QQVeHJmj6LRx9CZBByYdcVSeqG4iH558CPdOxRw==
Message-ID: <5b22257b90d5df1c4a6b02f9472f11588208c4b5.camel@mailbox.org>
Subject: Re: [PATCH] drm/nouveau: Fix race in nouveau_sched_fini()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 27 Oct 2025 14:00:15 +0100
In-Reply-To: <25c97722-e05d-467c-908e-baa31e636a44@kernel.org>
References: <20251024161221.196155-2-phasta@kernel.org>
	 <25c97722-e05d-467c-908e-baa31e636a44@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: t19ydhdbzc3pnxf3frk84k717hbxabab
X-MBO-RS-ID: ad959cffc22c1f1fbba

On Fri, 2025-10-24 at 18:17 +0200, Danilo Krummrich wrote:
> On 10/24/25 6:12 PM, Philipp Stanner wrote:
> > nouveau_sched_fini() uses a memory barrier before wait_event().
> > wait_event(), however, is a macro which expands to a loop which might
> > check the passed condition several times. The barrier would only take
> > effect for the first check.
> >=20
> > Replace the barrier with a function which takes the spinlock.
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# v6.8+
> > Fixes: 5f03a507b29e ("drm/nouveau: implement 1:1 scheduler - entity rel=
ationship")
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>=20
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Applied to drm-misc-fixes


P.

