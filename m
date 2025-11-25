Return-Path: <stable+bounces-196843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA666C83292
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 03:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4B03AE358
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 02:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F11EB195;
	Tue, 25 Nov 2025 02:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="oUfK99hO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996D1E2614
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039553; cv=none; b=CjBxMfuzxYFuob/fHvS4qQ9hq76cCmNZlK+cLah+s1koZDYMAjHoVlxlnYMOctdaBwpTXqBiz25P8zDgK+WjLN3rCJsND8gLrHrWR2z3jXio5W2EN0/wKbQsHw1aKV58NDKbCdYdbgaxNHotV3u1ki1RbzA5+EfQZaMmO0bxaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039553; c=relaxed/simple;
	bh=qOcJvk5j3GT8wZstGcm7Sla8cB6/2OsBskpQEOBj5RA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=GbWrIY2U01mqz6mWxUFKlHo5sm9eLVgQSAyZRuYnuhelSA67cYDbWV+AwpWSggv66/2oUw8bWugvypGnxGwGgFcm/nup5AmrcPVaFbC59dwWWIczj4+cIa5fO01FxBIx5qaCJgfRw28GG18CtsZKQb3pudxLHbDkv+inE0drsoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=oUfK99hO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b98a619f020so4039817a12.2
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 18:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764039551; x=1764644351; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzfgJ44UfEiA552cxAi6lVzfijHUmgPHG+YhsiVVCcg=;
        b=oUfK99hOnCKzNIutayGhcfRtwLRXmWwQ+3gh08XIJzNNlmAYrbd0593GHp+2kaVdXl
         u/zMqFgumHEo+RFXohh926hg9oHx3RRwFDA3Rf4KPzCUBxhKOw5SQaq+TCj0LxsGX14g
         cKHSlGnJTpm8or4Vm9ktzNe931gYE1ikmz1tkFEUkJSvlAaBbUsRZ8+Z2MWT2VpTT1nU
         +ybFw9GTlfR6HrRUFxhyhFl+PjIqcKMHdCR5dqzzBuD5AkyUcXG60DU3Vb2fACPGdf0P
         KOTbfhJAgE/EgXsS038CvIcWcs0lbywIWKCtGez6aK3+2H4ZIV0qNpHM99nOUq9/29sb
         tDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764039551; x=1764644351;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzfgJ44UfEiA552cxAi6lVzfijHUmgPHG+YhsiVVCcg=;
        b=fccrtqwJ7XDth3WPHaCaUeSMhHGm5iVxe33gWmB+aYojMd7vdLbkbDuak/JAa2MC+N
         nNEQ1rVRKcCBWEZyKZm2o1m7wRH9EoTVpASoCGTxun3bHVxaKT2g3eSMUSX2CXTuc8si
         m2+hv0uf99HAxc17Kei78hEmIDwyWXT+uuPwbt7MvgZcmgN0okcjkGqUZXbGfJdazZVo
         r3LasosVQ0BjRj/n5ydp+51Lv6Ma2oT36AgtriXalT4QPgx6jYfsXvh250ikNAE1JG3F
         dqLN0u/gwrOhcTFXzC67MHUuawTl1s1WK0kB4zUQg4yTiLAAlZJSX2Dzsa4N/srR/OnH
         SaVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtAANVUAPVtEq7OuDqRZFRG/zjzK9ZI8Jg1Ina5hjh8yv4AuCXj4Q0mR3W/jGk8Xrlodsu6Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKy+k37j+ec30wM+YIoLmSmiJSNt700xrtFNICHlGpFKNLlB+M
	0CXoqizhHPUPiwe7POtLUGgE2CRM5deggc9gOWevJhCrluiAKaYGc4/igVnt2JHDU9Q=
X-Gm-Gg: ASbGnctF+KrWKsL3LqtghEdQLh57nd5hMtWoH6sbW0/x5mCp0054LIaxONtaYwI8tDT
	gwZ3w5SnMkhh+M2gxYO7aTz2jupw02GArD0Z4FdxWy49/46Q76/yN7zLKerOQV6oJ7zZNoXwZm5
	mJaQ4a5H7NHHfwC94B82jj1Orncfb48LZ1DHw750vusWNcn2QbctQJTHZ9STsbPPAhdGBi2YaRQ
	thIC53Y7opf3+o9zwiAXp0PyekHR1GaS33PLXcHU/xRh0KuOcVl005gvvYt2detwwDs+Psvn3FX
	ZwViKyGO61DgQh8uj4CaDKOmBmLaolKeRC/6fsmt2eoEjvNNxEf81TGz74m2zMqoE+lDl1BPi6h
	BUZbFoOURphdL3Lnq3qrFm/Q0I8ZTUswXiXws01IWV6PfZz3t8h3Q1//dBXqlu22AxPhNGrPAhi
	K/sAgT
X-Google-Smtp-Source: AGHT+IG7Lnee8MVFwTQxW1Ph9vGHhZO4NJZYNw4lv50obGwEFrDf5pL9czM1krGQkHScR9h+bF9V0g==
X-Received: by 2002:a05:7301:7308:b0:2a4:3594:72da with SMTP id 5a478bee46e88-2a7190d39b0mr7301280eec.9.1764039551439;
        Mon, 24 Nov 2025 18:59:11 -0800 (PST)
Received: from f771fd7c9232 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc53169csm56078116eec.4.2025.11.24.18.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:59:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.11.y: (build)
 ./include/net/ip.h:472:14: error:
 default initialization of an obj...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 25 Nov 2025 02:59:10 -0000
Message-ID: <176403955026.358.9545679447853000563@f771fd7c9232>





Hello,

New build issue found on stable-rc/linux-6.11.y:

---
 ./include/net/ip.h:472:14: error: default initialization of an object of type 'typeof (rt->dst.expires)' (aka 'const unsigned long') leaves the object uninitialized [-Werror,-Wdefault-const-init-var-unsafe] in security/selinux/avc.o (security/selinux/avc.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:16f2d4d7ea51d0d2cee2101fea4a5d762aaeca6d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f6d41443f54856ceece0d5b584f47f681513bde4
- tags: v6.11.11


Log excerpt:
=====================================================
In file included from security/selinux/avc.c:30:
In file included from ./security/selinux/include/avc.h:18:
In file included from ./include/linux/lsm_audit.h:25:
In file included from ./include/rdma/ib_verbs.h:26:
./include/net/ip.h:472:14: error: default initialization of an object of type 'typeof (rt->dst.expires)' (aka 'const unsigned long') leaves the object uninitialized [-Werror,-Wdefault-const-init-var-unsafe]
  472 |                 if (mtu && time_before(jiffies, rt->dst.expires))
      |                            ^
./include/linux/jiffies.h:138:26: note: expanded from macro 'time_before'
  138 | #define time_before(a,b)        time_after(b,a)
      |                                 ^
./include/linux/jiffies.h:128:3: note: expanded from macro 'time_after'
  128 |         (typecheck(unsigned long, a) && \
      |          ^
./include/linux/typecheck.h:11:12: note: expanded from macro 'typecheck'
   11 |         typeof(x) __dummy2; \
      |                   ^
1 error generated.
  CC      security/keys/request_key_auth.o

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-69250a4bf5b8743b1f5fbe05/.config
- dashboard: https://d.kernelci.org/build/maestro:69250a4bf5b8743b1f5fbe05

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-x86-69250a16f5b8743b1f5fbddc/.config
- dashboard: https://d.kernelci.org/build/maestro:69250a16f5b8743b1f5fbddc


#kernelci issue maestro:16f2d4d7ea51d0d2cee2101fea4a5d762aaeca6d

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

