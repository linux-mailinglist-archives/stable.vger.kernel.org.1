Return-Path: <stable+bounces-267239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id he0hD89XNGrDVQYAu9opvQ
	(envelope-from <stable+bounces-267239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:40:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C75EC6A2A24
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:40:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=crowdstrike.com header.s=default header.b="KMkp 9XQ";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267239-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267239-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=crowdstrike.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C03C3024C91
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 20:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3909A30E827;
	Thu, 18 Jun 2026 20:39:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A93403FD
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815160; cv=none; b=Vt7XqNgFP1BZf/2l43SqZvRTTPas9FQ1UF8/1c2wdFlE+b8yk1rskxCxPNLz4m4EiFhTYBkuEll04D8AZlfBx0ZBfCF+VjmIZl6NWOacFnf6Dsr66SbDdjNWBXWNzbkXro3Ytlb+622SgIk5rWdTj9uhso0dKNyfTo/bP7gJGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815160; c=relaxed/simple;
	bh=AbVVgwnoaqlHfqGr8gaQznbWNiyDPk/UcPonmgfyG8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOanmNk+d5IQFxmyKLf0gVbwfl1PL03bbDhazr8DECeu8vanlHncj3j7woIxPEEOZnTaaogMM6irYUwQvzWeeLILQ5EhvfZgqaXlOsaTey4pHytqTwBpY0n0sObgf5Ci+gRDJdJLu/+AeosztIg6Hgi9IlgoJLv5VEXirgXL6ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=KMkp9XQb; arc=none smtp.client-ip=148.163.152.16
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IIsgdT3939561;
	Thu, 18 Jun 2026 20:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=P+rUnVS7i4alaqm6Sddr1Omeo2AG/XLny9qzOYeErNw=; b=KMkp
	9XQbMJFzILIsDsVNXGKzTXgD9yOjs5+fJQ/0Zqqq7tO0bFKTBYk4fo7nh7L2VKZV
	OeThJ7fh0dTCvLlolsGve5osJ46R/v5LIejw0/ykodRYmc0WSigT3VWMk2BSRmOV
	VE9VrHeWMujo21ajFBR/l3OCe53qhecaCrc1sGex6CVwF6yRswlThhTTJ4fN0PFb
	do1raUB41ytaofE4B4AX+1j8HEVWke2r6baccqAsg8SMgUZy59gTfXOfLS26FWsY
	chV5tH4mYY+fnO/WMq/EI0NJQptwGTaMOK3u0ajGOlwCBTDcTPl/aP7P+Ji2inSf
	vxW2Ym974ZiKGk6BmA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ev5c6v1ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:13 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:11 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 03/27] scripts/sorttable: Remove unneeded Elf_Rel
Date: Thu, 18 Jun 2026 16:38:41 -0400
Message-ID: <fd60832c3e492356a01c470a01997ee9a720831b.1781814094.git.andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=Eez4hvmC c=1 sm=1 tr=0 ts=6a345771 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=_YqY1u4RUxZ9fqoOkI0A:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: bc8-u2sabysn3qtbDn44xabGrrbwiz2w
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX10m2BkSFMfKb
 IsXQZVVfVp8N95cKVNW4MlmjHw5Jt5jY1cDbcg+1TQrPJ0O3aclVzMnAggUaXnbUNSBOmMoeSlV
 bRKWsTrSEnuQPEs7ZyKW2XLwdt9BUEeNpqElKxOPp6FkFUjKuxdb
X-Proofpoint-ORIG-GUID: bc8-u2sabysn3qtbDn44xabGrrbwiz2w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX01ViGy0aiQHE
 SDBWG0iQbyRVtJNEYzUXf1lcAj94S3S6F0GPdqR7nU4B8OjBPwTbge2mSZyufOju/8kyIlQmB6R
 pUbhKcSKAZP1VtvHcFEoSLGF4ruyzI7/cZmvIIjWs/kOgiCsb7RsEvD8IIo4YnjqR1On29w839R
 pAVfLWDSnPH+cqtzCve/PBQ7/jpStuh5Sp/04X/3M7NiD0NHPT7YL1o2HWvbCO+Uj1n8/5chZpc
 l5Zoi+SJoZCR1lBCK1y83BiNKRf/3lydmK9vfSaodJ92iidTVYRXi5KolnXku1n0rdV0ChV0rTm
 wiIReaWpl86z9eRPqgpQ4GSPmUxeibFhXtK7NIV3R8XnwRQgsb7cFm7QJwqEPIhSpfE+TwIRs3J
 Vze62aFdBZzShOyDKkd5KFys9I/usuAsxMGH25n6/nH2lOmnvcQOryvPa9N6wzNCdYU3YGK5w5p
 Ko92hndBJI0tzrcqDuw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180189
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[crowdstrike.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[crowdstrike.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-267239-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C75EC6A2A24

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 6f2c2f93a190467cebd6ebd03feb49514fead5ca ]

The code had references to initialize the Elf_Rel relocation tables, but
it was never used. Remove it.

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
Link: https://lore.kernel.org/20250105162344.515342233@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 scripts/sorttable.h | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 14d0c4d84..18d07fdb2 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -26,7 +26,6 @@
 #undef Elf_Addr
 #undef Elf_Ehdr
 #undef Elf_Shdr
-#undef Elf_Rel
 #undef Elf_Sym
 #undef ELF_ST_TYPE
 #undef uint_t
@@ -42,7 +41,6 @@
 # define Elf_Addr		Elf64_Addr
 # define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
-# define Elf_Rel		Elf64_Rel
 # define Elf_Sym		Elf64_Sym
 # define ELF_ST_TYPE		ELF64_ST_TYPE
 # define uint_t			uint64_t
@@ -57,7 +55,6 @@
 # define Elf_Addr		Elf32_Addr
 # define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
-# define Elf_Rel		Elf32_Rel
 # define Elf_Sym		Elf32_Sym
 # define ELF_ST_TYPE		ELF32_ST_TYPE
 # define uint_t			uint32_t
@@ -248,14 +245,10 @@ static int do_sort(Elf_Ehdr *ehdr,
 	Elf32_Word *symtab_shndx = NULL;
 	Elf_Sym *sort_needed_sym = NULL;
 	Elf_Shdr *sort_needed_sec;
-	Elf_Rel *relocs = NULL;
-	int relocs_size = 0;
 	uint32_t *sort_needed_loc;
 	const char *secstrings;
 	const char *strtab;
 	char *extab_image;
-	int extab_index = 0;
-	int i;
 	int idx;
 	unsigned int shnum;
 	unsigned int shstrndx;
@@ -279,23 +272,15 @@ static int do_sort(Elf_Ehdr *ehdr,
 	if (shnum == SHN_UNDEF)
 		shnum = _r(&shdr[0].sh_size);
 
-	for (i = 0, s = shdr; s < shdr + shnum; i++, s++) {
+	for (s = shdr; s < shdr + shnum; s++) {
 		idx = r(&s->sh_name);
-		if (!strcmp(secstrings + idx, "__ex_table")) {
+		if (!strcmp(secstrings + idx, "__ex_table"))
 			extab_sec = s;
-			extab_index = i;
-		}
 		if (!strcmp(secstrings + idx, ".symtab"))
 			symtab_sec = s;
 		if (!strcmp(secstrings + idx, ".strtab"))
 			strtab_sec = s;
 
-		if ((r(&s->sh_type) == SHT_REL ||
-		     r(&s->sh_type) == SHT_RELA) &&
-		    r(&s->sh_info) == extab_index) {
-			relocs = (void *)ehdr + _r(&s->sh_offset);
-			relocs_size = _r(&s->sh_size);
-		}
 		if (r(&s->sh_type) == SHT_SYMTAB_SHNDX)
 			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
 						      _r(&s->sh_offset));
@@ -397,10 +382,6 @@ static int do_sort(Elf_Ehdr *ehdr,
 		      extable_ent_size, compare_extable);
 	}
 
-	/* If there were relocations, we no longer need them. */
-	if (relocs)
-		memset(relocs, 0, relocs_size);
-
 	/* find the flag main_extable_sort_needed */
 	for (sym = (void *)ehdr + _r(&symtab_sec->sh_offset);
 	     sym < sym + _r(&symtab_sec->sh_size) / sizeof(Elf_Sym);
-- 
2.34.1


