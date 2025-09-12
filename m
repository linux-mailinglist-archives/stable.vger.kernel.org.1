Return-Path: <stable+bounces-179391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AE3B55697
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 20:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFCD567B84
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 18:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CAA338F23;
	Fri, 12 Sep 2025 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="gs8I3sSX"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4E3009F0;
	Fri, 12 Sep 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703344; cv=none; b=lTA0Q63gQMllUZMIzYEF3U2R7Yqx9ovNJrkXNQqz+gIn6gfVFC7NKQ5CW4nBR4IPHnWIyGm6G2E+3lcVraqQlf2KJB4B5Hglm2SjT3UUjVdSXwNPJRg9mPEaUYgGJ4bmaVUoE+q6EiLJaUOWGQxZ7QwC8BO0DqsYb0rm1nuQrMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703344; c=relaxed/simple;
	bh=kZkZJMxi4yA+FLStw976FETq38wCUlssMb5doYwlIhA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TI46N3B9DlE2b2UKETy8LZBVbwI2LETTGNepZWS0B4mzJJUofMRxXc+7h/4SEc6qCca9RsoXpyUPzNrw+Dl5rLLSCMQpEnRl/GKRkVW0TbWuham8LKwmGjcRpFJMHjlpLbT7DtlLwfB54sxXHoI9PbgwqDWJb8Lsir/gXq+K6sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=gs8I3sSX; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757703342; x=1789239342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ROAHn8JinYd2Op/PAB79hEy/1bYTPpyD+uFyRo9Hf4Q=;
  b=gs8I3sSXB3fcCtbyuT6hB7KX71DtGAjg/2Vca7O4MS2IBf0BKws89vN7
   iXpwAr5MbIFJm4XO7AQIlqpe+xSbyi0utWYZ/aLBr/XQbwUWV7H05z3BQ
   9hBpRYUy1iMCsbYWjHQQf4oxtuRLbIM+FxndzDCpU3c7ElSBKQPUHN8NI
   06LD7JZal5DpUbBqCu113qzqG0ZuYZ3ZsKsOW2Sm+0QWg9IVBMYvHlq1w
   Ty1hQNRUBBHbTfnb1NvsP1/KkFbY5yl6BfUee2BfvOY9S+iuvbhhOMMPv
   tYaIas0eJwd1zJTT+qtw6tCUlxZRQcZ+LamNBVh3X2OIppYRMJ+JI/XvO
   w==;
X-CSE-ConnectionGUID: 3/M4DYetQrqhkA+wOhSYtQ==
X-CSE-MsgGUID: vj2cFxv+QF2Rfzjlod9gtg==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="1933526"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 18:55:31 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:21484]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.20.211:2525] with esmtp (Farcaster)
 id 709a9bb8-6431-4bd5-a42f-fac9491b07b9; Fri, 12 Sep 2025 18:55:31 +0000 (UTC)
X-Farcaster-Flow-ID: 709a9bb8-6431-4bd5-a42f-fac9491b07b9
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 18:55:31 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 18:55:25 +0000
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
Subject: [PATCH v3 0/4 5.10.y] overflow: Allow mixed type arguments in overflow macros
Date: Fri, 12 Sep 2025 18:55:12 +0000
Message-ID: <20250912185518.39980-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

This series backports four commits to bring include/linux/overflow.h in
line with v5.15.193:
 - 4578be130a64 ("overflow: Correct check_shl_overflow() comment")
 - 4eb6bd55cfb2 ("compiler.h: drop fallback overflow checkers")
 - 53f2cd86a81c ("overflow: Allow mixed type arguments")
 - ed6e37e30826 ("tracing: Define the is_signed_type() macro once")

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

Bart Van Assche (1):
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
Changes in v3:
 - Fixed SHA1 of commits mentioned in cover letter

Changes in v2:
 - Added missing sign-off in all patches

-- 
2.47.3


