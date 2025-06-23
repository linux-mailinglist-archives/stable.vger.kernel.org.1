Return-Path: <stable+bounces-158107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095CEAE56FC
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBDB7AEF94
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06315222581;
	Mon, 23 Jun 2025 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HOcQmt8e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820E2192EC;
	Mon, 23 Jun 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717501; cv=none; b=GC6VWywFC9aQvs6HHOzUD5j9XO52khMQ+Hd6frmc4zqHcszNgNNsm8WfLFWD5AqUQS+Q6KQwrz4klsLLiIdvIKS13+CZVkguF2BrQwquIZIBeb3HybcJPKQUyz8Yefdm8H1qWXhM+DX31gikTckMRneJcun+faLIpiodEN+4q4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717501; c=relaxed/simple;
	bh=0GS3LpZmle9W6DeCO1kWnta89DeX/UdzoD7BG+uNxgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFhTnieUFHwFoNNId1jCT/uuYSCqJRVhN7NrOpfOTZ+ag1i8IvWnFZdnpwKE8mq+jEHhG+nSmhBc8pNRrKsD+ktkgVQwg619Zdqtq+UtkwgU3J4JrbvlczZnkNQ63TQoANfbp1QiuLzviIORR7ZTDE0XB5ygFSCaea87OZ25vao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HOcQmt8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457ABC4CEEA;
	Mon, 23 Jun 2025 22:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717501;
	bh=0GS3LpZmle9W6DeCO1kWnta89DeX/UdzoD7BG+uNxgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOcQmt8eIdKDjwsEK2KUm25bhPBcJ6CGCTE1KtAVKC6bbNLgu/6y2nBNeIFsxfs4K
	 FRvtolqFjT3ynGDUmF00L1nAVsn/QG6UrmzQklE1L6vtF2keUBhwD/LKCmDRxEvSSA
	 do20VzZ4U6+yavp+S5qhQvheCHDf2rq6RZDpqnk0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 6.12 402/414] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Mon, 23 Jun 2025 15:08:59 +0200
Message-ID: <20250623130651.989298555@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/pci/pci_mmio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -228,7 +228,7 @@ static inline int __pcilg_mio_inuser(
 		[ioaddr_len] "+&d" (ioaddr_len.pair),
 		[cc] "+d" (cc), [val] "=d" (val),
 		[dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=d" (tmp),
-		[shift] "+d" (shift)
+		[shift] "+a" (shift)
 		:: "cc", "memory");
 
 	/* did we write everything to the user space buffer? */



