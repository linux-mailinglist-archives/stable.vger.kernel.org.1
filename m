Return-Path: <stable+bounces-177672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2044B42D02
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 00:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37BA3B076F
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 22:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFC72ED86B;
	Wed,  3 Sep 2025 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="CYJdCftl"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818652E7BAE
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939904; cv=none; b=f4VaVA/laMGGS+trwmCE2s2DY8hz8/oz4pQAaUD+5OT30bmYghZrxGpGOoY8xvpEl1n/c9SFuogwv8aRgg/70kjLJt9KRj1226Bmv65YrDljmb5GgaZwuBtSrRrk4oHTFdKG+9H2eyAsLFQSlg/JF94qFUtRpk3euw4JZ0KFcII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939904; c=relaxed/simple;
	bh=hFbrD/0coVfyQddnGILrRkhr7q8X+/6R+jRvSG/XCOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6RgrBLjm1OuHVjjz0OoxN48v1SThllRcsSpYmm4O39HpacoGFTEpAJnXhWBV2e64Uv8kRfzmHBb5ryqO6ZSMZfrfK5mYm8nXNvRv7EDfHHFJjbazMpZ2Wkjx06W1PkUukKug/zc+LaUE/xbfigtLecSYAqKcs6j/qSpd1vGNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=CYJdCftl; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756939902; x=1788475902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gIlPnPrBrGND/kXLp6/X+PalV1vbvyxBGlqPfezTjrY=;
  b=CYJdCftlOKRfjU8BzqlXpfAdL71f5JVnyEYnJ+HriqNSH9BzJCcyKI3T
   /F8/PkEWDXzRkYadnaAC5G8epDrgw4dDo3iRzhmL6e7w/cFa6sjK4ZjOe
   4ingyAlNrLy/pDiAIoI5Rm69U1dP7h+x7+2iMEkLANHsn2BGvByjVke54
   5zgJ1v+WsMEr/fNXqKCjtQJC8zg96buNn9zxuYGxEIIQEyvosX6LzNBkg
   NDvM+WLKL7g3XS8PxzGKG8oVCaNOD4BMSvXdQqWQ1Q+RuCqhDff+4lcce
   U6ZV4yt2ntYbTWf5xEyoL78fpsH8/xD0A1dSOgBw6tXiHCcbBLMdkFHOG
   g==;
X-CSE-ConnectionGUID: yDHDtHG1RkeyPm9+yjSLOw==
X-CSE-MsgGUID: LJI+es9DTUKO3nDk9yjVdQ==
X-IronPort-AV: E=Sophos;i="6.18,236,1751241600"; 
   d="scan'208";a="2352082"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 22:51:41 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:42275]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.7:2525] with esmtp (Farcaster)
 id d0d759ba-3959-4633-a68b-ca08bbeef20b; Wed, 3 Sep 2025 22:51:41 +0000 (UTC)
X-Farcaster-Flow-ID: d0d759ba-3959-4633-a68b-ca08bbeef20b
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 3 Sep 2025 22:51:41 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.119.254.121) by
 EX19D015UWC003.ant.amazon.com (10.13.138.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 3 Sep 2025 22:50:31 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, "Suraj Jitindar
 Singh" <surajjs@amazon.com>
Subject: [PATCH 5.10 4/4] x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
Date: Wed, 3 Sep 2025 15:50:03 -0700
Message-ID: <20250903225003.50346-5-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903225003.50346-1-surajjs@amazon.com>
References: <20250903225003.50346-1-surajjs@amazon.com>
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

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit c8c81458863ab686cda4fe1e603fccaae0f12460 upstream.

Commit:

  010c4a461c1d ("x86/speculation: Simplify and make CALL_NOSPEC consistent")

added an #ifdef CONFIG_MITIGATION_RETPOLINE around the CALL_NOSPEC definition.
This is not required as this code is already under a larger #ifdef.

Remove the extra #ifdef, no functional change.

vmlinux size remains same before and after this change:

 CONFIG_MITIGATION_RETPOLINE=y:
      text       data        bss         dec        hex    filename
  25434752    7342290    2301212    35078254    217406e    vmlinux.before
  25434752    7342290    2301212    35078254    217406e    vmlinux.after

 # CONFIG_MITIGATION_RETPOLINE is not set:
      text       data        bss         dec        hex    filename
  22943094    6214994    1550152    30708240    1d49210    vmlinux.before
  22943094    6214994    1550152    30708240    1d49210    vmlinux.after

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20250320-call-nospec-extra-ifdef-v1-1-d9b084d24820@linux.intel.com
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: <stable@vger.kernel.org> # 5.10.x
---
 arch/x86/include/asm/nospec-branch.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 2cade6749322..9f84a00776e2 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -295,12 +295,8 @@ extern retpoline_thunk_t __x86_indirect_thunk_array[];
  * Inline asm uses the %V modifier which is only in newer GCC
  * which is ensured when CONFIG_RETPOLINE is defined.
  */
-#ifdef CONFIG_RETPOLINE
 #define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
 			"call __x86_indirect_thunk_%V[thunk_target]\n"
-#else
-#define CALL_NOSPEC	"call *%[thunk_target]\n"
-#endif
 
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
-- 
2.34.1


