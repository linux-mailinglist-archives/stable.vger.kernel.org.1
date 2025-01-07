Return-Path: <stable+bounces-107883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E2FA048FD
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 19:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BFBB7A240F
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846C618C900;
	Tue,  7 Jan 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6fbPTTx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442901F3D47
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273424; cv=none; b=rUzqwk5953GrNx6pGo+cgooNaNC0wwKGpsZ80f/trA9S9RbWWpVHS7gk/dgblTaQeiE6KozfjTEXdoiv1L8PjJmNzmkY4ueMLF5sIuOu1JIXnfVeEoG6tXSxPDI2ZKJjQ7WaUWlpZIjQ/uUZTDC85BNSMyzYzpjFIs3F3m641f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273424; c=relaxed/simple;
	bh=gbpt6aYxkcuOGhGuOC0bxE6G6UgaVP5KyojNrVRKlaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qh5nkP6pm2kgWp2ykeaPQJ13p8x0Et7ahsfA/X7HueNvhNjR6R9+GkhRVyfPfSqdvCtSd/604Q9jT4lhwBzK9BCjPnJd8A5iIF4a0DWuW88T2ZsfXUThGfsuvw1HNKiPRyWI2WsE7OzoN5Eiag5l/SvnxEX60Px2y0P2uLQdUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6fbPTTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE589C4CEE0;
	Tue,  7 Jan 2025 18:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273423;
	bh=gbpt6aYxkcuOGhGuOC0bxE6G6UgaVP5KyojNrVRKlaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6fbPTTxrfTpuhY4gh5/VVOIkuIp4vtAnlwsI1TSCFfP72UiTW1xVGJVhXVR1iYfh
	 V2b87BFWYdxxqFT/5Jf+CzUvsh/HuTJfwHDX0PvIXcmTXLTsgLDjgVFCdHjNdkTdqZ
	 O8QGSLNonkWyVQRc/r4VvJvapmHR4HD33oIqqxGfdlvC94hi3BJoMA6I5vo0P+pbAe
	 q56UwusNkJqjCm/Gyh4oksrq5Rb2BhU6Zos+Hw552vJUmD1nHJk8zUKJgVaZaq42Rl
	 aUqlpvOZEk+pyGuwrM6vYf2ZzDu4TxrPKAePk4Y/VC21ST6FE2klghF+yqa2pOV/7Y
	 ezTODgXizryFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity
Date: Tue,  7 Jan 2025 13:10:21 -0500
Message-Id: <20250107080235-0c18d4f88de18259@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250106174459.3206507-1-visitorckw@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 0210d251162f4033350a94a43f95b1c39ec84a90


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0210d251162f ! 1:  0298599f30c2 scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity
    @@ Commit message
     
         The orc_sort_cmp() function, used with qsort(), previously violated the
         symmetry and transitivity rules required by the C standard.  Specifically,
    -    when both entries are ORC_TYPE_UNDEFINED, it could result in both a < b
    +    when both entries are ORC_REG_UNDEFINED, it could result in both a < b
         and b < a, which breaks the required symmetry and transitivity.  This can
         lead to undefined behavior and incorrect sorting results, potentially
         causing memory corruption in glibc implementations [1].
    @@ Commit message
         Transitivity: If x < y and y < z, then x < z.
     
         Fix the comparison logic to return 0 when both entries are
    -    ORC_TYPE_UNDEFINED, ensuring compliance with qsort() requirements.
    +    ORC_REG_UNDEFINED, ensuring compliance with qsort() requirements.
     
         Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
         Link: https://lkml.kernel.org/r/20241226140332.2670689-1-visitorckw@gmail.com
    @@ Commit message
         Cc: Steven Rostedt <rostedt@goodmis.org>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit 0210d251162f4033350a94a43f95b1c39ec84a90)
    +    Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
     
      ## scripts/sorttable.h ##
     @@ scripts/sorttable.h: static inline unsigned long orc_ip(const int *ip)
    @@ scripts/sorttable.h: static int orc_sort_cmp(const void *_a, const void *_b)
      	 */
      	orc_a = g_orc_table + (a - g_orc_ip_table);
     +	orc_b = g_orc_table + (b - g_orc_ip_table);
    -+	if (orc_a->type == ORC_TYPE_UNDEFINED && orc_b->type == ORC_TYPE_UNDEFINED)
    ++	if (orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end &&
    ++	    orc_b->sp_reg == ORC_REG_UNDEFINED && !orc_b->end)
     +		return 0;
    - 	return orc_a->type == ORC_TYPE_UNDEFINED ? -1 : 1;
    + 	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
      }
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

