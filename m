Return-Path: <stable+bounces-179396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138DB556B0
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 20:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0397E1D62D8B
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D101933471B;
	Fri, 12 Sep 2025 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fAeHE267"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B163009F0;
	Fri, 12 Sep 2025 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.3.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703426; cv=none; b=cKlD9JQzCJvHfGWnR5xLMp1etxxLB+41jleK6EqoxAX8RP+nDif07DFNq0fKraqrnp5+FtBggTcFN3zra8BeeNV3fvhHBFgGqgkhfMYluLRKZmzs+kXFt04ryZeCz3hcsD9nqva77kGaqVp2/o9/mGwHEIMwHO4nnT043lfbSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703426; c=relaxed/simple;
	bh=N6IEPKkPlcIcHL4w87Dmwga9t6buCmp04U4z0XGo0rs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jBsdvRq45PfI1EXdLkqF5N4JGhtZvuQopkTjY3dufX2mJB5PRH1Y189RvhcYsA013J6jahr7MvFiWG2/8vUJwwYVJLuL+1bIA1ykE7SfBFrGQ42Mtf0cq2+Ydtx0s6WCqXCwh76HxT1Z/Acs6cjHkCi9f5q199755oAXgx9j2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fAeHE267; arc=none smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757703425; x=1789239425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N6IEPKkPlcIcHL4w87Dmwga9t6buCmp04U4z0XGo0rs=;
  b=fAeHE267vGfui+dcBaruWgWohcQ91UR3qGA4WkENWjfm9ocnpR9MDVP3
   Dk9OF9d0dzKPhX1BoJFc4vQykf+YuLnrmsb42U40TQNu5DyqZwws1/IBb
   9fiF5D5tqtWMtfQgw3YZmPmKjYD/g8Af5l4miFA6g3Rem2X93tIC+2Zj6
   JLycXHrcTtg1o8R6YGUJ1u6twAh3BHghkGgoFgNqIXQyLNeBn6a1gu2q3
   4U6YujHU6LEmVHKXZaNiaK/Lj2zoz45yO+8MKEeBdWp1uKijrRGYQippv
   H0RdJh3fnf8215ZANMTBuL4KO2YV+bULHsrbDZFdWEQFmNEP+g8r8tpgz
   w==;
X-CSE-ConnectionGUID: TYSMQi+hRyORnDTNtWzSVQ==
X-CSE-MsgGUID: 5EQNxFGHTreeDE4eahjckA==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="2039152"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 18:56:52 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:4208]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.27.75:2525] with esmtp (Farcaster)
 id 5bbe4fcc-b042-435b-ae23-0636ea2841e9; Fri, 12 Sep 2025 18:56:52 +0000 (UTC)
X-Farcaster-Flow-ID: 5bbe4fcc-b042-435b-ae23-0636ea2841e9
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 18:56:51 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 18:56:50 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.2562.020; Fri, 12 Sep 2025 18:56:50 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Sasha Levin <sashal@kernel.org>
CC: "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "natechancellor@gmail.com" <natechancellor@gmail.com>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"elver@google.com" <elver@google.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sj@kernel.org" <sj@kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
	"clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Chocron, Jonathan"
	<jonnyc@amazon.com>
Subject: RE: [PATCH v2 0/4 5.10.y] overflow: Allow mixed type arguments in
 overflow macros
Thread-Topic: [PATCH v2 0/4 5.10.y] overflow: Allow mixed type arguments in
 overflow macros
Thread-Index: AQHcJBb/hwKEbqodcEOOyWaCx0hteA==
Date: Fri, 12 Sep 2025 18:56:50 +0000
Message-ID: <278538a1b67d48e1912a23b91536c505@amazon.com>
References: <20250912153040.26691-1-farbere@amazon.com>
 <aMRPueS-kkgjHec4@laps>
In-Reply-To: <aMRPueS-kkgjHec4@laps>
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

> On Fri, Sep 12, 2025 at 03:30:34PM +0000, Eliav Farber wrote:
> >This series backports four commits to bring include/linux/overflow.h in=
=20
> >line with v5.15.193:
> > - 2541be80b1a2 ("overflow: Correct check_shl_overflow() comment")
> > - 564e84663d25 ("compiler.h: drop fallback overflow checkers")
> > - 1d1ac8244c22 ("overflow: Allow mixed type arguments")
> > - f96cfe3e05b0 ("tracing: Define the is_signed_type() macro once")
>
> None of these SHA1s match with what's actually in v5.15.193. What's going=
 on here?
Fixed in v3.

---
Thanks, Eliav

