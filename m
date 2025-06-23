Return-Path: <stable+bounces-155395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF2DAE41D8
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BC6189366B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5012512DD;
	Mon, 23 Jun 2025 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IYywxUot"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C9924EA85;
	Mon, 23 Jun 2025 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684315; cv=none; b=OZV2cNa3mhUxibqXpCH0lG6leSereVkRhOBSqFvGqzmhzd/QepmTgbomD2BTal+scpJnPSiS9hwvQEKOy7TGgvkWLF+oIBX0NtC3M8bTIT4DGQ0YbvcYVff4si71VuOxxfftQe8FYLeIitqIaiNfa8q9Q11UA7yh9Oon65C6mMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684315; c=relaxed/simple;
	bh=vAKumDoo0Uf7Yw6FMslsM5nNzVlsfFjnG4bHuSHngIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNRkgSpsp+Sp+E631pJPKtpemDNJiaUJFZZPGagc3txJKl6bJq8/jV0tVOiyLB47qRKOzEaQsjxS+M42gSRcPT18lgNl7enpf4U03m4lP7t6qHdranoRX29hS08GBmTAcp04MxIcQQn8NDaswh/0rmvor4RWKA5kTHN5a1KJspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IYywxUot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07BEC4CEEA;
	Mon, 23 Jun 2025 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684315;
	bh=vAKumDoo0Uf7Yw6FMslsM5nNzVlsfFjnG4bHuSHngIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYywxUot0fxSS5g/3uuNwCursveKT2BAJHhx7dTjhv+y9ZI5+agObU1DvlEke37am
	 ZHn9+xqc8osIg5f1NWqAFC8XXnr669thKn2NFo+bKgyGt1/YARTkm5VPpZagWi21oR
	 oYaQHZlh63m8x/OhjIheQrAa37ve740o+Zs5X3lc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 6.15 022/592] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Mon, 23 Jun 2025 14:59:40 +0200
Message-ID: <20250623130700.760199513@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <hca@linux.ibm.com>

commit c4abe6234246c75cdc43326415d9cff88b7cf06c upstream.

Use "a" constraint for the shift operand of the __pcilg_mio_inuser() inline
assembly. The used "d" constraint allows the compiler to use any general
purpose register for the shift operand, including register zero.

If register zero is used this my result in incorrect code generation:

 8f6:   a7 0a ff f8             ahi     %r0,-8
 8fa:   eb 32 00 00 00 0c       srlg    %r3,%r2,0  <----

If register zero is selected to contain the shift value, the srlg
instruction ignores the contents of the register and always shifts zero
bits. Therefore use the "a" constraint which does not permit to select
register zero.

Fixes: f058599e22d5 ("s390/pci: Fix s390_mmio_read/write with MIO")
Cc: stable@vger.kernel.org
Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/pci/pci_mmio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -236,7 +236,7 @@ static inline int __pcilg_mio_inuser(
 		: [ioaddr_len] "+&d" (ioaddr_len.pair), [exc] "+d" (exception),
 		  CC_OUT(cc, cc), [val] "=d" (val),
 		  [dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=d" (tmp),
-		  [shift] "+d" (shift)
+		  [shift] "+a" (shift)
 		:
 		: CC_CLOBBER_LIST("memory"));
 



