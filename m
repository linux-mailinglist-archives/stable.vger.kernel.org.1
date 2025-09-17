Return-Path: <stable+bounces-179819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BDAB8037D
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 16:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAF91BC042F
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64F731B806;
	Wed, 17 Sep 2025 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kYy/23bx"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B028489B;
	Wed, 17 Sep 2025 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105464; cv=none; b=OaDGyp2PQFOVZjaKxRx+3poMvAPGyfTq4F9ueNW3cqs/dhKnvXBTdxY2MTLywgkIih8RDsgLIpIBivkozBbtkfkXbPTSsoOZaKyoMt+tGVGeMeWI/vtB3jV4fdq/Hs/K2gm7B/ZpXvZbtUsGfX5kk3PLnkQlosKLF6skCb8feL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105464; c=relaxed/simple;
	bh=Ytv1newusG7+bkOHV2/blNmqr9tI6rdENvNUJmTjzz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pj5HnbfNam3uj5CZBkrEVA70Cqfp43AsOyXlwP5gGJ+s5/Py9pg5ayFStLgvFtPEHvmXdXRyMvoCNioYrRLu4DgknRCvik1feDk0jlKrJ6hJLY9IFLCO7spqhgwJ3yNhxMqTNBFhzmi3etPSKRUSN2yrl7dbaGtHMAFOz8FbkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kYy/23bx; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758105462; x=1789641462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eLSWhg5NVrk5v8Kgwub/wl0fv0lwqhPjbvfwBqv7PuY=;
  b=kYy/23bxnmi8b1Ar4vRrYiKTCpenbXe6D8rJCuVO43YSvISiX7lc0wWf
   /+e6d7eRTWhrh7iEiRlfFDeufXabmr/+58QOtiX3vkn6C8FdDY1ogbZmz
   svNppIULJA4HB7Pa5eXNqnORk7An0fP3koj3vhjAocJFopV8dmkd5ybyn
   q2Lmnti9P6aK0Co13ThiFNLb53TXkfLiO0yfpGZK1YMgK5h4rt0TCTM6O
   Elb+xwNfODmaNI/mAWGIyj6H7RscNRiFWhXVxwTVVK6mukdKLFS62em8w
   8bo+qGbR8YcIxy/3ypD/4b4KQSd1TGNoNA2f2pHF8xVQw+KeYmS58Ulk+
   w==;
X-CSE-ConnectionGUID: CtGF1Dk7RPWFlQviryGv4w==
X-CSE-MsgGUID: EBgriIOpTnCmIc2LiTXBrg==
X-IronPort-AV: E=Sophos;i="6.18,271,1751241600"; 
   d="scan'208";a="2137626"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 10:37:32 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:8555]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.1.3:2525] with esmtp (Farcaster)
 id 6aec255b-397c-4ef4-9439-fab825e22f38; Wed, 17 Sep 2025 10:37:31 +0000 (UTC)
X-Farcaster-Flow-ID: 6aec255b-397c-4ef4-9439-fab825e22f38
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 17 Sep 2025 10:37:31 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 17 Sep 2025 10:37:31 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.2562.020; Wed, 17 Sep 2025 10:37:31 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"sj@kernel.org" <sj@kernel.org>, "David.Laight@aculab.com"
	<David.Laight@aculab.com>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "keescook@chromium.org"
	<keescook@chromium.org>, "linux-sparse@vger.kernel.org"
	<linux-sparse@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Chocron, Jonathan" <jonnyc@amazon.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, "Farber, Eliav" <farbere@amazon.com>
Subject: RE: [PATCH 1/7 5.10.y] tracing: Define the is_signed_type() macro
 once
Thread-Topic: [PATCH 1/7 5.10.y] tracing: Define the is_signed_type() macro
 once
Thread-Index: AQHcJ78SUxQReVk2GUOsJiAxSQXGEw==
Date: Wed, 17 Sep 2025 10:37:31 +0000
Message-ID: <91da8ce3e4fb4a8991876a3ed130a873@amazon.com>
References: <20250916212259.48517-1-farbere@amazon.com>
 <20250916212259.48517-2-farbere@amazon.com>
 <2025091717-snowflake-subtract-40f7@gregkh>
In-Reply-To: <2025091717-snowflake-subtract-40f7@gregkh>
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

> On Tue, Sep 16, 2025 at 09:22:53PM +0000, Eliav Farber wrote:
> > From: Bart Van Assche <bvanassche@acm.org>
> >
> > commit 92d23c6e94157739b997cacce151586a0d07bb8a upstream.
>
> This is only in 6.1, and not other trees, why is it needed here?

It exists also in 5.15:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/inc=
lude/linux/overflow.h?h=3Dv5.15.193&id=3Ded6e37e30826b12572636c6bbfe6319233=
690c90

Without this change, I get many compilation errors when backporting
commit d53b5d862acd ("minmax: allow min()/max()/clamp() if the
arguments have the same signedness.")

  CALL    scripts/atomic/check-atomics.sh
  CC      arch/arm64/kernel/asm-offsets.s
In file included from ./include/linux/bits.h:22,
                 from ./include/linux/ioport.h:15,
                 from ./include/linux/acpi.h:12,
                 from ./include/acpi/apei.h:9,
                 from ./include/acpi/ghes.h:5,
                 from ./include/linux/arm_sdei.h:8,
                 from arch/arm64/kernel/asm-offsets.c:10:
./include/linux/nodemask.h: In function '__first_node':
./include/linux/minmax.h:30:39: error: implicit declaration of function 'is=
_signed_type' [-Werror=3Dimplicit-function-declaration]
   30 |  __builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))), \
      |                                       ^~~~~~~~~~~~~~
./include/linux/build_bug.h:78:56: note: in definition of macro '__static_a=
ssert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
./include/linux/minmax.h:50:3: note: in expansion of macro 'static_assert'
   50 |   static_assert(__types_ok(x, y),  \
      |   ^~~~~~~~~~~~~
./include/linux/minmax.h:30:24: note: in expansion of macro '__is_constexpr=
'
   30 |  __builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))), \
      |                        ^~~~~~~~~~~~~~
./include/linux/minmax.h:38:3: note: in expansion of macro '__is_signed'
   38 |  (__is_signed(x) =3D=3D __is_signed(y) ||   \
      |   ^~~~~~~~~~~
./include/linux/minmax.h:50:17: note: in expansion of macro '__types_ok'
   50 |   static_assert(__types_ok(x, y),  \
      |                 ^~~~~~~~~~
./include/linux/minmax.h:57:3: note: in expansion of macro '__cmp_once'
   57 |   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
      |   ^~~~~~~~~~
./include/linux/minmax.h:160:27: note: in expansion of macro '__careful_cmp=
'
  160 | #define min_t(type, x, y) __careful_cmp(min, (type)(x), (type)(y))
      |                           ^~~~~~~~~~~~~
./include/linux/nodemask.h:265:9: note: in expansion of macro 'min_t'
  265 |  return min_t(unsigned int, MAX_NUMNODES, find_first_bit(srcp->bits=
, MAX_NUMNODES));
      |         ^~~~~
./include/linux/minmax.h:30:54: error: expected expression before 'typeof'
   30 |  __builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))), \
      |                                                      ^~~~~~
./include/linux/build_bug.h:78:56: note: in definition of macro '__static_a=
ssert'
...


> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org> (cherry=20
> > picked from commit a49a64b5bf195381c09202c524f0f84b5f3e816f)
>
> This is not a valid git id in the tree at all.

I will fix the mismatch here and above, but please notice that this
hash appears in the link I shared.

---
Regards, Eliav

