Return-Path: <stable+bounces-82480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28E9994D00
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303E41C251A8
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906821DF25A;
	Tue,  8 Oct 2024 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DH71jAl9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7F31DF243;
	Tue,  8 Oct 2024 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392404; cv=none; b=bgKiRbgNCtbl3B47KbsUeaQa/ApBj1h7Yrba0c40MmiyA6uPthF8uw45DRLZXegd4P7v7qOWSPq638y08Nehw8MkSI6AVejoUodvXjlNGOE4UXmxbfy2Ygv7Gz5uBcmfDlwPGcO8SgwvZg/mVVThon3xAyS6KwiKegSVcmX4Rmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392404; c=relaxed/simple;
	bh=qiocdhCwGw2e/f9EKtsAXYMi0PR0+CqddzrYDOY++iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mrng6ATHQmeMrVEWrsFWxB1tMkMTdv9z6X45JH5QSVhCYP9KgcSVHZ5I7Gta8l8OgfwYqDlq3rDZCkM1u2jVlRRknXniJJKK6TdnrwCvGfiOvXPRkk83oUR8SbiBPMTVIig6vWQyRCvFQIsSob9U1ciaLB9rYKpyFvQaPuTzvXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DH71jAl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93539C4CEC7;
	Tue,  8 Oct 2024 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392404;
	bh=qiocdhCwGw2e/f9EKtsAXYMi0PR0+CqddzrYDOY++iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DH71jAl9YRw61TbfEX5IoKN9a7a0q3tir9O+x1jS3NcNpVZxeRQCfyVvPGCX9pMDo
	 6xL6jVBZYIrkSh1q6CoRGWPyGvLuugm/hdFezHr/+on+BAnB6nRHKbfxDathnrMcCG
	 mbvOfRkr5Doyecl2erdTJg9J33WGdyJI2+6wMs1o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Nam Cao <namcao@linutronix.de>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.11 404/558] of: address: Report error on resource bounds overflow
Date: Tue,  8 Oct 2024 14:07:14 +0200
Message-ID: <20241008115718.177134568@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

commit 000f6d588a8f3d128f89351058dc04d38e54a327 upstream.

The members "start" and "end" of struct resource are of type
"resource_size_t" which can be 32bit wide.
Values read from OF however are always 64bit wide.
Avoid silently truncating the value and instead return an error value.

This can happen on real systems when the DT was created for a
PAE-enabled kernel and a non-PAE kernel is actually running.
For example with an arm defconfig and "qemu-system-arm -M virt".

Link: https://bugs.launchpad.net/qemu/+bug/1790975
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Link: https://lore.kernel.org/r/20240905-of-resource-overflow-v1-1-0cd8bb92cc1f@linutronix.de
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/address.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -8,6 +8,7 @@
 #include <linux/logic_pio.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/sizes.h>
@@ -1061,7 +1062,11 @@ static int __of_address_to_resource(stru
 	if (of_mmio_is_nonposted(dev))
 		flags |= IORESOURCE_MEM_NONPOSTED;
 
+	if (overflows_type(taddr, r->start))
+		return -EOVERFLOW;
 	r->start = taddr;
+	if (overflows_type(taddr + size - 1, r->end))
+		return -EOVERFLOW;
 	r->end = taddr + size - 1;
 	r->flags = flags;
 	r->name = name ? name : dev->full_name;



