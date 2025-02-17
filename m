Return-Path: <stable+bounces-116624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C9EA38DE2
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 22:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B153C188CDC7
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 21:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5705523906A;
	Mon, 17 Feb 2025 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UP9c4bOg"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69123875A
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739826734; cv=none; b=fHZ6Tp391ltF5Jbl4Pc3oEnTOvcHA1z/UiBBnFMR9SYoGhr2Xc8Bvc77igqMPiMWw5P7SFGX0zpFaZZgUUtHOaDvOZCw0CAzA5B/sRz+kwgmkaorRPl9nrWhtgYeMSFw7y57coxXcU7hbOzYIBl19UmwG90+QU/eiA6WgeStW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739826734; c=relaxed/simple;
	bh=QwndMUsO4GNXBb3bxOgD/COilQuc90WR1dWxyatanII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a6QPFuZYF9Nx0bihwiD04m5VF+2AEjYkDb0h7pxAF9RkWwIyjMQnSygCwsS3/+KP0w7/dxrr1T6Aa1DrN4r4EuZ0IpRXncgOOHi5CivRmRtxITiQC5nRlQyKIyxKhg/rpiCnuKIlaR8roppW+LLniHd0I7GbpU0QaE1cHHxWbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UP9c4bOg; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739826733; x=1771362733;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3WNQurpTGeJMyp3SUbjxvPVlkXXNj/S/csLlyg6W9TE=;
  b=UP9c4bOg98kdxx+uOZw5KX+A3Uf+dznmtxaoEWZAkjhBNLxBqZ4KUeHJ
   SHp9XeFl/PPiQqrYgzrl0lEoUexvWISbcgdVzA0aCr+j+XPZgtrAl6Soj
   BVgXPxjbYVgqFaDSdcAGphMoOLow7hhKRmwCJSdgy4EZNqPipHSOCThU6
   M=;
X-IronPort-AV: E=Sophos;i="6.13,293,1732579200"; 
   d="scan'208";a="494689240"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:12:13 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:15647]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.141:2525] with esmtp (Farcaster)
 id e46d5eb5-e5df-4b09-b6ca-1537de767895; Mon, 17 Feb 2025 21:12:11 +0000 (UTC)
X-Farcaster-Flow-ID: e46d5eb5-e5df-4b09-b6ca-1537de767895
Received: from EX19D004UWA003.ant.amazon.com (10.13.138.250) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 21:12:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D004UWA003.ant.amazon.com (10.13.138.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 21:12:02 +0000
Received: from email-imr-corp-prod-iad-all-1b-af42e9ba.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Mon, 17 Feb 2025 21:12:02 +0000
Received: from dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com (dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com [10.189.199.127])
	by email-imr-corp-prod-iad-all-1b-af42e9ba.us-east-1.amazon.com (Postfix) with ESMTP id 214A2405B0;
	Mon, 17 Feb 2025 21:12:02 +0000 (UTC)
Received: by dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com (Postfix, from userid 30684173)
	id D9FC74F03; Mon, 17 Feb 2025 21:12:01 +0000 (UTC)
From: jaywang-amazon <wanjay@amazon.com>
To: <stable@vger.kernel.org>
CC: <wanjay@amazon.com>
Subject: [PATCH 5.10 0/1] Backport upsteam fix 70e6b7d9ae3c63df90a7bba7700e8d5c300c3c60
Date: Mon, 17 Feb 2025 21:11:20 +0000
Message-ID: <20250217211120.12666-2-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Backport upstream commit 70e6b7d9ae3c63df90a7bba7700e8d5c300c3c60 to stable 5.10.

David Woodhouse (1):
  x86/i8253: Disable PIT timer 0 when not in use

 arch/x86/kernel/i8253.c     | 11 +++++++++--
 drivers/clocksource/i8253.c | 13 +++++++++----
 include/linux/i8253.h       |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.47.1


