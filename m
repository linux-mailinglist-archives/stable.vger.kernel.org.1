Return-Path: <stable+bounces-179382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78111B553AC
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 17:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0AF1BA4242
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D653B310774;
	Fri, 12 Sep 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="q3pZOVyX"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.156.205.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71230EF7D;
	Fri, 12 Sep 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.156.205.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691186; cv=none; b=BDIy8aoiYPyG8vkaw2XgdCrQe75h2y7Z0cMSrxf50xA1DFHd9gXeXw2m9fuEzEwJ3Lk08+kQrFF53SeYRTWSUFOLpQQUf3u/LUNPoCzRC8c3kPGQqKwt5ncEoj00jCyGzNn6fsa6Zca82BNsHm/riV9DtOy7TXpoSWVRk5y/zjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691186; c=relaxed/simple;
	bh=gzA9/1hZWy6gPbQHUZJhPfmy5jKvOr47Ub69jJV3IWk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gd0N0pBo23bc71D2PE3MLMF/8IdSGndBG/3/tzD+qXpFcL8lKAOylg6SBlgms3W7anZ1M9xKaAVbnDKRfPTIu7FTC3zwWDM9dtJfUZQAfLicj6YlyA1idxUkr9h07XX2Zn0GH4Ze8+mwB9Z7lYfKS90WUoH3ZZMi2suJjtLK0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=q3pZOVyX; arc=none smtp.client-ip=18.156.205.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757691185; x=1789227185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jHoKpKMxq2o2+9UPCtViDZAZrnm3rcs7dDCTVFs0FxQ=;
  b=q3pZOVyXVEz1eXN+Ok5kCqf/mWgBRGZmoPzf3KBtotnzuKNnxVDVkGwF
   uwzkVOq8KL9ddpwLPx6cTFVxYsfU8aM7gIxJfl8Z0SC8yFzxcEwlHUDj0
   9qloFYFHBx/JYjTQZGXgokrzBxcSgwzLVNAv/uaqMoPKZV/l4SXQV3q8w
   /ieqEKm2AqbhSBit70Ae0Go8hcTVEACBc/wQin7jIy/XwJF1Qf9f3FcC8
   MVLw+ZGqsSOzcjcygZA/6z+1REeVFqCCdC7qPe9237GsJmNK2CWhahsZH
   /h0nXWGUsWAIUaWrnyT5MI2XUErAlvx/NBesjXG8BYhZlNaNgz3jCu35f
   Q==;
X-CSE-ConnectionGUID: Oz4mykgzSk6itai0GYmqfA==
X-CSE-MsgGUID: Tegs65bKRPq1taEz9QAy0w==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="2028476"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:32:59 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:7848]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.46.95:2525] with esmtp (Farcaster)
 id 2114a863-d1da-44e8-8dc2-3a44cc11fdbd; Fri, 12 Sep 2025 15:32:59 +0000 (UTC)
X-Farcaster-Flow-ID: 2114a863-d1da-44e8-8dc2-3a44cc11fdbd
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 15:32:56 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 15:32:55 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.2562.020; Fri, 12 Sep 2025 15:32:55 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "natechancellor@gmail.com" <natechancellor@gmail.com>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "sashal@kernel.org" <sashal@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "ojeda@kernel.org"
	<ojeda@kernel.org>, "elver@google.com" <elver@google.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "sj@kernel.org" <sj@kernel.org>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "leon@kernel.org"
	<leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
	"clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Chocron, Jonathan"
	<jonnyc@amazon.com>
Subject: RE: [PATCH 0/4 5.10.y] overflow: Allow mixed type arguments in
 overflow macros
Thread-Topic: [PATCH 0/4 5.10.y] overflow: Allow mixed type arguments in
 overflow macros
Thread-Index: AQHcI/qCCE2mK/L6wUiqKMD/tSSwPw==
Date: Fri, 12 Sep 2025 15:32:55 +0000
Message-ID: <81f4f5f407064c2188c98a0361b85b88@amazon.com>
References: <20250912125606.13262-1-farbere@amazon.com>
 <2025091237-frugally-ultra-b3a5@gregkh>
In-Reply-To: <2025091237-frugally-ultra-b3a5@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> On Fri, Sep 12, 2025 at 12:56:01PM +0000, Eliav Farber wrote:
> > This series backports four commits to bring include/linux/overflow.h=20
> > in line with v5.15.193:
> >  - 2541be80b1a2 ("overflow: Correct check_shl_overflow() comment")
> >  - 564e84663d25 ("compiler.h: drop fallback overflow checkers")
> >  - 1d1ac8244c22 ("overflow: Allow mixed type arguments")
> >  - f96cfe3e05b0 ("tracing: Define the is_signed_type() macro once")
>
> You forgot to sign-off on these backports :(
>
> Other than that, they look good to me, thanks!  Can you resend with that =
added?
Done

---
Thanks, Eliav

