Return-Path: <stable+bounces-154708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1BDADF753
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 21:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB15117DB2F
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 19:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225DD21ABD7;
	Wed, 18 Jun 2025 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOrVfkBx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920521ABA8;
	Wed, 18 Jun 2025 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276691; cv=none; b=mmcvihhqKoovzsLsFS9jp7kFzl+NJgFGRPV6UHYXIyOwlL/L8ffOt5lnR6nLhPmyvv3+bN3H7qTwtRm4j8kUFXxUroZ3siAzIPUJEgjt9gDnLVDHwfwZ7Uv8bhrOVoSeCWQNRTNvxaEPLxjeqRF7o6odar6rYxlsPYgrUAOpAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276691; c=relaxed/simple;
	bh=qrg5XH9dST1yxfViU8zNWZ+SBYjkeKKMq6F1GkTxSQ0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Jb6Jy+ETE9Y0Z8szP6BD2OtFMfow2815PS8mPSBbP1nbqojVoqnh0kw546qaU+R0Ep27y9zCzsZ2cELi93/wgi9NCIHWwc4c/uzCOoYGY7eT3wugMncY9uuA8lgPu29b+aoud4zMHVS/OS0u6m++RAavLumWaNZSFOpRjuJ5BHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOrVfkBx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750276690; x=1781812690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=qrg5XH9dST1yxfViU8zNWZ+SBYjkeKKMq6F1GkTxSQ0=;
  b=AOrVfkBxYdCsrmEf8JIWkiAxQ3Mw6Db4usLxTUL5fnl+HjUGvYaV5mjY
   aB3wiMJrfGMhw+3IYHkk6yEuSyZiZYaH0Q56OHC4ekXuoXGUghVkaLEt+
   VhjHZrIg0LWq2LTrzST5e0VXk/j1uIEsBf30yGXOm/AriH9mkg0QsZO5g
   xc3Nzqg7Vgm+wyogujRybkU/q1pIubpS85Vx7L9osmTwnW8YTYaULSEnK
   EN448LpIDE98gC+xBtD6R+jgZJ3TxAAyAJLO+q7uOsT7IZMrLuKvtkQFD
   i1ST/ZAX4X95k/lCEn+UN0mAPhuj6LjfRuRbaGQQrod9N5c6BEXDaEpoZ
   A==;
X-CSE-ConnectionGUID: 8/m/KNj1TmeWY030vU4Z6Q==
X-CSE-MsgGUID: OTQw73PUTxG+JayZ7NzpZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63553656"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="63553656"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 12:58:10 -0700
X-CSE-ConnectionGUID: oe8kFEefSNiUM+2jgaRHIw==
X-CSE-MsgGUID: twjwK1/KRxO/oZKwyzidCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="155884452"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.97]) ([10.125.108.97])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 12:58:10 -0700
Content-Type: multipart/mixed; boundary="------------FBV2T2tBlDMttuhV7SjpyS1W"
Message-ID: <71c1c545-da20-42ba-9249-0946d9c9edec@intel.com>
Date: Wed, 18 Jun 2025 12:58:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fpu: Delay instruction pointer fixup until after
 after warning
To: Alison Schofield <alison.schofield@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
 bp@alien8.de, mingo@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>,
 Eric Biggers <ebiggers@google.com>, Rik van Riel <riel@redhat.com>,
 stable@vger.kernel.org
References: <20250618193313.17F0EF2E@davehans-spike.ostc.intel.com>
 <aFMYsfwyALoi_X_x@aschofie-mobl2.lan>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <aFMYsfwyALoi_X_x@aschofie-mobl2.lan>

This is a multi-part message in MIME format.
--------------FBV2T2tBlDMttuhV7SjpyS1W
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/25 12:51, Alison Schofield wrote:
>> Do not fix up RIP until after printing the warning.
> How was this found and how is the change verified?

Good questions.

I found it from an Intel-internal bug report. It's not clear what's
causing the underlying XRSTOR #GP. But I spent some time scratching my
head about how RIP got pointing to the wrong place. I was blaming the
simulator at first.

I validated the fix using the attached patch. It waits until there's a
program named "dave" running, then corrupts the XSAVE buffer in a way
that will cause XRSTOR to #GP, triggering the warning that was off by an
instruction.

--------------FBV2T2tBlDMttuhV7SjpyS1W
Content-Type: text/x-patch; charset=UTF-8; name="os_rstor_fun.patch"
Content-Disposition: attachment; filename="os_rstor_fun.patch"
Content-Transfer-Encoding: base64

CgotLS0KCiBiL2FyY2gveDg2L2tlcm5lbC9mcHUvY29yZS5jIHwgICAgMyArKysKIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLXB1TiBhcmNoL3g4Ni9rZXJuZWwv
ZnB1L2NvcmUuY35vc19yc3Rvcl9mdW4gYXJjaC94ODYva2VybmVsL2ZwdS9jb3JlLmMKLS0t
IGEvYXJjaC94ODYva2VybmVsL2ZwdS9jb3JlLmN+b3NfcnN0b3JfZnVuCTIwMjUtMDYtMTgg
MTE6MjI6NTguNTgzNTEwODQyIC0wNzAwCisrKyBiL2FyY2gveDg2L2tlcm5lbC9mcHUvY29y
ZS5jCTIwMjUtMDYtMTggMTE6MjM6NDYuNjI2NzMwMDMyIC0wNzAwCkBAIC0yMDIsNiArMjAy
LDkgQEAgdm9pZCByZXN0b3JlX2ZwcmVnc19mcm9tX2Zwc3RhdGUoc3RydWN0CiAJCSAqLwog
CQltYXNrID0gZnB1X2tlcm5lbF9jZmcubWF4X2ZlYXR1cmVzICYgbWFzazsKIAorCQlpZiAo
IXN0cm5jbXAoY3VycmVudC0+Y29tbSwgImRhdmUiLCA0KSkKKwkJCWZwc3RhdGUtPnJlZ3Mu
eHNhdmUuaGVhZGVyLnhjb21wX2J2ID0gMDsKKwogCQlvc194cnN0b3IoZnBzdGF0ZSwgbWFz
ayk7CiAJfSBlbHNlIHsKIAkJaWYgKHVzZV9meHNyKCkpCl8K

--------------FBV2T2tBlDMttuhV7SjpyS1W--

