Return-Path: <stable+bounces-267207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3EX1Ev1RNGogUwYAu9opvQ
	(envelope-from <stable+bounces-267207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:15:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F996A27B5
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:15:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=crowdstrike.com header.s=default header.b="oYx/b724";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267207-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267207-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=crowdstrike.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C3D0301957A
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097203128B2;
	Thu, 18 Jun 2026 20:15:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F428C037
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:15:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813754; cv=none; b=K0LIre376/ztW/3SxyF7VAMg9p1xfPoW+OyuH9A1oLAcpp6iUH5lc3buaO+Vo23+DrFwT9ofUAziqXHOFJr6ceW3pzvpPvyOOuGwJ5QJhtmlN3KrmIxq/FpfGj5r7d+zdw7cgS2w9g+OMQ7dxFn/rg3+jYt59IDVeDB5XeUtcGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813754; c=relaxed/simple;
	bh=ODlJQjSR9sWkeTUDz3e/n3OU4llQhnVtEP96uZtTQzA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZTwXmy6bAW4uV1YUtUANoJfD01Lyx+is6Izg9v8q9IQt3m9NtdjpLAcI0f5MjG4p7S/cJRBAaeNnzohfaB0hJ0DdP9EiruQZWcgLAFGrDA0FMHHgylPHrEO2leGCl7VhPODeNW8H91C4SzBfseI4IMCrqGesLstTAf/Rx6BkLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=oYx/b724; arc=none smtp.client-ip=148.163.148.77
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiT7q3008102;
	Thu, 18 Jun 2026 20:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=m9LV7vn+MVpwS
	PAkn51YE07dplchoiEyjajMPf1U+48=; b=oYx/b724FiYG1I0ilMZL1CAM4zqDA
	sRO/WYpDEfyHYzXMZOkwanzS4fSwyOAQTcRsZwEAhty/jruncPIwj9sTWeDqRSYv
	pdTVUZFcvL/cYnOTOkqvCW9wfEuPI5INIi++Qw7vWAerx8EjizV4B7PTT7FpVlDp
	zq7JlftwR0iWc13H+kvJhpIQqtzOYWX+XWZ09ivSHdvFSN9/oEQkcEvNpB/zcjbB
	BQOfmFy4TdEaIdOABJRMemXxAvTZv84dPo3b9BBgbweZWYfgwpHcmavxwHSDz4wH
	3qPXidf14rWO5xWV2aUeL+h6FOn+wkEoFYfo9Dsfw/wdV8iJv0uSydAYA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3k84g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:15:46 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:15:44 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>, <justin.deschamp@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH 6.12.y 00/27] ftrace/sorttable: Fix ftrace symbol table corruption with CONFIG_X86_KERNEL_IBT=y
Date: Thu, 18 Jun 2026 16:15:14 -0400
Message-ID: <cover.1781809906.git.andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-ORIG-GUID: iAxQb8phpPq5aJXk1eKpRVxHjddRZXNE
X-Proofpoint-GUID: iAxQb8phpPq5aJXk1eKpRVxHjddRZXNE
X-Authority-Analysis: v=2.4 cv=QrVuG1yd c=1 sm=1 tr=0 ts=6a3451f2 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22
 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8 a=p0WdMEafAAAA:8
 a=FKHNVGkEP0QFufyHOfwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfXyEynmFZB49mp
 8boZCcKsb/xYMBB+6A1nkBrjhICqmYf92llu0GPoaSWM5TxNli8k/9KljaagNFNkWv2O/9VgCgJ
 H13ARubriSU8+LsJsy/vv9BD0o+sqCdK1ivFla3o4mwcVRVp53bD6g7YQfcXzKtZiZhrx3UwYdT
 6irpfRJ9QvRww7JSzPuLCBYPIIPIg/CbxZITqmr1P+MfYEAf6pemwd36id3RrUFWX2HPo/Vicf9
 G61M4kovA3w3+BA1JuapDODHsFMLjti6gIlATMiL6YoS/bkqOfGc5Ft3RWA/ne1U+lNDZja5dgg
 7peLeHPjNQOPbqiU86J6qv9+cEwvPw5OFniGoWPSzrUCOaEbibJL9jsgpQ6y1rx6ddASBG5VnPu
 wcys8UCZ/owyfclBpEh8GdOGDBoqGF559wHLK2YnYZkcohPmamM9S99bLZeXdhaJO21rKdqTG5x
 QASXPZP6Ug19qo7ZNIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX8VGJgwoinGAm
 BHL1ETnlfsPwIwxW7gR0TtE7HThwS3ISsJ3HnvRETx4C5LZ4tv4bHJoQAH84SPbt1fCMByusyR/
 dAhrRWobBGdwKhCotreSttXkdVa0zSlB6i8lZv/nz4Qtuc4uAMtA
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180185
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	FORGED_SENDER(0.00)[andrey.grodzovsky@crowdstrike.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:rostedt@goodmis.org,m:vmalik@redhat.com,m:jmarchan@redhat.com,m:martin.kelly@crowdstrike.com,m:justin.deschamp@crowdstrike.com,m:linux-open-source@crowdstrike.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267207-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.grodzovsky@crowdstrike.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7F996A27B5

This series backports the upstream fix for ftrace symbol table
corruption on kernels with CONFIG_X86_KERNEL_IBT=y. Weak overridden
functions corrupt the ftrace symbol table at boot, causing
non-deterministic hook attachment failures across all ftrace consumers
— most visibly fentry/trampoline-based hooks, but affecting any code
that relies on ftrace symbol lookups.

The fix was merged to mainline in Linux 6.15 via:
  https://lore.kernel.org/all/20250218195918.255228630@goodmis.org/

The original backport request and bug description sent to stable:
  https://lore.kernel.org/stable/CAOu3gNibeo3ov09CYpmzuqewB0EOsajB3hPU9pQmb_zoAUraHg@mail.gmail.com/

Red Hat independently backported this same set of patches to their
RHEL 10 kernel (6.12). Their work is at:
  https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/2689

The 27 patches are organized in four groups:
  - Patches 01-14: sorttable.c rewrite (prereq, merged 6.14)
  - Patch  15:     function pointer struct cleanup (prereq, merged 6.14)
  - Patches 16-21: the core IBT fix series (merged 6.15)
  - Patches 22-27: post-merge correctness fixes for arm64 and s390

All patches applied cleanly to 6.12.y (at 6.12.93). Tested on x86_64
with CONFIG_X86_KERNEL_IBT=y:

  grep __ftrace_invalid_address___ \
    /sys/kernel/tracing/available_filter_functions | wc -l
  Before: 589   After: 0

ftrace kernel selftests (tools/testing/selftests/ftrace):
  135 passed, 0 failed, 0 regressions introduced.

Guenter Roeck (1):
  ftrace: Do not over-allocate ftrace memory

Steven Rostedt (25):
  scripts/sorttable: Remove unused macro defines
  scripts/sorttable: Remove unused write functions
  scripts/sorttable: Remove unneeded Elf_Rel
  scripts/sorttable: Have the ORC code use the _r() functions to read
  scripts/sorttable: Make compare_extable() into two functions
  scripts/sorttable: Convert Elf_Ehdr to union
  scripts/sorttable: Replace Elf_Shdr Macro with a union
  scripts/sorttable: Convert Elf_Sym MACRO over to a union
  scripts/sorttable: Add helper functions for Elf_Ehdr
  scripts/sorttable: Add helper functions for Elf_Shdr
  scripts/sorttable: Add helper functions for Elf_Sym
  scripts/sorttable: Use uint64_t for mcount sorting
  scripts/sorttable: Move code from sorttable.h into sorttable.c
  scripts/sorttable: Get start/stop_mcount_loc from ELF file directly
  scripts/sorttable: Use a structure of function pointers for elf
    helpers
  arm64: scripts/sorttable: Implement sorting mcount_loc at boot for
    arm64
  scripts/sorttable: Have mcount rela sort use direct values
  scripts/sorttable: Always use an array for the mcount_loc sorting
  scripts/sorttable: Zero out weak functions in mcount_loc table
  ftrace: Update the mcount_loc check of skipped entries
  ftrace: Have ftrace pages output reflect freed pages
  ftrace: Test mcount_loc addr before calling ftrace_call_addr()
  ftrace: Check against is_kernel_text() instead of kaslr_offset()
  scripts/sorttable: Use normal sort if theres no relocs in the mcount
    section
  scripts/sorttable: Allow matches to functions before function entry

Vasily Gorbik (1):
  scripts/sorttable: Fix endianness handling in build-time mcount sort

 arch/arm64/Kconfig      |    1 +
 kernel/trace/ftrace.c   |   68 ++-
 scripts/link-vmlinux.sh |    4 +-
 scripts/sorttable.c     | 1119 +++++++++++++++++++++++++++++++++++++--
 scripts/sorttable.h     |  500 -----------------
 5 files changed, 1133 insertions(+), 559 deletions(-)
 delete mode 100644 scripts/sorttable.h

-- 
2.34.1


