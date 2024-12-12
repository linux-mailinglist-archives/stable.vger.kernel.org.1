Return-Path: <stable+bounces-100869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD019EE2D0
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B0A162181
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909B221146D;
	Thu, 12 Dec 2024 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmnv7M3G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF020E6EE;
	Thu, 12 Dec 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995401; cv=none; b=K8rycriPhiTwK0hhEqI8iWI3+/FpAiERDoSiK5hsOWz4nvf7uLF0Pxo5BkdCG7Zle7Z563pmEFTfzBLHKi8R1qyUiAMfNZyAB9MaAidvgSaHjH3O+NZ82/fEvC3zYIohPis1uoelIHdDJvmK0Df9DwcZLbsm6bfnolz029R0P1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995401; c=relaxed/simple;
	bh=g/1CaSp5CRV7wrXGjzqPiCWUX7Xl4YjfX/R9byJjNyw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=umxzw3XaH0+g9PqREVzypQMnQoIGYo7/Y8nSJe1VKVWlJ04iyg3p4+4d58KtRDO3mEi0K1vM4mF0jcmUk5tr0QXIFj/lgtphtXORlJ4WBQxu9QfMhzm23NDeECTgTRO/n7NkMm3DefNrwj579/NID1Rx9QQ7ciNAzueGyKKontM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmnv7M3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B93AC4CECE;
	Thu, 12 Dec 2024 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733995399;
	bh=g/1CaSp5CRV7wrXGjzqPiCWUX7Xl4YjfX/R9byJjNyw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Pmnv7M3GGAwXlXEZK1nTdpIliamYzNCWj6fVD1WqrxRNUc00Tu+JGI6jaPnex2oxw
	 TVf+v6aP0RgNiQBa3HwOVsxSQ/cSPtR50yAgglibMAi8c8xH0/HV1Dl8vpAu0LOf5e
	 jvVUNVksIvlByax+iUri3ZQA9dNcNvlBbnESvZ26J2wkGnCCCcQJajGofiP8eXu6cF
	 I+hQFcuPHyPxzDOAb1zTjSBEfAsqsrYT8PLTSQ1Rk0WEerTtBXIxrOs/gY3CaAxlPP
	 /t7CoKlHRduXcDSEmfeKG89boeEUYVH4s64Ymw675OG+arKzBqxENQ5EN1t+qMA+G3
	 AcaQBWegD9iGg==
Date: Thu, 12 Dec 2024 10:23:16 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Ulrich_M=FCller?= <ulm@gentoo.org>
cc: WangYuli <wangyuli@uniontech.com>, helugang@uniontech.com, 
    regressions@lists.linux.dev, stable@vger.kernel.org, 
    regressions@leemhuis.info, bentiss@kernel.org, jeffbai@aosc.io, 
    zhanjun@uniontech.com, guanwentao@uniontech.com, 
    Dmitry Savin <envelsavinds@gmail.com>
Subject: Re: "[REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works"
In-Reply-To: <ucyhxs1oh@gentoo.org>
Message-ID: <ops2o03r-ss88-nr02-qqq1-09p50s93sr8p@xreary.bet>
References: <uikt4wwpw@gentoo.org> <7DAFE6DAA470985D+20241210030448.83908-1-wangyuli@uniontech.com> <687qoq24-o1p4-519q-1r8p-s59680noorq3@xreary.bet> <ucyhxs1oh@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Dec 2024, Ulrich M=C3=BCller wrote:

> After the revert, there are now duplicate entries in hid-multitouch.c
> lines 2082-2048 and 2085-2087 ("Goodix GT7868Q devices").
>=20
> Maybe this should be fixed in a follow-up commit? It looks like a
> copy/paste error in commit c8000deb68365b461b324d68c7ea89d730f0bb85.
> CCing its author.

Yeah, WangYuli also noticed that earlier in this thread. Should be fixed=20
now by [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=
=3Dfor-6.13/upstream-fixes&id=3D8ade5e05bd094485ce370fad66a6a3fb6f50bfbc

--=20
Jiri Kosina
SUSE Labs


