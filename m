Return-Path: <stable+bounces-224865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP9XIJHHsmmvPAAAu9opvQ
	(envelope-from <stable+bounces-224865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:02:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2145273096
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52D423033018
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBB4330D23;
	Thu, 12 Mar 2026 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="DVNh16BF"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862D26C39F;
	Thu, 12 Mar 2026 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324161; cv=none; b=Tf7b/VqAPKXFMxwSepQ03r5LgYjbxtLjo93ZBv3m7HM6gKkY4WpnRTFYLTdq1AziPdmzSwoFJwneef4TIixRnRO37roFo8td6ZHfqq0/IDG+vVVPXM1ZslQ1rqlS1ZBmS7XErpFNZziXuFGs0yUmrGzWrCLFQoWWs2zh3fPvIHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324161; c=relaxed/simple;
	bh=3WYr+Re55T3p4HqSytdw71kyF3xT6CBChoz9wlh43Gk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zj02YupDlg84GkAPsW/Z2PD6ijPzeKNSWSQ9948Gwd5SzDrez69enQDqK5FekB5XvzNiFWXSt7SA/m3JHix7gP+roQMT/za6H+9qLCSeGYnOgDrVpYPOTe42wy6tw1d9Bvm6fPnOBA0Clvr73bom77KKYToRERjGxbsmQogoSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=DVNh16BF; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1773324160; x=1804860160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z88ZjHbOlzZ7FYVKHq35z1eRrA3S/yEFf/EQ/7zqy3g=;
  b=DVNh16BFjrqmh0XVXVw4nz38JAzGWEMtZ/5bE/aipIPPSPAo5hnD3Uab
   mcxM8GRJqc4rOesRzRYz7tYiAr97804iE+iVn+v0mwYHbcsSkZtRHhjk+
   xy4XZQl2nAawRFzmH48mWqzs91RcdXGa5R1AfwHcQBMibzvuBf8PU3EcQ
   GiSQfA5JP83xws17WBamwNf077MBbM+wwY1LP1anX5nRPGO6yijy48JRZ
   GeUj3cUL7pjfFD536QHwG0OS6No+IWPRhS1JIwCvSfgkXPR8ntbf3bbWG
   i/F0KnMi0RHnGSWQmghqFBdnp6076J8S6iMSCyWDEiqUAmQAU0Z5XHCNI
   w==;
X-CSE-ConnectionGUID: 8eVhSjFDQtSPSJOAACXRwQ==
X-CSE-MsgGUID: eQi/addtTp+d0chr3oH+VA==
X-IronPort-AV: E=Sophos;i="6.23,116,1770595200"; 
   d="scan'208";a="14882243"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:02:39 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:5375]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.67:2525] with esmtp (Farcaster)
 id 950a3c73-c8d8-4a41-92b0-93b576cf15e8; Thu, 12 Mar 2026 14:02:39 +0000 (UTC)
X-Farcaster-Flow-ID: 950a3c73-c8d8-4a41-92b0-93b576cf15e8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 12 Mar 2026 14:02:39 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 12 Mar 2026
 14:02:37 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Shuah Khan <shuah@kernel.org>, Simon Liebold <lieboldsimonpaul@gmail.com>,
	SeongJae Park <sj@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Simon Liebold <simonlie@amazon.de>, <stable@vger.kernel.org>
Subject: [PATCH] selftests/mqueue: Fix incorrectly named file
Date: Thu, 12 Mar 2026 14:02:00 +0000
Message-ID: <20260312140200.2224850-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224865-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:dkim,amazon.de:email,amazon.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simonlie@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A2145273096
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 85506aca2eb4 ("selftests/mqueue: Set timeout to 180 seconds")
intended to increase the timeout for mq_perf_tests from the default
kselftest limit of 45 seconds to 180 seconds.

Unfortunately, the file storing this information was incorrectly named
`setting` instead of `settings`, causing the kselftest runner not to
pick up the limit and keep using the default 45 seconds limit.

Fix this by renaming it to `settings` to ensure that the kselftest
runner uses the increased timeout of 180 seconds for this test.

Fixes: 85506aca2eb4 ("selftests/mqueue: Set timeout to 180 seconds")
Cc: <stable@vger.kernel.org> # 5.10.y
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 tools/testing/selftests/mqueue/{setting => settings} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tools/testing/selftests/mqueue/{setting => settings} (100%)

diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/settings
similarity index 100%
rename from tools/testing/selftests/mqueue/setting
rename to tools/testing/selftests/mqueue/settings

base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


