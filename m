Return-Path: <stable+bounces-264081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kp26MXZuMWqojAUAu9opvQ
	(envelope-from <stable+bounces-264081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:40:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73724691459
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:40:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=k4ZvDgqL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264081-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264081-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CE8E303988E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4913544103D;
	Tue, 16 Jun 2026 15:33:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158CC357D14;
	Tue, 16 Jun 2026 15:33:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624026; cv=none; b=iOebUNmTbfnGbBEdQBg+CqRaJK0tZTliitdGEMNUlXsybQiWjjW+mcSnUoyf0NZoAeIXqYkLziPnFVzQYdkZENR8JxUEKkJIRxdvHlrGt2DnMsM5eWVtX/sAsTVqDFOuxyLlVKGu8yscnb+fQhpsjkEmmDaqTfMzE1KgTnY/r9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624026; c=relaxed/simple;
	bh=3Wl7aw1NMhBSn+S0QfdHQ4jSCuj0jhyvxIr25ghK2SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSyZRWMmkYYrE1cS5LPaKwDipIs8vtu3nuSgiuq+v8fz9GgzaWpfvdWF1Gxi3GSj9KshjG6Lg4XcFkizXdMWxZJfagthM0FMMd6PVJNTd1GNdwZzFyFDv7eivcy5RI4NtzwXVIdIXKIk5qrfxAA/cdyRb/xR2lLzVK44z46dTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k4ZvDgqL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2570C1F000E9;
	Tue, 16 Jun 2026 15:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624025;
	bh=a9mnk0o5gOghuskrYkxkrLnfY/5lVOxbo64dMuSfa3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k4ZvDgqLr46TfeeEXiiBSjAFCpHLN5/8aDPIjb/6THlLewoVrPtVk2phbq0sJO7eb
	 FiUe+lqiJWyRk34tuKjI2j2dQL02oFpyYJ8fr6sGJaiJSUotfluq4Qv0MSd/h2iYJD
	 MjqiTKzQhMPshANmrUgmGiO58AY7BpQxHnjqTGzM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 7.0 258/378] s390: Remove GENERIC_LOCKBREAK Kconfig option
Date: Tue, 16 Jun 2026 20:28:09 +0530
Message-ID: <20260616145123.693127672@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264081-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:massimiliano.pellizzer@canonical.com,m:svens@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,canonical.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73724691459

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <hca@linux.ibm.com>

commit 1f57f68c4dd101e5e8ffc9ffa6428f45bcdd776a upstream.

s390 selects GENERIC_LOCKBREAK if PREEMPT is enabled. Reason is a historic
18 years old commit [1] which fixed a compile error for PREEMPT enabled
kernels. Back than only PREEMPT_NONE and PREEMPT_VOLUNTARY kernels were
considered to be important for s390. PREEMPT should "just work".

However, since recently PREEMPT is always enabled [2], which also causes
GENERIC_LOCKBREAK to be always enabled. For some workloads this leads to
massive performance degradation; e.g. a simple kernel compile on machines
with many CPUs may take up to four times longer.

To fix this just remove the GENERIC_LOCKBREAK from s390's Kconfig, since
the compile error from 18 years ago does not exist anymore.

[1] commit b6b40c532a36 ("[S390] Define GENERIC_LOCKBREAK.")
[2] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")

Cc: stable@vger.kernel.org
Reported-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/Kconfig |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -29,9 +29,6 @@ config GENERIC_BUG
 config GENERIC_BUG_RELATIVE_POINTERS
 	def_bool y
 
-config GENERIC_LOCKBREAK
-	def_bool y if PREEMPTION
-
 config AUDIT_ARCH
 	def_bool y
 



