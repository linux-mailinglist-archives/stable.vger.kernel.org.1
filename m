Return-Path: <stable+bounces-211439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBA9N8YudGmu2wAAu9opvQ
	(envelope-from <stable+bounces-211439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 03:30:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D2E7C3AD
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 03:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDC8E3006447
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 02:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E401531C8;
	Sat, 24 Jan 2026 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="V8MZWwE2"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1094175A5
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769221826; cv=none; b=JXsnuQ63cyw9hYIRXugSuSLN1fRFOzVUPGF6EGF5i/zjDUbbvE776SdBVTtfb+V+aJfOPVP8gAgrD2lOWo8nA9FZ9sX8x1k3kReIulJHZCPOZq8/hg642wvzF6/QH+3Rni4uXxop153toGrBM6Cdpxz9a9xkxpNPr4BZyQbNUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769221826; c=relaxed/simple;
	bh=xVqA4HmuFDomGYZdtXKVUygNcRU3V2GZLa6dXlAfL88=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=T7C3X6IOjR7UHvinysXTVvCG3e1DyNm7T0yyPDsN0u0ehVoaShY025zIqDnsHwXqCOcVH01lgNYBjJ7x/rVW/hwzrhOXhfCEBm0chz2W9VniEnadvBoWtpaZGvrzS28nJ1RQUKBbeWUlUjtF6TrMColSSigqZ3OydI19k45mqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=V8MZWwE2; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b71557299dso4047713eec.1
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 18:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1769221824; x=1769826624; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cG73BxDMEDjpS0IiNYSD6BAwJJ1QuBKWpvOBYp+Us0=;
        b=V8MZWwE2BjA0rVnKLwAp7gxeSufqqyqLk4BARHIO7yrLVFwrUXn5vdMuApX1BjoHK3
         R2ySdY1OG0tWJ2UAO0AFWepmzWfc/PXzJKc7viWKlZ9/5ZC7H54zG3NktwBxYgxW0Vty
         I4RRUqTAGcCgQH/3SLvwGP3qe7KzYMB357E5shqtTlDFuvuPnvv/PvE/Yhp3vuDL3v/j
         G7ZeGd0vJLDf+DpfWlLDu17MnXkR1fjGdO50Ayd3B4GtUN2ktmKP9wxy429hcXG8CTKw
         9fAak4AfR+G1mgabADo4XaHxwTzwoHggDNgFY2oUlOgLWD/W8FYnX5UA+yPZx+6dOX9F
         jjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769221824; x=1769826624;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cG73BxDMEDjpS0IiNYSD6BAwJJ1QuBKWpvOBYp+Us0=;
        b=EP5mCWag0WEbQTo8O1WPHlLYipbgeNVZSluHs7omhm18uH07Rn4/7CRRQB1U998ikS
         Yjme2MBFvrgTIYP06UUvUaphRfqUuz35n1X0zqAtFNxuhpzLlvzvUe5LZ97ECsWJYqs9
         hFpmIisQPFpmrL3+PIQfiiwxSggsXjcTYWcnQ6r188yB2GrMJMM+LmxuzdCjR+fCdeoX
         YUJDSE+EXX2OiwDamvbo6Xi2vmv6mbWX/bESyIfdOzuVKyaDSPN/4s5GdlG2YIxMvNim
         pGSMNGrRQFIoDVodYnUHKHA1odLabyO5l+mH0LAVOEiInP38bxIm0/tVCYeQvPbVqiD8
         aUvQ==
X-Gm-Message-State: AOJu0Yz6SYIyQkxSTHyKf7SQ0ThBrYnqDkJM+4YBGSdlk4/Dc8s2SWUD
	71qUxcUkAq7xfFiUY+Ci2IdRfFngi0uGSwCeEldErW5Cgu2ldA+SQTevjcZibtZsZYsW6NTPyQP
	vdQlmTQo=
X-Gm-Gg: AZuq6aIjsuQMLbbYbSjRmDV/nTwxTJXD85PdA6jAtU2R1rR8m0QVMvp74kaM3OVIPkR
	Ju4IDOp1UfaXs4rC73phuKunjj9ky/R83I8yEydTgyVsGIfHnDgVCozVn3sitJGyLHxSs4CJd3Y
	FEmM1iudAfE5GA4yJbUsIKAL/qcz+K2JqwUaGjiHMO1AdQMsgB1zi4WKlBf/YaV22P5K0LbJV2j
	beBCsd0efo4ZIfYxiMG4BE1kLbDyu4K6F0qRXKUyYkzlaBm8QA5RbyLpM+OHBNh3tcQtsfzlZvJ
	U7hUJxUVu7dWLPMpuxCPTfJJW8mlD6ug/RKg4rfR9eAiQ1nQFLtO4rYfaJkumFQNQWJaGZOKUsB
	AsWsVCCbygvV064Ntomv7jZ9m4EBSEhoM1V1lJorougWuPQAZfbMdZn57DYpcev81PEwOfvjd+Y
	5kaFFu
X-Received: by 2002:a05:7300:a883:b0:2b6:ffb9:9632 with SMTP id 5a478bee46e88-2b739bcd878mr1986667eec.28.1769221823797;
        Fri, 23 Jan 2026 18:30:23 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6f5d10sm5806840eec.15.2026.01.23.18.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 18:30:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 abf529abd660d8ccad46dd8c8f20e93db6134f5f
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 24 Jan 2026 02:30:23 -0000
Message-ID: <176922182285.1613.219708078159296099@22d5995788c3>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-211439-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email]
X-Rspamd-Queue-Id: 68D2E7C3AD
X-Rspamd-Action: no action





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/abf529abd660d8ccad46dd8c8f20e93db6134f5f/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: abf529abd660d8ccad46dd8c8f20e93db6134f5f
origin: maestro
test start time: 2026-01-23 10:44:02.552000+00:00

Builds:	   40 ✅    0 ❌    0 ⚠️
Boots: 	  188 ✅    0 ❌    0 ⚠️
Tests: 	 7367 ✅  328 ❌  925 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: acer-chromebox-cxi4-puff
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kernelci_sleep
      last run: https://d.kernelci.org/test/maestro:69735aea1908a6300d929263
      history:  > ✅  > ❌  
            
Hardware: dell-latitude-5400-4305U-sarien
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.cpufreq.suspend
      last run: https://d.kernelci.org/test/maestro:697359631908a6300d9288cf
      history:  > ✅  > ❌  
            
      - kselftest.cpufreq.suspend.cpufreq_main_sh
      last run: https://d.kernelci.org/test/maestro:697363391908a6300d92b6dd
      history:  > ✅  > ❌  
            
Hardware: dell-latitude-5400-8665U-sarien
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.cpufreq.suspend
      last run: https://d.kernelci.org/test/maestro:697359641908a6300d9288d2
      history:  > ✅  > ❌  
            
      - kselftest.cpufreq.suspend.cpufreq_main_sh
      last run: https://d.kernelci.org/test/maestro:69735c1a1908a6300d929aa1
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: acer-chromebox-cxi4-puff
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.cpufreq.suspend
      last run: https://d.kernelci.org/test/maestro:697359571908a6300d9288b0
      history:  > ❌  > ✅  
            
      - kselftest.cpufreq.suspend.cpufreq_main_sh
      last run: https://d.kernelci.org/test/maestro:69735c791908a6300d929c94
      history:  > ❌  > ✅  
            
Hardware: hp-x360-12b-ca0010nr-n4020-octopus
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kernelci_wifi_basic
      last run: https://d.kernelci.org/test/maestro:69735a0a1908a6300d928ae6
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

