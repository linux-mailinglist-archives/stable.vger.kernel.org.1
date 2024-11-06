Return-Path: <stable+bounces-91269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A655F9BED36
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0201F24D4F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AFF1E0DF0;
	Wed,  6 Nov 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wk/tINJf"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01B81DFD9D
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898238; cv=none; b=ueRI9TDFYL+tQRHwO/SjRJHvmC5cD3KsTEXWLw/N6ywstZ3JioI13+lFhqpnNpwgsjHh0bpYBurlCFTvOKWSnOaK+cocmZwgOVjZVRTvABwAJ0pe3kylrPV3uyv0bE0QmRfrGgqKIoGD8+++aMRLCQwgxuG7iv1L6sR1vxE5kHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898238; c=relaxed/simple;
	bh=+j2BPCV/dcJBmuv7OhMd5G1HPhWHTAL6XwsKjyZfxmE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ie55qBTjJLSsrmkcP0G4Ali/E9MebZfiwWbwXY5uqPSrSB3d+yrgdZaALFXfFgftX3LWgb1nYw/nlD3NbH4sg4I/v1Gv/yYomBlYsyv3jz1X9OQPP1h8IYEvr4T4DL3/I56WYqH0ZjOUOfUufNNROQJO4z8OtaNctxyn7NeR3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wk/tINJf; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730898237; x=1762434237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mN9LObjGI9LD3cynpmIHKf657Fb8b2qPcloYVNiC5ck=;
  b=Wk/tINJfpX8kdJzr5Zbn5qgCzierojx7t3GG5dGjkDngxFPLP56a5IPe
   1Go6+PbFwlpd3+O9wlS7dc9Ab4fXktC+Yw2ST35sYQ4HI1M75lO9jqLSz
   UIFqk6IYdXFkw44w6ghT78E6BNBz9VYZUqET3cPvYTOVPYHts+0HQcJ5J
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,262,1725321600"; 
   d="scan'208";a="437649827"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 13:03:52 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:53825]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.86:2525] with esmtp (Farcaster)
 id 91239882-e80d-456e-be06-691ce750d256; Wed, 6 Nov 2024 13:03:52 +0000 (UTC)
X-Farcaster-Flow-ID: 91239882-e80d-456e-be06-691ce750d256
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 13:03:51 +0000
Received: from email-imr-corp-prod-iad-all-1b-af42e9ba.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 6 Nov 2024 13:03:51 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com [10.15.1.225])
	by email-imr-corp-prod-iad-all-1b-af42e9ba.us-east-1.amazon.com (Postfix) with ESMTP id DF56540596;
	Wed,  6 Nov 2024 13:03:50 +0000 (UTC)
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 9CF689CB2; Wed,  6 Nov 2024 14:03:50 +0100 (CET)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <sashal@kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.1] kselftest/arm64: Initialise current at build time in signal tests
Date: Wed, 6 Nov 2024 14:03:37 +0100
Message-ID: <20241106130337.74091-1-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Mark Brown <broonie@kernel.org>

upstream 6e4b4f0eca88e47def703f90a403fef5b96730d5 commit.

When building with clang the toolchain refuses to link the signals
testcases since the assembly code has a reference to current which has
no initialiser so is placed in the BSS:

  /tmp/signals-af2042.o: in function `fake_sigreturn':
  <unknown>:51:(.text+0x40): relocation truncated to fit: R_AARCH64_LD_PREL_LO19 against symbol `current' defined in .bss section in /tmp/test_signals-ec1160.o

Since the first statement in main() initialises current we may as well
fix this by moving the initialisation to build time so the variable
doesn't end up in the BSS.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20230111-arm64-kselftest-clang-v1-4-89c69d377727@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
since 6.1.113 we see these compilations issues reported in the patch
description, this upstream patch fixes the issue, and it's a clean
backport.
 tools/testing/selftests/arm64/signal/test_signals.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals.c b/tools/testing/selftests/arm64/signal/test_signals.c
index 416b1ff431998..00051b40d71ea 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.c
+++ b/tools/testing/selftests/arm64/signal/test_signals.c
@@ -12,12 +12,10 @@
 #include "test_signals.h"
 #include "test_signals_utils.h"
 
-struct tdescr *current;
+struct tdescr *current = &tde;
 
 int main(int argc, char *argv[])
 {
-	current = &tde;
-
 	ksft_print_msg("%s :: %s\n", current->name, current->descr);
 	if (test_setup(current) && test_init(current)) {
 		test_run(current);
-- 
2.40.1


