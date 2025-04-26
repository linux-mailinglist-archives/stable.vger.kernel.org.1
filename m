Return-Path: <stable+bounces-136765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61765A9DB78
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 16:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85654A2612
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 14:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44698189B80;
	Sat, 26 Apr 2025 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf0zJfW6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304D11CAF;
	Sat, 26 Apr 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745677846; cv=none; b=Gjk2Vy9j6/Q7sWrDFr/lACJpM6fktfwoDcOZxLPVGQBe+myvli432J338y6IKAMVOBb35O18bLE9PrNjaQ1bsEITSt8UDNb2ZjMlO0ckkM/QIDrHSmq4VF3fSWv7qVc73RSW6D1vinQA789gGUTSB+PWejRaRLHfNS3+dWR+mt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745677846; c=relaxed/simple;
	bh=oyYg7u/2pPcAjocuz3ZQ394fbLtIayNczwaFTx+Qj6A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pKpiwcBd6yIx+21n+5e5mcqtQURYWPpRQecUyXeupF9WUrB2F6p+Gq0Wp787JBZCr9uhHXHv9nneYWKDo4jn53zyNdE1twYSpenlvQ6MTVFt/SpSJHF29BbwxfQYNIXeeZfX9De7qC2sowo2kzUW8nRqNVArGMUDHblWuITjpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf0zJfW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF6AC4CEE2;
	Sat, 26 Apr 2025 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745677845;
	bh=oyYg7u/2pPcAjocuz3ZQ394fbLtIayNczwaFTx+Qj6A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gf0zJfW6RwxnvdylZw4aXryL00UIeo4H1K52I7KwBf/rLvWiPMnJitdDpm/4ptKY8
	 7JMfa5Jl49ivRzw2NmZEIaSpuEjRIVTzXx/gfc4jrBPAr7aIusrB1KCJgFlS1JEL/N
	 u3S7QW3tuRJVwRzipDPIzmcN5vIoJvFDVXHt9AwD9pdDO71euwSeqKicu3JDOgN1CA
	 zNkVHbrsCBOXs0LGK6mvJIXdcAJGbwbtY1w/GHBLWeD8OUxSOdTSRydoFzgpT8LXb4
	 7aiafe5gSKjhUzyjCB4Ns/JYUJ9KBGabHf8x4R2PRb1vTrii1w/y7v6lNZOnCfzfWs
	 aIj4roKQT0vJA==
Date: Sat, 26 Apr 2025 07:30:42 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Sasha Levin <sashal@kernel.org>
CC: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: =?US-ASCII?Q?Re=3A_Patch_=22lib/Kconfig=2Eubsan=3A?=
 =?US-ASCII?Q?_Remove_=27default_UBSAN=27_from_?=
 =?US-ASCII?Q?UBSAN=5FINTEGER=5FWRAP=22_has_been_?=
 =?US-ASCII?Q?added_to_the_6=2E14-stable_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250426141107.GA3689756@ax162>
References: <20250426132510.808646-1-sashal@kernel.org> <71399E4C-AAD6-4ACF-8256-8866394F3895@kernel.org> <20250426141107.GA3689756@ax162>
Message-ID: <029BABE7-BB0E-49A6-8B24-EE5392B43DDD@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 26, 2025 7:11:07 AM PDT, Nathan Chancellor <nathan@kernel=2Eorg> =
wrote:
>On Sat, Apr 26, 2025 at 06:33:24AM -0700, Kees Cook wrote:
>>=20
>>=20
>> On April 26, 2025 6:25:09 AM PDT, Sasha Levin <sashal@kernel=2Eorg> wro=
te:
>> >This is a note to let you know that I've just added the patch titled
>> >
>> >    lib/Kconfig=2Eubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRA=
P
>> >
>> >to the 6=2E14-stable tree which can be found at:
>> >    http://www=2Ekernel=2Eorg/git/?p=3Dlinux/kernel/git/stable/stable-=
queue=2Egit;a=3Dsummary
>> >
>> >The filename of the patch is:
>> >     lib-kconfig=2Eubsan-remove-default-ubsan-from-ubsan_in=2Epatch
>> >and it can be found in the queue-6=2E14 subdirectory=2E
>> >
>> >If you, or anyone else, feels it should not be added to the stable tre=
e,
>> >please let <stable@vger=2Ekernel=2Eorg> know about it=2E
>>=20
>> Please drop this; it's fixing the other patch that should not be backpo=
rted=2E :)
>
>This one is still technically needed but I already sent a manual
>backport for this=2E=2E=2E
>
>https://lore=2Ekernel=2Eorg/stable/20250423172241=2E1135309-2-nathan@kern=
el=2Eorg/
>https://lore=2Ekernel=2Eorg/stable/20250423172504=2E1334237-2-nathan@kern=
el=2Eorg/

Ah yes! I need more coffee=2E Please use Nathan's patches=2E :)


--=20
Kees Cook

