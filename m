Return-Path: <stable+bounces-43204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0E28BEFB4
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 00:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5224028325F
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 22:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E453D77F2C;
	Tue,  7 May 2024 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cNK3nLHF"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBAA73163
	for <stable@vger.kernel.org>; Tue,  7 May 2024 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120319; cv=none; b=I09fjGKiS/OhKGoH6QA+LUK3qY3msWofl3Nmk5YqVijx5SnO1SBNNFCMKWdVUhg6xUL9T/a44yNuIDGYTEvYMNXzeXpoPWHYh/2uGvuAMhcDSgFkXqiuKCjAX3A7IyDll8t1ePGGcmwr6Mmt/8nB+pgBff746gPdiOkio2OycL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120319; c=relaxed/simple;
	bh=RdLO9YgFo0vg54RCpkV16hA+eMpW91LE8pTHroSk6D0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jvTYXtDOdqbO9E8dMMu3if7hD2tN3edVS4TvooXE23En2Uv5o2RgvK7iPDZfqY3C5JbK3QjaZCurz4LGk8zwBS+zLysAPDMwlIryOqlpMrRhIJjjRoaQ/CeQdL8+V3QS9E6SDYjdRwp+/I/aT3sTWPEe+uyTrSuf7lSzptYUbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cNK3nLHF; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715120318; x=1746656318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sYk5H6VzVkkEDqxLAMB/cUl3D4BlpKdRtNA5zg0DrSU=;
  b=cNK3nLHFlnRc26nKymWdKJ2nAKlmBIYu52G6zrXgQej0sn3au8Lqog3i
   WJXfquSr4Xhb9045QVj/aVvRTEkhfXsdU/blfvbEn815rv8/xjjmV51zM
   XlJPp4aeImqjV3+kZ/UL2MJmRO55iSMGpwV6qLAiqTh4JOu5qcTSEc/lA
   4=;
X-IronPort-AV: E=Sophos;i="6.08,143,1712620800"; 
   d="scan'208";a="203766510"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 22:18:37 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:46060]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.103:2525] with esmtp (Farcaster)
 id 1b5481f1-8cbf-4ebf-ae30-9c7f0fae9c8e; Tue, 7 May 2024 22:18:36 +0000 (UTC)
X-Farcaster-Flow-ID: 1b5481f1-8cbf-4ebf-ae30-9c7f0fae9c8e
Received: from EX19D046UWB004.ant.amazon.com (10.13.139.164) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:18:32 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by EX19D046UWB004.ant.amazon.com (10.13.139.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:18:32 +0000
From: Shaoying Xu <shaoyi@amazon.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <shaoyi@amazon.com>, <sd@queasysnail.net>, <kuba@kernel.org>
Subject: [PATCH 5.15 0/5] Backport CVE-2024-26583 and CVE-2024-26584 fixes
Date: Tue, 7 May 2024 22:18:01 +0000
Message-ID: <20240507221806.30480-1-shaoyi@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D046UWB004.ant.amazon.com (10.13.139.164)

Backport fix commit ("tls: fix race between async notify and socket close") for CVE-2024-26583 [1].
It's dependent on three tls commits being used to simplify and factor out async waiting.
They also benefit backporting fix commit ("net: tls: handle backlogging of crypto requests")
for CVE-2024-26584 [2]. Therefore, add them for clean backport:

Jakub Kicinski (4):
  tls: rx: simplify async wait
  net: tls: factor out tls_*crypt_async_wait()
  tls: fix race between async notify and socket close
  net: tls: handle backlogging of crypto requests

Sabrina Dubroca (1):
  tls: extract context alloc/initialization out of tls_set_sw_offload

Please review and consider applying these patches.

[1] https://lore.kernel.org/all/2024022146-traction-unjustly-f451@gregkh/
[2] https://lore.kernel.org/all/2024022148-showpiece-yanking-107c@gregkh/

 include/net/tls.h |   6 --
 net/tls/tls_sw.c  | 199 ++++++++++++++++++++++++----------------------
 2 files changed, 106 insertions(+), 99 deletions(-)

-- 
2.40.1


