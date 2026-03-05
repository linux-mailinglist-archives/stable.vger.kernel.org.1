Return-Path: <stable+bounces-223184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KS2D2hLqWk14AAAu9opvQ
	(envelope-from <stable+bounces-223184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 10:22:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CED20E4A1
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 10:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA56B3092BB3
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E79377EDE;
	Thu,  5 Mar 2026 09:15:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F85374E53
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702154; cv=none; b=Cb/WEneBYcgoh4+alFm/Ur5G22AObNIrRhXfZN3vvLRduXZDYSe/uxr7ay8IQk2Cv/IRI9WagSQr4IzXHLyQts0FfkTNCCHE+H7BQq6Ghcsi9/270tbKXXZumStXlGHmtt9Unx5bhaU4w4hxKagqCExTn3S8hfzGyk4RgdMAJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702154; c=relaxed/simple;
	bh=H6Za3VIsboVrM8OFJUYkAsmmpRLgB5UoYYKwWZikqDQ=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=twT0d144FbVYvo9fe30Yomj3SADQt/bo6j5i15ptAbcxvk13kHBnCZH3Bt3F35Nmq13BInNVLZa3ArtX+1OhKExrZdxupZRFgGhSELp4EFknlIEHRnrmWU7AzyaFqUIvt2ny0i/iWzDvBZbroCz6XwPJJlcgk+m4hk31GYDuYoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1772702145-086e235c85586a0001-OJig3u
Received: from zxbjmbx1.zhaoxin.com (zxbjmbx1.zhaoxin.com [10.29.252.163]) by mx1.zhaoxin.com with ESMTP id Nt1Y6IdTHlhSCcxB (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 05 Mar 2026 17:15:45 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Thu, 5 Mar
 2026 17:15:45 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Thu, 5 Mar 2026 17:15:45 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
Received: from [10.32.64.22] (10.32.64.22) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Thu, 5 Mar
 2026 17:03:25 +0800
Message-ID: <70139192-54e5-4a4b-bc96-1fe3ec4f7a0b@zhaoxin.com>
Date: Thu, 5 Mar 2026 17:03:07 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <me@ziyao.cc>
CC: <andrew.cooper3@citrix.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <stable@vger.kernel.org>,
	<tglx@kernel.org>, <x86@kernel.org>, David Wang <davidwang@zhaoxin.com>,
	<lukelin@viacpu.com>, <brucechang@via-alliance.com>, "TimGuo@zhaoxin.com"
	<TimGuo@zhaoxin.com>, <cooperyan@zhaoxin.com>, <benjaminpan@viatech.com>,
	<TimGuo-oc@zhaoxin.com>, <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>,
	"CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>
References: <20260228173704.62460-1-me@ziyao.cc>
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20260228173704.62460-1-me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 3/5/2026 5:15:43 PM
X-Barracuda-Connect: zxbjmbx1.zhaoxin.com[10.29.252.163]
X-Barracuda-Start-Time: 1772702145
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://mx2.zhaoxin.com:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2057
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.155405
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Rspamd-Queue-Id: C5CED20E4A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223184-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[zhaoxin.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[TonyWWang-oc@zhaoxin.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Thank you for submitting the patch to fix the Zhaoxin CPU issue.

After internal clarification, we have confirmed that this is an
issue with the ZX-C CPU ucode:
When modifying CR4.FSGSBASE bit 16, the ucode propagates its
value to another MSR register. During execution of FSGSBASE-related
instructions, the hardware actually checks whether this MSR
register's bit is set to determine whether to generate a #UD
exception.
When the CPU enters SMM mode and then returns via RSM, the CR4
register is restored but the value of CR4.FSGSBASE is not
re-propagated to the MSR register.
As a result, after enabling CR4.FSGSBASE, once the CPU goes
through SMM mode, executing FSGSBASE-related instructions will
trigger a #UD exception.

This issue exists only on ZX-C CPUs, which have two different
CPU vendor IDs and distinct FMS values. The following patch can
be used to identify ZX-C CPUs and properly handle this issue:

--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -201,6 +201,11 @@ static void init_centaur(struct cpuinfo_x86 *c)
         set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
  #endif

+       if (c->x86 == 6 && c->x86_model == 15 && c->x86_stepping >= 14) {
+               pr_warn_once("CPU has broken FSGSBASE support; clear 
FSGSBASE feature\n");
+               setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
+       }
+
         init_ia32_feat_ctl(c);
  }

diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 031379b7d4fa..6a2d6df307ee 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -89,6 +89,11 @@ static void init_zhaoxin(struct cpuinfo_x86 *c)
         set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
  #endif

+       if (c->x86 == 6 && c->x86_model == 25 && c->x86_stepping <= 3) {
+               pr_warn_once("CPU has broken FSGSBASE support; clear 
FSGSBASE feature\n");
+               setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
+       }
+
         init_ia32_feat_ctl(c);
  }

Sincerely
TonyWWang-oc

