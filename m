Return-Path: <stable+bounces-267256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dBk5O5FXNGqjVQYAu9opvQ
	(envelope-from <stable+bounces-267256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:39:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BA86A29DE
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:39:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=crowdstrike.com header.s=default header.b="epIC iOH";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267256-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267256-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=crowdstrike.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C499302D750
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 20:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486A0345751;
	Thu, 18 Jun 2026 20:39:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228634D3B0
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:39:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815180; cv=none; b=mo5C/SHR7b1bfOR9mMxqK4tMjKFerR1RunejNRTEzIoZ/fCyOyZWLQWgngfrLGox6L2UfLQuVAajYjDuIAxS+JuOG0Wecha0tY1uwVnpLURoZOxcYrYtvyG6M0hqxtXOHTBAhGDaaKxqoa/dceIrZFpyb+swSgHzb3xXyKPd2l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815180; c=relaxed/simple;
	bh=boepAnKUvO4y9mLFjz5C3vmoQoFSI3CN+G286vLgzkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GryQ4xrLJ5+hKtkz+JGhj96KMUTi9Zq41Y5ZqrsHyjQXG2G5FamW18mNr7l3I2wtfD2nGg0fhA+opokTBtNe59u6L0jKNE/z77dnpaq0aTuN+/lqEmyORmyWlJt0EddtB2ETWTLOOrgQS+kTncsWpeKdM+BF6+Cen8NptYeeV2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=epICiOHZ; arc=none smtp.client-ip=148.163.148.77
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IJiJWo3007934;
	Thu, 18 Jun 2026 20:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=1HHaaHn5yQu9aKScqAzIQ365aYrs90HhiEcf6Vr1bHI=; b=epIC
	iOHZkO9zF2nRroE9R4RjBx5FMWkM8imgUL14sIduYMr9I3PSiiqKCVvDRkdpS23r
	AeoqBMRtEBNUelG5bES4IsgzRD4nZNKRvBQ/arz6tB0xZ/cbNn1ugpA+prU7sCNf
	F8mUYsYiw32QeJ7ZEqHoMOaNbkEDcJxGQHAyxUF9m6GW5u/JY/RpmL+gPZimmGZM
	6vdUEAfXvdImsunqK4to6gGfD0XA5m0y+nZd5FO1VnBJ5FdtI9U6sp3w7L977hqD
	ncgvSSmU5bgi9U5aNYPUTiVSf0VhqxJJXLxHysMWiUuerlD2OrJ4DuYhdhionzwC
	MEf61osWG0ebUqlD5Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4evq3k87wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 20:39:33 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 18 Jun 2026 20:39:32 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>, <rostedt@goodmis.org>,
        <vmalik@redhat.com>, <jmarchan@redhat.com>,
        <martin.kelly@crowdstrike.com>
Subject: [PATCH 6.6.y 20/27] ftrace: Update the mcount_loc check of skipped entries
Date: Thu, 18 Jun 2026 16:38:58 -0400
Message-ID: <5c2b0521f89d30eca030b4f67c0483955d7af6a0.1781814148.git.andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: yhWcOqbrpFPnFsKP9ECjAYEeN4b2H3Es
X-Proofpoint-GUID: yhWcOqbrpFPnFsKP9ECjAYEeN4b2H3Es
X-Authority-Analysis: v=2.4 cv=QrVuG1yd c=1 sm=1 tr=0 ts=6a345785 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=7CQSdrXTAAAA:8 a=7d_E57ReAAAA:8 a=Z4Rwk6OoAAAA:8
 a=JfrnYn6hAAAA:8 a=cpyHj8QvAAAA:8 a=i0EeH86SAAAA:8 a=pl6vuDidAAAA:8
 a=1UX6Do5GAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=c2Yqh1CnMV39eQAqYPYA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BPjOrAZP5zzvMhA9psHf:22
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX/n6w0IL8qCCH
 S/sCYpCrOJPZJn1rkw+ZVNiJBsyWI4aAVneezTRNEoH9XLNxi/8obt+if83fZZOzRzzBfzarY3a
 EHU/M/fdIQpMb0Ciqo46MZ1CD9kYOuyG6vxuk8K06a6akFiRYt238XGRBrCC4hFlBQQCDFQZdO1
 7vJQ8IbuICZECiIdKKDBMm8C35lYC0uFG+cAHJxZOFUXT6w2rXwJHOHqmOPcMhsa6w7+9cySgV0
 vo/4KjHg2p9PpFEbakXGfllTvYVplsKernvwt1oXHIzpqoRK8V7nAhAq5sNmiYn5xt9bGteZSqJ
 LUcjcTIDgr/JpsIOrc8e8BgcCyypAfzEAGAOJKQsPONdJxpcF3gKeC62N/S/V0+pJsIrYzeJDeG
 tlVxkqyHB5KGWldUg0wchsZzbh80g/YYaBqroOLijNkQDVY7c6UIfJW03nCnd9vNbsysvxXDeBq
 FGTmiSuM0tUBMWKvjzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX35VJLz7HCE2F
 uIzHi/WcmH9sXq9jMQWI7mDpj8FuwRpgdhqPELHx0yn1MtwvMne0jwCar41eYuz9JMQtUUxkrTx
 XZN9cIo2PO+IW2pyJt9dyzV8IsC1pmyrUaDXzG5stC0BpVS48NQl
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11821
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-267256-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8BA86A29DE

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 4a3efc6baff931da9a85c6d2e42c87bd9a827399 ]

Now that weak functions turn into skipped entries, update the check to
make sure the amount that was allocated would fit both the entries that
were allocated as well as those that were skipped.

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
Link: https://lore.kernel.org/20250218200023.055162048@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/trace/ftrace.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2481613a1..ed045c296 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6632,7 +6632,28 @@ static int ftrace_process_locs(struct module *mod,
 
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
-		WARN_ON(!skipped);
+		unsigned long pg_remaining, remaining = 0;
+		unsigned long skip;
+
+		/* Count the number of entries unused and compare it to skipped. */
+		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
+
+		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
+
+			skip = skipped - pg_remaining;
+
+			for (pg = pg_unuse; pg; pg = pg->next)
+				remaining += 1 << pg->order;
+
+			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
+
+			/*
+			 * Check to see if the number of pages remaining would
+			 * just fit the number of entries skipped.
+			 */
+			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
+			     remaining, skipped);
+		}
 		/* Need to synchronize with ftrace_location_range() */
 		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
-- 
2.34.1


