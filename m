Return-Path: <stable+bounces-177674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F95B42D05
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 00:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77213ACA32
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 22:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FE42EBDFD;
	Wed,  3 Sep 2025 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="reS9hhR6"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B444829C339
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939946; cv=none; b=Wg1PeIx2rVN2VT34sbT9bVsDraBr7ayG2rGtjFMHgQcheLTxrxHE4cxWfUYHoCQF9/aBmlEYHImXNo/UKAJgU5Rl7p0R7oXt36gZM5yjPD6bM+4UW2648bdUoull1htg2zFmmBNH7OZJvn3pUqDCvtsRM94KYxS79yHwEBDCmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939946; c=relaxed/simple;
	bh=BhZtj4ARbTKJ7yOQBkYxg8O501GLIY5Ceb7yuzb5DYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mq3z+HpK4CayIh/7VIm8nzz2JYoNlMEsh+1KRa1mWIpYvbXOCKV4aMzsrnvV0e3kFe5IieiW6gkIeV+DjFhr31q0wGQvh4qaVQfmqCm5mX2HiM1aiUxhruzO8DsuoqCpsqtH1awyTwwWcg2H1zSXzCa0OrHJ/0OgcFSaT3F1vvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=reS9hhR6; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756939944; x=1788475944;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vCmA786qFxXCTzHCRIq+p5sD3GIBAKOaoZXXatTnWc4=;
  b=reS9hhR67np2++w0c4YJDaUmJ+BivPMr1n9E3hPW+qTDH1s3rV+FOVIO
   FJLkeBO6biWhh1wmhrkOAy4kjELiLKO4bkuI6vM0NAVKtYYXFNyrSwJCB
   5yXLz4wuGNdMEmw+QQOE4EDymaO6OEx/DqReLeXvGPCnrO8N2Wgmr6JgZ
   wvbgVuclsM6TCpFcMs2mPnQqCba8C3qTxiLZElR0aHGrJ8vfCmCpbm55q
   w67Xlw7Hcx7GyIlyMus2Z9bsiUD3uM09sby13wpVi6DiDmtbcYQvnc/pA
   O0qNtnixDMfRZnP20UPMldFydM6v5h7IocIhJHkLN9+s7j0+DjezU4jED
   A==;
X-CSE-ConnectionGUID: SWthtZrVQba+Jx+dJHRqxg==
X-CSE-MsgGUID: AzWqphhOQz2Rua28SkEiKw==
X-IronPort-AV: E=Sophos;i="6.16,202,1744070400"; 
   d="scan'208";a="2348166"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 22:52:24 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:36952]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.92:2525] with esmtp (Farcaster)
 id 2728f374-db46-4dfa-904c-616ff97df10b; Wed, 3 Sep 2025 22:52:23 +0000 (UTC)
X-Farcaster-Flow-ID: 2728f374-db46-4dfa-904c-616ff97df10b
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 3 Sep 2025 22:50:31 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.119.254.121) by
 EX19D015UWC003.ant.amazon.com (10.13.138.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 3 Sep 2025 22:50:31 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: Suraj Jitindar Singh <surajjs@amazon.com>
Subject: [PATCH 5.10 0/4] x86/speculation: Make {JMP,CALL}_NOSPEC Consistent
Date: Wed, 3 Sep 2025 15:49:59 -0700
Message-ID: <20250903225003.50346-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D015UWC003.ant.amazon.com (10.13.138.179)

The 4 patches in this series make the JMP_NOSPEC and CALL_NOSPEC macros used
in the kernel consistent with what is generated by the compiler.

("x86,nospec: Simplify {JMP,CALL}_NOSPEC") was merged in v6.0 and the remaining
3 patches in this series were merged in v6.15. All 4 were included in kernels
v5.15+ as prerequisites for the backport of the ITS mitigations [1].

None of these patches were included in the backport of the ITS mitigations to
the 5.10 kernel [2]. They all apply cleanly and are applicable to the 5.10
kernel. Thus I see no reason that they weren't applied here, unless someone can
correct me?

I am sending them for inclusion in the 5.10 kernel as this kernel is still
actively maintained for these kind of vulnerability mitigations and as such
having these patches will unify the handling of these cases with subsequent
kernel versions easing code understanding and the ease of backports in the
future.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ac116ce6468670eeda39345a5585df308243dca
[2] https://lore.kernel.org/stable/20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com/

Pawan Gupta (3):
  x86/speculation: Simplify and make CALL_NOSPEC consistent
  x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
  x86/speculation: Remove the extra #ifdef around CALL_NOSPEC

Peter Zijlstra (1):
  x86,nospec: Simplify {JMP,CALL}_NOSPEC

 arch/x86/include/asm/nospec-branch.h | 46 ++++++++++++++++++----------
 1 file changed, 30 insertions(+), 16 deletions(-)

-- 
2.34.1


