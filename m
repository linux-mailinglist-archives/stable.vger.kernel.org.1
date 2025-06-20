Return-Path: <stable+bounces-154892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EC7AE131C
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1DC4A25DE
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED98D1F09BF;
	Fri, 20 Jun 2025 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AO854kbz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87F1DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398083; cv=none; b=Z3RitzHsakjpiLLP75jDbfQ7gox2fXQzdV/dg+w+INz3tJA64RAY/4w8rraVlvsTp/d+E/mnCTzs0uFjcm1FcC49toQ8DN/UfJMH+dAYJa2mC3qvMOnYP+AMW0hmyU76vtIVt7qPeSsIBCixJ1UKXPBsxk/34uY2YlrOcFcCPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398083; c=relaxed/simple;
	bh=dTcHZWu12yeJpEHT0ef4fu3ppaRTp9b0kenjUqiQbXI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o83Xy0hUndXmG75ukctNN4ltAKXaGRGCN1iDkfosdtLdzRSU8enB6gYAnpk/JZh8I8tVatN4OlP8O/ZLtG+A+FnjfNKC1SaOBsGd+A/ea8ix82vCoaKydlJaLi1OhUpqqo/RKaiHuPhFgDof8LOQFP2azHN5QOAEZrMPCcBl6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AO854kbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C58C4CEE3;
	Fri, 20 Jun 2025 05:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398083;
	bh=dTcHZWu12yeJpEHT0ef4fu3ppaRTp9b0kenjUqiQbXI=;
	h=Subject:To:Cc:From:Date:From;
	b=AO854kbzICM2JkDbo0SqSNsePBhulusF+lhA69gIhxQLnJV1N7v/pbqjSty86FfwV
	 VRbWVIbZh+K9g5dVYUEepwDp+4eA8xAx4OrAqHvk37jkLbaY6wRTRNk5q9p+V0KK15
	 eiVBQyXEKUMIAnyVo+0tCn0ixo1TBXODaX3Mu79Q=
Subject: FAILED: patch "[PATCH] s390/pci: Fix __pcilg_mio_inuser() inline assembly" failed to apply to 6.12-stable tree
To: hca@linux.ibm.com,schnelle@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:41:20 +0200
Message-ID: <2025062020-aware-estranged-e8a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c4abe6234246c75cdc43326415d9cff88b7cf06c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062020-aware-estranged-e8a8@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c4abe6234246c75cdc43326415d9cff88b7cf06c Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Mon, 19 May 2025 18:07:11 +0200
Subject: [PATCH] s390/pci: Fix __pcilg_mio_inuser() inline assembly

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

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 9680055edb78..51e7a28af899 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -244,7 +244,7 @@ static inline int __pcilg_mio_inuser(
 		: [ioaddr_len] "+&d" (ioaddr_len.pair), [exc] "+d" (exception),
 		  CC_OUT(cc, cc), [val] "=d" (val),
 		  [dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=d" (tmp),
-		  [shift] "+d" (shift)
+		  [shift] "+a" (shift)
 		:
 		: CC_CLOBBER_LIST("memory"));
 	disable_sacf_uaccess(sacf_flag);


