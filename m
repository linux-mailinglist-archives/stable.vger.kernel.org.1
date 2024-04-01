Return-Path: <stable+bounces-35231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD5894307
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6E428375A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E4482DF;
	Mon,  1 Apr 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ms4Bkbvr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC64BA3F;
	Mon,  1 Apr 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990723; cv=none; b=R8GVs9+h1brqHkgHnQjE1mwJ8XlBdKppUXIipS6f8qun0erBf4QV3GtpEFGyieH801xn4zZ2fLHB2iBw/1UcXZcQ6i+yn+XTCQ2xfENpWF1PBTTgViwgOEU41KljYoX2rDqyCDkbP46RfDJ2JHvOo6TK0DJCqwDBP7w6WnLQoCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990723; c=relaxed/simple;
	bh=RAjX3Yd9+ZrF2fHMLTDTWlimYWfCXL+KA8CZN4Pb0RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwYQyiZmf/wNEqwAcZgKxOGuwh9c3OCiFJFhmEKlCmBvcXLWnQtW4Tmci6G/QwxmExprPsSFJl4Csfb47YE3HmbCS4OriBqyLQD9poDwbvkN2vDxjca3ugNC3CKSexoZ398WUELI5pefq7+dPnnz5ZM2GhW8OoEOjxIHnnYgOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ms4Bkbvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08113C433C7;
	Mon,  1 Apr 2024 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990723;
	bh=RAjX3Yd9+ZrF2fHMLTDTWlimYWfCXL+KA8CZN4Pb0RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ms4BkbvrGAxA6vrYppab1HQuwRWTYSdfLIB4D0utEVpZ0fnCH0k44w3WN2agBrVtC
	 Vcg2AClasjU9/Irws0MyKPvRY57xAFzxQ6lwA2c4Ss4+W6XfaUuqOoc5jAAqy4Caph
	 EGHoEgcZ4Zfpbb09LPSfdl++yQp/9R86M61KjfNU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 046/272] parisc: Fix ip_fast_csum
Date: Mon,  1 Apr 2024 17:43:56 +0200
Message-ID: <20240401152531.838736905@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit a2abae8f0b638c31bb9799d9dd847306e0d005bd ]

IP checksum unit tests report the following error when run on hppa/hppa64.

    # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:463
    Expected ( u64)csum_result == ( u64)expected, but
        ( u64)csum_result == 33754 (0x83da)
        ( u64)expected == 10946 (0x2ac2)
    not ok 4 test_ip_fast_csum

0x83da is the expected result if the IP header length is 20 bytes. 0x2ac2
is the expected result if the IP header length is 24 bytes. The test fails
with an IP header length of 24 bytes. It appears that ip_fast_csum()
always returns the checksum for a 20-byte header, no matter how long
the header actually is.

Code analysis shows a suspicious assembler sequence in ip_fast_csum().

 "      addc            %0, %3, %0\n"
 "1:    ldws,ma         4(%1), %3\n"
 "      addib,<         0, %2, 1b\n"	<---

While my understanding of HPPA assembler is limited, it does not seem
to make much sense to subtract 0 from a register and to expect the result
to ever be negative. Subtracting 1 from the length parameter makes more
sense. On top of that, the operation should be repeated if and only if
the result is still > 0, so change the suspicious instruction to
 "      addib,>         -1, %2, 1b\n"

The IP checksum unit test passes after this change.

Cc: Palmer Dabbelt <palmer@rivosinc.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/include/asm/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index 3c43baca7b397..f705e5dd10742 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -40,7 +40,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 "	addc		%0, %5, %0\n"
 "	addc		%0, %3, %0\n"
 "1:	ldws,ma		4(%1), %3\n"
-"	addib,<		0, %2, 1b\n"
+"	addib,>		-1, %2, 1b\n"
 "	addc		%0, %3, %0\n"
 "\n"
 "	extru		%0, 31, 16, %4\n"
-- 
2.43.0




