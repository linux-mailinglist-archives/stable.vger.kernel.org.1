Return-Path: <stable+bounces-268678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q4/YGXOnPWry5AgAu9opvQ
	(envelope-from <stable+bounces-268678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 00:10:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B85BD6C8E52
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 00:10:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=cTiLefe6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268678-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268678-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EBBB306847F
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 22:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9835536EAAB;
	Thu, 25 Jun 2026 22:05:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1632D0CC;
	Thu, 25 Jun 2026 22:05:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425141; cv=none; b=r2KG1wtdg6WiRUtXfeuaqWE3pAoWFSt/R1T6qk5Onaj84AIn2r5ggE08TFJr+ASqQH/s2hjMWmrh1bhh8pzNxMLSq3CpppUCv97B5Zl7UnGySXelkCOjtERBTVFhg8xmRIDu/uvdZsalPKLWnSnl4RxwJPT+AMWBswNvHQZ/rKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425141; c=relaxed/simple;
	bh=o9784fq5H0vKbEhs9q1nhq9qzCGvGCXr6nkGiH4HQdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMoKXyj7U1mpEhyk7yD82QHxAZrbpBlMOIF8IAFqX1cdY4jU5qM3gEhksw2o0/j1W5UGD2dLBIV1M6E6O1BzfrFgtIHPKGwcwBXbu2ogFN1O70+eFFKtyKkgI1aFF/o+PR3lgpeTdMjKaFdl9AGHlKdsxChgABLvoRwicvj7rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cTiLefe6; arc=none smtp.client-ip=50.112.246.219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1782425140; x=1813961140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aoFONVOhyScoEnWz8QaO9D6p4/Oi64chHMt1wSu33gc=;
  b=cTiLefe6/DYCYR3q7uTSE26YwktRd1kRams/NBt0FfbJRUJnJJhJiQh7
   +A9ubVMquTU17nkxE1F56nT4PtUIih4LEZ9H4eOO7MS3j+QSdKDEFdfUC
   f3Aw/GWE5gutnqzy6PiWBbKGZH3BT+eGO4FlLFIe4NP7B8MUR0oD70528
   NUzVmV+5NbcSHT4+uwLp3GvGCpSQaOj+J8vg7u63UTCJYatwVQAM9OOra
   1aaLgOK4SqCRlYoZFJorYt+wwTwAfh96ITCMicZUykXh1KMHTdWTy8TYM
   YXtGKVrZh5aw+CODeNztpvWBfu61lf8Iv/URK34J0DCkTTD+EO/DzASzY
   w==;
X-CSE-ConnectionGUID: IIl9M7GQTKKu5hd2UILYNA==
X-CSE-MsgGUID: b6Hm8G91T5az+AqzX1mSWA==
X-IronPort-AV: E=Sophos;i="6.24,225,1774310400"; 
   d="scan'208";a="22325959"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 22:05:40 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:30621]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.142:2525] with esmtp (Farcaster)
 id ec50139c-a60b-49fe-b7e2-85f290cfb846; Thu, 25 Jun 2026 22:05:39 +0000 (UTC)
X-Farcaster-Flow-ID: ec50139c-a60b-49fe-b7e2-85f290cfb846
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 25 Jun 2026 22:05:39 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.171.24) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 25 Jun 2026 22:05:39 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <pbonzini@redhat.com>
CC: <bkov@amazon.com>, <doebel@amazon.de>, <fgriffo@amazon.co.uk>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <seanjc@google.com>,
	<stable@vger.kernel.org>, <zcgao@amazon.com>
Subject: Re: stable backports for "KVM: x86: Fix shadow paging use-after-free due to unexpected GFN"
Date: Thu, 25 Jun 2026 15:04:37 -0700
Message-ID: <20260625220437.52368-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CABgObfawkiKRDz0to=oCjo1vygVAkHyZXAzpsLWT2GXwkszV_A@mail.gmail.com>
References: <CABgObfawkiKRDz0to=oCjo1vygVAkHyZXAzpsLWT2GXwkszV_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zcgao@amazon.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268678-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pbonzini@redhat.com,m:bkov@amazon.com,m:doebel@amazon.de,m:fgriffo@amazon.co.uk,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:seanjc@google.com,m:stable@vger.kernel.org,m:zcgao@amazon.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[zcgao@amazon.com,stable@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux-kvm.org:url];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B85BD6C8E52

Thanks Paolo! I tested these in the context of Amazon Linux, carrying the
series as a downstream patch set on top of our 5.10 and 5.15 trees, as
follows.

Test setup
- Trees: Amazon Linux 5.10 and 5.15, with the backports applied as
  downstream patches. (For 5.10, applied a83e50d86^..d3d0e6688; for 5.15,
  applied 4db658c99^..1ab8cd246)
- For each tree we ran with EPT enabled and disabled, i.e.
    sudo rmmod kvm_intel && sudo modprobe kvm_intel ept=0
  and confirmed via /sys/module/kvm_intel/parameters/ept.
- Tested with AWS EC2 c5.metal.

Tests
- KVM selftests: make -C tools/testing/selftests/kvm run_tests
- kvm-unit-tests: https://www.linux-kvm.org/page/KVM-unit-tests

For each (tree x EPT setting) we collected results before and after
applying the backport and compared them.

Results
- No regressions. On both 5.10 and 5.15, and with EPT on and off, the
  test outcomes are the same before and after the backport.
- kvm-unit-tests output was identical before vs. after.
- The KVM selftest verdicts (ok/not ok) were identical before vs. after.
  The handful of failing tests are pre-existing on our baseline and
  unrelated to the MMU change (e.g. debug_regs, vmx_pmu_msrs_test, a
  memslot_perf_test timeout, etc.).

So from these tests, the backport looks good. Please let me know if
there are any other tests I can help with. 

Tested-by: Nathan Gao <zcgao@amazon.com>

Thanks,
Nathan Gao

