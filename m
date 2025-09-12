Return-Path: <stable+bounces-179377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1864CB553A2
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 17:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44CDAC7A54
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CBB314A92;
	Fri, 12 Sep 2025 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kdKFwO9D"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C1D31354D;
	Fri, 12 Sep 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.3.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691068; cv=none; b=AQzHR720Rq0guHpyE/94B5FPpG8x+pd1I7E9qY6AoDgZxSn6PgMdQiat0/vX/IJBlW6cHdDDy8Y7YjBgupfgFLVXaLaM6nlRHM1al0VNtf+oLgdhtAs51aIVcjcDxemJYjvmDRLJOvMkFI+72Hf9AnPQ63A6q/XomJW8ZGyJ8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691068; c=relaxed/simple;
	bh=7TA3xc19CvF3ExK6/0kUO1lbjqcgIkmvqrZHzJNZXo4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AFf18P5pyN+rYSseCUYe3zf/U+W0sLTmUjjodxCOzl7BVS9Iu6pqbJVx5OHo+UuIxz5bEl5+IOBaVZcApGfiLrXLtcHTzm22Nxccz0Ghs9vvTnYIz98H9JYm3gg/ONc93x+PxpPRZyn3stJMCqW+CKqKP9I6mOljvhORYqfuIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kdKFwO9D; arc=none smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757691066; x=1789227066;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FvMhpA+UyxM428Kyi4yOOoUDP/xqifkcOGmJkfBcvpE=;
  b=kdKFwO9DCAVx9V1P6LHYjufeHnO9vIjPG+i6aEcHHstPHHA/3fHMVyW2
   D8mGmUFZ7jBriVrItH486SwI5mp9sqIie7T+WUZKkbez6M+ZFsBUyzJnP
   MBch1CNPqcywWyLUf3QF0ETpa5PaRogyJI6X4MzqT+W4ihzMSwQnldDqX
   CgrZGywJ3aLp/VIQ+VKOSuyoNjLSrVX9fTP7HfDVxOy42VAlo9DeEb7CC
   MSx+qqXv8PWjemfUdFqE1G5zvD42YTIJF+S5SqQfciDFP6+Nt7bPux5LD
   haOYrksEWJFSFfs53c0Nf2uBIPAcMp/hymSzru5BVIteTDaoVeFZDK8S0
   Q==;
X-CSE-ConnectionGUID: A6dI1L0RToOFypwEEZ9CPg==
X-CSE-MsgGUID: UGYZ00eMRb6jee7h+ESh+A==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="2031910"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:30:55 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:3432]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.1.255:2525] with esmtp (Farcaster)
 id f0285c8b-2da1-427e-9ebe-cdcdb5fa3926; Fri, 12 Sep 2025 15:30:54 +0000 (UTC)
X-Farcaster-Flow-ID: f0285c8b-2da1-427e-9ebe-cdcdb5fa3926
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 15:30:52 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 15:30:46 +0000
From: Eliav Farber <farbere@amazon.com>
To: <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <mingo@redhat.com>,
	<natechancellor@gmail.com>, <ndesaulniers@google.com>,
	<keescook@chromium.org>, <sashal@kernel.org>, <akpm@linux-foundation.org>,
	<ojeda@kernel.org>, <elver@google.com>, <gregkh@linuxfoundation.org>,
	<kbusch@kernel.org>, <sj@kernel.org>, <bvanassche@acm.org>,
	<leon@kernel.org>, <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
	<linux-sparse@vger.kernel.org>, <clang-built-linux@googlegroups.com>,
	<stable@vger.kernel.org>
CC: <jonnyc@amazon.com>, <farbere@amazon.com>
Subject: [PATCH v2 0/4 5.10.y] overflow: Allow mixed type arguments in overflow macros
Date: Fri, 12 Sep 2025 15:30:34 +0000
Message-ID: <20250912153040.26691-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

This series backports four commits to bring include/linux/overflow.h in
line with v5.15.193:
 - 2541be80b1a2 ("overflow: Correct check_shl_overflow() comment")
 - 564e84663d25 ("compiler.h: drop fallback overflow checkers")
 - 1d1ac8244c22 ("overflow: Allow mixed type arguments")
 - f96cfe3e05b0 ("tracing: Define the is_signed_type() macro once")

The motivation is to fix build failures such as:

drivers/net/ethernet/intel/e1000e/ethtool.c: In function ‘e1000_set_eeprom’:
./include/linux/overflow.h:71:15: error: comparison of distinct pointer types lacks a cast [-Werror]
   71 |  (void) (&__a == __d);   \
      |               ^~
drivers/net/ethernet/intel/e1000e/ethtool.c:582:6: note: in expansion of macro ‘check_add_overflow’
  582 |  if (check_add_overflow(eeprom->offset, eeprom->len, &total_len) ||
      |      ^~~~~~~~~~~~~~~~~~

This regression was triggered by commit ce8829d3d44b ("e1000e: fix heap
overflow in e1000_set_eeprom").

check_add_overflow() requires the first two operands and the result
pointer to be of identical type. On 64-bit builds, using size_t for the
result conflicted with the u32 fields eeprom->offset and eeprom->len,
resulting in type check failures.

BarteVan Assche (1):
  tracing: Define the is_signed_type() macro once

Kees Cook (1):
  overflow: Allow mixed type arguments

Keith Busch (1):
  overflow: Correct check_shl_overflow() comment

Nick Desaulniers (1):
  compiler.h: drop fallback overflow checkers

 include/linux/compiler-clang.h     |  13 --
 include/linux/compiler-gcc.h       |   4 -
 include/linux/compiler.h           |   6 +
 include/linux/overflow.h           | 209 ++++++-----------------------
 include/linux/trace_events.h       |   2 -
 tools/include/linux/compiler-gcc.h |   4 -
 tools/include/linux/overflow.h     | 140 +------------------
 7 files changed, 52 insertions(+), 326 deletions(-)

---
Changes in v2:
 - Added missing sign-off in all patches

-- 
2.47.3


