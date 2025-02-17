Return-Path: <stable+bounces-116629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9DEA38F51
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 23:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2E71727AE
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 22:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCBE1A83E2;
	Mon, 17 Feb 2025 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="U9kwVmZR"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735381A5B9D
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739832867; cv=none; b=IMnNbqbD3C60sZC+fdBhqrBwyjca/WAHwNyU1muT9a3Vq+b+9hyXzgcniFO6AE/fV1llEJvMNWs4zZ7Ps946qFUpSyABoZEEgxj1KP8Mua4atss/unR6sUA3tDUl12GHGOwJxCey3/9ZHTFOQFgt7FeVNA2SVAp4h0VYMfpDPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739832867; c=relaxed/simple;
	bh=XyQMds23xtWJ7/f7tXZbSYvQTVYBe2H4RDME7csQWt4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VnqVrObww749VqULk7BEaTPTrqrdnqQnFuEVPf7sp0shT1to9RnddqDiBhvYgNIQHM6bnjQj2KxPrqzJfDTfnQixdA78aAX+gUQ+BgSNLwyIePIRYGZcv5WSFF87qETsOxnJOYxUW3dfSo22XC3cCWJcT/edjKT4mNjuRSGKn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=U9kwVmZR; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739832866; x=1771368866;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k7Hb7ZFSDiD+1g4jauYnyjoLg5ylmUkIgS6UZobxAKM=;
  b=U9kwVmZRVw81d70WY5tG2cQZS3ypLoMPjuTBaowxRes3yOgyROjK5Ycr
   lPooD127xvljd9ISh49vavCVut9yTm01nI8//kjGXz8r0HCyZWCeqBK7K
   hAGDB257bQVz/NXmuk67Dxz84gDiQ9HymFCACM1SaD10IX7zarkkpBG11
   k=;
X-IronPort-AV: E=Sophos;i="6.13,294,1732579200"; 
   d="scan'208";a="697926859"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 22:54:25 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:20290]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.181:2525] with esmtp (Farcaster)
 id 9292f06d-8a5c-4808-bc66-dec9662aaa23; Mon, 17 Feb 2025 22:54:23 +0000 (UTC)
X-Farcaster-Flow-ID: 9292f06d-8a5c-4808-bc66-dec9662aaa23
Received: from EX19D004UWB002.ant.amazon.com (10.13.138.45) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 22:54:23 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D004UWB002.ant.amazon.com (10.13.138.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 22:54:23 +0000
Received: from email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Mon, 17 Feb 2025 22:54:22 +0000
Received: from dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com (dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com [10.189.199.127])
	by email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com (Postfix) with ESMTP id 45A58406E0;
	Mon, 17 Feb 2025 22:54:22 +0000 (UTC)
Received: by dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com (Postfix, from userid 30684173)
	id 403E84F37; Mon, 17 Feb 2025 22:54:22 +0000 (UTC)
From: jaywang-amazon <wanjay@amazon.com>
To: <stable@vger.kernel.org>
CC: <wanjay@amazon.com>
Subject: [PATCH 6.1 0/1] Backport upstream commit 70e6b7d9ae3c63df90a7bba7700e8d5c300c3c60 to stable 6.1
Date: Mon, 17 Feb 2025 22:53:53 +0000
Message-ID: <20250217225353.21795-2-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Backport upstream commit 70e6b7d9ae3c63df90a7bba7700e8d5c300c3c60 to stable 6.1

David Woodhouse (1):
  x86/i8253: Disable PIT timer 0 when not in use

 arch/x86/kernel/i8253.c     | 11 +++++++++--
 drivers/clocksource/i8253.c | 13 +++++++++----
 include/linux/i8253.h       |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.47.1


