Return-Path: <stable+bounces-235290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ft/J+D51mnsKQgAu9opvQ
	(envelope-from <stable+bounces-235290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 02:59:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 978933C5208
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 02:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BA023009815
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 00:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38484259CA9;
	Thu,  9 Apr 2026 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20251104.gappssmtp.com header.i=@kernelci-org.20251104.gappssmtp.com header.b="vR4bW0KO"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55932BB13
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775696347; cv=none; b=YlZ7rc7kUaBzIvvmCmCWa0xWRCvMC+jmJSdtX/VTS58IoWI1pwK2zn9mYMrUEJdyyDu4wTRcgKfScKf7BoIngdxNCTN3oj2kpI+mbHEfZ8IMgDozHoSN44u4Tmvpu7sNnRfuM2oc3qODr+VzaGV+55iPr5T9ZO36BjsRoyR4Wng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775696347; c=relaxed/simple;
	bh=QHHIe2fy0HIZgG8L1am0yf0ql+D4nU35BH7hbu3sAvw=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=MBs0m16zULRzBVRzxUNGhbtRgJhUuLC+JlzyRnC3Bd4j/BkzlE1gDyMYy4vSEHQsEvAQH0jV3tTK3zbUUfJQ9EkpB/Hx0z8T/cFfUct+GLisJWY9grdymQ0qFBlnvVLmaGtljU7KWM52cGZb5UNcvY4JnM062SF2q/eSfXBlAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20251104.gappssmtp.com header.i=@kernelci-org.20251104.gappssmtp.com header.b=vR4bW0KO; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so310590eec.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 17:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20251104.gappssmtp.com; s=20251104; t=1775696345; x=1776301145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hEacgVfOqE1v0EbZbw7o5FRCJTBMJ4J4fiaeRcUuTg=;
        b=vR4bW0KOmw/yqLUhqt5Hb/eT8qHYl29hUkIEZfRwUeq0qRzfYoQM+Y+b23gHyVR5fF
         g/9BuZGFAfWmOn7OMJLTC91ZLfpRTaUCblgSSUzGSQclDLooVMJEK8fzqP1YC/tk4BvT
         0GktPt1bCQgLKiImyJqPqPbOmfolQqBhS6KsFtLgUhlK4YH+C8FwxBRyJ6W6j1GC7IRI
         0VFBVsPwZFsTkJfteb7CiB2JthEMVF8GXIUyHsnE2GgD1lrtH5cBWIPDaje5vqUVvu9y
         GtNDDwOsti/cPFlGXsS2by+vU1wj3V9CQRwFAdA1fqUcRcnW0TI30QOPKPpcJhOJ5mP4
         kG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775696345; x=1776301145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hEacgVfOqE1v0EbZbw7o5FRCJTBMJ4J4fiaeRcUuTg=;
        b=O0iLxUt0GUFKjMVdE6sPLJltQXXEbYg5dt5TsYiPXhSgH7hNSAUoANmf3ZBAn+8dBD
         COwgQYvIqp1qNmrrH+awsQz3rlj6MFAV/YIV3I6sDmsSaiZjR89gOSX7pKdI7dta3afl
         EHZBp7UQeb8pbQV8gqwqi1bq0DEfld8E9PhEt6GDoUFhKanyjvpGXGBzx758l4/B9N2N
         ThlAI5ZcMJLNYTiB2JL1M52wJTNbUaT/XZCrTJqliYmVsrHiCxek3z1fJP3u0+U05gi0
         CDPrArWJgeNWTSxV0wGVsPc3Inyti4TjABcVRphPd44Tvj/KOMekpBxLQYiPkXWEkvwI
         atrA==
X-Forwarded-Encrypted: i=1; AJvYcCXkePhoTRnKHytQbHkQB0T/ZvDwy+8fVcFFElaReXGNyg9tqRM8497ReSlU+frRNYwDmwum2vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO6LDSXDvHk7d3m9PjB1XBykGJAnP8sYnEoDbMAlF8nqkzjlRK
	CYpSH2ORTdoP8tZ7QFQFuXh7qybLhAyj3Zn8XHpX3NM31Dbmm+kS0ie7612c1geRS8g=
X-Gm-Gg: AeBDievrWOA5Gmo3nli0yt7W4tICPijmGIfm692gNgHa6fZx3Y7H4/WKEZe9VZE1WTr
	TPffNhnjEP6+Me8Df4rl2ZiVoGeHoljf2sNXlXGTYBv11xq8Zqt33g3sWSuRKyZ80hpTra2Uadc
	6cK4zvUn35WjMYKFFOgbZBCm3kb9ez1fg+KUjTS0iRVbj1VRq2GWsDtGOdpkNJUlgN5Bgz5Alai
	f1nMr4vBZElE8EJIM49oj0mP7Bjp6gudksgEwO0jxLD30Vo6i4LjVGlPAcoZhtGD85r6z2660bg
	3e2ynZPgvuih6Xzhz8tolYgDDgfLgnTAATCFzAhw7+IMf5ppgHpFVzc3i7VR1qjPRU8r81a4onx
	hlhllsxZdw+aB1sI4ZYsDKwyUNp9Aqj6KOB3KJXMidZMd8QL9IiXD4PWF8IeYjzr4ucyOoR9iFE
	W49eFWOdXv/eKWrqsCOUyyAhPE2Eo=
X-Received: by 2002:a05:7300:dc8b:b0:2c8:7172:3b86 with SMTP id 5a478bee46e88-2cbfba8eb13mr13485817eec.22.1775696344638;
        Wed, 08 Apr 2026 17:59:04 -0700 (PDT)
Received: from 8692ffc4d55e ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca793ea2f2sm22658343eec.9.2026.04.08.17.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 17:59:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.19.y: (build) incompatible integer to
 pointer
 conversion assigning to 'struct so...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 09 Apr 2026 00:59:03 -0000
Message-ID: <177569634303.3066.14119534942670985880@8692ffc4d55e>
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-69d6a8ae86a2e63970e2db6c/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235290-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernelci-org.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernelci-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 978933C5208
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-6.19.y:

---
 incompatible integer to pointer conversion assigning to 'struct software_node_ref_args *' from 'int' [-Wint-conversion] in arch/x86/platform/geode/geode-common.o (arch/x86/platform/geode/geode-common.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:38d14aeecdf6c49934ce1a0e4b88e6cba3740995
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  571831a3f83a43f64984cacb7064dc31c25694bb


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
arch/x86/platform/geode/geode-common.c:132:12: error: incompatible integer to pointer conversion assigning to 'struct software_node_ref_args *' from 'int' [-Wint-conversion]
  132 |         gpio_refs = kzalloc_objs(*gpio_refs, n_leds);
      |                   ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-69d6a8ae86a2e63970e2db6c/.config
- dashboard: https://d.kernelci.org/build/maestro:69d6a8ae86a2e63970e2db6c


#kernelci issue maestro:38d14aeecdf6c49934ce1a0e4b88e6cba3740995

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

