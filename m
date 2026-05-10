Return-Path: <stable+bounces-245073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XOQOMlvxAGrxOgEAu9opvQ
	(envelope-from <stable+bounces-245073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:58:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AE35065D7
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 965B7300902B
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330FF33689C;
	Sun, 10 May 2026 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZzEosxeQ"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460813043CE;
	Sun, 10 May 2026 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446676; cv=none; b=kxPLkdGVvvZBAoUzSekw4hVuDD57U0sDcyLC5AYpREUQu7E2LHj1lOHNAmMEXA3cbAl/Thg4mwmN4nWmuwoHxt9ivJJTzDCJEDl90wlK0Bh8uKid+w71KTtT7EUm8UN/Ge1JJuyt06cC78jMqjoyDCfA62g2VanO6n45OqjFvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446676; c=relaxed/simple;
	bh=U3XG11g75IcTjdRGvwT9tM9l7i7M8yifd56uOB36Wsk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uKBPkhlFLyGFoi4F8LH+NTUgPsMuh1TMjxo8mOuGRQ46izWQ2Ie7aPRqMAXgxsKL2OgBpQ107WbADin7blRvmoXEIAqsmy0sCfWBONskdcM8Ggd4VGQXuMYIby02XsDxfjB4S1nMI4cZNpGnjqJhftCQCkvDOATTbxlN03Fmob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZzEosxeQ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gDFYT6Sztz9t8W;
	Sun, 10 May 2026 22:57:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778446670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JhbkDIgXOs/Y9f4bIfEtVjnIvM/A/84iZ7rQjx1TFrs=;
	b=ZzEosxeQ3kh0XSwlKI+79DS079iUxOiXPGpsqiiu79VPMcXIjnn26+3ubtGlQCgjHJsxkk
	EagOTRR+b9+YR6JzYKeh3yrsgHRPvCKwOyzmgvekp+og5URxGpm0gEKy+qE5VmF97gYUnF
	r8QkOgPbhElyJAF+XF0+cbNdv5g7ykd1ps+ahQsaV2zt2OPVd7pAhjEyQq22UAmynCTG1s
	1p1LMZVj++ljAKqkP63C8yDP5YJUiiO575O7AFrB3cVuW/OdPTIR5PGwiIioVPj2Y36KmJ
	xW06mZmYzxRZG5WcxFocCOSECYNPKksU4u0RDRmN7ZUtZEuXWeRi6ZYpv5jN6Q==
Message-ID: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
Date: Sun, 10 May 2026 22:57:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Sasha Levin <sashal@kernel.org>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
 linux-rt-users@vger.kernel.org
From: Lukas Beckmann <lbckmnn@mailbox.org>
Subject: [REGRESSION] 6.12.y: d66792919d4f (sched/deadline: Use revised wakeup
 rule for dl_server) causes latencies up to 50ms with PREEMPT_RT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 819ydxywk7c5su85wrfixtgzefupgtru
X-MBO-RS-ID: 69f2eb288b23dbea7ee
X-Rspamd-Queue-Id: 35AE35065D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245073-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lbckmnn@mailbox.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Action: no action

Hi,

I am reporting a regression which was introduced by d66792919d4f on 6.12.y.
Since this commit, cyclictest reports latencies up to 50 milliseconds, 
on kernels with CONFIG_PREEMPT_RT=y.

Steps to reproduce:
1. run a load (e.g. stress-ng --cpu 4 --io 2 --vm 2 --vm-bytes 128M)
2. run cyclictest (e.g. cyclictest -a -t -m -p 80 -i 250 -d 0)

cyclictest results on the current linux-6.12.y branch (tag v6.12.87):
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 9.37 9.21 6.90 9/211 978
T: 0 ( 884) P:80 I:250 C:4688252 Min: 3 Act: 6 Avg: 6 Max: 51956
T: 1 ( 885) P:80 I:250 C:4688051 Min: 3 Act: 7 Avg: 6 Max: 50106
T: 2 ( 886) P:80 I:250 C:4688242 Min: 3 Act: 6 Avg: 6 Max: 51965
T: 3 ( 887) P:80 I:250 C:4688434 Min: 3 Act: 12 Avg: 8 Max: 59

cyclictest results on 6.12.y with d66792919d4f reverted:
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 9.43 9.50 9.44 8/204 5758
T: 0 ( 862) P:80 I:250 C:272329322 Min: 3 Act: 6 Avg: 6 Max: 57
T: 1 ( 863) P:80 I:250 C:272329324 Min: 3 Act: 7 Avg: 6 Max: 77
T: 2 ( 864) P:80 I:250 C:272329322 Min: 3 Act: 7 Avg: 6 Max: 68
T: 3 ( 865) P:80 I:250 C:272329322 Min: 3 Act: 16 Avg: 7 Max: 81

This is reproducible on multiple machines.

It looks like the timer fires and there is also a sched_waking event in 
the trace, but the cyclictest thread does not get scheduled for another 
50ms.

I found this, because Debian updated its rt kernel from 6.12.74 to 6.12.85.
The issue was also present with upstream 6.12.85 and HEAD, but not with 
6.12.74, so I started bisecting and eventually found d66792919d4f.

Is it possible to revert the commit?

I can provide traces or help with testing if needed.

Thanks
Lukas Beckmann

#regzbot introduced: d66792919d4f


