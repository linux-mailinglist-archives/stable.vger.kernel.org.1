Return-Path: <stable+bounces-179180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB93B5127C
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 11:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 121167B2CE2
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 09:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F327313556;
	Wed, 10 Sep 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="ZhxPSqLj"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18A313544;
	Wed, 10 Sep 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496532; cv=none; b=ZE50O22Y3pZ657K3qQ9V327ZPZ2pgb1D0wbebPx0vpw4jvMtBn0Nmc8SgmX7wqajaUnJJxPtD1V1i0CN9gtOKXtrgmEjmkv2ec4w3qB3pTLLbvUzs95P5UK9ejltKZaUcR93TTzeSiqf9tjoXbFjvcHS5ww7C+7lJXzwWJH6HBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496532; c=relaxed/simple;
	bh=8M1NClmvgIt+dhiZcZXDzCJ1AB1iwZ1egz2MFeaVKyw=;
	h=From:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QTUeqEE+xCD3eEvy0ovmbGp+KNRKgdBGoS3V/GnqlpgLSBqo3N9B+YpsMfjCq98Su63QDSJzWg4Nw21Mxk/v6EJVhVolFJERS3lXn5mMFCO3lrReAYT9UoHTTlAd62jKrzt6GpUFQrgTLZG9h8d3Koey004vwPqMgXtSH4joPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=ZhxPSqLj; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1757496529; x=1789032529;
  h=from:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UYBeIk1Sgl6VARFAnYk+1Npq0eTLyrVghsS0KiRYD80=;
  b=ZhxPSqLjvcFSH7Nn25m6NEGkNESDX6JV2WbMCqIW7JBpVf88V6t6ypTu
   cpxL9Q3Mpm3xH48feges+VAZ8Iw12VjVxhcRiLJxR3T9z3c/ireBMTVKa
   BiOEL4xESeMyhlx580sNNcSfw+dQaVOIEkta9K2eKpmgBgIQ4eQIpX5FH
   Ny7DDE2HRtkjiVOuxZ3rlWLTk6XrGb4FaaS2pQujxalWnWll8y9JalupK
   nAPj1vpgkOwCXqNj0qGsO+au9OLYtamHOMVssjNw9WHn6Jwm6zZopGfVm
   Pn9Z8YbYhirV1Gtb5kIO5GwmW9WQoTneIoWmoardngyEPsO9w8xzCM41F
   A==;
X-CSE-ConnectionGUID: u/IpeAocSuWjQ6qjoMuysA==
X-CSE-MsgGUID: s0vP7LJQR2CHqKOPqmdAug==
X-IronPort-AV: E=Sophos;i="6.18,214,1751241600"; 
   d="scan'208";a="1890739"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 09:28:38 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:14793]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.16.14:2525] with esmtp (Farcaster)
 id 2040ec64-2b97-42f5-bda1-4ba39ea8b2d5; Wed, 10 Sep 2025 09:28:38 +0000 (UTC)
X-Farcaster-Flow-ID: 2040ec64-2b97-42f5-bda1-4ba39ea8b2d5
Received: from EX19D008EUC003.ant.amazon.com (10.252.51.205) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 09:28:38 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC003.ant.amazon.com (10.252.51.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 09:28:37 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.2562.020; Wed, 10 Sep 2025 09:28:37 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, "Matthieu Baerts (NGI0)"
	<matttbe@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Thomas Dreibholz <dreibh@simula.no>, Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Mat Martineau
	<mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	<matthieu.baerts@tessares.net>, "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "mptcp@lists.01.org" <mptcp@lists.01.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 5.10] mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
Thread-Topic: [PATCH 5.10] mptcp: pm: kernel: flush: do not reset ADD_ADDR
 limit
Thread-Index: AQHcIjVJBuGE8H44G0WWr6MpfYiLLg==
Date: Wed, 10 Sep 2025 09:28:37 +0000
Message-ID: <20250910-nicety-alert-0e004251@mheyne-amazon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 68fc0f4b0d25692940cdc85c68e366cae63e1757 upstream.

A flush of the MPTCP endpoints should not affect the MPTCP limits. In
other words, 'ip mptcp endpoint flush' should not change 'ip mptcp
limits'.

But it was the case: the MPTCP_PM_ATTR_RCV_ADD_ADDRS (add_addr_accepted)
limit was reset by accident. Removing the reset of this counter during a
flush fixes this issue.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reported-by: Thomas Dreibholz <dreibh@simula.no>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/579
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-2-=
521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[adjusted patch by removing WRITE_ONCE to take into account the missing
 commit 72603d207d59 ("mptcp: use WRITE_ONCE for the pernet *_max")]
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
For some reason only the corresponding selftest patch was backported and
it's now failing on 5.10 kernels. I tested that with this patch the
selftest is succeeding again.
---
 net/mptcp/pm_netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 32379fc706cac..c31a1dc69f835 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -869,7 +869,6 @@ static void __flush_addrs(struct pm_nl_pernet *pernet)
 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	pernet->add_addr_signal_max =3D 0;
-	pernet->add_addr_accept_max =3D 0;
 	pernet->local_addr_max =3D 0;
 	pernet->addrs =3D 0;
 }
-- =

2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


