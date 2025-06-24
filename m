Return-Path: <stable+bounces-158270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1313DAE5B25
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 06:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DCB2C27D7
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 04:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC31C22B8D9;
	Tue, 24 Jun 2025 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXWvgn8g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B032221DB9;
	Tue, 24 Jun 2025 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750738346; cv=none; b=ShuMTI0rmh6SxzVeXHShGdh6aCTm98Dos6tpjt7jDvreB8kUc5ANiTbcPa0GX/hkhwfydCwWUmzszh5lo9LM2LCGLIRILD0TPcRTgC8BLPJgCiJ3ynJV3yk9exdjp0omRQ5hmXpW77s+gQ1icreuqxKfN5bk7R3Y9Ky2EXjmpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750738346; c=relaxed/simple;
	bh=+vmQseMJm0Csnk8ZH7N0eziFnpNk9CZVqw+zqztxKS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RYhHoVnha412G2+m88PJLD4GOL9UQN/Ytc1aSncQ/ZNjFONkMy2AVTbQKfD8gH0dubd4bxDBtp2iZutqZ37hB/D6rnX2wnUO+Ur4SlnwveI7gEuD9MCL6JmkHjPtzNdqOYFcd82G6HRYhdVAk+mrly3O53Jj8GAgs/jmVvZ3d40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXWvgn8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016EBC4CEE3;
	Tue, 24 Jun 2025 04:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750738346;
	bh=+vmQseMJm0Csnk8ZH7N0eziFnpNk9CZVqw+zqztxKS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXWvgn8gkwAfUvwO3zpVmqI/bBpuUeXGFuEI0C8A3t+Otaa0RLA7769NfLNa0aZ4e
	 ONS56mPZ7i7XcwNutw11MJ+DY8x8WG23gsErwnqHvw0NuGYCKIrZufEYiJJdFXHL3X
	 Sed0kYWqUZK6BmhOA2mhG7dR7vTGNc3ZIcbGsZWjDwbCFbS1g/WbTeLBMmgcVap6yQ
	 zn454Xj2I5ixkAzqQxXPiVft5p2W3jVUSKBQRGWs+MM3Q6jH62+n0d9eImdD1KIUBD
	 +CCdVq0B3P1eSq3Zakvl5og+H6qNllfvKqa3z6wGYnGqHCO224kzmR53kPLFmrQXuD
	 OYtQfD/IkC7CQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Tulio Magno <tuliom@ascii.art.br>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Justin M . Forbes" <jforbes@fedoraproject.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 09/18] powerpc: Fix struct termio related ioctl macros
Date: Tue, 24 Jun 2025 00:12:05 -0400
Message-Id: <20250624041214.84135-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624041214.84135-1-sashal@kernel.org>
References: <20250624041214.84135-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.94
Content-Transfer-Encoding: 8bit

From: Madhavan Srinivasan <maddy@linux.ibm.com>

[ Upstream commit ab107276607af90b13a5994997e19b7b9731e251 ]

Since termio interface is now obsolete, include/uapi/asm/ioctls.h
has some constant macros referring to "struct termio", this caused
build failure at userspace.

In file included from /usr/include/asm/ioctl.h:12,
                 from /usr/include/asm/ioctls.h:5,
                 from tst-ioctls.c:3:
tst-ioctls.c: In function 'get_TCGETA':
tst-ioctls.c:12:10: error: invalid application of 'sizeof' to incomplete type 'struct termio'
   12 |   return TCGETA;
      |          ^~~~~~

Even though termios.h provides "struct termio", trying to juggle definitions around to
make it compile could introduce regressions. So better to open code it.

Reported-by: Tulio Magno <tuliom@ascii.art.br>
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
Closes: https://lore.kernel.org/linuxppc-dev/8734dji5wl.fsf@ascii.art.br/
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20250517142237.156665-1-maddy@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a real build failure**: The commit message clearly documents
   a userspace build failure when `asm/ioctls.h` is included without
   `struct termio` being defined. This breaks userspace programs that
   use these ioctl definitions.

2. **Simple and contained fix**: The change is minimal and low-risk - it
   merely replaces macro calls with their hardcoded equivalents. The
   hardcoded values (0x40147417, 0x80147418, 0x80147419, 0x8014741c) are
   the exact expansion of the original macros for a 20-byte `struct
   termio` on PowerPC.

3. **Follows established patterns**: Other architectures (sh and xtensa)
   already use this same approach of hardcoding the values with comments
   showing the original macro. This indicates it's a known and accepted
   solution.

4. **No functional changes**: The ioctl values remain exactly the same -
   only the way they're defined changes. This ensures binary
   compatibility is maintained.

5. **Prevents future issues**: As noted in the commit message, the
   termio interface is obsolete, and trying to reorganize header files
   to fix this properly could introduce regressions. The hardcoded
   approach is safer.

6. **Clear user impact**: The commit includes a specific example of the
   build failure with line numbers and error messages, demonstrating
   this affects real users (reported by Tulio Magno).

7. **Tested**: The commit indicates it was tested by Justin M. Forbes,
   providing confidence in the fix.

The commit follows the stable tree rules by fixing an important bug
(build failure) with minimal risk of regression, making it an ideal
candidate for backporting.

 arch/powerpc/include/uapi/asm/ioctls.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/ioctls.h b/arch/powerpc/include/uapi/asm/ioctls.h
index 2c145da3b774a..b5211e413829a 100644
--- a/arch/powerpc/include/uapi/asm/ioctls.h
+++ b/arch/powerpc/include/uapi/asm/ioctls.h
@@ -23,10 +23,10 @@
 #define TCSETSW		_IOW('t', 21, struct termios)
 #define TCSETSF		_IOW('t', 22, struct termios)
 
-#define TCGETA		_IOR('t', 23, struct termio)
-#define TCSETA		_IOW('t', 24, struct termio)
-#define TCSETAW		_IOW('t', 25, struct termio)
-#define TCSETAF		_IOW('t', 28, struct termio)
+#define TCGETA		0x40147417 /* _IOR('t', 23, struct termio) */
+#define TCSETA		0x80147418 /* _IOW('t', 24, struct termio) */
+#define TCSETAW		0x80147419 /* _IOW('t', 25, struct termio) */
+#define TCSETAF		0x8014741c /* _IOW('t', 28, struct termio) */
 
 #define TCSBRK		_IO('t', 29)
 #define TCXONC		_IO('t', 30)
-- 
2.39.5


