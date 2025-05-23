Return-Path: <stable+bounces-146207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2F7AC2714
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 18:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352B31886FB1
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A1A221DA8;
	Fri, 23 May 2025 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="sDqt8WYT"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A08828382;
	Fri, 23 May 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016108; cv=none; b=gHim64QFX/2AVGNdtgGTGUYUeICC/n2RBhz3DC1bqLq5QT/bfoHmYJaF8i3MkvfSZoefIG0/biBTSAHYHpEIzY1O5yQDt2yNv+nkQiN9was51gM+YinVhFuecVwld0BqbILF8cXXmiAh6y//0YR6EXptyo1V3xk+nXWq3c+zOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016108; c=relaxed/simple;
	bh=X4/5x2g3r0H0D5vuqU8mLH/IrNTkGVhsWoxQBRNKzpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUBexj/4vhevZBGMGBbQ6zfUrgp9oC25rbDrBY5sOSsS7x2VY8KGHZrhYeP/UUXPSMYEAxAFOokH4T+IheCeUKsuoD3ilLT5xtPnHj1rBMb+ClHfN7u3yV9tDYNzXj46Lq4xC6agCFFQqU9r0m0qDGLyPZIWeZh90JyaUPYQM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=sDqt8WYT; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1748016107; x=1779552107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ux2fz6ALWguuUll23AorrgrszZl9ikA7djgXi7e3PXE=;
  b=sDqt8WYTI2OiysEHkc2nBlZzixbEtKg2h266dTVaCZXymM5XxKQKc+dY
   ZoNv3NyCtDgvc0BAzv3r8agTe78ySeVekFHSJnce+0uiTlkOCeBULosEi
   Wt7HflKkXldBg4X8hck3ajjF//R+Erz7QL+m6PKM8gSSxgyJvgepSMHy8
   rC1hvDCAeydtc6kfOu949IctEh3K/3agjIpAfPulI60UYgVyxhT/5aQW7
   pahLjax4f0baywbydR8PU6ZMkrnfBkD67LnpGvdmoNyH/nP5ds6nALJr+
   +QFu+JUV8M6efhJy0zVNRy/WxOuUrVLqG2xP7YWYuiXIZ8gBQA+kN3NF6
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,309,1739836800"; 
   d="scan'208";a="493505763"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 16:01:43 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:49295]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.235:2525] with esmtp (Farcaster)
 id 2f752404-5de8-41fe-8a16-eb65358a1460; Fri, 23 May 2025 16:01:40 +0000 (UTC)
X-Farcaster-Flow-ID: 2f752404-5de8-41fe-8a16-eb65358a1460
Received: from EX19D031EUB002.ant.amazon.com (10.252.61.105) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 16:01:40 +0000
Received: from dev-dsk-hmushi-1a-0c348132.eu-west-1.amazon.com
 (172.19.124.218) by EX19D031EUB002.ant.amazon.com (10.252.61.105) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Fri, 23 May 2025
 16:01:37 +0000
From: Mushahid Hussain <hmushi@amazon.co.uk>
To: <tip-bot2@linutronix.de>
CC: <efault@gmx.de>, <linux-kernel@vger.kernel.org>,
	<linux-tip-commits@vger.kernel.org>, <peterz@infradead.org>,
	<stable@vger.kernel.org>, <x86@kernel.org>, <hmushi@amazon.co.uk>,
	<nh-open-source@amazon.com>, <sieberf@amazon.com>
Subject: Re: [PATCH 6.12 000/122] 6.12.11-rc1 review
Date: Fri, 23 May 2025 16:01:28 +0000
Message-ID: <20250523160128.8846-1-hmushi@amazon.co.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <173902629450.10177.17446372607519992642.tip-bot2@tip-bot2>
References: <173902629450.10177.17446372607519992642.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D031EUB002.ant.amazon.com (10.252.61.105)

> The following commit has been merged into the sched/urgent branch of tip:
> 
> Commit-ID:     55294004b122c997591d9de8446f5a4c60402805
> Gitweb:        https://git.kernel.org/tip/55294004b122c997591d9de8446f5a4c60402805
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Tue, 28 Jan 2025 15:39:49 +01:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Sat, 08 Feb 2025 15:43:12 +01:00

Was this merged to sched/urgent or any other branches/RCs? Given gitweb link
sends me to "Bad commit reference". I don't see this commit in sched/urgent:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=sched%2Furgent

