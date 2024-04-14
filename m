Return-Path: <stable+bounces-36447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DAC89BFEB
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E1D1F24C19
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0C37D08A;
	Mon,  8 Apr 2024 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qu2DM7px"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674B2E62C;
	Mon,  8 Apr 2024 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581352; cv=none; b=HjduANmDN2glzLoSMjUHW94JFNhwIJod157YJvr+YJojoDPtHj+RsfrTOh6/qJl2Y22flLi+0wfB2dCRYCu8/fzBP56kqL8VKjH2IbaLCrLv5Q/VnTikQufzUkJbofpm/8uDkHo8Tkp8HARYhJcanGGq0/Hg2EBX7Au/cI/OyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581352; c=relaxed/simple;
	bh=tKkkVWydQbrMDH9CMV8J4PceVXNt7gg5/XqAVM864d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoPQDc0gATYrcWAmMun+csBmZ411cgFQXyyBL7wJd4Xfz5ckf139eRDwEtcmNcREcwsHjpLcDuAB+/2lcEekXSW/jxKRKpZ6ndWxyfWZHFHvXwbPwb9F0Q5oUxyVRixefUMoQnW5VEuLaS0BkculCqp2asX7Nlri35qnn1QnXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qu2DM7px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C23BC433C7;
	Mon,  8 Apr 2024 13:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581352;
	bh=tKkkVWydQbrMDH9CMV8J4PceVXNt7gg5/XqAVM864d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qu2DM7pxWkHsyKSHLy6Ff2rqLGoeeSh5BtMr8shfmXfioZriVbH00E+xobQYtNbpI
	 /vFSDWNGUO3GQ1kxA9qbE+I0tFKTzIP2jgMKhVNumzD6gOgZIxsiavKZhwIJ5PYg+v
	 o6ADqhITjlRNcp/TW+8zGHr48ogUokPvebUPBWJ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 037/690] parisc: Fix csum_ipv6_magic on 32-bit systems
Date: Mon,  8 Apr 2024 14:48:23 +0200
Message-ID: <20240408125400.882457712@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 4408ba75e4ba80c91fde7e10bccccf388f5c09be ]

Calculating the IPv6 checksum on 32-bit systems missed overflows when
adding the proto+len fields into the checksum. This results in the
following unit test failure.

    # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:506
    Expected ( u64)csum_result == ( u64)expected, but
        ( u64)csum_result == 46722 (0xb682)
        ( u64)expected == 46721 (0xb681)
    not ok 5 test_csum_ipv6_magic

This is probably rarely seen in the real world because proto+len are
usually small values which will rarely result in overflows when calculating
the checksum. However, the unit test code uses large values for the length
field, causing the test to fail.

Fix the problem by adding the missing carry into the final checksum.

Cc: Palmer Dabbelt <palmer@rivosinc.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/include/asm/checksum.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index f705e5dd10742..e619e67440db9 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -163,7 +163,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 "	ldw,ma		4(%2), %7\n"	/* 4th daddr */
 "	addc		%6, %0, %0\n"
 "	addc		%7, %0, %0\n"
-"	addc		%3, %0, %0\n"	/* fold in proto+len, catch carry */
+"	addc		%3, %0, %0\n"	/* fold in proto+len */
+"	addc		0, %0, %0\n"	/* add carry */
 
 #endif
 	: "=r" (sum), "=r" (saddr), "=r" (daddr), "=r" (len),
-- 
2.43.0




