Return-Path: <stable+bounces-131395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D31A809AD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880074E66E3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647A26FDBC;
	Tue,  8 Apr 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svNeZAup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D026FDB3;
	Tue,  8 Apr 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116281; cv=none; b=Df+0NVgbPwqLMRuiDBdJ0MaYerzab72I16nWlsW/FDAfOs5CUDay0vdB8smNIu2FwQombdLKJXgE7S5Qi2RrIB0QdUDJUCcZTyR2KVeCTYjWb0IgCPOcgJJcLqisZhIZMWOwTPZKvd43hZ5M5BEXHvd33pGrBLdVmlO/HcukcvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116281; c=relaxed/simple;
	bh=kDkRatK2GdnodjR88CZWoy9/Fw+bNqC+SWMqcgVGZTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9zXmDCp5qrlJ+4WGC8eScpeppRWUghslTWfJrR7JtNyYtoj1YCFACcfqbItqpuNSyhAfaoXhhf8QMNUYO0AW95fQZpJs7c9LUZ6dSlI+IbKItcSPhRTMSxkxDFdRjafnPKfFHaONgefEwLKOQ0tYxdnsM7JS27PmkErgUlhOQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svNeZAup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE27C4CEE5;
	Tue,  8 Apr 2025 12:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116281;
	bh=kDkRatK2GdnodjR88CZWoy9/Fw+bNqC+SWMqcgVGZTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=svNeZAup6hg14MBIzYqStscPbBHpqo9Y+qA+bgUe7SQe9rAkGbE/qXXy8Db4ol8Qz
	 UEHWbJOF9c46arsiIWYrynp0AAhFM4t9BJAUSKjin0b696zndKZ+QadDh4pXiLud08
	 43ScvfeR41p9s2UsDN7fBqRbtc4UrIelerKk2Yck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Sathvika Vasireddy <sv@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 081/423] crypto: powerpc: Mark ghashp8-ppc.o as an OBJECT_FILES_NON_STANDARD
Date: Tue,  8 Apr 2025 12:46:47 +0200
Message-ID: <20250408104847.631356494@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 1e4d73d06c98f5a1af4f7591cf7c2c4eee5b94fa ]

The following build warning has been reported:

  arch/powerpc/crypto/ghashp8-ppc.o: warning: objtool: .text+0x22c: unannotated intra-function call

This happens due to commit bb7f054f4de2 ("objtool/powerpc: Add support
for decoding all types of uncond branches")

Disassembly of arch/powerpc/crypto/ghashp8-ppc.o shows:

 arch/powerpc/crypto/ghashp8-ppc.o:     file format elf64-powerpcle

 Disassembly of section .text:

 0000000000000140 <gcm_ghash_p8>:
   140:    f8 ff 00 3c     lis     r0,-8
 ...
   20c:    20 00 80 4e     blr
   210:    00 00 00 00     .long 0x0
   214:    00 0c 14 00     .long 0x140c00
   218:    00 00 04 00     .long 0x40000
   21c:    00 00 00 00     .long 0x0
   220:    47 48 41 53     rlwimi. r1,r26,9,1,3
   224:    48 20 66 6f     xoris   r6,r27,8264
   228:    72 20 50 6f     xoris   r16,r26,8306
   22c:    77 65 72 49     bla     1726574 <gcm_ghash_p8+0x1726434>      <==
 ...

It corresponds to the following code in ghashp8-ppc.o :

 _GLOBAL(gcm_ghash_p8)
    lis    0,0xfff8
 ...
    blr
 .long    0
 .byte    0,12,0x14,0,0,0,4,0
 .long    0
 .size    gcm_ghash_p8,.-gcm_ghash_p8

 .byte 71,72,65,83,72,32,102,111,114,32,80,111,119,101,114,73,83,65,32,50,46,48,55,44,32,67,82,89,80,84,79,71,65,77,83,32,98,121,32,60,97,112,112,114,111,64,111,112,101,110,115,115,108,46,111,114,103,62,0
 .align    2
 .align    2

In fact this is raw data that is after the function end and that is
not text so shouldn't be disassembled as text. But ghashp8-ppc.S is
generated by a perl script and should have been marked as
OBJECT_FILES_NON_STANDARD.

Now that 'bla' is understood as a call instruction, that raw data
is mis-interpreted as an infra-function call.

Mark ghashp8-ppc.o as a OBJECT_FILES_NON_STANDARD to avoid this
warning.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/8c4c3fc2-2bd7-4148-af68-2f504d6119e0@linux.ibm.com
Fixes: 109303336a0c ("crypto: vmx - Move to arch/powerpc/crypto")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-By: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Sathvika Vasireddy <sv@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/7aa7eb73fe6bc95ac210510e22394ca0ae227b69.1741128786.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/crypto/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/crypto/Makefile b/arch/powerpc/crypto/Makefile
index 59808592f0a1b..1e52b02d8943b 100644
--- a/arch/powerpc/crypto/Makefile
+++ b/arch/powerpc/crypto/Makefile
@@ -56,3 +56,4 @@ $(obj)/aesp8-ppc.S $(obj)/ghashp8-ppc.S: $(obj)/%.S: $(src)/%.pl FORCE
 OBJECT_FILES_NON_STANDARD_aesp10-ppc.o := y
 OBJECT_FILES_NON_STANDARD_ghashp10-ppc.o := y
 OBJECT_FILES_NON_STANDARD_aesp8-ppc.o := y
+OBJECT_FILES_NON_STANDARD_ghashp8-ppc.o := y
-- 
2.39.5




