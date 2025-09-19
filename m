Return-Path: <stable+bounces-180648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389A1B891A7
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 12:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892EFB644E1
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FFB308F18;
	Fri, 19 Sep 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sJTrYxDg"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1C93093DE;
	Fri, 19 Sep 2025 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278478; cv=none; b=V9miLAMoy9t8BhL5n6AtsSW+iM8sBea0pxNS6qDJ82olrnbTYDU4BHplTMkIAWhmR3/WuBmajGOZzOceJ04g476nHsJAf9irbRW87jwaKc2btcU9hOiQ+dGUyKRQ6TIkN73xOHKtSy8NhVIMMSqHhZEIvx7Yf2ivP0q+YoPMLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278478; c=relaxed/simple;
	bh=dp3f92ooJx/Qlj2pugKuI/xuwCibHRao7VwSC+oBMbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hnC95gYKXRnpkZN4aZNa9zi/+Dl3LYMewyXG8LiN6K3yP6nctJLkZ08vdHgE4s+gIXAZgnaddxNqwjJJp422ZQ2LuHxPN5q9RVGs7hlZb6yn7jTwA9RABSkPd+Rf//YNazCZtD7iRQodQ71VaUwYvCym1L+0f5F8a5CWCu/vpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sJTrYxDg; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758278473; x=1789814473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W0Ai5Zxfm7dB1PJ4NTWSgwXGTfzI+LMJh0bJX4Aj+GA=;
  b=sJTrYxDglnqDGRSiLCX46y2vQbQb2oUDPZUFOIHamLYQIlbqTDmuzSNy
   RWQnS4Xy/3/eo67sN5LUjYKlnOjILvcDapyVtOXcdWB0gNakKRl+ei9i9
   xp59ojnBuEIoIWvZVe4ZQPT8lkkVQsWrDzMXRcRgHpGuH8HkFX5SKKVHG
   o01FUm8Eyl8lUyh99/9HWzeULN4itO8ZkqM/FY+JrJ6TxGQAYyBN0PZSY
   IYv6bqS8VG5RYAeetpL9RORFOaeddLhjPckCxZimf2dP8sLvbucY/CVpD
   TPjgiBITStC7JtThMK0sMoSCGUepl1CqWLDr5247K3fNFcN7MajyZWxnD
   Q==;
X-CSE-ConnectionGUID: /jhZ36E6T/6z3u9MC8KPMw==
X-CSE-MsgGUID: 7CO/c3eDTFCrQt77yaHI5g==
X-IronPort-AV: E=Sophos;i="6.18,277,1751241600"; 
   d="scan'208";a="2268735"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:41:10 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:14263]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.39.25:2525] with esmtp (Farcaster)
 id 05227dc1-3d5c-4ee4-8b04-fa5b09820c29; Fri, 19 Sep 2025 10:41:10 +0000 (UTC)
X-Farcaster-Flow-ID: 05227dc1-3d5c-4ee4-8b04-fa5b09820c29
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 10:41:10 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 19 Sep 2025 10:41:10 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.2562.020; Fri, 19 Sep 2025 10:41:10 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: David Laight <david.laight.linux@gmail.com>
CC: "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sj@kernel.org"
	<sj@kernel.org>, "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chocron,
 Jonathan" <jonnyc@amazon.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 0/7 5.10.y] Cherry pick of minmax.h commits from 5.15.y
Thread-Topic: [PATCH 0/7 5.10.y] Cherry pick of minmax.h commits from 5.15.y
Thread-Index: AQHcKVHp4/4nJqw1BEmK54brcBSm0g==
Date: Fri, 19 Sep 2025 10:41:09 +0000
Message-ID: <98f086dbdc2d4a7c8586bdcb04571300@amazon.com>
References: <20250916212259.48517-1-farbere@amazon.com>
 <20250918220106.75a8191b@pumpkin>
In-Reply-To: <20250918220106.75a8191b@pumpkin>
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

> On Tue, 16 Sep 2025 21:22:52 +0000
> Eliav Farber <farbere@amazon.com> wrote:
>
> > This series backports seven commits from v5.15.y that update minmax.h=20
> > and related code:
> >
> >  - ed6e37e30826 ("tracing: Define the is_signed_type() macro once")
> >  - 998f03984e25 ("minmax: sanity check constant bounds when clamping")
> >  - d470787b25e6 ("minmax: clamp more efficiently by avoiding extra
> >    comparison")
> >  - 1c2ee5bc9f11 ("minmax: fix header inclusions")
> >  - d53b5d862acd ("minmax: allow min()/max()/clamp() if the arguments
> >    have the same signedness.")
> >  - 7ed91c5560df ("minmax: allow comparisons of 'int' against 'unsigned
> >    char/short'")
> >  - 22f7794ef5a3 ("minmax: relax check to allow comparison between
> >    unsigned arguments and signed constants")
>
> I think you need to pick up the later changes (from Linus) as well.
> Without them nested min() and max() can generate very long lines from the=
 pre-processor (tens of megabytes) that cause very slow and/or failing comp=
ilations on 32bit and other memory-limited systems.
>
> There are a few other changes needed at the same time.
> The current min() and max() can't be used in a few places because they ar=
en't 'constant enough' with constant arguments.

I aligned minmax.h to include all changes in v6.17-rc6.
https://lore.kernel.org/stable/20250919101727.16152-1-farbere@amazon.com/T/=
#t

---
Regards, Eliav


