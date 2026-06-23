Return-Path: <stable+bounces-267965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 49A0MbqnOmo7CwgAu9opvQ
	(envelope-from <stable+bounces-267965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 17:35:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0186B8542
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 17:35:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=DzVafJmD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267965-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267965-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 878283022D19
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC22C2DF3D1;
	Tue, 23 Jun 2026 15:35:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454552C3268;
	Tue, 23 Jun 2026 15:35:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228910; cv=none; b=BB/BJ3V7fk3oTHrnxlwdDHGdQIsSS5QpT+/fXpZyTeD4dO6ckTF/mcOwy8HA1fe1IBkeGy6mzNkQUzN8zsw5u08op+GIgGQzQo0vhvUDb91Dd25p6Cv2jDWluow3uWhl7pDlr/q9qZZ5RVwgtpyYN7aKkZKMOUmPCYAzJ43UK9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228910; c=relaxed/simple;
	bh=mLTuFzzMVDKELXF1rAT/Mbx9fVbGLqpC5NH2pZ1ytkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5Zvh8rAq033nEJPngUDB4o3SJkucFkrOl9Y9SBM9fYtVMfXeL8tSDU88Ik2zet5rVDhLMYfBbtD6gABe9KWaW8zbY34KqMkEMrROLPv3SRPm4Px+QAZb/Md37EK/IaG7/nM6o8X3MMy7EosynZEXaChq+IhMjG7pPfTsHJu29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=DzVafJmD; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782228907;
	bh=Gx2pxVFTVh6CiezPzsu7vQ1YDNEI7j7XBUAxmNRT16M=;
	h=From:To:Cc:Subject:Date:From;
	b=DzVafJmDrIL2Ee0agTEXJ/yol2TdqjBOjmeM80UFaT3xcqRDsatfgEpNhiACGNcsu
	 mdwRzS/igrFv4kKvVQSECmZ+HdckiXhaEuokSSf1/xYiuC4ig8AdC6/YRCN/VqknAO
	 Fl1zQpg2i215l2vwuD2p+Ak8oJd9e1n9ttff1Wkk=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gl8Jq3zc3z10x8;
	Tue, 23 Jun 2026 15:35:07 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gl8Jp2CN3z10xZ;
	Tue, 23 Jun 2026 15:35:06 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>,
	Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v2 1/4] sys_info: add helper for callers that handle all_bt
Date: Tue, 23 Jun 2026 15:34:58 +0000
Message-ID: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267965-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,linux.intel.com,mobileye.com,suse.com,chromium.org,google.com,lists.ozlabs.org,vger.kernel.org,grrlz.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pmladek@suse.com,m:feng.tang@linux.alibaba.com,m:akpm@linux-foundation.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mchauras@linux.ibm.com,m:andriy.shevchenko@linux.intel.com,m:wangjinchao600@gmail.com,m:kees@kernel.org,m:rioo.tsukatsukii@gmail.com,m:joel.granados@kernel.org,m:pnina.feder@mobileye.com,m:petr.pavlu@suse.com,m:senozhatsky@chromium.org,m:dianders@chromium.org,m:mrungta@google.com,m:tj@kernel.org,m:yaozhenguo1@gmail.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:include@grrlz.net,m:riootsukatsukii@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF0186B8542

Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
Add a helper that strips that bit without turning an all_bt only mask into
a kernel_sys_info fallback.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes since v1:
- New patch for the shared helper suggested by Petr.

 include/linux/sys_info.h |  1 +
 lib/sys_info.c           | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
index a5bc3ea3d44b..87a841ec7b6a 100644
--- a/include/linux/sys_info.h
+++ b/include/linux/sys_info.h
@@ -18,6 +18,7 @@
 #define SYS_INFO_BLOCKED_TASKS		0x00000080
 
 void sys_info(unsigned long si_mask);
+void sys_info_without_all_bt(unsigned long si_mask);
 unsigned long sys_info_parse_param(char *str);
 
 #ifdef CONFIG_SYSCTL
diff --git a/lib/sys_info.c b/lib/sys_info.c
index f32a06ec9ed4..6afd4c697633 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -164,3 +164,18 @@ void sys_info(unsigned long si_mask)
 {
 	__sys_info(si_mask ? : kernel_si_mask);
 }
+
+void sys_info_without_all_bt(unsigned long si_mask)
+{
+	unsigned long dump_mask = si_mask & ~SYS_INFO_ALL_BT;
+
+	/*
+	 * Do not call sys_info() when the caller context required only
+	 * backtraces from all CPUs. Otherwise sys_info() would fall back
+	 * to the generic kernel_si_mask.
+	 */
+	if (si_mask && !dump_mask)
+		return;
+
+	sys_info(dump_mask);
+}
-- 
2.53.0

