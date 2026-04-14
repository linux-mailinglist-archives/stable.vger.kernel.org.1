Return-Path: <stable+bounces-237913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ8BMbRg3mn+CQAAu9opvQ
	(envelope-from <stable+bounces-237913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:43:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 299113FC114
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC65E30821C4
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9973EC2E7;
	Tue, 14 Apr 2026 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YT3VkFT7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC63E8C46
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181292; cv=none; b=RnjdIFJi2Ow1+3rbn+MywyCdJ/un/aRK2rub7LLQgLrGxaiMgPcI9B70QjQt4yKox84Fi/3gfXlciRezjfZ3MEdrIwkubIh4G0hM9CXp/5xwKV4E4WsLRgZ95o+nmdNUq1iIyFyDvdvEJqlumAZlSImBIVTxgWIS87JOePFVKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181292; c=relaxed/simple;
	bh=MR0HLXOfqwtxrES6xusGzWLrOVp3fQekqgEqt5AqHLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYMPLwOmEWys5UQNINPG7uo3syTbZpnQ64OcEMWp6IZ0pnM7t1QD82JBwq/GqSmenjQvVEsPnlLFJ9gF+dpR993ipDyNpc4gnjRha627HQnmaO6HNX3WfQb+stSDL2gcbeX4tXE2oGgsczky+NAePzgDVeUaV0ie9scRR1P7Mh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YT3VkFT7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d734223e4so1689791f8f.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776181288; x=1776786088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkLwsWawNgSidPsvnjshuNEBTeOMWcXEl4V0Yhhn+Wk=;
        b=YT3VkFT7anSmFQs9KPj3e0RhFl5QZErig4GKhZiO8w3PvL6RsT+Truqvd6AVaWff8I
         gT59gTHxzRFhq+rsHJROqKrY2S02rRAIWnhmUOg9agVnQ+7o6VmaTSZXmAzszeA5aaYR
         tyic9vDjBYY6p/HmwGA8WZkYF/CldE0BrvS05kfIV3LjdsniXkfqpH4xiEX+ccAeVhLC
         717nm9SxYui1Y0qH5mjmiAFVfkyNPKjUPgtthHh4ve3I9LpD1cKJwXMznwr0GSMtKjgM
         Zq7vh3a6rzPNI1GSjR24ZbzaBbRkwsNp7tPmisP+ZzHhGdyt85ff6sXbqfaB6Zk+YDTV
         f+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776181288; x=1776786088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkLwsWawNgSidPsvnjshuNEBTeOMWcXEl4V0Yhhn+Wk=;
        b=VUAb9SWfXgL2G1IUvIVCMnSG0F7/QxQm0I9PMYr9ycbEd8NyvDOtxssUq10OUNwzFE
         YiX4UsQe0WfZMI9XmqBmA1lPTP0UPe1zfIxmz3mH+6AV5hu24SOmcuiwTYO0/pssiYL7
         zkupmZ/+J9pgah9SLB9okSjEI671Y0S8IG3wYzMs0z5mYsDiQaxzTrq8BgIz1XqCHQU3
         yJ/LiCKlP83mmsopxGGfm8ojpz0AtTZj4ZCf8Nexmft54EGQLkXkYBNYupmuirDh+UmV
         GLFlhvoeZwd1d2m57TCyaZZg61OusnhgehGJyH0FYq7gBfMG83m6qX+WwXBJf98WkCqc
         ZeWg==
X-Forwarded-Encrypted: i=1; AFNElJ9/G3TEKMAzqtdKOElc4+bba+J98qxG50lkqoHadFD1fdmyjcAbK+ySAKYAUc9IfTcgZTJpMYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywky5vPNGK2FznvH5G+vC5NuWF+tIWYNcrXv9eqQT7dQBwvR28a
	nmV4eTg25D2d3zdlB6g/Bd3lRt4cLO0Ec10HxzUtYLdzVVgUsBqqLKWYGboWczZ/VRI=
X-Gm-Gg: AeBDies2yH0loVBv7MRPOPPlI+SFgh7kTB3aaDyZsAn3x7UwDLJlXvfDZH8pxO4rTIC
	zHlz3yFVeeF0+HFhaBXbLrQIclQ1DfjFtuv7LK/+upPdNN3IHEmTAYqGfpJjbGvADohG+49/wsd
	Hmijo+Mnk3Kq5cjbIzAQvdXNVfHx6gMeW9DIkFRq2DIs3i7kWD/rXP701tmGPfHzbHNS6e+N9Sk
	h6rvMSGjkej35DWF5BaNyBfZzcJ6IPqPun+1lvTHdoupJqTtM9d75CUFV+Bj3HUs1hiQyCZOwIM
	fXTBeG9R6EB90J3ZQGuPp8ORTxKrWcEcPerDqKgPzZ1sip376QoI7xnXZFclA03PHlCmAw0e8s1
	oU7np59bxicoA6NxctDI78FvbZiL7ZzPt0wpUZQ7kawU/lCGxuF3b6I3O2qmohcDHK0Rm2RppeJ
	HER+3Ju87m+7iXaa1SK4Dh++vGYQ==
X-Received: by 2002:a05:6000:40ce:b0:43d:6df0:c7f6 with SMTP id ffacd0b85a97d-43d6df0c862mr17241543f8f.18.1776181287839;
        Tue, 14 Apr 2026 08:41:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d76eeb2d1sm22799682f8f.22.2026.04.14.08.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:41:27 -0700 (PDT)
Date: Tue, 14 Apr 2026 17:41:24 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3] printf: Compile the kunit test with
 DISABLE_BRANCH_PROFILING DISABLE_BRANCH_PROFILING
Message-ID: <ad5gJAX9f6dSQluz@pathway.suse.cz>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
 <20260406111531.779571d7@gandalf.local.home>
 <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
 <20260406123232.3dacbe94@gandalf.local.home>
 <adTqIepV2W6M_Q2o@pathway.suse.cz>
 <CAJ-ks9nPvGaYPKj5Py0OPrU1E8JgDrLNM29d+iwc3c2U6KZ0kg@mail.gmail.com>
 <adYAsnyZMykg3y9f@pathway.suse.cz>
 <CAJ-ks9ni9bth243ciTynDXGWG20sSbz52jSYHPsiVdxixkncPQ@mail.gmail.com>
 <adZJ41Cdvfv3-dWJ@pathway.suse.cz>
 <CAJ-ks9mNv7pefcS9iVZfMpqpkXGHNiPP4fCD5s1ZtUxRHo0XJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9mNv7pefcS9iVZfMpqpkXGHNiPP4fCD5s1ZtUxRHo0XJA@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237913-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email,pathway.suse.cz:mid,intel.com:email]
X-Rspamd-Queue-Id: 299113FC114
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

GCC < 12.1 can miscompile printf_kunit's errptr() test when branch
profiling is enabled. BUILD_BUG_ON(IS_ERR(PTR)) is a constant false
expression, but CONFIG_TRACE_BRANCH_PROFILING and
CONFIG_PROFILE_ALL_BRANCHES make the IS_ERR() path side-effectful.
GCC's IPA splitter can then outline the cold assert arm into
errptr.part.* and leave that clone with an unconditional
__compiletime_assert_*() call, causing a false build failure.

This started showing up after test_hashed() became a macro and moved its
local buffer into errptr(), which changed GCC's inlining and splitting
decisions enough to expose the compiler bug.

Workaround the problem by disabling the branch profiling for
printf_kunit.o. It is a straightforward and acceptable solution.

The workaround can be removed once the minimum GCC includes commit
76fe49423047 ("Fix tree-optimization/101941: IPA splitting out
function with error attribute"), which first shipped in GCC 12.1.

Fixes: 9bfa52dac27a ("printf: convert test_hashed into macro")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604030636.NqjaJvYp-lkp@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
Changes against v2:

  + Added info about gcc version and commit where the miscompilation
    was fixed. (Tamir)

Changes against v1:

  + Disable the branch profiling for the whole printf_kunit.o
    instead of using "noinline".

lib/tests/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 05f74edbc62b..7e9c2fa52e35 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -40,6 +40,8 @@ obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
 obj-$(CONFIG_MIN_HEAP_KUNIT_TEST) += min_heap_kunit.o
 CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
 obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
+# GCC < 12.1 can miscompile errptr() test when branch profiling is enabled.
+CFLAGS_printf_kunit.o += -DDISABLE_BRANCH_PROFILING
 obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
 obj-$(CONFIG_RANDSTRUCT_KUNIT_TEST) += randstruct_kunit.o
 obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
-- 
2.53.0

