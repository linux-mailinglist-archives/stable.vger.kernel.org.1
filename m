Return-Path: <stable+bounces-136759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C55A9DB24
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 398FC7B5DF1
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE3918DB02;
	Sat, 26 Apr 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8vYeEJ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0663D2FB;
	Sat, 26 Apr 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745674346; cv=none; b=swpCXycvN/jGCOd7jFQY2g4CwFjPHqCBTomjSCAR/uxTeUQwUrQ3rxi2kSA+8E5VYDJWX7rjplqrV7a4YAAd1ndxZUBrtCjkMu+oPZ4tFmfyL88oDE+7POX+c/be2yQJXN9eK7G4ctFbiJUEUWgg14o0rqaxWVjCMFTq8rm/gxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745674346; c=relaxed/simple;
	bh=EKOjTjpOVplrxHq+zwLYFp3Xomo1P87H92bcj5Jmztg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MVVIA8tRj8Uxr0kgtJha+ELYRDg1rr7Kp47gSsGdbj3LibNVzorH1IDilfQp+qIa+nBSpvNjFsRox/UWcZmei6F9mMtthpIAX8t/hck3PqqyxwJevyy3d7vzXbZtVRpAVG/AABHCmO0AKkRZTLYqZjj9JxthjvPcPciFb5Hk2VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8vYeEJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B69BC4CEE2;
	Sat, 26 Apr 2025 13:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745674345;
	bh=EKOjTjpOVplrxHq+zwLYFp3Xomo1P87H92bcj5Jmztg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=L8vYeEJ60RmhL+NUMjGZTWLPZh8qx74neavOCsI1cLfrpop7inGZfJa2d6Ysf0j2r
	 rXCVFmXW+nHD/uZn8KU43OWgFtov8zH8mmpAFyCIt/VVVqsr4kDtqBbiWtm3gitLiA
	 dCPyP3YBYIoZSKuK8heAtq+9A62CiQDqtRS+sBsuwJuuehuMwAMrBaiBO7ScgS8yQv
	 09TpeMxXvgJQRrA0rjnWr/LAzvRryKStZ2YfRh+tpudF0vIurKpxcX6TFFOXHSQbeH
	 t7vSW0QmNqh3KinygDjj2Cm8U4uUwP1FfceaFGYhvoYt5+re2toCoTjuT7p2LEDkv1
	 tRDtq3jKincLA==
Date: Sat, 26 Apr 2025 06:32:22 -0700
From: Kees Cook <kees@kernel.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 stable-commits@vger.kernel.org
CC: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Subject: =?US-ASCII?Q?Re=3A_Patch_=22ubsan/overflow=3A_Rewor?=
 =?US-ASCII?Q?k_integer_overflow_sanitizer_opt?=
 =?US-ASCII?Q?ion_to_turn_on_everything=22_has_b?=
 =?US-ASCII?Q?een_added_to_the_6=2E14-stable_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250426132506.808609-1-sashal@kernel.org>
References: <20250426132506.808609-1-sashal@kernel.org>
Message-ID: <6C9F87EE-31A5-473A-8713-BF6C224BF73F@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 26, 2025 6:25:06 AM PDT, Sasha Levin <sashal@kernel=2Eorg> wrote:
>This is a note to let you know that I've just added the patch titled
>
>    ubsan/overflow: Rework integer overflow sanitizer option to turn on e=
verything
>
>to the 6=2E14-stable tree which can be found at:
>    http://www=2Ekernel=2Eorg/git/?p=3Dlinux/kernel/git/stable/stable-que=
ue=2Egit;a=3Dsummary
>
>The filename of the patch is:
>     ubsan-overflow-rework-integer-overflow-sanitizer-opt=2Epatch
>and it can be found in the queue-6=2E14 subdirectory=2E
>
>If you, or anyone else, feels it should not be added to the stable tree,
>please let <stable@vger=2Ekernel=2Eorg> know about it=2E

Please drop this; it is a config change and should not be backported=2E

-Kees

--=20
Kees Cook

