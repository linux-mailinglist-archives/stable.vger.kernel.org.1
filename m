Return-Path: <stable+bounces-256764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHq5J/fyGWp10AgAu9opvQ
	(envelope-from <stable+bounces-256764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 22:11:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8353A6084D6
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 22:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92A063083C4D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E80C3A6F09;
	Fri, 29 May 2026 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Ks8XCAmi"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F373382C7;
	Fri, 29 May 2026 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085051; cv=none; b=hlE//RKz3xsezKlBGyvgk4zWkzCRyQr5r8z61WxT9uehFDXalRyGJeGCX+ajTSqoTmy172HXSBymFy0Ob+QJ/xVKXYjjXbTHF48diBiFaXAbEXj6Bj21scW7Pl+CMSCHmGSnWaLAAJIBIj161yfl6nck9Di1/D3guWWSYz/Jbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085051; c=relaxed/simple;
	bh=zGw+kIvSx41Cdv3aLqZU53FgvvEH4b7LmIt2nGC1v+M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HSGvqYwYwkxp/UC4hQrW1IXsOPdeCf+t+m0SfpcAJxBfNB8u1/vL2alE8x11QQqm9ovW4If+5kKh4JYTdOMuTjOgiNpbJsdgrSMVfBkgsqDRfQodLt0+7zHc3xpkgLKwYSQmZSkHIEMyOXSi+sEqNeWKvsRn1aSLhd69cR3YjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Ks8XCAmi; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1780085050; x=1811621050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q1or6XUc2xvLIFww3vzaG2BUmcXyxmaO3nDz0H1yzeg=;
  b=Ks8XCAmilBqVbnK+YancEagsrAwJU2ks2bG+pD/fjyAXNxJyb/IV8Et4
   6cui6BCb9C4/nCXv+gDtDu2H0VeRriV+28C79pPFU4Fo+N6iRFsbRE6o6
   x1xLJ+RFwnmdsFgaYDJWFzv7iOtAM4FINzQYbhwRro2falpGMa8y/8qvE
   eQFdlIKjAm63AaF+m2Iwp/qe5LB25pnVa1CWUBmttyq/vCToPPmBpA0bF
   5nVvE9xoxRU0fSoRb2P6El30IR5rgqST/Mg6OBP7CflA2HXPq5CvkumlF
   v+GeI/ZnPxcSE24MGvuilWCvHANB2YvfuckYFB/Z1o0iKgdZhB2SBN/33
   Q==;
X-CSE-ConnectionGUID: eBDACEm+TCyS8LJNrRXPpg==
X-CSE-MsgGUID: XXJFaV0SQsmK+LdFZHNp5g==
X-IronPort-AV: E=Sophos;i="6.24,176,1774310400"; 
   d="scan'208";a="20729283"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 20:04:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:13799]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.88:2525] with esmtp (Farcaster)
 id 3ae9febb-b541-41a9-b367-03e1c4ec2983; Fri, 29 May 2026 20:04:06 +0000 (UTC)
X-Farcaster-Flow-ID: 3ae9febb-b541-41a9-b367-03e1c4ec2983
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 29 May 2026 20:04:06 +0000
Received: from dev-dsk-mheyne-1b-8cc83676.eu-west-1.amazon.com (10.13.235.223)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 29 May 2026 20:04:04 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: <stable@vger.kernel.org>
CC: Maximilian Heyne <mheyne@amazon.de>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Shuah Khan
	<shuah@kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] selftests/landlock: explicitly disable audit
Date: Fri, 29 May 2026 20:03:41 +0000
Message-ID: <20260529-welsh-nagoya-b4d9ca60@mheyne-amazon>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256764-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:email,amazon.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mheyne@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8353A6084D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm seeing sporadic selftest failures, such as

  #  RUN           scoped_audit.connect_to_child ...
  # scoped_abstract_unix_test.c:314:connect_to_child:Expected 0 (0) == records.access (8)
  # connect_to_child: Test failed
  #          FAIL  scoped_audit.connect_to_child
  not ok 19 scoped_audit.connect_to_child

This seems similar to what commit 3647a4977fb73d ("selftests/landlock:
Drain stale audit records on init") tried to fix. However, the added
drain loop is not effective. When setting the AUDIT_STATUS_PID, the
kauditd_thread is woken up starting to send messages from the hold queue
to the netlink. Depending on scheduling of this kthread not all messages
might be send via the netlink in the 1 us interval.

Therefore, instead of trying to drain the queue, let's just disable
audit when running non-audit tests or more precisely disable it after
audit-tests. This way we won't generate any new audit message that could
interfere with the other tests.

The comment saying that on process exit audit will be disabled is wrong.
The closed file descriptor just causes an auditd_reset(), not a
disablement. So future messages will be queued in the hold queue.

Cc: stable@vger.kernel.org
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---

I've seen the failures on the 6.18 kernels but haven't tested on latest
upstream. However, I still think this is an issue.

---
 tools/testing/selftests/landlock/audit.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 834005b2b0f09..7842330875f53 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -494,10 +494,9 @@ static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
 static int audit_cleanup(int audit_fd, struct audit_filter *filter)
 {
 	struct audit_filter new_filter;
+	int err;
 
 	if (audit_fd < 0 || !filter) {
-		int err;
-
 		/*
 		 * Simulates audit_init_with_exe_filter() when called from
 		 * FIXTURE_TEARDOWN_PARENT().
@@ -518,12 +517,10 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
 	audit_filter_exe(audit_fd, filter, AUDIT_DEL_RULE);
 	audit_filter_drop(audit_fd, AUDIT_DEL_RULE);
 
-	/*
-	 * Because audit_cleanup() might not be called by the test auditd
-	 * process, it might not be possible to explicitly set it.  Anyway,
-	 * AUDIT_STATUS_ENABLED will implicitly be set to 0 when the auditd
-	 * process will exit.
-	 */
+	err = audit_set_status(audit_fd, AUDIT_STATUS_ENABLED, 0);
+	if (err)
+		return err;
+
 	return close(audit_fd);
 }
 
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


