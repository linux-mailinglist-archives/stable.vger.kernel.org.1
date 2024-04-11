Return-Path: <stable+bounces-38692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CECA8A0FE6
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D206B23C78
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937DF146A77;
	Thu, 11 Apr 2024 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lD2yjiYb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E1145B13;
	Thu, 11 Apr 2024 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831316; cv=none; b=ckUSpCbU3ZaT65431sGxEk5hdJXRKZ8Agg8F+Y0QREdN6zcWWsqBAOglAG24sbvmrvZWaCCtqK8JgYLKV9sE4/avO5XtgrhF6TKp1YrgirULiOkovsSaXcH4+oVjwFnu2dpTgH7VtHVmsvqUuDC6zKg2v9cbJepIbbz+F402e9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831316; c=relaxed/simple;
	bh=QWJP0McdeeqyQ70UqQvDKdFCi8eXbw0MXgV81nPZvyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWYSK4DHTVZX10kSXg5E8YJgt5bXJGkw7ZzctBI7bvC8ujgDxxsr2VhabP+5UAcINZBNEI2LacFJENFXJargUxsrXLoAzZKO86+wtzYBcQOIPOfXjgsrcJEqXQKdJKscXKybkOBsXuczHK++knpXtW58anFv3zNWtshG+99+G2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lD2yjiYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF52C433F1;
	Thu, 11 Apr 2024 10:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831316;
	bh=QWJP0McdeeqyQ70UqQvDKdFCi8eXbw0MXgV81nPZvyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lD2yjiYb2GvjXaEltvSJnnMMt6YeSZxLmMG8G3hMJRmEgV2+Q2ZEnIkxKr3P2ZouV
	 /ll/CNIpaoPABQfIWUhcAm1yXcr0b8ixEtHbCkTze/DftHirxK8ogfewR5Slfxo0Md
	 D4CFokWtr5jz5XX55ypWomLZP2biSYIb8DXOyyPg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sandipan Das <sandipan.das@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 081/114] perf/x86/amd/lbr: Discard erroneous branch entries
Date: Thu, 11 Apr 2024 11:56:48 +0200
Message-ID: <20240411095419.333773890@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
References: <20240411095416.853744210@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandipan Das <sandipan.das@amd.com>

[ Upstream commit 29297ffffb0bf388778bd4b581a43cee6929ae65 ]

The Revision Guide for AMD Family 19h Model 10-1Fh processors declares
Erratum 1452 which states that non-branch entries may erroneously be
recorded in the Last Branch Record (LBR) stack with the valid and
spec bits set.

Such entries can be recognized by inspecting bit 61 of the corresponding
LastBranchStackToIp register. This bit is currently reserved but if found
to be set, the associated branch entry should be discarded.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://bugzilla.kernel.org/attachment.cgi?id=305518
Link: https://lore.kernel.org/r/3ad2aa305f7396d41a40e3f054f740d464b16b7f.1706526029.git.sandipan.das@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/lbr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 110e34c59643a..5149830c7c4fa 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -173,9 +173,11 @@ void amd_pmu_lbr_read(void)
 
 		/*
 		 * Check if a branch has been logged; if valid = 0, spec = 0
-		 * then no branch was recorded
+		 * then no branch was recorded; if reserved = 1 then an
+		 * erroneous branch was recorded (see Erratum 1452)
 		 */
-		if (!entry.to.split.valid && !entry.to.split.spec)
+		if ((!entry.to.split.valid && !entry.to.split.spec) ||
+		    entry.to.split.reserved)
 			continue;
 
 		perf_clear_branch_entry_bitfields(br + out);
-- 
2.43.0




