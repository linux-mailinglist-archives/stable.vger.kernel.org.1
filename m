Return-Path: <stable+bounces-179752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75162B5A3CC
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 23:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1951BC836D
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 21:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACF02877C1;
	Tue, 16 Sep 2025 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="icF3vNmX"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28D287515;
	Tue, 16 Sep 2025 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.176.194.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057812; cv=none; b=P+ncE4NQ+yBF9qntfKFIWkJYa7apBZI0iLz+Z27d4gT0p4dSS4QH7P0bZl37XNqAt78+Ki41Zsu+iPWbTjbYt67YLCsqQfgE58ifLoB1PoqR2RJxFuV+bIj85skPICZPqe/kztBbYRYVEmJI3P3E9wf0FLeMqXkUxuVnsciY1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057812; c=relaxed/simple;
	bh=esyAzSji+adnp9bEMrjhOKGtohfgrOrb8yIfBdZNEx0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jWqM+oJcYks00jNYFoynBzU899knxLSji5vf6mviQqzCfWv3thn8RcuVlKwqK3WcinRa4AEgcEeUR9X4N+geMnEAo1wJeFQvcOS+7/IZZ26kamm9ZGqxcLakJd6yAZFMvhoFcHvvH4cL7JGe3ZJHCatWFbTsd4sfsWXoM3L5sDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=icF3vNmX; arc=none smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758057810; x=1789593810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e/vB7Zs9aHMwYsXkTiYJPhWtLpilAdRV0YFCpKnteE0=;
  b=icF3vNmXJ9OatxNza2d4xwas3+sPt+TM1CSlEkLQZuhde4sqzApnXm/h
   FbV5tRY9GnJ32DlKFXB/WjRLBdwgVgAI36PROpDIYJGWUZAcRCbyXXuTp
   +IIdBtIAqwqKGoPLQlpH+G2fzN1UCKPxbQEdixo9IEQfwfV/Zutr9sg2G
   aySqZrosRIP0S3hTodw3zwzftMGYb9krwFg0kbk6YmDOpoYzV9B+L+FIR
   B1rB4jn0jggMfdCV3zBKFEgjWRbiryeerb3f0xiejFeYEHNVXDuDJcKPn
   ireP716p92H96nG3Q78fp9T7Yl1g6Vp9/raWUtlFQ9B0l1wT3w6dEcYBS
   w==;
X-CSE-ConnectionGUID: G9gJrqgFR5iQk+BTToyKSw==
X-CSE-MsgGUID: JPHEJVGKQsuVHRVhQjZNkA==
X-IronPort-AV: E=Sophos;i="6.18,270,1751241600"; 
   d="scan'208";a="2214755"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 21:23:20 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:29113]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.39.25:2525] with esmtp (Farcaster)
 id d5687765-781d-4aee-8ed0-c911a128d4b7; Tue, 16 Sep 2025 21:23:20 +0000 (UTC)
X-Farcaster-Flow-ID: d5687765-781d-4aee-8ed0-c911a128d4b7
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 21:23:17 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 16 Sep 2025
 21:23:12 +0000
From: Eliav Farber <farbere@amazon.com>
To: <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <mingo@redhat.com>,
	<akpm@linux-foundation.org>, <gregkh@linuxfoundation.org>, <sj@kernel.org>,
	<David.Laight@ACULAB.COM>, <Jason@zx2c4.com>,
	<andriy.shevchenko@linux.intel.com>, <bvanassche@acm.org>,
	<keescook@chromium.org>, <linux-sparse@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jonnyc@amazon.com>, <farbere@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH 0/7 5.10.y] Cherry pick of minmax.h commits from 5.15.y
Date: Tue, 16 Sep 2025 21:22:52 +0000
Message-ID: <20250916212259.48517-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

This series backports seven commits from v5.15.y that update minmax.h
and related code:

 - ed6e37e30826 ("tracing: Define the is_signed_type() macro once")
 - 998f03984e25 ("minmax: sanity check constant bounds when clamping")
 - d470787b25e6 ("minmax: clamp more efficiently by avoiding extra
   comparison")
 - 1c2ee5bc9f11 ("minmax: fix header inclusions")
 - d53b5d862acd ("minmax: allow min()/max()/clamp() if the arguments
   have the same signedness.")
 - 7ed91c5560df ("minmax: allow comparisons of 'int' against 'unsigned
   char/short'")
 - 22f7794ef5a3 ("minmax: relax check to allow comparison between
   unsigned arguments and signed constants")

The main motivation is commit d53b5d862acd, which removes the strict
type check in min()/max() when both arguments have the same signedness.
Without this, kernel 5.10 builds can emit warnings that become build
failures when -Werror is used.

Additionally, commit ed6e37e30826 from tracing is required as a
dependency; without it, compilation fails.

Andy Shevchenko (1):
  minmax: fix header inclusions

Bart Van Assche (1):
  tracing: Define the is_signed_type() macro once

David Laight (3):
  minmax: allow min()/max()/clamp() if the arguments have the same
    signedness.
  minmax: allow comparisons of 'int' against 'unsigned char/short'
  minmax: relax check to allow comparison between unsigned arguments and
    signed constants

Jason A. Donenfeld (2):
  minmax: sanity check constant bounds when clamping
  minmax: clamp more efficiently by avoiding extra comparison

 include/linux/compiler.h     |  6 +++
 include/linux/minmax.h       | 89 ++++++++++++++++++++++++++----------
 include/linux/overflow.h     |  1 -
 include/linux/trace_events.h |  2 -
 4 files changed, 70 insertions(+), 28 deletions(-)

-- 
2.47.3


