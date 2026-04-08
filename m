Return-Path: <stable+bounces-233883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO82JPxM1ml8DQgAu9opvQ
	(envelope-from <stable+bounces-233883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:41:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BD63BC4DC
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EFAC30C621D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D73338E137;
	Wed,  8 Apr 2026 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fDJZlrxB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA73C2792
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651305; cv=none; b=naaaFl5XaSabXXNsq43cA0HEMWAETRRz+D7BpgjPIkhw0F0nxg2ypMaU1jwP+Oj2ZmGqmyzpiOdViVrbVL/EzeXuYaj2RhLiV+NosoityoFjKGVKTEwMD1AVbNsb6+dPnuEWn25GgtcSVNQTYyQKwrEo1+UFecLoa6Za5GIcy3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651305; c=relaxed/simple;
	bh=6Kdnwxr96EsTxfaWezkGx9SRHGwg1QyMdUpR0cWOVZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea+ux6EPYfCCVrrQUvpxySyIP7iOChqklP2vp+jMcTLqnhfDV/q/IqDmKEK64k2vor3IKIiWSPZLHt5xk3rqNpeE2QLPelQMpCGewOgQ9jHVfjta9gz19nTnlmwbBZ2Vqx+ZADrfK/zCQ/MOvBesd+Ok70kaqxCFRTX+X3VvjO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fDJZlrxB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488c21c636dso9437545e9.2
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775651302; x=1776256102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTIuaNAsV64v9k7CIPCdYWOTBbCxwaMb4Lz1Bijxn3c=;
        b=fDJZlrxBsgRpiteycXqOi6MlJSKV15syGtHnA88gg+lpFDXaBQU1Z3tCTPZr6orub9
         6y8VpPgDqgpz6eZT3eLsn00rHKwT9xaAdZH4Odk9PgDhwlo1F4jXjg72ilKE6wuWYlLe
         ANd945a+Ty+J2DKzU3VKY8gwbvFrHvdaUZfPx+LA7qgS7XiwvkzoehkwuvCw11KVcfFf
         gukYafLN5ZFnQ/Rr4C5HZAiSNQSQqAGHX5ihoYrMBkkV1dWL1JjL5rfbqUwFfeSizmY1
         mmrZvBuWI16z/PT/eH5+Tk1NOmNpe4TF216eBynuIfvnxZgrkOFqCPQ4UKjSH7p8RLCu
         JJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775651302; x=1776256102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTIuaNAsV64v9k7CIPCdYWOTBbCxwaMb4Lz1Bijxn3c=;
        b=cqFAhUm2Io4NTMcWscE3e8muJ0XWl3ofHQhrLo2F4DWFZIwmU2oxTtJx0q1lzfDbUW
         3eXNQAS1J2rUkAaMVH9rBIy5u88uhq/m6R+69l732RowzR9G6OWw0ZVzP55pKYbUMUu+
         8Kr2LRj15xfgme/G8bUz/l3y9Ewi0IYZ42TxGht7LQZuO1DqwMBZC/RSJjRAECMcDaf6
         8SAe7bPZ/DTUTFltbkpASsp78WmUQ0LbsuFfjiN/4QVdONuztdPH18sLDugUsG+9pP9H
         Y3Z52VRssslFZBs7FA7SabvSuV+icoENRtbqvy0auO5idW/1lfxj+vZgd00vGAbA6Neb
         VCbw==
X-Forwarded-Encrypted: i=1; AJvYcCUlLC5ZwaIvSEBg9h8E+Hic2KCoc5NeXYuysdiiI3Vlw/9Z8oWduvwXMIrGwYF4z53al2JQBYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywT9WppAhZv7YEeZH7ng8EjGDHe5bSbJIW58PRSGVHcmM/1jZ0
	cwo2B2pLOp08L6EPlae4eIfsUXVAEg0ueCsEI9+KJV062p1F+Goo6/hbvwF5b5syhD0=
X-Gm-Gg: AeBDiesbdqtIAY1Yz9jjZXgavt0j1BKsu262h2BLt39IrMCqIJ9yOcN9G1qLFqu7ERg
	qiish900GXJQvGtEpCwL96sSAWNw9b8hu9S9DxU3j9mU7mNR/zlKhK6PTf3Q5zpetz28eZaN9nv
	++D2UXSCV4moq+ahMHM5ft30/Cz7AOB/Wbp1zQzrXK1bCrYPVyMQoR4STsHXIO7l0XDVvww5+O+
	hgW6QxqpZvSrnchbQ4pDjJVT+ucIwXBQwyUP4kYiHYk7xvAtdgFx1M1uQSeiqv64xw4UlPpvM60
	kFtsfQVCeEGC88hfprxrSfZRgGXORL3vDkK+OUQaUPU/1N8U6EzkHjX3Q+ZdbOdshu5ETPj7tqE
	ceIHcZ5p7XhreemE/IDXd6fswd/pDOcIrSrjohbLKyyNBBRBXwtZyII5YiW9DUmwb3xzJTitaLp
	0TEBSRI7mU51fh3RX/brixu9zkSYkbpBsjtfrg
X-Received: by 2002:a05:600c:6305:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-4889978c561mr284463935e9.14.1775651302143;
        Wed, 08 Apr 2026 05:28:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c535dbb1sm30926145e9.2.2026.04.08.05.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 05:28:21 -0700 (PDT)
Date: Wed, 8 Apr 2026 14:28:19 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] printf: Compile the kunit test with
 DISABLE_BRANCH_PROFILING
Message-ID: <adZJ41Cdvfv3-dWJ@pathway.suse.cz>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
 <20260406111531.779571d7@gandalf.local.home>
 <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
 <20260406123232.3dacbe94@gandalf.local.home>
 <adTqIepV2W6M_Q2o@pathway.suse.cz>
 <CAJ-ks9nPvGaYPKj5Py0OPrU1E8JgDrLNM29d+iwc3c2U6KZ0kg@mail.gmail.com>
 <adYAsnyZMykg3y9f@pathway.suse.cz>
 <CAJ-ks9ni9bth243ciTynDXGWG20sSbz52jSYHPsiVdxixkncPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9ni9bth243ciTynDXGWG20sSbz52jSYHPsiVdxixkncPQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233883-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:dkim,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0BD63BC4DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Old GCC can miscompile printf_kunit's errptr() test when branch
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

Fixes: 9bfa52dac27a ("printf: convert test_hashed into macro")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604030636.NqjaJvYp-lkp@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
Changes against v1:

  + Disable the branch profiling for the whole printf_kunit.o
    instead of using "noinline".

 lib/tests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 05f74edbc62b..fbb2aad26994 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
 obj-$(CONFIG_MIN_HEAP_KUNIT_TEST) += min_heap_kunit.o
 CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
 obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
+CFLAGS_printf_kunit.o += -DDISABLE_BRANCH_PROFILING
 obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
 obj-$(CONFIG_RANDSTRUCT_KUNIT_TEST) += randstruct_kunit.o
 obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
-- 
2.53.0


