Return-Path: <stable+bounces-136760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9B3A9DB26
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A66B4A53AF
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339879C2;
	Sat, 26 Apr 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="My1u3iX+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D2A3594E;
	Sat, 26 Apr 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745674407; cv=none; b=kE5AQU1faxJT0n3EKoVeX0pNdMsfWio1ajcU0K4vfNLkP4SbnJWWAhGhYsLjCn3jfPAJLnrXfRe6xWKxBi0I39RgO9xdgQjT0x7OiQx/0PPzOnWQxsSy/z+VAFqu6s7e27hzaP/V7WsqY718/3h4tKNGucGtJ8pzFH7Yi1P9vkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745674407; c=relaxed/simple;
	bh=9OHP7wipa/adNPUxGlUCbrZO3/WBA0rDQBET5+6Y3m4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eKQAOiyzoOXO35SpBgzeqxfVcvWHZwuoVxQ7fcjKTaWBhWNbVodfJwD1N95HXUQbUzxq8YxZH1Ed0cOVw0wvkk5dVRW568PhpFFJGbmlwl4h7nf54kSGj8EFy+62bjG3pkSTN1onxP1Ixm4LNd4N1qZF675XKLPchD4AOj2gANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My1u3iX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E425C4CEEA;
	Sat, 26 Apr 2025 13:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745674407;
	bh=9OHP7wipa/adNPUxGlUCbrZO3/WBA0rDQBET5+6Y3m4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=My1u3iX+4wTRVI/Elbqit9cWUpWkN8OMf+V+ruHG0YOIVQ09f0xaxkyGNHiVpudYh
	 lP4zdFLGoscRb0DNF+RaIOpDZDt3E/gO8mzFxowWrONetngmq7ZHx5TbF0Nf/D8DO3
	 Irrvui6LPeTCzdfGHC0J2YtzqK+Qo3mpYBrpwv/ukvuFglH2jnQPH8OERbr7rt+R42
	 HN3wk6yapq52EvsjvN28vcp8CVgTPNcT3sWRqqU2wPnltnGPwiYAhPBddFTqpJNeUi
	 3ze2vKOU2ULebI4A6LwpfhFEsKCUa2Sls1GivSt7M6qOxYsTUwm2L4AasKtLoU5qEx
	 8w+msgEsbI8Dw==
Date: Sat, 26 Apr 2025 06:33:24 -0700
From: Kees Cook <kees@kernel.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 stable-commits@vger.kernel.org, nathan@kernel.org
CC: Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: =?US-ASCII?Q?Re=3A_Patch_=22lib/Kconfig=2Eubsan=3A?=
 =?US-ASCII?Q?_Remove_=27default_UBSAN=27_from_?=
 =?US-ASCII?Q?UBSAN=5FINTEGER=5FWRAP=22_has_been_?=
 =?US-ASCII?Q?added_to_the_6=2E14-stable_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250426132510.808646-1-sashal@kernel.org>
References: <20250426132510.808646-1-sashal@kernel.org>
Message-ID: <71399E4C-AAD6-4ACF-8256-8866394F3895@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 26, 2025 6:25:09 AM PDT, Sasha Levin <sashal@kernel=2Eorg> wrote:
>This is a note to let you know that I've just added the patch titled
>
>    lib/Kconfig=2Eubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
>
>to the 6=2E14-stable tree which can be found at:
>    http://www=2Ekernel=2Eorg/git/?p=3Dlinux/kernel/git/stable/stable-que=
ue=2Egit;a=3Dsummary
>
>The filename of the patch is:
>     lib-kconfig=2Eubsan-remove-default-ubsan-from-ubsan_in=2Epatch
>and it can be found in the queue-6=2E14 subdirectory=2E
>
>If you, or anyone else, feels it should not be added to the stable tree,
>please let <stable@vger=2Ekernel=2Eorg> know about it=2E

Please drop this; it's fixing the other patch that should not be backporte=
d=2E :)

-Kees

--=20
Kees Cook

