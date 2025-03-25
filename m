Return-Path: <stable+bounces-126003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE7FA6ED83
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB17F3AF827
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 10:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9261EBFE2;
	Tue, 25 Mar 2025 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="FYNKqZPL"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A91EA7CD
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898297; cv=none; b=MAL2Ex76fmQbqH7E/q7x0xzg6iR1QYInxQqjmiSiC48SAu4sAcO1jDy+xCuQPgNtwvL4kJEIOTIBoZ6JNkCQfuRtt1FiCyO0Eu3uArhB5fPT7W23kCrh1ZifqNJNwO+/Lu1QxuZz6BOVyoOU14YTr+nzcA71cYRyD9E4JsJ/eQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898297; c=relaxed/simple;
	bh=z+c8zELSrHp64t09GyCDgXuXyc4d7V+DwrevJ04pFik=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gJz3smki8ewHgt+BQBGmteiDBBCDFwhHrFg+Vbd7lNep31bEX2cikLLWKWDEYp/3MFaJrFj632RYh+/qfr9EbzBmcrrv5vwiWSKuzp4pcQiwCS68/VtVHmbYUhdbL2Jwp6ja0f5qykseQ1gxQ8k5oYU09MXe/sT7kjvW8bOaV/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=FYNKqZPL; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1742898296; x=1774434296;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=f8H/YRU3zx591aQycj/3pVhlY+IjvDM6UVse4mwe5O4=;
  b=FYNKqZPLvFUVgK3h7VO6vE/b1lU+yKVh9+OLQb2QoLA9W3iON0w4tZWB
   XBOTjZGeFePa48CJA/N6fYr2gOUC77ZXMgP6EBY0a3ZoN1Cz3c+YbWymo
   3FK7UoU0iV//YZAmxlUFNlBdo0btkZDS/6kD4LGbZstPs1tIy9Ur9wVl9
   k=;
X-IronPort-AV: E=Sophos;i="6.14,274,1736812800"; 
   d="scan'208";a="474128744"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 10:24:51 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:30922]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.139:2525] with esmtp (Farcaster)
 id adf60b02-6bf7-47f2-a9c5-21e053e71723; Tue, 25 Mar 2025 10:24:49 +0000 (UTC)
X-Farcaster-Flow-ID: adf60b02-6bf7-47f2-a9c5-21e053e71723
Received: from EX19D019EUB002.ant.amazon.com (10.252.51.33) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 10:24:41 +0000
Received: from EX19D019EUB003.ant.amazon.com (10.252.51.50) by
 EX19D019EUB002.ant.amazon.com (10.252.51.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 10:24:41 +0000
Received: from EX19D019EUB003.ant.amazon.com ([fe80::531b:a721:1f0c:7896]) by
 EX19D019EUB003.ant.amazon.com ([fe80::531b:a721:1f0c:7896%3]) with mapi id
 15.02.1544.014; Tue, 25 Mar 2025 10:24:41 +0000
From: "Acs, Jakub" <acsjakub@amazon.de>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "Acs, Jakub" <acsjakub@amazon.de>, Hagar Hemdan <hagarhem@amazon.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 6.1] block, bfq: fix re-introduced UAF in bic_set_bfqq()
Thread-Topic: [PATCH 6.1] block, bfq: fix re-introduced UAF in bic_set_bfqq()
Thread-Index: AQHbnXAe8vbn5GzlZEaO8KyHerbMYQ==
Date: Tue, 25 Mar 2025 10:24:41 +0000
Message-ID: <20250325102409.50587-1-acsjakub@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Commit eca0025faa96ac ("block, bfq: split sync bfq_queues on a=0A=
per-actuator basis"), which is a backport of 9778369a2d6c5e ("block,=0A=
bfq: split sync bfq_queues on a per-actuator basis") re-introduces UAF=0A=
bug originally fixed by b600de2d7d3a16 ("block, bfq: fix uaf for bfqq in=0A=
bic_set_bfqq()") and backported to 6.1 in cb1876fc33af26 ("block, bfq:=0A=
fix uaf for bfqq in bic_set_bfqq()").=0A=
=0A=
bfq_release_process_ref() may release the sync_bfqq variable, which=0A=
points to the same bfqq as bic->bfqq member for call context from=0A=
__bfq_bic_change_cgroup(). bic_set_bfqq() then accesses bic->bfqq member=0A=
which leads to the UAF condition.=0A=
=0A=
Fix this by bringing the incriminated function calls back in correct=0A=
order.=0A=
=0A=
Fixes: eca0025faa96ac ("block, bfq: split sync bfq_queues on a per-actuator=
 basis")=0A=
Signed-off-by: Jakub Acs <acsjakub@amazon.de>=0A=
Cc: Hagar Hemdan <hagarhem@amazon.com>=0A=
Cc: stable@vger.kernel.org=0A=
---=0A=
 block/bfq-cgroup.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c=0A=
index 5d202b775beb..c202e2527d05 100644=0A=
--- a/block/bfq-cgroup.c=0A=
+++ b/block/bfq-cgroup.c=0A=
@@ -739,8 +739,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,=
=0A=
 		 * old cgroup.=0A=
 		 */=0A=
 		bfq_put_cooperator(sync_bfqq);=0A=
-		bfq_release_process_ref(bfqd, sync_bfqq);=0A=
 		bic_set_bfqq(bic, NULL, true, act_idx);=0A=
+		bfq_release_process_ref(bfqd, sync_bfqq);=0A=
 	}=0A=
 }=0A=
 =0A=
-- =0A=
2.47.1=0A=
=0A=

