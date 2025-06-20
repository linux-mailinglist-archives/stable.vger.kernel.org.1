Return-Path: <stable+bounces-154893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB60AE131D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981634A26A9
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D99E1F09BF;
	Fri, 20 Jun 2025 05:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y0fpf4cW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19FE1EFF92
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398091; cv=none; b=fecHZ1I5WjZRX0pu8BTqpnEFA48MGStiOwemu+F6bTF4U2+xk0nb+78nW6zeoKGJ1z6uqTu1rlqCiae3F1C2D1E7DSkh5RoXB4EdacfeLKEav6zLZK84ob1+emRtPdUbxl4NrJPSh91QwfykeyiaiUZoVmSV1oYaA66cBXwRstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398091; c=relaxed/simple;
	bh=cJHha5pYEybKuZn6Wo5q0ThFie1LbJ7kOAHr6pVvx3U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J4GjMDEwomohuBaLoztXcsydLE36iiPJ1WPHImEh84Hed6wcmbcr40wIaN5n8Vz9I+RWWjksWOQcN5BrdRCqKj3jimYQgSTiZ+iWlB4gPlsj7htZ4z9FzCbbpYmcdmSmJy6dnkm6/iTQw+6p1z508q6HnyRsxaXb+KGeG9G4Des=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y0fpf4cW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DE5C4CEE3;
	Fri, 20 Jun 2025 05:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398091;
	bh=cJHha5pYEybKuZn6Wo5q0ThFie1LbJ7kOAHr6pVvx3U=;
	h=Subject:To:Cc:From:Date:From;
	b=y0fpf4cWfF7uH9MQzc6zy/e231GPBW1Cmb+LrgfQCjxf5iYdY86WU50m6JZ4iGtRC
	 9VQeudTnv/bDBNrdE6hq1b0/AjnREhE7cAKIcG2Zy0SSJOUJxhzkEPkLiS0hzMe6rQ
	 g/tjRta2TxaLNncK856F4hhMzuXL8BygF94j7tyE=
Subject: FAILED: patch "[PATCH] s390/pci: Fix __pcilg_mio_inuser() inline assembly" failed to apply to 6.6-stable tree
To: hca@linux.ibm.com,schnelle@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:41:20 +0200
Message-ID: <2025062020-kindness-glancing-e58b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c4abe6234246c75cdc43326415d9cff88b7cf06c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062020-kindness-glancing-e58b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


