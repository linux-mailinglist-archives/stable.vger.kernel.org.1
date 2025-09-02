Return-Path: <stable+bounces-177556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCEBB41102
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 01:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 248267B3132
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 23:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E54C2EAB64;
	Tue,  2 Sep 2025 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSr7D5h+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED12EAB6F
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 23:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857175; cv=none; b=aJgZzKbnxyoJxJz0Yl6s0z/qJXuSwDKquGAA5cFrwgihz2uwQ4m8ynrW1JBnsrd9qSwtKcJwtFTD1gvxcGXR2Ui2M2mKrcxlyg7cwbk+xUsf5EXUdcQ/WOX0x/PrWa3vPw2yWGMk/1lQITwDyLtDwChCiEWs2AzAr3psr+m5dgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857175; c=relaxed/simple;
	bh=6givWJeo2KbjB4vPFl536ZK/TBqk0kofHXgNZGIJA7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XoHc83VvY67v0y++FlXK8f1aZjmogpuS2t9xzJC4HLaGq+Wx9D7Z/WajGbsDHJ2cGx2FCtOX1E90Be1DLfTGDd3Ii4S03GiUTqKozQHqV4wDboPgctGbmq/Qswaa7+WIFFn9OF5ycjHKSUERAEA2MImim4VanBRuqeEdw4NkaLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSr7D5h+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF25C4CEF7;
	Tue,  2 Sep 2025 23:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756857174;
	bh=6givWJeo2KbjB4vPFl536ZK/TBqk0kofHXgNZGIJA7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=HSr7D5h+2t7T6w5sEZcnMb9TqV2Zh1xHWp4tg3ZmEOu0pjgDtXzx6JQSEMTd1eH2F
	 ajrL34w603laEBpRXbPAZgcWwZ1fU8PHltOQNjZTYsRMJkFIN/jRV1ko4QjTlW3jx7
	 8YTGvTpzBj56HBHu/vFwXTfbMN+yNakOJuSHJPVNfmaDlUk1UUkkYuW5H6hNnohvVY
	 nFxHqpDEIjO3ltHGVwX2vKiCUc2dXOJfUGQaztk2IL3K8C43hW5HVFvCgbhi302uNr
	 pPj0YwXTj0Y82ZJ5NltplVQnq0G4zz3sL7WOWndHwmagpjGmdOZO13Zrjb7PI/b034
	 uKiMCUK5e/xQw==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.4 only] powerpc: boot: Remove unnecessary zero in label in udelay()
Date: Tue,  2 Sep 2025 16:52:34 -0700
Message-ID: <20250902235234.2046667-1-nathan@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building powerpc configurations in linux-5.4.y with binutils 2.43
or newer, there is an assembler error in arch/powerpc/boot/util.S:

  arch/powerpc/boot/util.S: Assembler messages:
  arch/powerpc/boot/util.S:44: Error: junk at end of line, first unrecognized character is `0'
  arch/powerpc/boot/util.S:49: Error: syntax error; found `b', expected `,'
  arch/powerpc/boot/util.S:49: Error: junk at end of line: `b'

binutils 2.43 contains stricter parsing of certain labels [1].

Remove the unnecessary leading zero to fix the build. This is only
needed in linux-5.4.y because commit 8b14e1dff067 ("powerpc: Remove
support for PowerPC 601") removed this code altogether in 5.10.

Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=226749d5a6ff0d5c607d6428d6c81e1e7e7a994b [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/boot/util.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/util.S b/arch/powerpc/boot/util.S
index f11f0589a669..5ab2bc864e66 100644
--- a/arch/powerpc/boot/util.S
+++ b/arch/powerpc/boot/util.S
@@ -41,12 +41,12 @@ udelay:
 	srwi	r4,r4,16
 	cmpwi	0,r4,1		/* 601 ? */
 	bne	.Ludelay_not_601
-00:	li	r0,86	/* Instructions / microsecond? */
+0:	li	r0,86	/* Instructions / microsecond? */
 	mtctr	r0
 10:	addi	r0,r0,0 /* NOP */
 	bdnz	10b
 	subic.	r3,r3,1
-	bne	00b
+	bne	0b
 	blr
 
 .Ludelay_not_601:

base-commit: c25f780e491e4734eb27d65aa58e0909fd78ad9f
-- 
2.51.0


