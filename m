Return-Path: <stable+bounces-244293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM5PDWye+mk8QQMAu9opvQ
	(envelope-from <stable+bounces-244293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:50:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB514D572A
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E715E3031EAC
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 01:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65AF26ED3D;
	Wed,  6 May 2026 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rOQZIhp+"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3D40DFB3;
	Wed,  6 May 2026 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032145; cv=none; b=FT6wLQK1pFFMKtwvL4NOPYzrZKFWvzJvzLBX2eh7hYDHbkns58ol4PELkPRrMuKjGm2rP7j8RNDgUBzzkc/SfL3fEIA0V38lVsCjacaMa4MvkiqRJmZLh2suqIopQjOWZ8wzfN5wJ5m0szx/P7P3Dyxv1XcXRWBFtcsRh2HcfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032145; c=relaxed/simple;
	bh=myi/D7XE6u0EBzzV9ClzoSdPhbtkU2YHSjtvN6OomBg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1da6PogkCG+DVMjsYTn1zKkRal9n1jRKzJPlNUyWMt/MOvQIgLm2mWcNtOJZLPGjekW7urRruwFSdZXcXSckmrP8AaSwBRfXIrTJR9o/MtWBTMnrOsZGCqGs1TlVPzTzpa001i0h9pUv2B9Vbz4acgVKjNopvMvt+aJNWSf82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=rOQZIhp+; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6461H4cV2256404;
	Wed, 6 May 2026 01:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=hw9gz9AJD
	tPg6ZAr5apAzDSOH5Jlg4JAoCipMg4iMGQ=; b=rOQZIhp+Xw7CYmjH0lf80sGds
	8K/DTp1g0Vu40BxeiE9+JQWf9nl3Bt87CDzQWgk9NVKMxAoymt8VDrC7BVq0O3e4
	kpB40unfIfGO4zYFoJ4bLI0eTuf07M0dbQUba5HiIepwlm+3KtuLgL73WpYMRUy6
	gyB1ZgUjFIM+OPZuTuXQHuemJjHxCA3dNqiwk2djBH5arcc0d4/RmuWnp3vhb8ua
	6fY2wyhAve92u/6D7OTOYSpJyG1Uuz71a1wreVO7Vb6+paMx+OVjkvz0hLpwnkSX
	lmfVX4QTkud/OAn1Ay7Yp3YEJ6Lrt6ChH6twKm58hgfg0ab/PDb8E8K50rlZA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dw8t5va9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 06 May 2026 01:27:11 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 5 May 2026 18:27:10 -0700
Received: from pek-lpggp9.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 5 May 2026 18:27:07 -0700
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
To: <naveen@kernel.org>, <davem@davemloft.net>, <mhiramat@kernel.org>,
        <arnd@arndb.de>, <mark.rutland@arm.com>, <catalin.marinas@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <stable@vger.kernel.org>,
        Jianpeng Chang
	<jianpeng.chang.cn@windriver.com>
Subject: [v2 PATCH] kprobes: skip non-symbol addresses in kprobe_add_ksym_blacklist()
Date: Wed, 6 May 2026 09:27:06 +0800
Message-ID: <20260506012706.2785785-1-jianpeng.chang.cn@windriver.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDAxMiBTYWx0ZWRfXwHR0mauZfcWY
 BBmZ90MIum8UC4wVNPFbCb3kLgBE86ZJ4cak6VqIVF7HrE9rQ7XlkfIO44ECR0ijllGKwgR4ZTd
 81qSvjlqGJkYbd2SZz5PFY5HTA8aGUaWmiiWVrK+voqlcwqfXeI/EIJ0Jr1ajJH4PW5pnF4BrO9
 F3Vq3bti52HxSc9eIV+Lw4ynfVBEnO/ZXqaKDSrRZVMrEiafX1gL6pmh6xvzTyYkRN8JlbgK6mg
 WVdf0R+rYVnSk8FMCtYh4jlPPpUVYMOg8L/e/yhI5RgMOa1OtoiVjRtP02cNZrJO5imNU7QK2hN
 Jwt0LJ92bQy/dPTs2yD2XrznErLWhtX7BY6VSSVGEM3AJe43ed13Tkm4V9ll417r/mOFuZr1Aoz
 SSrBqwT6aSI0W5zQKowxPVSQ/BN7BpqJAtpXw7rXRdVUf9Se4xutLBb5tDtN/+gzNKqBiK8Zdzp
 8oDTU44ZefElkJz2p0w==
X-Proofpoint-ORIG-GUID: JHVEniI2kF2He3E7a179foNcS5mb1Y_7
X-Proofpoint-GUID: JHVEniI2kF2He3E7a179foNcS5mb1Y_7
X-Authority-Analysis: v=2.4 cv=BcLoFLt2 c=1 sm=1 tr=0 ts=69fa98ef cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=5DZcFgTl-RdOG2hZ3NwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060012
X-Rspamd-Queue-Id: CBB514D572A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244293-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:email,windriver.com:dkim,windriver.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianpeng.chang.cn@windriver.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[windriver.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

When kprobe_add_area_blacklist() iterates through a section like
.kprobes.text, the start address may not correspond to a named symbol.
On ARM64 with CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS=y (introduced by
commit baaf553d3bc3 ("arm64: Implement
HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")), the compiler flag
-fpatchable-function-entry=4,2 inserts 2 NOPs before each function entry
point for ftrace call_ops. These pre-function NOPs sit at the section base
address, before the first named function symbol. The compiler emits a $x
mapping symbol at offset 0x00 to mark the start of code, but
find_kallsyms_symbol() ignores mapping symbols.

Without CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS (e.g. defconfig), no
pre-function NOPs are inserted, the first function starts at offset
0x00, and the bug does not trigger.

This only affects modules that have a .kprobes.text section (i.e. those
using the __kprobes annotation). Modules using NOKPROBE_SYMBOL() instead
(like kretprobe_example.ko) blacklist exact function addresses via the
_kprobe_blacklist section and are not affected.

For kprobe_example.ko on ARM64 with -fpatchable-function-entry=4,2,
the .kprobes.text section layout is:

  offset 0x00: $x + 2 NOPs    (mapping symbol + ftrace preamble)
  offset 0x08: handler_post   (64 bytes)
  offset 0x50: handler_pre    (68 bytes)

kprobe_add_area_blacklist() starts iterating from the section base
address (offset 0x00), which only has the $x mapping symbol.
kprobe_add_ksym_blacklist() then calls kallsyms_lookup_size_offset()
for this address, which goes through:

  kallsyms_lookup_size_offset()
    -> module_address_lookup()
      -> find_kallsyms_symbol()

find_kallsyms_symbol() scans all module symbols to find the closest
preceding symbol.

Since no named text symbol exists at offset 0x00,
find_kallsyms_symbol() picks __UNIQUE_ID_vermagic (a .modinfo symbol
whose address is in the temporary image) as the "best" match. The
computed "size" = next_text_symbol - modinfo_symbol spans across
these two unrelated memory regions, creating a blacklist entry with
a bogus range of tens of terabytes.

Whether this causes a visible failure depends on address randomization,
here is what happens on Raspberry Pi 4/5:

  - On RPi5, the bogus size was ~35 TB. start + size stayed within
    64-bit range, so the blacklist entry covered the entire kernel
    text. register_kprobe() in the module's own init function failed
    with -EINVAL.

  - On RPi4, the bogus size was ~75 TB. start + size overflowed
    64 bits and wrapped to a small address near zero. The range
    check (addr >= start && addr < end) then failed because end
    wrapped around, so the bogus entry was accidentally harmless
    and kprobes worked by luck.

The same bug exists on both machines, but randomization determines whether
the integer overflow masks it or not.

Fix this by adding notrace to the __kprobes macro. Functions in
.kprobes.text are kprobe infrastructure handlers that should never be
traced by ftrace. With notrace, the compiler stops inserting them and the
non-symbol gap at the section start disappears entirely.

Fixes: baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")
Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
---
v2: 
  - use notrace instead of skipping the nops
v1: https://lore.kernel.org/all/20260427073545.3656835-1-jianpeng.chang.cn@windriver.com/

 include/asm-generic/kprobes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/kprobes.h b/include/asm-generic/kprobes.h
index 060eab094e5a..5290a2b2e15a 100644
--- a/include/asm-generic/kprobes.h
+++ b/include/asm-generic/kprobes.h
@@ -14,7 +14,7 @@ static unsigned long __used					\
 	_kbl_addr_##fname = (unsigned long)fname;
 # define NOKPROBE_SYMBOL(fname)	__NOKPROBE_SYMBOL(fname)
 /* Use this to forbid a kprobes attach on very low level functions */
-# define __kprobes	__section(".kprobes.text")
+# define __kprobes	notrace __section(".kprobes.text")
 # define nokprobe_inline	__always_inline
 #else
 # define NOKPROBE_SYMBOL(fname)
-- 
2.54.0


