Return-Path: <stable+bounces-136761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A82A9DB2F
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A665A8918
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70991B87D7;
	Sat, 26 Apr 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRbOcWB2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BCB2F44;
	Sat, 26 Apr 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745674465; cv=none; b=lJo91+nFr657NhsMFWBh1QN18jZbtrzn8qjNpPGvp+ABIuAuCeZJHOKaCSW5hR0v9HgZ3qWCmQnrkD5V25gPVzCHL9pCqLNjkk8pPMeBiLDXNqgjzhLYMBTdbUDpIaWuoO9pmPLi+YiyCiRcl+THLGNdSAWp2n/ux3wb19U0TmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745674465; c=relaxed/simple;
	bh=w1dIi6QOBPhdnqxxzcOrcBADZBC4h7LcfeAdWWQ8upw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pWDGdfxEfxLBSj/iqwmHNf/ElTcwW7FG6RB+DoXowhrV/6RbgzU9vM0Pzp2BNXYO+7iuZbZRE1sYEHQ/OX0wfylttIQEzIPUcSrJBkp/JSMMSRK1B7L5ar4UUKJKjeb1Hv3+Ka6ZgBLQGkm7y+LBXVWq3s+cIV9jXVLclI9O1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRbOcWB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F48EC4CEE2;
	Sat, 26 Apr 2025 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745674465;
	bh=w1dIi6QOBPhdnqxxzcOrcBADZBC4h7LcfeAdWWQ8upw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WRbOcWB2GjDCEPAEKo7mZRyViHjNHxm7I1oeBauy1lBC9gh/TDJQlhOWg56gHhLYR
	 ZUFlCa+u8iHkBDHnByO/WvadhM004STBNhLwI43AXnNOaJmx5MctPdrUaMAawTUJ9W
	 cvEKMqcGpHtA2sUv+cXjhlT0lnINQdEW1cKIuEZxqf6FAsysFNO35mjQWo4x+a2PfN
	 BY+MRLgtHjbM18DXr6j/7gfefzH9YQ79HPdAgu2Msa374ORjlvkeTyONEhWVR1m6qe
	 1czc71l9HJuXlSoRInv9Aglqpdf/ygmG+wj8jXm6b0QaaEJTIx0kJ1mjQpbUAa6bX7
	 EyvB55gv+wbTw==
Date: Sat, 26 Apr 2025 06:34:23 -0700
From: Kees Cook <kees@kernel.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 stable-commits@vger.kernel.org
CC: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Subject: =?US-ASCII?Q?Re=3A_Patch_=22ubsan/overflow=3A_Rewor?=
 =?US-ASCII?Q?k_integer_overflow_sanitizer_opt?=
 =?US-ASCII?Q?ion_to_turn_on_everything=22_has_b?=
 =?US-ASCII?Q?een_added_to_the_6=2E12-stable_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250426132707.810304-1-sashal@kernel.org>
References: <20250426132707.810304-1-sashal@kernel.org>
Message-ID: <7CD116BE-645C-4F3E-B2D3-6B300A58F5E7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 26, 2025 6:27:07 AM PDT, Sasha Levin <sashal@kernel=2Eorg> wrote:
>This is a note to let you know that I've just added the patch titled
>
>    ubsan/overflow: Rework integer overflow sanitizer option to turn on e=
verything
>
>to the 6=2E12-stable tree which can be found at:
>    http://www=2Ekernel=2Eorg/git/?p=3Dlinux/kernel/git/stable/stable-que=
ue=2Egit;a=3Dsummary
>
>The filename of the patch is:
>     ubsan-overflow-rework-integer-overflow-sanitizer-opt=2Epatch
>and it can be found in the queue-6=2E12 subdirectory=2E
>
>If you, or anyone else, feels it should not be added to the stable tree,
>please let <stable@vger=2Ekernel=2Eorg> know about it=2E

Same as the other email; please drop=2E

-Kees

--=20
Kees Cook

