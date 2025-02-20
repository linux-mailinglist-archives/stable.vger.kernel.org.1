Return-Path: <stable+bounces-118400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D388AA3D4D3
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 10:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0097F188EE48
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992F71E04AE;
	Thu, 20 Feb 2025 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oNGhOWdS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039EB1AF4E9
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043943; cv=none; b=Zxntqhp0LKxh97R0cucTy9EGeX6B3qU/GQFe5bQP1l9YvG6Y9deI3wxlXJ+1Za1fWLkQzd/p14uM7tx4gah1E+RqsXK+Al7x9p0flcbxFYBQDBlJ756gGZkbt8puiMFAOfNaXKh58S2J2sqXJvTXqZicBFrA4R1z6lptg/1oQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043943; c=relaxed/simple;
	bh=G/NpxWFnGuuVYOPgtzAud7ObNtveoqAoyfEHgE0Lblo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9scplhfidvteBK2IKEb/yqu5t4t6CFab7lkfV5BxepPXneFirqS9PniAZhKPB7HLi4l40Ex2a3aVPoOF02kkrHiazT41SuaZYfSTUhbI+bRW5S7I9ZW6eXijKAXBKemlG+MY6t5dwYalNyJH2P7bH/fMn9pt9LtA7hbbBaq6E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oNGhOWdS; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740043942; x=1771579942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhOAwu5x55FT3q2ps5ltDsRHzYr9CkV4P5yNC9l1hMM=;
  b=oNGhOWdS2Cs2kDKghc3MztAMKgqvHVzegzyoNajkVb0fIx5YqyTC7Y1W
   kuWqJ7ruvEGz9vGHHPJ75+dnZRwWXNYRRTmHSh41sLazAmxCjkiIn/f++
   iA/Zu/a3UwjkyG71in8FinF7yzGr9GD5dTp+8eBYhn+rIC3C7y9YnJn0S
   E=;
X-IronPort-AV: E=Sophos;i="6.13,301,1732579200"; 
   d="scan'208";a="410164144"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:32:21 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:23710]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.115:2525] with esmtp (Farcaster)
 id d39a1876-e05b-4e87-a0b2-d95a28efd138; Thu, 20 Feb 2025 09:32:20 +0000 (UTC)
X-Farcaster-Flow-ID: d39a1876-e05b-4e87-a0b2-d95a28efd138
Received: from EX19D004UWB004.ant.amazon.com (10.13.138.108) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 20 Feb 2025 09:32:17 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D004UWB004.ant.amazon.com (10.13.138.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 20 Feb 2025 09:32:16 +0000
Received: from email-imr-corp-prod-iad-all-1b-8410187a.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Thu, 20 Feb 2025 09:32:16 +0000
Received: from dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com (dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com [10.189.199.127])
	by email-imr-corp-prod-iad-all-1b-8410187a.us-east-1.amazon.com (Postfix) with ESMTP id A5A9040884;
	Thu, 20 Feb 2025 09:32:16 +0000 (UTC)
Received: by dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com (Postfix, from userid 30684173)
	id 69E92504F; Thu, 20 Feb 2025 09:32:16 +0000 (UTC)
From: Jay Wang <wanjay@amazon.com>
To: <stable@vger.kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>, Jay Wang <wanjay@amazon.com>
Subject: [PATCH v1 v5.10/v5.15/v6.1/v6.6] Please also incorporate this patch into 6.6.y
Date: Thu, 20 Feb 2025 09:32:11 +0000
Message-ID: <20250220093215.15211-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025021959-headfirst-dayroom-c1bc@gregkh>
References: <2025021959-headfirst-dayroom-c1bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

commit 70e6b7d9ae3c63df90a7bba7700e8d5c300c3c60 upstream

Jay Wang (1):
  x86/i8253: Disable PIT timer 0 when not in use

 arch/x86/kernel/i8253.c     | 11 +++++++++--
 drivers/clocksource/i8253.c | 13 +++++++++----
 include/linux/i8253.h       |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.47.1


