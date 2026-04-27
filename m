Return-Path: <stable+bounces-241247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN9gOeYS72mU5QAAu9opvQ
	(envelope-from <stable+bounces-241247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:40:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0F546E7AB
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB31303DA8C
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF27C3822A1;
	Mon, 27 Apr 2026 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="p25QGms6"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CA37E2F2;
	Mon, 27 Apr 2026 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275388; cv=none; b=LcxqjD8xMpezOzCVJ/P2N6kxq1ibA1hcTaarjW/6cEx4tpP6Baxbn8Uk08RFeB5Ld1TVMKkWTv6Jd0heJXjJP95zC9fQGrUMfQ2NF8ygcD+FJ8+N9WDBqaJMu2iDtbO4qwNa4mbEsCcSj1ZWBCmYuNjLQHgXc35bzBFr7AQdwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275388; c=relaxed/simple;
	bh=BmIv9uDaWGl2BsLjmW6P7Fd2alD9SELik5QJjIs6rNo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jtoyuRrQppPNf8NKxRtpqWwV7a6M2LJkyuq9eYBiV2+XCk5XH1e26dojSK7SYw5Eix/zUFWdXLPuxXUoWJVemIO1dN9qbbfiE4hA4wl8O2tSAppHvhKl9XCePS4IxsBTVDIRA3OnHYJ9bdEB1PkpPWPUpWVCYW3tKQufMrstBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=p25QGms6; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R4hqVi2793495;
	Mon, 27 Apr 2026 07:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=f67sUy0Fk
	VF2WqulClpkvvF+yIicieX9w6ew9YdyzuI=; b=p25QGms6U107VTfUv8hFVf+ea
	5YYjpDXCEVVeyy/aFulyhAHX1DEREuYUaNTsmxymMSznr66SkoZBtzosDJ8aMWws
	E67nikNujPHdPpk2u0S3UeLCB0cfOnnrF70Kfh+GkDrWzFpUI2pEpvIheEaJtWGZ
	PfS2W5qc8lVd4bnmURqKvVd4QfoDVemtLapEs3Yyx/fxd6ImrLDqE52yTifOoIhT
	o30AI9gTzswQc1uh5DjY/ErzRwF9tFwYG8nkO79dHboJn02EuRFYdP9dM1laX/aQ
	dFEEK1j7e7gPC4s5EuX3lkvhOYuI0nJy96lZv8mB+E1XosADVtGzNi4BwRHvg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drju09r9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 27 Apr 2026 07:35:49 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 27 Apr 2026 00:35:48 -0700
Received: from pek-lpggp9.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 27 Apr 2026 00:35:45 -0700
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
To: <naveen@kernel.org>, <davem@davemloft.net>, <mhiramat@kernel.org>,
        <catalin.marinas@arm.com>, <mark.rutland@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Subject: [PATCH] kprobes: skip non-symbol addresses in kprobe_add_ksym_blacklist()
Date: Mon, 27 Apr 2026 15:35:44 +0800
Message-ID: <20260427073545.3656835-1-jianpeng.chang.cn@windriver.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=69ef11d5 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=5DZcFgTl-RdOG2hZ3NwA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: aKj4uyfhAoZRw7PlaAPC0czNkP3t4UZH
X-Proofpoint-ORIG-GUID: aKj4uyfhAoZRw7PlaAPC0czNkP3t4UZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA3OSBTYWx0ZWRfX1M35TX5ulHAd
 wuDi5EHD7vV+HdoAKp+GgZDuCCul0lqqY9X99AmHYN4rnBhhD8qWx+Xrsx7ppxsMkJEeQhCAunh
 A9zbOdBrBtXzrXNK/zcc05VUVkm081o19ZivOO+3P1+UeGDm51HbQAFfaH8Qaj9oJ12bW4YAJVM
 wjRG4PVRjLrawm75i8uGjpcv+qkmHQP625O5FUbbStO9KEePrydCZi3Mr3ZaCwzXH5OBwGdyX8C
 WPCCRFMG4noNdDcs9nqOWvuzTHtmTiORBSRDH+AjnWuGWG0WXoq5hZFfwn5kDaVc//G2jSdcFeA
 KBWc4NA4FQAckSGmWkN2ybj8dYgzuuKa5siasC6n+W2g90EzC9ZWmW8zs92kWEl20pcrIyijbMT
 /w4fpiywvydgiZXrRFSR9P2tbdNVmuLGc5sV6kZjkpcrCbHIA6uEweK7JY1hAiBYnITACYpCA8e
 poaOqsQIdfDptO5j3ZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 clxscore=1011 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270079
X-Rspamd-Queue-Id: 4A0F546E7AB
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
	TAGGED_FROM(0.00)[bounces-241247-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,windriver.com:dkim,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianpeng.chang.cn@windriver.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
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

Fix this by checking the offset returned by kallsyms_lookup_size_offset().
A non-zero offset means the address is not at a symbol boundary, so skip
forward to the next symbol instead of creating a blacklist entry with a
wrong size.

Fixes: baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")
Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
---
Hi,

This patch skips non-symbol addresses, fixes the bogus blacklist entry,
but leaves the NOP gap at the start of .kprobes.text unblacklisted.

We can continue alloc the ent without return to add the gap to
blacklist, or do some more works to add the gap to the first symbol in
blacklist. I'm not sure if is this necessary, or is there a better way?

Thanks,
Jianpeng

 kernel/kprobes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index bfc89083daa9..be700fb03198 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2503,6 +2503,10 @@ int kprobe_add_ksym_blacklist(unsigned long entry)
 	    !kallsyms_lookup_size_offset(entry, &size, &offset))
 		return -EINVAL;
 
+	/* Not on a symbol boundary -- skip to the next symbol */
+	if (offset)
+		return (int)(size - offset);
+
 	ent = kmalloc_obj(*ent);
 	if (!ent)
 		return -ENOMEM;
-- 
2.54.0


