Return-Path: <stable+bounces-126961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1974CA75085
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 19:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE89B176435
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 18:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B621DE3B3;
	Fri, 28 Mar 2025 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oa6+IPTx"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AF222094
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743187583; cv=none; b=HkpNQGGIx3U2mJpUi+JRunQfJsjqZSwCwww85B6d69IzINhF4KyV4fftEAFevXJmxmBCkMGcMmnS71Eydyri5iKa3nFIDnwOfw9mw54JQ4BtAaRrreuQMNdrKZ2Gg8/zoa9JzecgbCBD88unjcGg9vt/oL0D1XJNL72uw/ahT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743187583; c=relaxed/simple;
	bh=P1Q3XMje0NUvkabdcM7lRASwTClU8d5c7ikT4F3TYpw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IcNZ/9XqtFTUt53YHJgqxFhRdeqOqAH6zN1MCOD/f87fCXcOaNGpwbKFvHD6Sfw+nqkMfoHCoao+1EjOFKT47JM0sZ8LYslQKdpH9LZ3f3RlDIUTmWpHvP8W5+OYTLlK+y2ds6eYnDampIxzm3GvLq84Egw1Gkr0/UbOdgV4k2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oa6+IPTx; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743187582; x=1774723582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P1Q3XMje0NUvkabdcM7lRASwTClU8d5c7ikT4F3TYpw=;
  b=oa6+IPTxOW6W0bipgB/IEUwTo1U5+subKCmvOXmHK6gxnewOCb9xRXSC
   nAaRvEK/l8dHXTA1odigsY51az1V7vC3G7ckQWbh1F7eU+pAejaIi9gWU
   w0gMHjfgSwYG3EequPQsc2rqBN33+eYGm4iZB6ajHtpO7N9aEA0/AiO0x
   c=;
X-IronPort-AV: E=Sophos;i="6.14,284,1736812800"; 
   d="scan'208";a="182859140"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 18:46:21 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:38860]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.254:2525] with esmtp (Farcaster)
 id 2db5a3b5-6862-49b8-a00d-bb3341a230f3; Fri, 28 Mar 2025 18:46:21 +0000 (UTC)
X-Farcaster-Flow-ID: 2db5a3b5-6862-49b8-a00d-bb3341a230f3
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Mar 2025 18:46:21 +0000
Received: from u14c311f44f1758.ant.amazon.com (10.187.171.24) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Mar 2025 18:46:21 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <stable@vger.kernel.org>
CC: <keescook@chromium.org>, <yangyj.ee@gmail.com>
Subject: Request to cherry-pick a few ARM mm fixes
Date: Fri, 28 Mar 2025 11:46:09 -0700
Message-ID: <20250328184609.751984-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)

Hello stable maintainers,

The following mainline commits fix a certain stack unwinding issue on ARM,
which had existed till v6.9. Could you please cherry-pick them for 5.4.y -
6.6.y?

 169f9102f919 ("ARM: 9350/1: fault: Implement copy_from_kernel_nofault_allowed()")
 8f09b8b4fa58 ("ARM: 9351/1: fault: Add "cut here" line for prefetch aborts")
 3ccea4784fdd ("ARM: Remove address checking for MMUless devices")

Confirmed these cleanly apply and build in all the branches.


Thanks,
Munehisa

