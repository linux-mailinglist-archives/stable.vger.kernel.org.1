Return-Path: <stable+bounces-179357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E9DB54E97
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 14:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396317C2757
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2136F306480;
	Fri, 12 Sep 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="knYGKiuC"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC823064A3;
	Fri, 12 Sep 2025 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681793; cv=none; b=Q73dtS1fQOrwSHCbHoNa4diHoG0njyx8Pp5m1dO2Qed0exF+HinkjuocrOEeGSuMFr8oC1rur29jMsIFy+zbSxgCqYakfITdvaDY2WoZTQpO07feU2HZhOHOc2D5StKRIBb7NtztZRkkucvGIjBQW0rwZpecCy0RmdKiMEJS25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681793; c=relaxed/simple;
	bh=6JbAF9nqJVcH7dtb3TDCpTTXE428ZAiVfhu9toRIJXw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j1ix1OvOxo4y9W31uVKoq6Cgk1LacNUXlsSs9hHfEcZXcHULFOZMPi1ZuzHLBxr2rbpliGLn+zLsVpDZ99wL68YRx+aO7SWttMFA64ESlhSD/2dUULgAv4GhMaQY7MWPNgP9M1iIdsff86ZmU286ypBe+jo7EdNN6TRKLBn2CwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=knYGKiuC; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757681792; x=1789217792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8XPAlSPEA8VS5QX5oda/u8IFY9M8nwVCg+rKWmjuFh4=;
  b=knYGKiuC7B9SDRNgHCVs4qanBoXy1OT2u4fPYV0J6TQoXZQBHlXFZZ5G
   Py4fKWSkAcDqVvnRB1oEVybXRXf0Bn88oG9AKlkgJoMe7utsjJ/PVNMkz
   qeSn24BaXDjvNTayEO5WGTwUxj4wME6zTINelHjPCXYchjTgi0aX+pGA5
   IK7qHUCRtvj6NJwRod5GUhQCl1DPJdq55L1I09yNo5EQUbEbHY23dhlfu
   2ScRolncMXZy9WseaZyocADBq4L9JHgAdoB33XvkaocCcbHZKVJDLXukF
   q62nkBjvgyaPuKK7uTDitZ5ec1AXWFO4WnHXOUjsMO3NdFHAsID27WBVD
   g==;
X-CSE-ConnectionGUID: zAQgLpVSSwG3eDQ8VcEhJQ==
X-CSE-MsgGUID: xGDH0KX9RNmV55FnoxGsaQ==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="1919948"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 12:56:21 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:19396]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.1.255:2525] with esmtp (Farcaster)
 id ba462319-b15f-4b93-81f5-879fc8889bb4; Fri, 12 Sep 2025 12:56:21 +0000 (UTC)
X-Farcaster-Flow-ID: ba462319-b15f-4b93-81f5-879fc8889bb4
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 12:56:19 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 12:56:13 +0000
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
Subject: [PATCH 0/4 5.10.y] overflow: Allow mixed type arguments in overflow macros
Date: Fri, 12 Sep 2025 12:56:01 +0000
Message-ID: <20250912125606.13262-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
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

-- 
2.47.3


