Return-Path: <stable+bounces-157965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CADAE56AF
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573134A415A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2721F6667;
	Mon, 23 Jun 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qt3o2T4o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5819E7F9;
	Mon, 23 Jun 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717153; cv=none; b=GVpZri8M8LdzhEu/0MQszcQi2RiwAS+mXQZTt8+5/UnkFymtwyPvKfG5DbCoX8TDxVWF0RzFCs6LJRrmhk3wRBQAxnfH8kfn6F98P0M2rFEN5b9JouzHhb8ldJrwKThOHDdhQ1X5qf6RZYF45sfbh6pf7+5DbfmcLvjJgFy/j14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717153; c=relaxed/simple;
	bh=Ps3IOZxc7BuxRu78OTXOLw65DHl664wM5tWPMveIznQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BruFKTGDOqUSN7LSp1M6G/wJfd288LJV5YYFvAsiT3fxtx7oFcAXbSOdkLoj3ogMpDrlZajFDH1y7XgxSo3FITyo/pEiCaYGvYvbd+N1TXo8iL2KOb+tbnlCFpuZkNYpdaBMwMH4RbcBALpoYunmu2LdGxKHyy6iF41sV1uJlLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qt3o2T4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DE0C4CEEA;
	Mon, 23 Jun 2025 22:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717153;
	bh=Ps3IOZxc7BuxRu78OTXOLw65DHl664wM5tWPMveIznQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qt3o2T4oPm+mhCh74iMU++MTeeNIpqgIK8Opoa64RTG5DaeXh8p7om1BL9kTJ1u6+
	 V6ZH/LGa1GevC4g4J8HuXjd9MOl3iYj586rY+AOxylUlbSqXPFoqvykWnyoW30aoV7
	 +EkiZExsqSiBlv8LfaLXF8ALWgIUatCdpOUDQ+sU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 5.15 408/411] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Mon, 23 Jun 2025 15:09:12 +0200
Message-ID: <20250623130643.954344749@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -222,7 +222,7 @@ static inline int __pcilg_mio_inuser(
 		[ioaddr_len] "+&d" (ioaddr_len.pair),
 		[cc] "+d" (cc), [val] "=d" (val),
 		[dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=d" (tmp),
-		[shift] "+d" (shift)
+		[shift] "+a" (shift)
 		:: "cc", "memory");
 
 	/* did we write everything to the user space buffer? */



