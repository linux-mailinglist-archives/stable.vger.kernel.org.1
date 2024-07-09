Return-Path: <stable+bounces-58492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD90492B750
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681661F231F0
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD46115884E;
	Tue,  9 Jul 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fh74V4nI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C49B156238;
	Tue,  9 Jul 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524104; cv=none; b=gn47XGZ3jKKW8YEeSnMP3N5yAJ/OQoHG34wtfK1rMP2Vk+SfAIgCKWwYDef1eVx08EfGugFjrG5GoONaAHKzmHNw8MTGTcth47CpXb1lWSWwUTrAdTeHQLzvFwS8jXBCU1uA9SU28nRhvMbjRi/7f+ScSa8kFkSkXXBIeM9vpAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524104; c=relaxed/simple;
	bh=mxf8VbIzq25enKUu7r8SMqm2koRPIuhv2OEut1KzBY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NitbA8cLiV9uuh7iQyfoOaRFEn09n4jst9VzGGhM9zD3/QzRVdYQDb9x65LLZyEdxEWbQI2YueajOuwh0SP+kwZ6BqGKOybGDsR1sUn6ww41CSCUlJbYYd2/dtev/ODIp5DdL1evNU9iGQdngTzHrFkLg4OwkQIDOnohTGyEGqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fh74V4nI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF212C3277B;
	Tue,  9 Jul 2024 11:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524104;
	bh=mxf8VbIzq25enKUu7r8SMqm2koRPIuhv2OEut1KzBY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fh74V4nIA3Gxf/rZX78wBCidjafwUAyBsQdwkdRovB41cGddCha5Eu/H4ievLhuSk
	 8PSis+fPkzphkH6gDUYxA8HmMBOwovC5OIgHNSPzFY7r3ksS9rNIQUdAonNH+mp5vR
	 +AuLqkG78JvsApIRjmBNV2JyC3scmdEiYSREzfnY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 072/197] s390: Mark psw in __load_psw_mask() as __unitialized
Date: Tue,  9 Jul 2024 13:08:46 +0200
Message-ID: <20240709110711.752439381@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit 7278a8fb8d032dfdc03d9b5d17e0bc451cdc1492 ]

Without __unitialized, the following code is generated when
INIT_STACK_ALL_ZERO is enabled:

86: d7 0f f0 a0 f0 a0     xc      160(16,%r15), 160(%r15)
8c: e3 40 f0 a0 00 24     stg     %r4, 160(%r15)
92: c0 10 00 00 00 08     larl    %r1, 0xa2
98: e3 10 f0 a8 00 24     stg     %r1, 168(%r15)
9e: b2 b2 f0 a0           lpswe   160(%r15)

The xc is not adding any security because psw is fully initialized
with the following instructions. Add __unitialized to the psw
definitiation to avoid the superfluous clearing of psw.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index bbbdc5abe2b2c..a589547ee0200 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -305,8 +305,8 @@ static inline void __load_psw(psw_t psw)
  */
 static __always_inline void __load_psw_mask(unsigned long mask)
 {
+	psw_t psw __uninitialized;
 	unsigned long addr;
-	psw_t psw;
 
 	psw.mask = mask;
 
-- 
2.43.0




