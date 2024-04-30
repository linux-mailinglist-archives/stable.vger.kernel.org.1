Return-Path: <stable+bounces-42271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628EA8B722E
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F861281CB4
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D5812C54B;
	Tue, 30 Apr 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nXVrPaaN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486812C47A;
	Tue, 30 Apr 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475120; cv=none; b=DXvClVOSfut8pbDFuy4Qw/J1oWk7tvK6NKP4rlBWEWigf5WqgZJcdaqrn/gRv4yWSFzROxcFTzWwqpbIRsF1WYKmjmPpw6ZZnnJokiOMyTUIcLNgMAM94559ysPxPCtoqm3e6s3SkDXF/w9sKE3IcQgKOzlhJNmP+iPMIMT2KEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475120; c=relaxed/simple;
	bh=gJY9nEP7/DFfNjDluoSalQ0AnIYfTjgt81NFSlKFwCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clzDN2t01nkF8yIc2K41xs+xMZkPanC4O2Rb8TPMe01iCcrvHP2NP4k08P5mxf8eGCEgUbybqHqWCWjC4P/KsOAEwoOlhXBTSuTjy9to9Cj5VWXz/yTRPICCBEREy4oD4faiYueX1td6kxEcX3qLL0WYMGS82FEhkJXG4Do53OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nXVrPaaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F160EC2BBFC;
	Tue, 30 Apr 2024 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475120;
	bh=gJY9nEP7/DFfNjDluoSalQ0AnIYfTjgt81NFSlKFwCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXVrPaaNoUiYk14K06yOMzYu8+wjSy+vYQu66y2U4PPmjmG31lOHy/iIZ3WY7K8Qg
	 PAYLmgynStcn629nrYkus1S53jCHSxLXAW1mlLLkFBFUu8pPS329e4/Cr3eUKQu3US
	 PJnQhuIZbaJPAcO53dyQQ2lw/l4u1sQGYYc6qDbI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.10 125/138] mtd: diskonchip: work around ubsan link failure
Date: Tue, 30 Apr 2024 12:40:10 +0200
Message-ID: <20240430103053.084372070@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
References: <20240430103049.422035273@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 21c9fb611c25d5cd038f6fe485232e7884bb0b3d upstream.

I ran into a randconfig build failure with UBSAN using gcc-13.2:

arm-linux-gnueabi-ld: error: unplaced orphan section `.bss..Lubsan_data31' from `drivers/mtd/nand/raw/diskonchip.o'

I'm not entirely sure what is going on here, but I suspect this has something
to do with the check for the end of the doc_locations[] array that contains
an (unsigned long)0xffffffff element, which is compared against the signed
(int)0xffffffff. If this is the case, we should get a runtime check for
undefined behavior, but we instead get an unexpected build-time error.

I would have expected this to work fine on 32-bit architectures despite the
signed integer overflow, though on 64-bit architectures this likely won't
ever work.

Changing the contition to instead check for the size of the array makes the
code safe everywhere and avoids the ubsan check that leads to the link
error. The loop code goes back to before 2.6.12.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240405143015.717429-1-arnd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/diskonchip.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -53,7 +53,7 @@ static unsigned long doc_locations[] __i
 	0xe8000, 0xea000, 0xec000, 0xee000,
 #endif
 #endif
-	0xffffffff };
+};
 
 static struct mtd_info *doclist = NULL;
 
@@ -1552,7 +1552,7 @@ static int __init init_nanddoc(void)
 		if (ret < 0)
 			return ret;
 	} else {
-		for (i = 0; (doc_locations[i] != 0xffffffff); i++) {
+		for (i = 0; i < ARRAY_SIZE(doc_locations); i++) {
 			doc_probe(doc_locations[i]);
 		}
 	}



