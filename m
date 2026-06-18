Return-Path: <stable+bounces-267253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rx9SCI5XNGqgVQYAu9opvQ
	(envelope-from <stable+bounces-267253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:39:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C7D6A29D2
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:39:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=crowdstrike.com header.s=default header.b="ZwMC uGb";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267253-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267253-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=crowdstrike.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 952E63026229
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 20:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3193469E7;
	Thu, 18 Jun 2026 20:39:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E330E82C
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815176; cv=none; b=qpaZUA4vNGGq2GsstNuFxq4H0vraV8cn51c7/XZzo089zPfzwHvnPbEh9DcE8xSyqmtiEKcgF9Tc3/CgMpPu9g+/jHxnNba9ANSAmCXeUQ6hNIDZVJAOSUzOJm2d9efl4PJCKaj+YSBFEeYxeojrBH5+oTZYnZ4bKhMW9yg+qlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815176; c=relaxed/simple;
	bh=E6BeMurtrzKA27t6UVf4wK4vphIqoWMGrwvbGO9Lj1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMTMrQ6Styu+eG0Vvy/Bz7SVJex0FA9wjzGGMRm1RWZxZuYLJJ+9C8wcTWWljpgoz8x5mQzhEdxNrbVeKuUYfGiiV2JbCA1JHFpcd+pu4dvZimgPiMS9XksZlIjEu+p7Y+ao1CwzSJ8FgWvC5PkkssvwjN83hHZYWWEund/dams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ZwMCuGbm; arc=none smtp.client-ip=148.163.148.77
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiCHW4006048;
	Thu, 18 Jun 2026 20:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=aOqpmm9Bqw5tTRw8fA0kgErhnonC8Nk6pBWYTNjt2JY=; b=ZwMC
	uGbm5jT4VoVjANVQg877icmN0LVGCK+gNO3hsR7HtDAjtrCLAWEqQ7SQKJaggC3T
	03ryaV+HaRCX+fsfXBD3UjEgvGKYQaurZJ4Biz09PM6vPW/0ht9g+Jp9m54v6Y9l
	2T+OdGN8IRYd2xAbdRAKC+LzSQLK80a31dkCdhLzTcT7HkclDnr2QE9cQ0WcIYIe
	dtU7TS8VkKXBHU8VYyACyax6TtNvY1+2Sg8Y8b3lViqBgF/CZ/kIuFqv7pBdpv8S
	N2ZARVs8Bo1Lk16+nYko/T9TveHYG4Ne924oVCq3i1n6BnMSIJuhKWlaJAKPJbsF
	DoiimsuSL9shmshdrA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3jg7yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:29 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:28 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 17/27] scripts/sorttable: Have mcount rela sort use direct values
Date: Thu, 18 Jun 2026 16:38:55 -0400
Message-ID: <b28d8bc583e483febb99a1436a58a4470798a1df.1781814138.git.andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781814083.git.andrey.grodzovsky@crowdstrike.com>
References: <cover.1781814083.git.andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX+hpvF13ldioM
 5HgLQfo1KbN4x4hgzbgWRtLeQEm+oc1get01W1DtzAYhxNnyWKxurxHtgf4sdEJmb2iLJ8u2c6j
 Vmm7m/F9jEwh4fP0WPgGEvoq2T/2mqJbKiV8Zw1ZyhOYBsORC9kN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX7WHIXV9Zx6AF
 fIEDi9jmGRH3I78nPd/nS2ODZwd0W6K3BVEAZ8vXtTmBAym91OYJGKwnagRqsSSXUSRDZ/5ND2M
 7a2QLyeAnDk4bC3OeAu0tM0lN1rc5z54NzPxsv/VyXCJBDXqcp1+kwfjhYi26iYkeTJ6n+FaCDX
 CiR5MhGZ6/Qjgea8lDU7JTycbETk8uhGF+scark2GZX8dspwOOO+mR2xbbGJkDaHulennPEhQUD
 UiEpFU0mfgjYSXsoW66rEkLyYfMpSuM9cM1A/O3qXu2Rr6EFajCIu7X1accYdedYu7mAOT+4Lk/
 73HpqERXnX9dVQ0tIb9iCtNRPr45KiCTXFqSViveKsSfALVUKwxAwmxbCzMiE4yFfvJMj2694yh
 dDMUZxUFkPA7QCuYsAT6yvQOgNpGiXAYrW+g++F6Xjg2KXu9Oq0DkiAHRbru8DveTBTICPFwJ1E
 FUWs4DTIBWpnaJN0LDA==
X-Proofpoint-ORIG-GUID: ErZKM6BKTmMEyL_DcimDvSgDbQVAdzet
X-Proofpoint-GUID: ErZKM6BKTmMEyL_DcimDvSgDbQVAdzet
X-Authority-Analysis: v=2.4 cv=AvLeGu9P c=1 sm=1 tr=0 ts=6a345781 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=UWjLTQXr3SkU-CwT73AA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-267253-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:rostedt@goodmis.org,m:vmalik@redhat.com,m:jmarchan@redhat.com,m:martin.kelly@crowdstrike.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrey.grodzovsky@crowdstrike.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.grodzovsky@crowdstrike.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[crowdstrike.com:+];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8C7D6A29D2

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit a0265659322540d656727b9e132edfb6f06b6c1a ]

The mcount_loc sorting for when the values are stored in the Elf_Rela
entries uses the compare_extable() function to do the compares in the
qsort(). That function does handle byte swapping if the machine being
compiled for is a different endian than the host machine. But the
sort_relocs() function sorts an array that pulled in the values from the
Elf_Rela section and has already done the swapping.

Create two new compare functions that will sort the direct values. One
will sort 32 bit values and the other will sort the 64 bit value. One of
these will be assigned to a compare_values function pointer and that will
be used for sorting the Elf_Rela mcount values.

Cc: bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Cc: Martin  Kelly <martin.kelly@crowdstrike.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/20250218200022.538888594@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 4a34c2751..f62a91d8a 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -552,6 +552,28 @@ static void *sort_orctable(void *arg)
 
 #ifdef MCOUNT_SORT_ENABLED
 
+static int compare_values_64(const void *a, const void *b)
+{
+	uint64_t av = *(uint64_t *)a;
+	uint64_t bv = *(uint64_t *)b;
+
+	if (av < bv)
+		return -1;
+	return av > bv;
+}
+
+static int compare_values_32(const void *a, const void *b)
+{
+	uint32_t av = *(uint32_t *)a;
+	uint32_t bv = *(uint32_t *)b;
+
+	if (av < bv)
+		return -1;
+	return av > bv;
+}
+
+static int (*compare_values)(const void *a, const void *b);
+
 /* Only used for sorting mcount table */
 static void rela_write_addend(Elf_Rela *rela, uint64_t val)
 {
@@ -583,6 +605,8 @@ static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
 	void *vals;
 	void *ptr;
 
+	compare_values = long_size == 4 ? compare_values_32 : compare_values_64;
+
 	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
 	shentsize = ehdr_shentsize(ehdr);
 
@@ -640,7 +664,7 @@ static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
 		}
 	}
 	count = ptr - vals;
-	qsort(vals, count / long_size, long_size, compare_extable);
+	qsort(vals, count / long_size, long_size, compare_values);
 
 	ptr = vals;
 	for (int i = 0; i < shnum; i++) {
-- 
2.34.1


