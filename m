Return-Path: <stable+bounces-37763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08B889C64D
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF8A286AD8
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6A674438;
	Mon,  8 Apr 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rghnOiBJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277F8063B;
	Mon,  8 Apr 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585189; cv=none; b=Rprz7ea2mvMttFEdEJZt9LZ6COcHm3h7rrYRa4GEZai8SWguoSZeMBIcQFahkniXUbBIVJwV4EBuVSpp9VyuAacfO6gQ9YkVxX6ypUCFygTlDX2G/3Y69EnUTA0xnxTFLzNV6GfWrBPc2ytsg78GfiybSmZCDrvNrvGUlbPRV3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585189; c=relaxed/simple;
	bh=w1Xqb2J+Yxc5INT33x/l1ZbZ/jCyDGpYF4KFb4w0ifc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfuC4EqdScdI7pGQlvU/Yjqr4LM5jVAAr3zTo8KktmGCKV1Epfhh8mfGj0jNUkBEpUtfQt0HcC1kAWtg5c8FyT5MNpHJUD53K2QOcZMKSiJ7xmtZg8BATq7nB6pW9xEpiSUkQWLgnLnXbbPCHXm9qnTthl7Fgj9svgofj06p3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rghnOiBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCE8C43390;
	Mon,  8 Apr 2024 14:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712585188;
	bh=w1Xqb2J+Yxc5INT33x/l1ZbZ/jCyDGpYF4KFb4w0ifc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rghnOiBJU6nAV5DMQrz0Xkx2WfSPML1XSkGM2FFops5aBD6N+ukykPz1lpNCXcc5a
	 ly1JWFb/g0PMH4TVZw+NSY0QrN7r6je/qJe+4ghb+g+u0dmg1HWyueO2ycVoxDRFl7
	 rffTemnt6iXX0cpFT5BKo+zeRR37m/NJqL28N0dg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 5.15 683/690] riscv: Fix spurious errors from __get/put_kernel_nofault
Date: Mon,  8 Apr 2024 14:59:09 +0200
Message-ID: <20240408125424.467199520@linuxfoundation.org>
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

From: Samuel Holland <samuel.holland@sifive.com>

commit d080a08b06b6266cc3e0e86c5acfd80db937cb6b upstream.

These macros did not initialize __kr_err, so they could fail even if
the access did not fault.

Cc: stable@vger.kernel.org
Fixes: d464118cdc41 ("riscv: implement __get_kernel_nofault and __put_user_nofault")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Link: https://lore.kernel.org/r/20240312022030.320789-1-samuel.holland@sifive.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/uaccess.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -467,7 +467,7 @@ unsigned long __must_check clear_user(vo
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
-	long __kr_err;							\
+	long __kr_err = 0;						\
 									\
 	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
 	if (unlikely(__kr_err))						\
@@ -476,7 +476,7 @@ do {									\
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
 do {									\
-	long __kr_err;							\
+	long __kr_err = 0;						\
 									\
 	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
 	if (unlikely(__kr_err))						\



