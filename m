Return-Path: <stable+bounces-136762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A607A9DB30
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB88E5A85F0
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6DB3594E;
	Sat, 26 Apr 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAa5v0MC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC78F22098;
	Sat, 26 Apr 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745674505; cv=none; b=AI+PP1Eox+7liYfleYfpTeVD0PYNLw1FWNgXJ5Drl2t0j863yDwPgQDrFJxRkm3L3qfQ4aRQEXb1yb1V5Zo6qd8+4L5PEZFg/Mg+YKkjgiqKQ01J4VNv8qrklMSQOqgvps7ihNsIv7VV9LPGQqYWJ8dx36du6nrjRqeflmWc5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745674505; c=relaxed/simple;
	bh=nb98Ro92DzSyr6/blONXFO3srenjbjeU/NXfh80k0dM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kOHOm2zyOkeTqrBVbyydroYgJslPPIMssNruthjQKMmXnawn3ufQ6PymObbZ+7I4Eglwbu87c76EbdYPqGOD0bninDOx46cG9p9sh6nT35Q1OFeEIzDlYZdDqkfy+ehG0/m+uh4dl1ZaDRitvThTF6WmAy0VYvPmEf425LEM0q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAa5v0MC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE2BC4CEE2;
	Sat, 26 Apr 2025 13:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745674505;
	bh=nb98Ro92DzSyr6/blONXFO3srenjbjeU/NXfh80k0dM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jAa5v0MCmFcGwyBDK65yhfCxfFW/F6WsBc5kWQ8mj0TPa4t9EmLOyhpwMpbclF/mr
	 ++zoPePtzsdUw5uHIqphSd4b/nlybzHwT0KprJ3Wd6x9VFAPCbqL/aR1oC3xScmh4E
	 bXwtG00Jr194JYVv+0+KJk0tuPWX37Mo6V81rzRWmWW+g0g/6fqn/uG8TfikdCzJIH
	 B0Q3QskoRMi8jjroJF7LBe8ZROj0IPUxR3sWJthqx8OP10KEUb8yxQtiYzP3VfHsJE
	 Bn+lRoj385lK5YtSiio56hD1G8gC1Wu0tuzcLqZU3pIWwQ/HPnqYCF+9sf98D5sNLf
	 +PDWd8L+8sFsA==
Date: Sat, 26 Apr 2025 06:35:03 -0700
From: Kees Cook <kees@kernel.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 stable-commits@vger.kernel.org, nathan@kernel.org
CC: Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_Patch_=22lib/Kconfig=2Eubsan=3A?=
 =?US-ASCII?Q?_Remove_=27default_UBSAN=27_from_?=
 =?US-ASCII?Q?UBSAN=5FINTEGER=5FWRAP=22_has_been_?=
 =?US-ASCII?Q?added_to_the_6=2E12-stable_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250426132711.810341-1-sashal@kernel.org>
References: <20250426132711.810341-1-sashal@kernel.org>
Message-ID: <10E8E371-735B-4C1F-B510-64CC3AC85708@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 26, 2025 6:27:11 AM PDT, Sasha Levin <sashal@kernel=2Eorg> wrote:
>This is a note to let you know that I've just added the patch titled
>
>    lib/Kconfig=2Eubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
>
>to the 6=2E12-stable tree which can be found at:
>    http://www=2Ekernel=2Eorg/git/?p=3Dlinux/kernel/git/stable/stable-que=
ue=2Egit;a=3Dsummary
>
>The filename of the patch is:
>     lib-kconfig=2Eubsan-remove-default-ubsan-from-ubsan_in=2Epatch
>and it can be found in the queue-6=2E12 subdirectory=2E
>
>If you, or anyone else, feels it should not be added to the stable tree,
>please let <stable@vger=2Ekernel=2Eorg> know about it=2E

And this too; please drop=2E :)

-Kees

--=20
Kees Cook

