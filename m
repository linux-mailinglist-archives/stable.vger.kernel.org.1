Return-Path: <stable+bounces-180915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB25BB90016
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 12:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F2217100B
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E10296BA2;
	Mon, 22 Sep 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="libv0xp1"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44364284894;
	Mon, 22 Sep 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537106; cv=none; b=WzDp2nhGwxQ6gRpxPh/d0iejLoawk1/2bVR5JdAbi3BPoMIOLxJX5eikeTF0VhC38xbHRnp/LN03HHX2O9eAZ1CIn6lFWkg1PiRrdsz1cXnEYd5L5jLkazDZe62jT7XztYr0fNC1YqOPknUSFl/VRcA1mDBxr5dCYdQniTqmE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537106; c=relaxed/simple;
	bh=ny6pPfS7gbxU+FugGn+NuQ/hYD47BSQbJzs9zDHxRV0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=deQXVHZsF4snuGRcpUISVlDdGzrkaGsB9QEgF+w8YcG+Ql9ypLOjvlna3D66VNzCgWpnF72KBXh10uO0CY0FDdNFi+D3MUb7aqkG98otNHy8FgdXlp14lkTZdRV1fL+c1xqUa84T1ne5u+7frEHKMMRrJxltU1/4TPnWVuxRLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=libv0xp1; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758537104; x=1790073104;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n8XjtnnBKQmyHqgJGk7gPoNtlcgR8pb+zPUWTuFLNQY=;
  b=libv0xp189rIZ8Qpy1LRvlZ4lc8iePtzDlvB5BZEfpNeZvDsWsAQpMTy
   AFjZHvMvtwxbi4M6tVKJtEsKp6piLoy3cDl1z834sqop+78EGdWWnzny2
   yA2ia5IWXtl8F6YSz10lnC41FZkRUG/rHAXvXCwLGRhjhGccfdF5oH61n
   h3ljb5gv1phLbmtxhMSHy+OgA27K0PwJTEA0EVM6W2iSWQ9KvzO5qmUV8
   Use98wmKMP8T1yhx7YnTVslztB12xgrfbDhTQeKRvZQdDl8oN6KUEe8Zt
   R9DpRqqEE45jD0NbEvIzBVsg6nTQohUyFHYcX72K7ZU64GEAD3Wwb5Dne
   Q==;
X-CSE-ConnectionGUID: Lyrv1SpJQu6EdV+O5//e6A==
X-CSE-MsgGUID: LCmcx/5sRke49YsFN9o+YQ==
X-IronPort-AV: E=Sophos;i="6.18,284,1751241600"; 
   d="scan'208";a="2370802"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 10:31:34 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:15930]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.36.68:2525] with esmtp (Farcaster)
 id 346010fb-7c1e-48b2-9079-17b806a92229; Mon, 22 Sep 2025 10:31:33 +0000 (UTC)
X-Farcaster-Flow-ID: 346010fb-7c1e-48b2-9079-17b806a92229
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 10:31:33 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 22 Sep 2025
 10:31:30 +0000
From: Eliav Farber <farbere@amazon.com>
To: <farbere@amazon.com>, <akpm@linux-foundation.org>,
	<David.Laight@ACULAB.COM>, <arnd@kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH 0/7 6.12.y] Backport minmax.h updates from v6.17-rc7
Date: Mon, 22 Sep 2025 10:31:16 +0000
Message-ID: <20250922103123.14538-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

This series backports 7 patches to update minmax.h in the 6.12.y branch,
aligning it with v6.17-rc7.

The ultimate goal is to synchronize all longterm branches so that they
include the full set of minmax.h changes.

The key motivation is to bring in commit d03eba99f5bf ("minmax: allow
min()/max()/clamp() if the arguments have the same signedness"), which
is missing in older kernels.

In mainline, this change enables min()/max()/clamp() to accept mixed
argument types, provided both have the same signedness. Without it,
backported patches that use these forms may trigger compiler warnings,
which escalate to build failures when -Werror is enabled.

David Laight (7):
  minmax.h: add whitespace around operators and after commas
  minmax.h: update some comments
  minmax.h: reduce the #define expansion of min(), max() and clamp()
  minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
  minmax.h: move all the clamp() definitions after the min/max() ones
  minmax.h: simplify the variants of clamp()
  minmax.h: remove some #defines that are only expanded once

 include/linux/minmax.h | 205 +++++++++++++++++++----------------------
 1 file changed, 95 insertions(+), 110 deletions(-)

-- 
2.47.3


